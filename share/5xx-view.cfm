<cfscript>
this.statusErrorMessage = { 102= "Processing",
200 = "OK",201 = "Created",202 = "Accepted",203 = "Non-Authoritative Information",204 = "No Content",205 = "Reset Content",206 = "Partial Content",207 = "Multi-Status",208 = "Already Reported",226 = "IM Used",207 = "OK",300 = "Multiple Choices",301 = "Moved Permanently",302 = "Found",303 = "See Other",304 = "Not Modified",305 = "Use Proxy",306 = "Switch Proxy",307 = "Temporary Redirect",308 = "Permanent Redirect",400 = "Bad Request",401 = "Unauthorized",402 = "Payment Required",403 = "Forbidden",404 = "Not Found",405 = "Method Not Allowed",406 = "Not Acceptable",407 = "Proxy Authenticate Required",408 = "Request Timeout",409 = "Conflict",410 = "Gone",411 = "Length Required",412 = "Precondition Failed",413 = "Payload Too Large",414 = "URI Too Long",415 = "Unsupported Media Type",416 = "Range Not Satisfiable",417 = "Expectation Failed",418 = "I'm a Teapot",421 = "Misdirected Request",422 = "Unprocessable Entity",423 = "Locked",424 = "Failed Dependency",426 = "Upgrade Required",428 = "Precondition Required",429 = "Too Many Requests",431 = "Request Header Fields Too Large",451 = "Unavailable For Legal Reasons",500 = "Internal Server Error",501 = "Not Implemented",502 = "Bad Gateway",503 = "Service Unavailable",504 = "Gateway Timeout",505 = "HTTP Version Not Supported",506 = "Variant Also Negotiates",507 = "Insufficient Storage",508 = "Loop Detected",510 = "Not Extended",511 = "Network Authentication Required" };
STATUS_ERROR_MESSAGE = this.statusErrorMessage; 
</cfscript>

<html>
<head>
<!--- href --->
<cfif 0>
	<link rel=stylesheet href="/assets/5xx-view.css" type=text/css>
<cfelseif 0>
<cfelse>
 <style type="text/css">
	html, body, div, span, applet, object, iframe,
	h1, h2, h3, h4, h5, h6, p, blockquote, pre,
	a, abbr, acronym, address, big, cite, code,
	del, dfn, em, img, ins, kbd, q, s, samp,
	small, strike, strong, sub, sup, tt, var,
	b, u, i, center,	dl, dt, dd, ol, ul, li,
	fieldset, form, label, legend,
	table, caption, tbody, tfoot, thead, tr, th, td,
	article, aside, canvas, details, embed, 
	figure, figcaption, footer, header, hgroup, 
	menu, nav, output, ruby, section, summary,
	time, mark, audio, video
	{ margin: 0;padding: 0;border: 0;font: inherit;
		font-size: 100%;vertical-align: baseline; }
	/* HTML5 display-role reset for older browsers */
	article, aside, details, figcaption, figure, 
	footer, header, hgroup, menu, nav, section
	{ display: block; }
	.container	
	{ min-width: 300px; width: 70%; margin: 0 auto; }
	html	
	{ ; }
	body
	{ line-height: 1; }
	ol, ul
	{ list-style: none; }
	blockquote, q 
	{	quotes: none; }
	blockquote:before, blockquote:after, q:before, q:after
	{ content: ''; content: none; }
	table
	{ border-collapse: collapse; border-spacing: 0; }
	h2
	{ font-size: 3.0em; font-weight: bold; text-align: center; }	
	h3
	{ font-size: 1.2em; font-weight: bold; 
		text-align: center; background-color: pink; }	
	li
	{ list-style-type: none; list-style: none; 
		padding: 0; margin: 0; left: 0; }
	pre
	{ color:white; line-height: 11px;
		padding:10; text-align: left; font-weight: normal; }
	.errorHeader
	{ font-size: 0.8em; text-transform: capitalize; 
		position: relative; top: 8px; left: 5px;  }
	.error
	{ display: block; padding: 10; margin-top: 10; background-color: cyan; }
	.code 
	{ background-color: #483d8b; }
	.container-status
	{ text-align: center;	width: 40%;
		margin: 0 auto; min-width: 320px; }
	.exact { background-color: red; color: white; }
	div.hide 
	{ display: block; height: 0; padding: 0; overflow: hidden; transition: height 0.2s; }

	input[ type="checkbox" ]:checked + .hide
	{ display: block; height: auto; }
	.lineNo { background-color: yellow; }
	.text { background-color: pink; }
 </style>
</cfif>
</head>



<!--- body --->
<body>
<cfoutput>
<div class="container">
	<!--- Status Code --->
	<div class="container-status">
	<cfif isDefined( "err.statusCode" )>
		<h2>#err.statusCode#</h2>
		<h4>#STATUS_ERROR_MESSAGE[ err.statusCode ]#</h4>
	<cfelse>
		<h2>#status_code#</h2>
		<h4>#STATUS_ERROR_MESSAGE[ status_code ]#</h4>
	</cfif>
	</div>


	<!--- Status message --->
	<cfif isDefined( "err.statusMessage" )>
		<div class="errorHeader">Error Message</div>
		<p class="error text">#err.statusMessage#</h3>
	<cfelse>
		<div class="errorHeader">Error Message</div>
		<p class="error text">#status_message#</p>
	</cfif>


	<!--- Status message --->
	<cfif isDefined( "err.statusLine" )>
		<div class="errorHeader">Line</div>
		<p class="error lineNo">Error at line: #err.statusLine#</p>
	</cfif>


	<!--- Actual error message --->
	<cfif isDefined( "err.message" )>
		<div class="errorHeader">Message</div>
		<p class="error">#err.message#</p>
	<cfelse>
		<cfif isDefined( "errorMsg" )>
			<div class="errorHeader">Message</div>
			<p class="error">#errorMsg#</p>
		</cfif>
	</cfif>


	<!--- Actual error long message --->
	<cfif isDefined("err.msgLong")>
		<div class="errorHeader">Long Message</div>
		<p class="error">#err.msgLong#</p>
	<cfelse>
	<!---
		<p>#msgLong#</p>
	--->
	</cfif>


	<!-- Show the offending lines provided that an exception is there -->
	<cfif isDefined("err.exception")>
		<div class="errorHeader">Message</div>
		<p class="error exact">#err.exception.Message#</p>

		<div class="errorHeader">Occurred at</div>
		<pre class="error code">#err.exception.TagContext[ 1 ].codePrintHTML#</pre>
	</cfif>

	<!-- The error exception -->
	<cfif isDefined("err.exception")>
	<div class="errorHeader">Exception Text</div>
	<div class="error">
		See full exception <input type="checkbox" class="check"></input>
		<div class="error hide">
			<cfdump var=#err.exception#>
		</div>
	</div>
	<p class="error">
	</p>
	</cfif>

	<!--- Exception --->
	<cfif isDefined("Exception")>
		See full exception <input type="checkbox" class="check"></input>
		<div class="error hide">
			<cfdump var=#exception#>
		</div>
	<p class="error">
	</p>
	</cfif>
</div>

</body>
</cfoutput>
</html>
