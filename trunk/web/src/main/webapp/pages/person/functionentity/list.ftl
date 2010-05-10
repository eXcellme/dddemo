<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>权限管理 - 功能实体管理</title>

    <#include "/pages/include/head.ftl" />
	<!--tree组件样式-->
	<#include "/pages/include/tree-css.ftl" />
	<script>
	</script>
    
    <style type="text/css">
      .tree-left-height{height:510px;}
   </style>
</head>
<body>

<#assign model="functionentity"/>
<#assign gridId="${model + 'Grid'}">
<@s.url id="indexurl" action="${model}Grid-index" namespace="/widgets"/>
<@s.url id="showurl" action="${model}Grid-show" namespace="/widgets"/>
<@s.url id="deleteurl" action="${model}Grid-delete" namespace="/widgets"/>

<!-- 功能实体类型下拉列表组件 start -->
<@s.component id="select_functionEntityType" template="components/dropdown.ftl"> 
		<@s.param name="dataModel" value="%{'functionEntityTypeClass'}" />
</@s.component>

<!-- 功能实体类型下拉列表组件 end -->
    

<div class="page-top-bar">
<ul class="path">权限管理<span>&gt;</span>功能实体管理</ul>
</div>
<div class="function-bar">
<ul class="form-function">
</ul>
</div>
<div class="list-container">
<div class="tree-left"><h1>权限分类</h1><div id="treeLeft" class="tree-left-height">

<#---->
	
	
	<@s.url var="actionUrl" action="tree" namespace="/widgets" />
	<@s.component id="tree" template="components/tree.ftl">
		<@s.param name="targetId" value="%{'tree'}" />
		<@s.param name="treeModelBean" value="%{'functionEntityTreeModel'}" />
		<@s.param name="parentProperty" value="%{'parent.id'}" />
		<@s.param name="idProperty" value="%{'id'}" />
		<@s.param name="textProperty" value="%{'alias'}" />
	</@s.component>
	<div id="tree"></div>
</div></div>
<div class="tree-right" id="treeRight">

<div class="list-container"  style="float:left;">
<div class="list-search">

<form id="search_form" class="list-search">
<ul>
<li>
	<label for="">功能实体类型：</label>
	<select id="select_functionEntityType" name="criteria.functionEntityType.id" class="select-word-10">
	</select>
</li>
<li><label for="">状态：</label><select id="" name="criteria.status" class="select-word-10">
        <option value="" selected="selected">全部</option>
    <option value="ENABLED">激活</option>
        <option value="DISABLED">停用</option>
  </select>
</li>
<li>
	<label for="">业务系统：</label>
	<select id="" name="" class="select-word-10">	
	<option>全部</option>
	</select>
</li>
</ul>

<ul>
    <li><label for="">功能实体名称：</label><input id="" name="criteria.name" type="text" class="input-common input-word-10" /></li>
	<li><label for="">功能实体别名：</label><input id="" name="criteria.alias" type="text" class="input-common input-word-10" /></li>
	<li class="search-btn-area">
        <div class="btn-order">
          <ul>
            <li class="left-normal" id="btn1_11"></li>
            <li class="middle-normal" id="submit"><img src="${contextPath}/images/ico16/ico-search.gif" alt="查询" />查 询</li>
            <li class="right-normal" id="btn1_13"></li>
          </ul>
        </div>
      </li>
</ul>
</form>
<script>$(function(){ $("#${gridId}").externalSearch("#search_form"); });</script>
</div>

<!--工具栏-->
<div class="toolbar">
	<ul>
	<li><a href="add.action" onfocus="this.blur()" target="main"><img src="${contextPath}/images/ico16/ico-add.gif" alt="新建" border="0" title="新建" /></a></li>
    <li><a id="btn-edit" href="javascript:void(0)"><img src="${contextPath}/images/ico16/ico-edit.gif" alt="修改" title="修改" /></a></li>
    <li><a id="btn-delete" href="javascript:void(0)"><img src="${contextPath}/images/ico16/ico-cancel.gif" alt="删除" title="删除" /></a></li>
    <li><a id="btn-setstatus" href="javascript:void(0)"><img src="${contextPath}/images/ico16/ico_commission_16.gif" alt="设置激活状态" border="0" title="设置激活状态" /></a></li>
    </ul>
</div>
<!--结束-->

<!-- grid start -->

<@sj.grid 
	id="${gridId}" 
	caption="功能实体列表" 
	dataType="json"
	href="%{indexurl}"
	pager="true" 
	gridModel="gridModel"
	rowList="10,15,20"
	rowNum="10"
	rownumbers="true"
	multiselect="true"
	width="880"
	onGridCompleteTopics="grid-complete">
	<@sj.gridColumn name="id" 			index="id"			title="序号" 		hidden="true"	sortable="false"/>
	<@sj.gridColumn name="name" 		index="name"		title="功能实体名称" 	formatter="showlink" formatoptions="{baseLinkUrl:'%{showurl}'}" />
	<@sj.gridColumn name="alias" 		index="alias"		title="功能实体别名" 	sortable="false"/>
	<@sj.gridColumn name="functionEntityType.name" 		index="functionEntityType.name"		title="功能实体类型"		sortable="false"/>
	<@sj.gridColumn name="description"			index="description"		title="备注" 	sortable="false"/>
	<@sj.gridColumn name="status"		index="status"		title="状态"		formatter="icon" sortable="false"/>
</@sj.grid>

<!-- grid end -->

<div id="grid" class="border-lbr"></div>
</div>
</div>
</div>

<@sj.a openDialog="setStatusDialog" id="openDialog"  />
<@sj.dialog id="setStatusDialog" autoOpen="false" modal="true" title="设置状态" 
buttons="{  
                '确定':function() { setStatus();$(this).dialog('close'); }, 
                '取消':function() { $(this).dialog('close'); }  
                }"  
>

<@s.form id="saveform" action="">
<@s.hidden id="entityid" name="entity.id" value=""/>
<table cellpadding="0" cellspacing="0" class="form-2column">
  <tr>
      <th height="50" width="50">有效状态：</th>
      <td ><input type="radio" name="entity.status" value="ENABLED">
        启用
        <input type="radio" name="entity.status" value="DISABLED">
        停用</td>
    </tr>
</table>
</@s.form>

</@sj.dialog>

</body>

 <script>
$(function(){
	$("#${gridId}").enhanceGrid();
	$("#btn-delete").click(function(){
	   
	   var selectedId = $("#${gridId}").jqGrid('getGridParam','selrow');
	   if(selectedId != null){
	      if(window.confirm("确定要删除选中的记录吗？")){
		    $("#${gridId}").publish("grid-delete", {url: "${deleteurl}"});
	      }
	   }
	});

	$("#btn-edit").click(function(){
		var selectedId	= getSelectId();
		
		if(selectedId != null){
			var url = "edit.action?entity.id="+selectedId; 
		    window.open(url,"main",""); 
		}

	});
	
	$("#btn-setstatus").click(function(){
	    var selectedId	= getSelectId();
	    if(selectedId != null){
	        $("#entityid").val(selectedId);
			$("#openDialog").click();
		}
	});
	
	$("#tree").subscribe("tree-nodeSelect", function(event, data){
		data['criteria.id'] = data.id;
		delete data.id;
		$("#${gridId}").publish("grid-filter", data);
	});
});

  function getSelectId(){
	   var selectedId	= $("#${gridId}").jqGrid('getGridParam','selarrrow');
		
		if(selectedId.length==0){
             alert("请选中你所需要操作的记录");
             return null;
        }
         
		 if(selectedId.length>1){
             alert("当前操作只能选择一条记录");
             return null;
           }
        return selectedId;
	}
	
function setStatus(){  
$.ajax({                                                
    type: "POST",                                     
    url: "setStatus.action",                                    
    data: $("#saveform").serialize(),
    success: function(msg){
      $("#${gridId}").trigger("reloadGrid");
    } 
}); 
}
</script>
</html>
