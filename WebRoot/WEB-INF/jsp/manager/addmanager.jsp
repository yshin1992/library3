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
				/**
				校验这一块js还未做
				**/
				$("form").submit();
			});
		});
	</script>
</head>
<body>
	<library:navigation cssClass="breadcrumb"/>
	<form action="manager/addMgrCmt.html" method="post">
	<div class="row2">
  	<div class="col-md-8">
    <table class="table table-hover table-bordered" >
    	<tr>
    		<td class="tdTitle success" style="vertical-align:middle;">管理员ID</td>
    		<td class="tdValue"><input type="text" class="form-control" name="managerID" autocomplete="off"/></td>
    	</tr>
    	<tr>
    		<td class="tdTitle success"  style="vertical-align:middle;">姓名</td>
    		<td class="tdValue"><input type="text" class="form-control" name="userName" autocomplete="off"/></td>
    	</tr>
    	<tr>
    		<td class="tdTitle success">性别</td>
    		<td class="tdValue">
    			<input type="radio" name="sex" value="男" checked="checked"/>男 &nbsp;
    			<input type="radio" name="sex" value="女" />女
    		</td>
    	</tr>
    	<tr>
    		<td class="tdTitle success"  style="vertical-align:middle;">联系电话</td>
    		<td class="tdValue"><input type="text" class="form-control" name="telephone" autocomplete="off"/></td>
    	</tr>
    	<tr>
    		<td class="tdTitle success" style="vertical-align:middle;">电子邮箱</td>
    		<td class="tdValue"><input type="text" class="form-control" name="email" autocomplete="off"/></td>
    	</tr>
    </table> 
    	<input type="button" class="btn btn-primary" value="新增"/> &nbsp;<input type="reset" class="btn btn-default" value="取消"/>
    	</div>
    </div>
    </form>
    <div id="EEE"><c:out value="${addMgrError}"/></div>
</body>
</html>