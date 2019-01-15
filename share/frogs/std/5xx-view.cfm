<!---
5xx-view.cfm

@author
	Antonio R. Collins II (ramar.collins@gmail.com)
@end

@copyright
	Copyright 2016-Present, "Deep909, LLC"
	Original Author Date: Tue Jul 26 07:26:29 2016 -0400
@end

@summary
 	500 and friends page template
@end
  --->
<html>
<head>
<cfif #data.localOverride.4xx#>
 <link rel=stylesheet href="/assets/5xx-view.css" type=text/css>
<cfelse>
 <style type="text/css">
 /* Borrowed and modified from http://meyerweb.com/eric/tools/css/reset/ */
 html, body, div, 
 h1, h2, h3, h4, h5, h6, 
 p, pre,
 a, img, b, u, i, center, dl, dt, dd, ol, ul, li,
 fieldset, form, label, legend, table, caption, 
 tbody, tfoot, thead, tr, th, td, article, aside, 
 canvas, details, embed, figure, figcaption, 
 footer, header, hgroup, menu, nav, output, ruby, 
 section, summary, time, mark, audio, video {
 	margin: 0;
 	padding: 0;
 	border: 0;
 	font-size: 100%;
 	font: inherit;
 	vertical-align: baseline;
 }
 /* HTML5 display-role reset for older browsers */
 article, aside, details, figcaption, figure, 
 footer, header, hgroup, menu, nav, section {
 	display: block;
 }
 body {
 	line-height: 1;
 }
 ol, ul {
 	list-style: none;
 }
 blockquote, q {
 	quotes: none;
 }
 blockquote:before, blockquote:after, q:before, q:after {
 	content: '';
 	content: none;
 }
 table {
 	border-collapse: collapse;
 	border-spacing: 0;
 }
 
 
 /*global*/
 html {
 	font-family: Helvetica;
 	background-color: pink;
 }
 
 pre {
 	font-family: "Lucida Console", "Lucida Sans Typewriter", monaco, "Bitstream Vera Sans Mono", monospace;
 	width: 95%;
 	margin: 0 auto;
 	background-color: white;
 	color: black;
 	margin-top: 10;
 	padding: 5;
 }
 
 /*full-screen on most normal things*/
 .center
 {
 	text-align: center;
 }
 
 .container
 {
 	width: 90%;
 	background-color: #661a16;
 	color: white;
 	padding-top: 50px;
 	margin: 0 auto;
 	margin-top: 50px;
 }
 
 .container-section
 {
 	position: relative;
 	width: 95%;
 	padding-top: 10;
 	margin: 0 auto;
 	margin-bottom: 10;
 	padding-bottom: 30;
 }
 
 .container-dark-line {
 	border-top: 5px solid #333;
 }
 
 .container-light-line {
 	border-top: 5px solid #ccc;
 }
 
 .container p
 {
 	font-size: 1.5em;
 }
 
 h1, h2, h3, h4, h5 {
 	transition: font-size 0.2s;	
 }
 
 p {
 	transition: font-size 0.2s,
 							width 0.2s;
 }
 
 a {
 	transition: background-color 0.2s,
 							color 0.2s;
 }
 
 h1 { font-size: 15em; font-weight: bold; text-align: center; }
 h2 { font-size: 5em; font-weight: bold; text-align: center; }
 h3 { font-size: 4em; }
 h4 { font-size: 3em; }
 h5 { font-size: 2em; }
 
 a {
 	font-family: "Lucida Console", "Lucida Sans Typewriter", monaco, "Bitstream Vera Sans Mono", monospace;
 	line-height: 40px;
 	background-color: #333;
 	font-size: 1.4em;
 	color: white;
 	text-align: center;
 	padding: 10px;
 }
 
 a:hover {
 	background-color: white;
 	color: black;
 }
 
 p {
 	font-family: "Lucida Console", "Lucida Sans Typewriter", monaco, "Bitstream Vera Sans Mono", monospace;
 	font-size: 1.4em;
 	margin-top: 30px;
 }
 
 ul li {
 	margin: 5;
 	margin-left: 0;
 }
 
 .gets
 {
 	transition: display 0.2s;
 	display: none;
 }
 
 
 /*500 specific stuff*/
 li
 { list-style-type: none; list-style: none; 
 	padding: 0; margin: 0; left: 0; }
 pre
 { color:white; line-height: 11px;
 	padding:10; text-align: left; font-weight: normal; }
 .errorHeader
 { font-size: 1.1em; text-transform: capitalize; 
 	position: relative; top: 8px; left: 5px;  }
 p.error
 { display: block; padding: 10; margin-top: 10; background-color: red; }
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
 .text { background-color: red; }
 
 
 
 /*mobile*/
 @media ( max-width: 736px ) {
 	.container {
 		width: 100%;
 		height: auto;
 		padding: 0;
 		margin: 0;
 		padding-bottom: 20px;
 	}
 
 	h1 { font-size: 12em; 
 			 font-weight: bold; padding-bottom: 10; padding-top: 100px; }
 
 	.gets
 	{
 		display: block;
 		position: absolute;
 		bottom: 10;
 		right: 10;
 	}
 
 	pre
 	{ color:white; line-height: 11px;
 		padding:10; text-align: left; font-weight: normal; }
 
 	p.error 
 	{ font-size: 0.8em; }
 
 	.errorHeader
 	{ font-size: 0.8em; text-transform: capitalize; 
 		position: relative; top: 8px; left: 5px;  }
 
 /*	.error
 	{ display: block; padding: 10; margin-top: 10; background-color: red; }
 	*/
 }
 
 
 /*made something else*/
 @media (min-width: 737px) and ( max-width: 1200px ) {
 	h1 { font-size: 10em; 
 			 font-weight: bold; 
 			 padding-top: 100px; }
 }
 </style>
</cfif>
</head>


<!--- This is an ugly block... with status codes... --->
<cfscript>
this.statusErrorMessage = { 102= "Processing",
200 = "OK",201 = "Created",202 = "Accepted",203 = "Non-Authoritative Information",204 = "No Content",205 = "Reset Content",206 = "Partial Content",207 = "Multi-Status",208 = "Already Reported",226 = "IM Used",207 = "OK",300 = "Multiple Choices",301 = "Moved Permanently",302 = "Found",303 = "See Other",304 = "Not Modified",305 = "Use Proxy",306 = "Switch Proxy",307 = "Temporary Redirect",308 = "Permanent Redirect",400 = "Bad Request",401 = "Unauthorized",402 = "Payment Required",403 = "Forbidden",404 = "Not Found",405 = "Method Not Allowed",406 = "Not Acceptable",407 = "Proxy Authenticate Required",408 = "Request Timeout",409 = "Conflict",410 = "Gone",411 = "Length Required",412 = "Precondition Failed",413 = "Payload Too Large",414 = "URI Too Long",415 = "Unsupported Media Type",416 = "Range Not Satisfiable",417 = "Expectation Failed",418 = "I'm a Teapot",421 = "Misdirected Request",422 = "Unprocessable Entity",423 = "Locked",424 = "Failed Dependency",426 = "Upgrade Required",428 = "Precondition Required",429 = "Too Many Requests",431 = "Request Header Fields Too Large",451 = "Unavailable For Legal Reasons",500 = "Internal Server Error",501 = "Not Implemented",502 = "Bad Gateway",503 = "Service Unavailable",504 = "Gateway Timeout",505 = "HTTP Version Not Supported",506 = "Variant Also Negotiates",507 = "Insufficient Storage",508 = "Loop Detected",510 = "Not Extended",511 = "Network Authentication Required" };
STATUS_ERROR_MESSAGE = this.statusErrorMessage; 
</cfscript>


<!--- body --->
<body>
<cfoutput>
	<div class="container">
		<!--- Status Code --->
		<div class="container-section">
		<cfif isDefined( "err.statusCode" )>
			<h1>#err.statusCode#</h1>
			<h2>#STATUS_ERROR_MESSAGE[ err.statusCode ]#</h2>
		<cfelse>
			<h1>#status_code#</h1>
			<h2>#STATUS_ERROR_MESSAGE[ status_code ]#</h2>
		</cfif>
		</div>

		<div class="container-section">
		<!--- Status message --->
		<cfif isDefined( "err.statusMessage" )>
			<div class="errorHeader">Error Message</div>
			<p class="error text">#err.statusMessage#</p>
		<cfelse>
			<div class="errorHeader">Error Message</div>
			<p class="error text">#status_message#</p>
		</cfif>
		</div>

		<!--- Status message --->
		<cfif isDefined( "err.statusLine" )>
		<div class="container-section">
			<div class="errorHeader">Line</div>
			<p class="error lineNo">Error at line: #err.statusLine#</p>
		</div>
		<cfelse>
		<div class="container-section">
			<div class="errorHeader">Line</div>
			<p class="error lineNo">Error at line: #status_line#</p>
		</div>
		</cfif>

		<!--- Actual error message --->
		<div class="container-section">
		<cfif isDefined( "err.message" )>
			<div class="errorHeader">Message</div>
			<p class="error">#err.message#</p>
		<cfelse>
			<cfif isDefined( "errorMsg" )>
				<div class="errorHeader">Message</div>
				<p class="error">#errorMsg#</p>
			</cfif>
		</cfif>
		</div>

		<!--- Actual error long message --->
		<cfif isDefined("err.msgLong")>
		<div class="container-section">
			<div class="errorHeader">Long Message</div>
			<p class="error">#err.msgLong#</p>
		</div>
		<cfelse>
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
		<div class="container-section">
			See full exception <input type="checkbox" class="check"></input>
			<div class="error hide">
				<cfdump var=#exception#>
			</div>
		<p class="error">
		</p>
		</div>
		</cfif>
	</div>

</body>
</cfoutput>
</html>
