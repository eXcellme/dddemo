<#import "/pages/import/helper.ftl" as h />
<#-- scripts -->
<#-- sj (jquery and plugins included) -->
<@sj.head locale="cn" compressed="false" useJqGridPlugin="true" jqueryui="true" jquerytheme="redmond"/>
<#-- redwork extends -->
<@h.js src="/static/jquery.jqGrid.ext.js"/>
<@h.js src="/static/dropdown/jquery.ajaxDropdown.js"/>
<@h.js src="/static/cbox/jquery.colorbox.js"/>
<@h.js src="/javascripts/jquery.ajaxTree.js"/>
<@h.js src="/javascripts/jquery.blockUI.js"/>
<#--<@h.js src="/firebug-lite.js"/>-->
<#-- validation -->
<@h.js src="/struts/utils.js"/>
<@h.js src="/struts/xhtml/validation.js"/>
<@h.js src="/struts/css_xhtml/validation.js"/>
<@h.js src="/static/validate/jquery.validate.js"/>
<@h.js src="/static/validate/jquery.validate.ext.js"/>
<@h.js src="/javascripts/Simple.Validate.js"/>
<@h.js src="/javascripts/redwork.validate.submit.js"/>

<#-- window ext js -->
<@h.js src="/uiwidget/window/ext-base.js"/>
<@h.js src="/uiwidget/window/ext-all.js"/>
<@h.js src="/uiwidget/window/window.js"/>
<@h.js src="/javascripts/public.js"/>

<#-- ctyles -->
<@h.css href="/css/common.css"/>
<@h.css href="/css/list.css"/>
<@h.css href="/css/left-nav.css"/>
<@h.css href="/uiwidget/window/css/window.css"/>
<@h.css href="/static/cbox/colorbox.css"/>
<@h.css href="/css/tree.css"/>
<@h.css href="/css/popwindow.css"/>

<#assign contextPath = request.contextPath/>
<script>
function page(p){
		window.open(p,"main","");
}
function icon(cellvalue, options, rowdata){
	if(cellvalue == 0 || cellvalue == "DISABLED")
		return "<img src='${contextPath}/images/ico16/ico-prohibit.gif'/>";
	else if(cellvalue==1 || cellvalue == "ENABLED")
		return "<img src='${contextPath}/images/ico16/ico-pass.gif'/>";
	else
		return cellvalue;
}
</script>