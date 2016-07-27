<cfcomponent name="GlobalApplication">
  <!---=--->
  <!---=--->
  <!---/THIS SCOPE--->
    <cfset This.name = 'NCCUApp'/>
    <cfset This.applicationTimeout = #createtimespan(2,0,0,0)#/>
    <cfset This.clientManagement = 'false'/>
    <cfset This.clientStorage = 'cookie'/>
    <cfset This.loginStorage = 'session'/>
    <cfset This.scriptProtect = 'true'/>
    <cfset This.sessionManagement = 'true'/>
    <cfset This.setClientCookies = 'false'/>
    <cfset This.setDomainCookies = 'false'/>
    <cfset this.datasource = 'WebDB'>
  <!---//THIS SCOPE--->
  <!---=--->
  <!---/SERVER SCOPE--->
    <cfparam name='server.basePath' default=#ExpandPath('/')#>
    <cfparam name='server.baseDirectory' default='/'>
    <cfif 1 OR NOT(
      IsDefined('server.basePath') 
      AND IsDefined('server.baseDirectory')
    )>
      <cflock timeout='10' scope='server' throwOnTimeout='no' type='exclusive'>
        <cfset server.basePath = ExpandPath('/')>
        <cfset server.baseDirectory = '/'>
      </cflock>
    </cfif>
    <cflock timeout='10' scope='server' throwOnTimeout='no' type='exclusive'>
      <cfset server.encryptionKey='/LoNNZMMLa0ADo04bz4i+g=='>
      <cfset server.deprecatedKeyList='bTeBbSA+3PHi6xI8gE/efA=='>
      <!---DEPRECATED---><cfset server.encryptionKeyX='zZl0WZUtCShAKmKZOOQyGg=='>
      <!---DEPRECATED---><cfset server.encryptionKey2='pPsZsjt3eZ3gcqiHP7fmxw=='>
      <cfset server.systemUsername='PepperLookup'>
      <cfset server.systemPassword='Aa9861hZyUTVY4sjljDMkgLSb7pUnmc1IU5iQUN2w86csamkSw1NxpKJsdOmCZo'>
      <cfset server.szSoapAdapDSDirectoryToolsKey = 'sand.ad.nccu.edu-2fdb8843-4692-4884-8c87-3c9b0516d267'>
      <cfset server.szSoapAdapDSDirectoryTools = 'https://sg-adap.ad.nccu.edu/DirectoryServices2011/services/DirectoryTools.asmx?WSDL'>
      <cfset server.objJRun = CreateObject('java','jrunx.kernel.JRun')>
    </cflock>
    <!---
    --->
  <!---//SERVER SCOPE--->
  <!---=--->
  <!---/APPLICATION SCOPE--->
    <cfif NOT IsDefined('application.cachedData')>
      <cfset application.cachedData = ArrayNew(1)>
    </cfif>
    <!---
    <cfif NOT IsDefined('application.cacheTime')>
      <cfset application.cacheTime = CreateTimeSpan(0,3,0,0)>
    </cfif>
    --->
    <cfset application.ldapServer = "goten.ad.nccu.edu">
    <cfset application.ldapServer2 = "goten.ad.nccu.edu">
    <cfset application.RE_NOT_basic_char = "([^a-zA-Z0-9\ ])"/><!---matches characters other than alphanumeric--->
    <cfset application.RE_NOT_basic_char2 = "([^a-zA-Z0-9\ ',-])"/><!---matches characters other than alphanumeric or apostraphes or commas--->
    <cfset application.RE_NOT_basic_char3 = "([^a-zA-Z0-9\ ',()\.])"/><!---matches characters other than alphanumeric or basic punctuation (allows basic paragraph text)--->
    <cfset application.RE_URLprotocol = "(((https?|ftp)(://)(www\.)?)|(www\.))"/><!---matches a URL prefix--->
    <cfset application.RE_NOT_URLdomain = "([^a-zA-Z0-9-_/\ \.])"/><!---matches characters not valid in URL domains--->
    <cfset application.RE_General_Text = "([^a-zA-Z0-9\ ',()\.=/_-])"/><!---matches characters not valid in URL domains--->
    <cfset application.RE_NOT_basic_char4 = "([^A-Za-z0-9'!,@_ \(\)\?\./\$:-]+)"/><!---matches characters other than alphanumeric, basic punctuation, or smiley text--->
    <cfset application.RE_basic_char4 = "([A-Za-z0-9'!,@_ \(\)\?\./\$:-]+)"/><!---matches alphanumeric, basic punctuation, or smiley text--->
    <!--- example: <cfset url.tags = REReplace(url.tags,application.RE_NOT_basic_char,"","all")> --->
    <!---DEPRECATED---><cfset application.encryptionKey='#server.encryptionKey#'><!---use 'server.encryptionKey' instead--->
    <!---DEPRECATED---><cfset application.deprecatedKeyList='#server.deprecatedKeyList#'><!---use 'server.deprecatedKeyList' instead--->
    <!---DEPRECATED---><cfset application.encryptionKeyX='#server.encryptionKeyX#'><!---use 'server.encryptionKeyX' instead--->
    <!---DEPRECATED---><cfset application.encryptionKey2='#server.encryptionKey2#'><!---use 'server.encryptionKey2' instead--->
    <!---DEPRECATED---><cfset application.systemUsername='#server.systemUsername#'><!---use 'server.systemUsername' instead--->
    <!---DEPRECATED---><cfset application.systemPassword='#server.systemPassword#'><!---use 'server.systemPassword' instead--->
    <!---
      <!---DEPRECATED---><cfset application.devDir = "#iif(REFindNoCase("^(D:\\websites\\NCCU\.edu\\development\\)",getCurrentTemplatePath()),DE('/development'),DE(''))#"/><!---development directory; set to "" when not in development mode. otherwise, set to subdirectory componenet corresponding to development directory--->
      <!---DEPRECATED---><cfset application.devDirLocal = "#iif(REFindNoCase("^(D:\\websites\\NCCU\.edu\\development\\)",getCurrentTemplatePath()),DE('\development'),DE(''))#"/><!---development directory (non-web/windows address); set to "" when not in development mode. otherwise, set to subdirectory componenet corresponding to development directory--->
      <!---DEPRECATED---><cfset application.mappingDir = "/mappings/intranet">
    --->
  <!---//APPLICATION SCOPE--->
  <!---=--->
  <!---/SESSION SCOPE--->
    <cfparam name="session.username" default=''>
    <cfparam name="session.password" default=''>
    <cfparam name="session.mail" default=''>
    <cfparam name="session.user_ID" default=''>
    <cfparam name="session.display_name" default=''>
    <cfparam name="session.first_name" default=''>
    <cfparam name="session.last_name" default=''>
    <cfparam name="session.middle_init" default=''>
    <cfparam name="session.authenticated" default="no">
    <cfparam name="session.rememberme" default="no">
    <cfparam name="session.admin" default="no">
    <cfparam name="session.requestedPage" default="">
    <cfparam name="session.home_directory" default="">
    <cfparam name="session.department" default="">
    <cfparam name="session.userDashboardRightsArray" default="#ArrayNew(1)#">
    <cfparam name="session.insecurePassword" default="false">
    <cfparam name="session.isEmployee" default="false">
    <cfparam name="session.isStudent" default="false">
    <cfparam name="session.isProspect" default="false">
    <cfparam name="session.isAlumni" default="false">
    <cfparam name="session.alumniUser" default="no">
    <cfparam name="session.prospectiveUser" default="no">
    <cfparam name="session.bannerID" default="">
    <cfparam name="session.streetAddress1" default="">
    <cfparam name="session.streetAddress2" default="">
    <cfparam name="session.city" default="">
    <cfparam name="session.stateProvince" default="">
    <cfparam name="session.country" default="">
    <cfparam name="session.applicantType" default="">
    <cfparam name="session.zip" default="">
    <cfparam name="session.sessionTimeSpan" default="#createTimeSpan(0,0,40,0)#">
    <cfparam name="session.expireSecondsRemaining" default="2400"><!---40 minutes--->
    <!---news-events box params--->
    <!---DEPRECATED---><cfparam name="session.newsBit" default="on">
    <!---DEPRECATED---><cfparam name="session.eventsBit" default="off">
    <!---DEPRECATED---><cfparam name="session.athleticsBit" default="on">
    <!---DEPRECATED---><cfparam name="session.alertsBit" default="off">
    <!---DEPRECATED---><cfparam name="session.newsBit" default="on">
    <!---DEPRECATED---><cfparam name="session.announcementsBit" default="off">
  <!---//SESSION SCOPE--->
  <!---=--->
  <!---/REQUEST SCOPE--->
    <!---FDR Params--->
    <!---DEPRECATED---><cfparam name="request.file_path" default='/formsdocs/files'>
  <!---//REQUEST SCOPE--->
  <!---=--->
  <!---/VARIABLES SCOPE--->
    <!---/COMMON VENDER VARIABLES--->
      <cfparam name="variables.venderCode" default="0000">
      <cfparam name="variables.venderTitle" default="North Carolina Central University">
      <cfparam name="variables.venderDescription" default="North Carolina Central University">
      <cfparam name="variables.venderName" default="Web Services">
      <cfparam name="variables.venderKeywords" default="North Carolina Central University">
      <cfparam name="variables.venderPrimaryCSS" default="0">
      <cfparam name="variables.venderCurrGuideCSS" default="0">
      <cfparam name="variables.venderPrimaryJS" default="0">
    <!---//COMMON VENDER VARIABLES--->
    <cfparam name='variables.cacheTime' default='#CreateTimeSpan(0,3,0,0)#'>
  <!---//VARIABLES SCOPE--->
  <!---=--->
  <!---=--->
  <cftry>
  	<cfif IsDefined('cookie.rememberme') AND cookie.rememberme NEQ "">
			<cfset decryptedCookie = #decrypt(cookie.rememberme,application.encryptionKey,"AES","Hex")#>
      <cfset session.expireSecondsRemaining = #dateDiff("s",now(),getToken(decryptedCookie,4,','))#>
      <cfif 
				NOT(
					LCase(session.authenticated) EQ "yes" AND 
					session.username EQ GetToken(decryptedCookie,1,',') AND 
					CreateTimeSpan(0,0,0,session.expireSecondsRemaining) GT CreateTimeSpan(0,0,40,0)
				)
			>
      	<cfset session.expireSecondsRemaining = 2400>
      <cfelse>
				<cfset this.sessionTimeout = #CreateTimeSpan(0,0,0,session.expireSecondsRemaining)#/>
        <cfset session.sessionTimeSpan = #CreateTimeSpan(0,0,0,session.expireSecondsRemaining)#/>
      </cfif>
    </cfif>
    <cfcatch type="any">
    </cfcatch>
  </cftry>
  <!---=--->


  <!---=--->
  <cffunction name="onRequestStart" returnType="boolean">
    <cfargument type="String" name="targetPage" required=true/>
    <!---=--->
    <cfif 
      0
    >
      <cfoutput>
        Your IP address <b>#cgi.remote_addr#</b> has been flagged as the source of suspicious network activity.<br/>
        <br/>
        Please contact NCCU Information Technology Services Helpdesk at 919-530-7676 or <a href="mailto:helpdesk@nccu.edu?subject=My IP Address Has Been Flagged">helpdesk@nccu.edu</a>, and reference this notice.
      </cfoutput>
      <cfreturn 0>
    <cfelse>
      <cfreturn 1>
    </cfif>
  </cffunction>
  <!---=--->
  <!---=--->
  <cffunction name="onRequest" returnType="void">
    <cfargument name="targetPage" type="String" required=true/>
    <!---=--->
    <cfif 
      NOT(
        cgi.server_name EQ 'www.nccu.edu' 
        OR cgi.server_name EQ 'nccu.edu' 
        OR cgi.server_name EQ 'www.sand.ad.nccu.edu' 
        OR cgi.server_name EQ 'sand.ad.nccu.edu'
      )
      OR NOT(
        cgi.http_host EQ 'www.nccu.edu' 
        OR cgi.http_host EQ 'nccu.edu' 
        OR cgi.http_host EQ 'www.sand.ad.nccu.edu' 
        OR cgi.http_host EQ 'sand.ad.nccu.edu'
      )
    >
      <cfabort>
    </cfif>    
    <!---=--->
    <cfif arguments.targetPage NEQ cgi.path_info>
      <cf_location url='#arguments.targetPage##iif(cgi.query_string NEQ '',DE('?'),DE(''))##cgi.query_string#'>
    </cfif>
    <!---=--->
    <cfset vars.originalURL = '#arguments.targetPage##iif(cgi.query_string NEQ '',DE('?'),DE(''))##cgi.query_string#'>
    <cfset vars.cleanTargetPage = REReplaceNoCase(arguments.targetPage,'[\(\)\$\|\+:;]','','all')>
    <cfset vars.cleanTargetPage = REReplaceNoCase(vars.cleanTargetPage,'\.\.\.','..','all')>
    <cfset vars.cleanQueryString = REReplaceNoCase(cgi.query_string,'[\(\)\$\|\\\*{}\[\]]|#URLEncodedFormat("'")#|#URLEncodedFormat('"')#|#URLEncodedFormat('<')#|#URLEncodedFormat('>')#','','all')>
    <cfset vars.cleanURL = '#vars.cleanTargetPage##iif(vars.cleanQueryString NEQ '',DE('?'),DE(''))##vars.cleanQueryString#'>
    <cfset vars.cleanURL = REReplaceNoCase(vars.cleanURL,'\\','/','all')>
    <!---<cfset vars.cleanURL = REReplaceNoCase(vars.cleanURL,'//','/','all')>--->
    <cfif vars.originalURL NEQ vars.cleanURL>
      <cf_location url='#vars.cleanURL#'>
    </cfif>
    <!---=--->
    <cfinclude template="/nccuRootMapping/utilities/initializePage.cfm">
    <!---=--->
    <cfset vars.pageID = objCMS.GetCMSPageID(targetURL=arguments.targetPage)>
    <!---=--->
    <cfif vars.pageID GT 0>
      <cf_getCMSPage pageID='#vars.pageID#'>
    <cfelse>
      <cfinclude template="#arguments.targetPage#">
    </cfif>
  </cffunction>
  <!---=--->
  <!---=--->
  <cffunction name='onError'>
    <cfargument name='Exception' required=true/>
    <cfargument type='String' name='EventName' required=true/>
    <!---=--->
    <cfif session.username EQ 'derekb'
      OR session.username EQ 'acolli10'
    >
      <cfdump var='#arguments.Exception#'>
    </cfif>
    <!---=--->
    <cfif NOT (Arguments.EventName IS 'onSessionEnd') OR (Arguments.EventName IS 'onApplicationEnd')>
      <cftry>
        <cfset vars.objCommon = createObject("component","nccuRootMapping/common")>
        <cfoutput>#CreateObject('component','errors').ReportError(exception='#arguments.exception#')#</cfoutput>
      	<cfcatch type='any'>
          <cfoutput><div style="color:##660000;font-weight:bold;">An error has occurred. Please restart your web browser, and then try again. If this message continues to appear, then please report this error to <a href="mailto:helpdesk@nccu.edu?subject=A ColdFusion error occurred on #cgi.server_name##cgi.path_info# (#DateFormat(Now(),'yyyy-mm-dd')#, #LCase(TimeFormat(Now(),'hh:mm:ss tt'))#)">helpdesk@nccu.edu</a>.</div></cfoutput>
          <!---
          <cfoutput><div style="color:##660000;font-weight:bold;">ITS Web Support Services is conducting website maintenance between 2:30 pm and 3:30 pm on Monday, May 20, 2013.<br/><br/>After the maintenance period has ended, please restart your web browser, and then try again.<br/><br/>If you need immediate assistance, please dial 919-530-7676 or email <a href="mailto:helpdesk@nccu.edu?subject=A ColdFusion error occurred on #cgi.server_name##cgi.path_info# (#DateFormat(Now(),'yyyy-mm-dd')#, #LCase(TimeFormat(Now(),'hh:mm:ss tt'))#)">helpdesk@nccu.edu</a>.</div></cfoutput>
          <cfoutput><div style="color:##660000;font-weight:bold;">An error has occurred. Please report this error to <a href="mailto:helpdesk@nccu.edu?subject=A ColdFusion error occurred on #cgi.server_name##cgi.path_info# (#DateFormat(Now(),'yyyy-mm-dd')#, #LCase(TimeFormat(Now(),'hh:mm:ss tt'))#)">helpdesk@nccu.edu</a>.</div></cfoutput>
          --->
        </cfcatch>
      </cftry>
      <!---=--->
    </cfif>
	</cffunction>
  <!---=--->
  <!---=--->
  <cffunction name="GetApplicationRootPath" returntype="string" hint="Returns the root path of the acting Application.cfm file." output="false" access="public">
    <cfargument name="base_path" default="./">
    <!---=--->
    <cfset actual_path = ExpandPath(arguments.base_path)>
    <cfif FileExists(ExpandPath(arguments.base_path & "Application.cfc"))>
      <cfreturn actual_path>
    <cfelseif REFind(".*[/\\].*[/\\].*", actual_path)>
      <cfreturn GetApplicationRootPath("../#arguments.base_path#")>
    <cfelse>
      <cfthrow message="Unable to determine Application Root Path" detail="#actual_path#"><!--- we have reached the root dir, so throw an error not found --->
    </cfif>
    <!---Source: http://www.petefreitag.com/item/630.cfm--->
  </cffunction>
  <!---=--->
  <!---=--->
  <cffunction name='onMissingTemplate' returnType='boolean'>
    <cfargument type='string' name='targetPage' required='true'>
    <!---=--->
    <cfif 
      NOT(
        cgi.server_name EQ 'www.nccu.edu' 
        OR cgi.server_name EQ 'nccu.edu' 
        OR cgi.server_name EQ 'www.sand.ad.nccu.edu' 
        OR cgi.server_name EQ 'sand.ad.nccu.edu'
      )
      OR NOT(
        cgi.http_host EQ 'www.nccu.edu' 
        OR cgi.http_host EQ 'nccu.edu' 
        OR cgi.http_host EQ 'www.sand.ad.nccu.edu' 
        OR cgi.http_host EQ 'sand.ad.nccu.edu'
      )
    >
      <cfabort>
    </cfif>    
    <!---=--->
    <cfif arguments.targetPage NEQ cgi.path_info>
      <cf_location url='#arguments.targetPage##iif(cgi.query_string NEQ '',DE('?'),DE(''))##cgi.query_string#'>
    </cfif>
    <!---=--->
    <cfset vars.originalURL = '#arguments.targetPage##iif(cgi.query_string NEQ '',DE('?'),DE(''))##cgi.query_string#'>
    <cfset vars.cleanTargetPage = REReplaceNoCase(arguments.targetPage,'[\(\)\$\|\+:;]','','all')>
    <cfset vars.cleanTargetPage = REReplaceNoCase(vars.cleanTargetPage,'\.\.\.','..','all')>
    <cfset vars.cleanQueryString = REReplaceNoCase(cgi.query_string,'[\(\)\$\|\\\*{}\[\]]|#URLEncodedFormat("'")#|#URLEncodedFormat('"')#|#URLEncodedFormat('<')#|#URLEncodedFormat('>')#','','all')>
    <cfset vars.cleanURL = '#vars.cleanTargetPage##iif(vars.cleanQueryString NEQ '',DE('?'),DE(''))##vars.cleanQueryString#'>
    <cfset vars.cleanURL = REReplaceNoCase(vars.cleanURL,'\\','/','all')>
    <!---<cfset vars.cleanURL = REReplaceNoCase(vars.cleanURL,'//','/','all')>--->
    <!---=--->
    <cfif vars.originalURL NEQ vars.cleanURL>
      <cf_location url='#vars.cleanURL#'>
    </cfif>
    <!---=--->
    <cfinclude template="/nccuRootMapping/utilities/initializePage.cfm">
    <!---=--->
    <cfset vars.pageID = objCMS.GetCMSPageID(targetURL=vars.cleanTargetPage)>
    <!---<cfset vars.pageID = objCMS.GetCMSPageID(targetURL=vars.cleanURL)>--->
    <cfif vars.pageID GT 0>
      <cf_getCMSPage pageID='#vars.pageID#'>
    <cfelse>
      <cf_applyTemplate 
        templateName='summer2013'
        pageTitle='Page Not Found' 
        secondaryNavigationID='279' 
        secondaryNavigationPath='' 
        displaySecondaryNavigationAdvertisement='0'
      >
        <cfinclude template="/404_block.cfm">
      </cf_applyTemplate>
    </cfif>
    <cfreturn 1>
  </cffunction>
</cfcomponent>
