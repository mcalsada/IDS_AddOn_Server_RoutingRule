local Settings = {};
Settings.chooseprocesstype = GetSetting("chooseprocesstype");
Settings.choosestatus = GetSetting("choosestatus");
Settings.locationvalue = GetSetting("locationvalue");
Settings.changestatus = GetSetting("changestatus");
Settings.changeprocess = GetSetting("changeprocess");

	
local interfaceMngr = nil;

function Init()
	RegisterSystemEventHandler("SystemTimerElapsed", "TimerElapsed");
end

function TimerElapsed(eventArgs)
	local transactionsToProcess = GetTransactions();
	ProcessDataContexts("TransactionNumber",transactionsToProcess,"ProcessTransaction");
end

function ProcessTransaction()
     local currentTN = GetFieldValue("Transaction", "TransactionNumber");
                WriteNote(currentTN );
                Rewritestatus(currentTN);
				SetFieldValue("Transaction", "ProcessType", changeprocess);
	SaveDataSource("Transaction");
end

function WriteNote(currentTN)
	ExecuteCommand("AddNote", {currentTN, "This transaction has been changed by ChangeYourStatus system level addon."});
end

function Rewritestatus(currentTN)
    ExecuteCommand("Route", {currentTN, Settings.changestatus});
end

function GetTransactions()
   	local connection = CreateManagedDatabaseConnection();
	connection.QueryString = "SELECT TransactionNumber FROM Transactions WHERE TransactionStatus =  '" .. Settings.choosestatus .. "' AND ProcessType = '" .. Settings.chooseprocesstype .. "' AND Location like '%" .. Settings.locationvalue .. "%'";
	connection:Connect();
	local transactionsTable = connection:Execute();
	if transactionsTable.Rows.Count ~= nil then
		local transactionNumbers = {};
		for i = 0, transactionsTable.Rows.Count - 1 do
			transactionNumbers[i] = transactionsTable.Rows:get_Item(i):get_Item("TransactionNumber");
		end
            
		return transactionNumbers;
	end
              
end


