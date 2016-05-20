<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib uri="library/tags" prefix="library" %>
<!DOCTYPE HTML>
<html>
  <head>
    <base href="<%=basePath%>">
    <title><library:pageTitle/></title>
    <script type="text/javascript" src="js/jquery-1.11.2.js"></script>
	<script type="text/javascript" src="bootstrap/js/bootstrap.js"></script>
	<link rel="stylesheet" href="bootstrap/css/bootstrap.css">
	<link rel="stylesheet" href="css/base.css">
	<script>
		$(document).ready(function(){
			$(":button").click(function(){
				location.href="manager/addmanager.html";
			});
		
		});
	</script>
	
  </head>
  
  <body>
  	<library:navigation cssClass="breadcrumb"/>
  	<div class="row2">
  	<div class="col-md-8">
    <table class="table table-hover table-bordered" >
    	<tr>
    		<td class="tdTitle success">管理员ID</td>
    		<td class="tdValue">${addUser.managerID }</td>
    	</tr>
    	<tr>
    		<td class="tdTitle success">姓名</td>
    		<td class="tdValue">${addUser.userName }</td>
    	</tr>
    	<tr>
    		<td class="tdTitle success">性别</td>
    		<td class="tdValue">${addUser.sex }</td>
    	</tr>
    	<tr>
    		<td class="tdTitle success">联系电话</td>
    		<td class="tdValue">${addUser.telephone }</td>
    	</tr>
    	<tr>
    		<td class="tdTitle success">电子邮箱</td>
    		<td class="tdValue">${addUser.email }</td>
    	</tr>
    	<c:if test="${addUser.roleId eq 2 }">
    	<tr>
    		<td class="tdTitle success">是否是超级管理员</td>
    		<td class="tdValue">是</td>
    	</tr>
    	</c:if>
    </table>
    <input type="button" class="btn btn-success" value="继续新增"/>
    </div>
    </div>
  </body>
</html>
