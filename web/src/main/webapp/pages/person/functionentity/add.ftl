<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>新增功能实体</title>

    <#include "/pages/include/head.ftl" />
	
	<!--tree组件样式-->
	<#include "/pages/include/tree-css.ftl" />

  <style type="text/css">
      .tree-left-height{height:300px;}
   </style>
</head>
<body>
<div class="page-top-bar">
<ul class="path">权限管理<span>&gt;</span><a href="javascript:void(0)" onclick="goBack()">功能实体管理</a><span>&gt;</span>新建功能实体</ul>
  <ul class="page-control">
    <li><a href="javascript:void(0)" onfocus="this.blur()"><img src="${contextPath}/images/ico16/ico-back.gif" alt="" /><span onclick="goBack()">返回</span></a></li>
  </ul>
</div>
<div class="function-bar">
  <ul class="form-function">
<li><a href="javascript:void(0)" onfocus="this.blur()" onclick="postdata();"><img src="${contextPath}/images/ico16/ico-save.gif" alt="保存" title="保存" /><span>保存</span></a></li>
  </ul>
</div>
<div class="form-container">
<div class="form-title"><span class="form-title-into">新增功能实体</span></div>
	<@s.component id="select_functionEntityType" template="components/dropdown.ftl"> 
		<@s.param name="dataModel" value="%{'functionEntityTypeClass'}" />
     </@s.component>


<@s.form id="saveform" name="saveform" action="">

   <@s.hidden name="entity.version" value="0"/>
   <@s.hidden name="entity.status" value=""/>

  <table cellspacing="1" cellpadding="0" class="form-2column form-margin">
    <tr>
      <th>功能实体名称：</th>
      <td class="from-require"><input type="text" id="entity.name" name="entity.name" dataType="Require" msg="请填写功能实体名称" autocomplete="off" class="input-common input-word-10" />
例如“com.ce.myproject.MyService，作为功能实体真正的身份标志”</td>
    </tr>
    <tr>
      <th>功能实体别名：</th>
      <td class="from-require"><input type="text" name="entity.alias" dataType="Require" msg="请填写功能实体别名" autocomplete="off" class="input-common input-word-10" />
例如“我的方法”，作为树显示使用”</td>
    </tr>
    <tr>
      <th>功能实体类型：</th>
      <td><select id="select_functionEntityType" name="entity.functionEntityType.id" class="select-word-10" dataType="Require" msg="请选择功能实体类型" autocomplete="off">
	  </select></td>
    </tr>
    <tr>
      <th>父实体名称：</th>
      <td>
	  <div>
	  <ul>
	  <li style="float: left; padding-right: 5px;">
	  <input id="fpid" type="hidden" name="entity.parent.id" value="" />
	  <input type="text" name="parentName" id="fptext" class="input-common input-word-10" />
	  </li>
	  <li style="float: left;">
	   <div class="btn-order">
        <ul>
          <li class="left-normal" id="btn1_41"></li>
          <li class="middle-normal" id="btn1_42"><@sj.a openDialog="newDialog"><img src="${contextPath}/images/ico16/ico-search.gif" alt="查询" />查找父实体</@sj.a></li>
          <li class="right-normal" id="btn1_43"></li>
       </ul>
      </div>
	  </li>
	  </ul>
	  </div>
	  </td>
    </tr>
    <tr>
      <th>备注：</th>
      <td><textarea name="entity.description" cols="50" rows="5"></textarea></td>
    </tr>
  </table>
<div class="form-title"></div>
  <div class="main-form-btn">
    <div class="btn-order" onclick="postdata();">
      <ul>
        <li class="left-normal" id="btn1_11"></li>
        <li class="middle-normal" id="btn1_12" onmouseover="btn_change_over(1)" onmouseout="btn_change_out(1)" onblur="btn_change(1)"><img src="${contextPath}/images/ico16/ico-save.gif" alt="" />保存</li>
        <li class="right-normal" id="btn1_13"></li>
      </ul>
    </div>
    <div class="btn-order" onclick="page('permissions/tree.action')">
      <ul>
        <li class="left-normal" id="btn1_21"></li>
        <li class="middle-normal" id="btn1_22" onmouseover="btn_change_over(2)" onmouseout="btn_change_out(2)" onblur="btn_change(2)"><img src="${contextPath}/images/ico16/ico-back.gif" alt=""/>返 回</li>
        <li class="right-normal" id="btn1_23"></li>
      </ul>
    </div>
    
  </div>
  </@s.form>
</div>
</body>
<@s.component id="tree" template="components/tree.ftl" >
	<@s.param name="targetId" value="%{'tree'}" />
	<@s.param name="treeModelBean" value="%{'functionEntityTreeModel'}" />
	<@s.param name="parentProperty" value="%{'parent.id'}" />
	<@s.param name="idProperty" value="%{'id'}" />
	<@s.param name="textProperty" value="%{'alias'}" />
</@s.component>
<@sj.dialog id="newDialog" autoOpen="false" modal="true" title="选择父实体" 
buttons="{  
                '确定':function() { parentSelect();$(this).dialog('close'); }, 
                '取消':function() { $(this).dialog('close'); }  
                }"  
>
<div id="tree" class="tree-left-height"></div>
</@sj.dialog>


<script type="text/javascript">
function postdata(){  
var form = document.forms['saveform'];
var legal = Validator.Validate(form,3);

if(legal){
  $.ajax({                                                
    type: "POST",                                     
    url: "save.action",                                   
    data: $("#saveform").formToArray(),   
    success: function(msg){                 
	  goBack();                  
    } ,
    error:function(xmlhttp,textStatus, errorThrown){
        alert("error："); 
    }
}); 
}

}

<!--  lingen.liu修改，选择父节点的函数 -->
function parentSelect(){

	$("#fpid").val($("#tree").data("selected").id);
	$("#fptext").val($("#tree").data("selected").text);
}

function goBack(){
	window.open("list.action","main","");
}
</script>
</html>
