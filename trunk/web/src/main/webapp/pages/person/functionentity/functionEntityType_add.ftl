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
<@s.url var="createurl" action="addFunctionEntityType" namespace="/functionentity" />
<#assign contextPath = request.contextPath/>
<div class="page-top-bar">
<ul class="path">权限管理<span>&gt;</span><a href="javascript:void(0)">功能实体类型管理</a><span>&gt;</span>新建功能实体类型</ul>
<ul class="page-control"><li><a href="javascript:void(0)" onfocus="this.blur()"><img src="${contextPath}/images/ico16/ico-back.gif" alt="" /><span onclick="page('functionEntityType_list.action')">返回</span></a></li></ul>
</div>
<div class="function-bar">
<ul class="business-info"></ul>
<ul class="form-function">
<li><a href="javascript:void(0)" onclick="postdata();" onfocus="this.blur()"><img src="${contextPath}/images/ico16/ico-save.gif" alt="保存" title="保存" /><span>保存</span></a></li>
</ul>
</div>
<div class="form-container">
<div class="form-title"><span class="form-title-into">新建功能实体类型</span></div>
<@s.form id="form" theme="css_xhtml" action="${createurl}">
<table cellspacing="1" cellpadding="0">
    <tr>
      <td class="from-require">功能实体类型名称:<input type="text" id="type_name" name="type.name" class="input-common input-word-10" /></td>
    </tr>
  </table>
<div class="form-title"></div>
<div class="main-form-btn">
     <div class="btn-order" onclick="postdata();">
        <ul>
          <li class="left-normal" id="btn1_11"></li>
          <li class="middle-normal" id="btn1_12"><img src="${contextPath}/images/ico16/ico-save.gif" alt="" />保 存</li>
          <li class="right-normal" id="btn1_13"></li>
       </ul>
      </div>
      <div class="btn-order" onclick="page('functionEntityType_list.action')">
        <ul>
          <li class="left-normal" id="btn1_21"></li>
          <li class="middle-normal" id="btn1_22"><img src="${contextPath}/images/ico16/ico-back.gif" alt="" />返 回</li>
          <li class="right-normal" id="btn1_23"></li>
       </ul>
      </div>
</div>
</div>
</@s.form>
</body>
</html>
<@s.url var="url" action="functionEntityType-addFunctionEntityType" namespace="/functionentity" />
<script type="text/javascript">
function postdata(){
   $('#form').submit();
}

function page(url){
	window.open(url,"main","");
}

$(function(){
   $("#form").submit(function(){
			validate();
			return false;
   });
   function validate(){
     var value = $('#type_name').val();
    if($.trim(value)==""){
      alert("名称不能为空");
      return;
    }
    
    $.ajax({
				url: "${url}",
				type: "POST",
				data: $("#form").serialize() + '&struts.enableJSONValidation=true&struts.validateOnly=true',
				complete: function(data, textStatus){
					var text = data.responseText;
				    //validate exception
					var errorsObject = StrutsUtils.getValidationErrors(text);
				     //show errors, if any
				     if(errorsObject && errorsObject.fieldErrors) {
				        StrutsUtils.showValidationErrors(document.getElementById("form"), errorsObject);
				     } else {
				       var jsonData = eval("("+text+")"); 
				       if(jsonData.msg){
                          alert(jsonData.msg);
				       }else{
				          page('functionEntityType_list.action');
				       }
				     }
				 }
			});
   }
});
</script>
</html>
