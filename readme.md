IDS Enhanced Routing Rules Addon
================================

IDS server addon for enhanced routing rules.  This addon could easily serve as a template for any routing rule that you may want to schedule.  In addition, you could easily add other functionality (adding info to fields, generating emails, etc).

**Becareful with server addons:  they are very powerful and can do great good...or great damage.**

**This addon has not yet been approved by Atlas Systems.**

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
		<dd>The MatchString is the condition(s) that must be met by the transactions to be included in the query</dd>
		<dd>This is where the magic happens</dd>
		<dd>Example: t.RequestType="Loan" AND t.Username="Sauron, Lord of the Rings"</dd>
	<dt>NewProcessType</dt>
		<dd>The new ProcessType that the request should receive</dd>
		<dd>Options: Borrowing, Doc Del, Lending</dd>
	<dt>NewTransactionStatus</dt>
		<dd>The new TransactionStatus that the request should receive</dd>
</dl>