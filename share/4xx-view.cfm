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
	4[00-99] HTTP Error page template
@end
  --->
<cfoutput>
<style type=text/css>
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
</style>

<h2>#status_code#</h2>
<h3>#status_message#</h3>

<p>

</p>
</cfoutput>
