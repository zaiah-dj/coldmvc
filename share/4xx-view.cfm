<!---
4xx-view.cfm

@author
	Antonio R. Collins II (ramar.collins@gmail.com)
@end

@copyright
	Copyright 2016-Present, "Deep909, LLC"
	Original Author Date: Tue Jul 26 07:26:29 2016 -0400
@end

@summary
 	404 page template
@end
  --->
<html>

<head>
<cfif #data.localOverride.4xx#>
 <link rel=stylesheet href="/assets/4xx-view.css" type=text/css>
<cfelse>
 <style type=text/css>
 /*zero*/
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
 	background-color: #a5ed84;
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
 	background-color: #2a5616;
 	color: white;
 	height: 80%;
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
 }
 
 @media (min-width: 737px) and ( max-width: 1200px ) {
 	h1 { font-size: 10em; 
 			 font-weight: bold; 
 			 padding-top: 100px; }
 }
 </style>
</cfif>
</head>

<body>

<cfoutput>
	<div class="container">
		<div class="container-section">
			<h1>404</h1>
			<h2>Page Not Found</h2>
		</div>
		<div class="container-section container-less container-light-line center">
			<p>The client made a request for
			<u>#cgi.script_name#</u>
			and it was not found on this server.</p>
		</div>

		<div class="container-section container-less container-light-line left">
			<ul>
				<li>Go back <a href="#link("")#">home</a></li>
			</ul>
		</div>

	</div>

</body>
</cfoutput>
</html>
