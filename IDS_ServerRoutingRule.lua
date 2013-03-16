-- IDS_ServerRoutingRule.lua
--
-- Bill Jones
-- Michael C. Mulligan
--

local Settings = {};

Settings.VERSION = '0.0.2.0';

Settings.NVTGC = GetSetting("NVTGC");
Settings.ProcessType = GetSetting("ProcessType");
Settings.RequestType = GetSetting("RequestType");
Settings.TransactionStatus = GetSetting("TransactionStatus");
Settings.MatchString = GetSetting("MatchString");
Settings.NewProcessType = GetSetting("NewProcessType");
Settings.NewTransactionStatus = GetSetting("NewTransactionStatus");

Settings.OCLCSymbol = '';

function Init()
	RegisterSystemEventHandler("SystemTimerElapsed", "TimerElapsed");
end

function TimerElapsed(eventArgs)
	setOCLCSymbol()
	local tns = getTransactionsToProcess();
	ProcessDataContexts("TransactionNumber", tns, "ProcessTransaction");
end

function setOCLCSymbol()
	local q = "select OCLCSymbol from LocalInfo where NVTGC='" .. Settings.NVTGC .. "'";
	Settings.OCLCSymbol = getScalar(q);
end

function ProcessTransaction()
	local cur_tn = GetFieldValue("Transaction", "TransactionNumber");
	local cur_type = GetFieldValue("Transaction", "ProcessType");
	if (cur_type == Settings.NewProcessType) then
		ExecuteCommand("Route", {cur_tn, Settings.NewTransactionStatus});
	elseif (cur_type == 'Borrowing') and (Settings.NewProcessType == 'Doc Del') then
		ExecuteCommand("RouteToDocumentDelivery", {cur_tn, Settings.NewTransactionStatus});
	elseif (cur_type == 'Doc Del') and (Settings.NewProcessType == 'Borrowing') then
		ExecuteCommand("RouteToBorrowing", {cur_tn, Settings.NewTransactionStatus});
	else
		LogDebug("ERROR! Invalid change of process type");
	end
	SaveDataSource("Transaction");
end

function getTransactionsToProcess()
	local usersTable = getUsersTable();
	local q = '';
	q = q .. "select t.TransactionNumber ";
	q = q .. "from Transactions t, " .. usersTable .. " u ";
	q = q .. "where ( t.Username = u.Username ) ";
	q = q .. "and ( u.NVTGC = '" .. Settings.NVTGC .. "' ) ";
	q = q .. "and ( t.ProcessType = '" .. Settings.ProcessType .. "' ) ";
	q = q .. "and ( t.RequestType = '" .. Settings.RequestType .. "' ) ";
	q = q .. "and ( t.TransactionStatus = '" .. Settings.TransactionStatus .. "' ) ";
	q = q .. 'and ( ' .. Settings.MatchString .. ' ) ';
	return getTransactions(q);
end

function getTransactions(query)
	local connection = CreateManagedDatabaseConnection();
	connection.QueryString = query;
	connection:Connect();
	local resultsTable = connection:Execute();
	local transactionNumbers = {};
	for i = 0, resultsTable.Rows.Count - 1 do
		transactionNumbers[i] = resultsTable.Rows:get_Item(i):get_Item("TransactionNumber");
	end
	connection:Disconnect();
	connection:Dispose();
	return transactionNumbers
end

function getScalar(query)
	local value = '';
	local connection = CreateManagedDatabaseConnection();
	connection.QueryString = query;
	connection:Connect();
	value = connection:ExecuteScalar();
	connection:Disconnect();
	connection:Dispose();
	return value;
end

function getUsersTable()
	local usersTable = 'Users';
	local shared = getScalar("select Value from Customization where CustKey = 'SharedServerSupport' and NVTGC = 'ILL'");
	if (shared == "Yes") then
		usersTable = 'UsersAll';
	end
	return usersTable;
end