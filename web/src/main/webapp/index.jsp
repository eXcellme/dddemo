<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%> 
<%
 String contextPath = request.getContextPath();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>LPS系统框架培训DEMO</title>
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
}
-->
</style></head>

<body>
<div align="center"><a href="<%=contextPath %>/functionentity/functionEntityType_list.action" target="main">功能实体类型管理</a> &nbsp;<a href="<%=contextPath %>/functionentity/list.action" target="main">功能实体管理</a></div>
<br/>
<iframe  height="600px" width="100%" frameBorder=0 name="main"  scrolling="yes" src=""></iframe>
</body>

</html>