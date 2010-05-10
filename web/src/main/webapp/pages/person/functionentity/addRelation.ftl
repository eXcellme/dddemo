<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title></title>
	<!-- sj start -->
	<@sj.head locale="cn" useJqGridPlugin="true" compressed="false" jqueryui="true" jquerytheme="redmond"/>
	<!-- sj end -->
	<link href="/css/index.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" href="/styles/tree.css" />
    <link href=" /css/list.css" rel="stylesheet" type="text/css" />
    <link href="../../../uiwidget/grid/css/uiwidget-grid.css" rel="stylesheet" type="text/css" />
    <link href="../../../uiwidget/tree/css/uiwidget-tree.css" rel="stylesheet" type="text/css" />
    <link href="../../../css/index.css" rel="stylesheet" type="text/css" />
    <link href="../../../css/tree.css" rel="stylesheet" type="text/css" />

    <script src="/static/jquery.jqGrid.ext.js" type="text/javascript" charset="utf-8"></script>
    <script src="/struts/utils.js" type="text/javascript"></script>
    <script src="/struts/css_xhtml/validation.js" type="text/javascript"></script>
    <script src="/javascripts/jquery.validate.js" type="text/javascript" charset="utf-8"></script>
    <script src="/javascripts/jquery.ajaxTree.js" type="text/javascript" charset="utf-8"></script>
</head>
<body>

<div class="popwindow-title">功能实体管理设置</div>
<div class="popwindow-container">
    <#assign model="resource"/>
	<#assign gridId="${model + 'Grid'}">
	<@s.url id="indexurl" action="${model}GridIndex"/>
	<@s.url id="showurl" action="${model}GridShow"/>
	<@s.url id="deleteurl" action="${model}GridDelete"/>
<!-- search start -->
	<form id="search_form" name="search_form">
		<div class="list-search">
	<ul>
	<li>
	  <label for="">实体名称：</label><input id="" name="criteria.value" type="text" class="input-common input-word-10" />
	  </li>
	<li>
	  <label for="">实体别名：</label><input id="" name="criteria.name" type="text" class="input-common input-word-10" />
	  </li>
    <li><label for="">业务系统：</label><select id="" name="" class="select-word-10">
            <option selected="selected">请选择</option>
	  </select></li>
    <li><label for="">状态：</label><select name="commonityClassify" class="select-word-5" onchange="dateSelect(this.options [this.options.selectedIndex].value)">
              <option value="0" selected>已关联</option>
              <option value="1">未关联</option>
            </select></li><li class="search-btn-area">
      <div class="btn-order">
        <ul>
          <li class="left-normal" id="btn1_11"></li>
          <li class="middle-normal" id="btn1_12"><input type="image" src="${contextPath}/images/ico16/ico-search.gif" alt="查询" onclick="document.search_form.submit()"/>查 询</li>
          <li class="right-normal" id="btn1_13"></li>
       </ul>
      </div>
	  </li>
</ul>
</div>
	</form>
	<script>$(function(){ $("#${gridId}").externalSearch("#search_form"); });</script>
	<!-- search end -->

<!--工具栏-->
<div class="toolbar">
<ul>
     <li id="Select12"><a href="javascript:void(0)"><img src="../../../images/ico16/link_break2.gif" alt="解除关联" title="解除关联" /> 解除关联</a></li>
     <li id="Select14" style="display:none;"><a href="javascript:void(0)"><img src="../../../images/ico16/lock_edit.gif" alt="添加关联" title="添加关联" /> 添加关联</a></li>
	 <li class="toolbar-edit-line"></li>  
    </ul>
  </div>  
	<!-- search start -->
	<form id="search_form">
		
	</form>
	<script>$(function(){ $("#${gridId}").externalSearch("#search_form"); });</script>
	<!-- search end -->


	<!-- grid body start -->
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
    	onGridCompleteTopics="grid-complete">
    	<@sj.gridColumn name="id" 			index="id"			title="序号" 	sortable="false"/>
    	<@sj.gridColumn name="value" 		index="value"		title="功能实体名称" 	formatter="showlink" formatoptions="{baseLinkUrl:'%{showurl}'}" />
    	<@sj.gridColumn name="name" 		index="name"		title="功能实体别名" 	sortable="false"/>
    	<@sj.gridColumn name="resourcesTypeId" 		index="resourcesTypeId"		title="功能实体类型"		sortable="false"/>
    	<@sj.gridColumn name="memo"	index="memo"	title="备注"	formatter="currency" sortable="false"/>
    	<@sj.gridColumn name="status"	index="status"	title="状态"	formatter="currency" sortable="false"/>
    </@sj.grid>
    <!-- grid body end -->
	
	<@sj.dialog id="newDialog" autoOpen="false" modal="true" title="新建用户">
    	<@s.textfield label="姓名" name="%{object.name}"/>
    	<@s.textfield label="国家" name="%{object.name}"/>
    	<@sj.a button="true" onClickTopics="onSearch_${gridId}">保存</@sj.a>
    </@sj.dialog>
    
    <@sj.dialog id="editDialog" autoOpen="false" modal="true" title="修改用户">
    	<@s.textfield label="姓名" name="%{object.name}"/>
    	<@s.textfield label="国家" name="%{object.name}"/>
    	<@sj.a button="true" onClickTopics="onSearch_${gridId}">保存</@sj.a>
    </@sj.dialog>
 
</body>

</html>
