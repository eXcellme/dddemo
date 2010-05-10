<#assign contextPath = request.contextPath/>

<#macro url path>
	<@s.url value="${path}"/>
</#macro>

<#macro firebug>
<a href="javascript:var firebug=document.createElement('script');firebug.setAttribute('src','http://getfirebug.com/releases/lite/1.2/firebug-lite-compressed.js');document.body.appendChild(firebug);(function(){if(window.firebug.version){firebug.init();}else{setTimeout(arguments.callee);}})();void(firebug);">Firebug Lite</a>
</#macro>

<#macro js src>
<script src="${contextPath}${src}" type="text/javascript" charset="utf-8"></script>
</#macro>

<#macro css href>
<link href="${contextPath}${href}" rel="stylesheet" type="text/css" />
</#macro>

<#macro select>
</#macro>