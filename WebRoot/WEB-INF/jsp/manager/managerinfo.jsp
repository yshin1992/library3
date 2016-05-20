<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="fmt" %>
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
  </head>
  
  <body>
  	<library:navigation cssClass="breadcrumb"/>
  	<div class="row2">
  	<div class="col-md-8">
    <table class="table table-hover table-bordered">
    	<tr>
    		<td colspan="2">
    			<img src="manager/showPhoto.do?managerID=${curUser.model.managerID }" width="59" height="82" style="vertical-align:middle"/>
    		</td>
    	</tr>
    	<tr>
    		<td class="tdTitle success">管理员ID</td>
    		<td class="tdValue">${curUser.model.managerID }</td>
    	</tr>
    	<tr>
    		<td class="tdTitle success">姓名</td>
    		<td class="tdValue">${curUser.model.userName }</td>
    	</tr>
    	<tr>
    		<td class="tdTitle success">性别</td>
    		<td class="tdValue">${curUser.model.sex }</td>
    	</tr>
    	<tr>
    		<td class="tdTitle success">联系电话</td>
    		<td class="tdValue">${curUser.model.telephone }</td>
    	</tr>
    	<tr>
    		<td class="tdTitle success">电子邮箱</td>
    		<td class="tdValue">${curUser.model.email }</td>
    	</tr>
    	<tr>
    		<td class="tdTitle success">创建时间</td>
    		<td class="tdValue"><fmt:formatDate value="${curUser.model.createTime }" pattern="yyyy-MM-dd HH:mm:ss"/></td>
    	</tr>
    	<c:if test="${curUser.model.roleId eq 2 }">
    	<tr>
    		<td class="tdTitle success">是否是超级管理员</td>
    		<td class="tdValue">是</td>
    	</tr>
    	</c:if>
    </table>
    </div>
    </div>
  </body>
</html>
