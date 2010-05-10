<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>权限管理 - 功能实体管理</title>
    <#include "/pages/include/head.ftl" />
	  <style type="text/css">
      .tree-left-height{height:510px;}
   </style>
</head>
<body>
<#assign contextPath = request.contextPath/>
<@rw.gridToolbar grid="functionEntityTypeGrid"/>
<#assign model="functionEntityType"/>
	<#assign gridId="${model + 'Grid'}">
	<@s.url id="showurl" action="${model}GridShow"/>
	<@s.url id="deleteurl" action="${model}GridDelete"/>
	<@rw.topicBridge 
		publisher="tree" publisherTopic="tree-a"
		subscriber="${gridId}" subscriberTopic="grid-filter"/>
		
<div class="page-top-bar">
<ul class="path">权限管理<span>&gt;</span>功能实体类型管理</ul>
</div>
<div class="function-bar">
<ul class="form-function">
<li><a href="functionEntityType_add.action" target="main"><img src="${contextPath}/images/ico16/ico-add.gif" alt="新建" title="新建" /></a></li>
  <li><a id="btn-modify"><img src="${contextPath}/images/ico16/ico-edit.gif" alt="修改" title="修改" /></a></li>
   <li><a id="functionEntityTypeGrid-delete"><img src="${contextPath}/images/ico16/ico-cancel.gif" alt="删除" title="删除" /></a></li>
</ul>
</div>
<div class="list-container">
<div class="list-search">
<form id="search_form" name="search_form">
<ul>
<li>功能实体类型名称：<input name="criteria.name"/></li>
<li class="search-btn-area">
      <div class="btn-order">
        <ul>
          <li class="left-normal" id="btn1_11"></li>
          <li id="submit" class="middle-normal"><img src="${contextPath}/images/ico16/ico-search.gif"" alt="查询" />查 询</li>
          <li class="right-normal" id="btn1_13"></li>
       </ul>
      </div>
	</li>
</ul>
</form>
<script>$(function(){ $("#${gridId}").externalSearch("#search_form"); });</script>
</div>

<div id="grid" class="border">
<@rw.grid 
    	id="${gridId}" 
    	caption="功能实体类型" 
    	dataType="json"
    	pager="true" 
    	multiselect="true"
        width="1000"
    	gridModel="gridModel"
    	rowList="10,15,20"
    	rowNum="10"
    	rownumbers="true"
    	onGridCompleteTopics="grid-complete">
    	<@sj.gridColumn name="id" 			index="id"			title="功能实体类型ID" 	sortable="false"/>
    	<@sj.gridColumn name="name" 		index="name"		title="功能实体类型名称" 	formatter="showlink" formatoptions="{baseLinkUrl:'%{showurl}'}" />
    </@rw.grid>
    <!-- grid body end -->
</div>
</div>
</body>
<script>

	$(function(){
		$("#btn-modify").click(function(){
           var selectedIds = $("#${gridId}").jqGrid('getGridParam','selarrrow');
           if(selectedIds.length>1){
             alert("只能选择一个进行修改");
             return;
           }
           if(selectedIds.length==0){
             alert("请选中你所需要修改的记录");
             return;
           }
		      page('functionEntityType-getFunctionEntityType.action?id='+selectedIds);
		});
		
		$("#${gridId}").enhanceGrid();
	});
	</script>
</html>
