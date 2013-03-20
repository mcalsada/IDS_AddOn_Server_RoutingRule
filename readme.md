IDS Enhanced Routing Rules Addon
================================

IDS server addon for enhanced routing rules.  This addon could easily serve as a template for any routing rule that you may want to schedule.  In addition, you could easily add other functionality (adding info to fields, generating emails, etc).

-------------
Configuration
-------------

Most of these settings mirror the same settings you would use in Customization Manager to set up a new routing rule.
<dl>
	<dt>ProcessType</dt>
		<dd>The ProcessType on which the rule should run</dd>
		<dd>Options: Borrowing, Doc Del, Lending</dd>
	<dt>RequestType</dt>
		<dd>The RequestType on which the rule should run</dd>
		<dd>Options: Article, Loan</dd>
	<dt>TransactionStatus</dt>
		<dd>The Transaction Status on which the rule should run</dd>
	<dt>MatchString</dt>
		<dd>The MatchString...'nuff said</dd>
		<dd>This is where the magic happens</dd>
	<dt>NewProcessType</dt>
		<dd>The new ProcessType that the request should receive</dd>
		<dd>Options: Borrowing, Doc Del, Lending</dd>
	<dt>NewTransactionStatus</dt>
		<dd>The new TransactionStatus that the request should receive</dd>
	<dt>Debug</dt>
		<dd>You may be asked to turn this on for troubleshooting</dd>
		<dd>Options: true, false</dd>
</dl>