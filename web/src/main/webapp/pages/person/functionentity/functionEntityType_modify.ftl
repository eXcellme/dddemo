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
<div class="form-title"><span class="form-title-into">修改功能实体类型</span></div>
<@s.form id="saveform" name="saveform" action="functionEntityType-modifyFunctionType.action" namespace="/permissions" method="POST">
<table cellspacing="1" cellpadding="0">
    <tr>
      <td class="from-require"><@s.hidden name="type.id" value="%{type.id}"/><@s.hidden name="type.version" value="%{type.version}"/></td>
    </tr>
    <tr>
      <td class="from-require"><@s.textfield name="type.name" value="%{type.name}" id="type_name" label="功能实体类型名称:" /></td>
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
          <li class="middle-normal" id="btn1_22" 2)"><img src="${contextPath}/images/ico16/ico-back.gif" alt="" />返 回</li>
          <li class="right-normal" id="btn1_23"></li>
       </ul>
      </div>
</div>
</div>
</@s.form>
</body>
</html>
<script type="text/javascript">
function postdata(){  
    var value = $('#type_name').val();
    if($.trim(value)==""){
      alert("名称不能为空");
      return;
    }
	$('#saveform').submit();
}

function page(url){
	window.open(url,"main","");
}
</script>
</html>
