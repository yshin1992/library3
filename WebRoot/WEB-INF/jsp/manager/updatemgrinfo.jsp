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
				$("form").submit();
			});
		});
	</script>
  </head>
  
  <body>
  	<library:navigation cssClass="breadcrumb"/>
    <form action="manager/updateMgrCmt.html" method="post">
    
    <div class="row2">
  	<div class="col-md-8">
    <table class="table table-hover table-bordered" >
    	<tr>
    		<td class="tdTitle success" style="vertical-align:middle;">管理员ID</td>
    		<td class="tdValue"><input type="text" class="form-control" name="managerID" value="${curUser.model.managerID }" readonly="readonly"/></td>
    	</tr>
    	<tr>
    		<td class="tdTitle success" style="vertical-align:middle;">姓名</td>
    		<td class="tdValue"><input type="text" class="form-control" name="userName" value="${curUser.model.userName }" autocomplete="off"/></td>
    	</tr>
    	<tr>
    		<td class="tdTitle success">性别</td>
    		<td class="tdValue">
    			<input type="radio" name="sex" value="男" <c:if test="${curUser.model.sex eq '男'}">checked="checked"</c:if> />男 &nbsp;
    			<input type="radio" name="sex" value="女" <c:if test="${curUser.model.sex eq '女'}">checked="checked"</c:if> />女
    		</td>
    	</tr>
    	<tr>
    		<td class="tdTitle success" style="vertical-align:middle;">联系电话</td>
    		<td class="tdValue"><input class="form-control" type="text" name="telephone" value="${curUser.model.telephone }"  autocomplete="off"/></td>
    	</tr>
    	<tr>
    		<td class="tdTitle success" style="vertical-align:middle;">电子邮箱</td>
    		<td class="tdValue"><input type="text" class="form-control" name="email" value="${curUser.model.email }"  autocomplete="off"/></td>
    	</tr>
    </table> 
    	<!--  <input type="hidden" name="managerID" value="${curUser.model.managerID }"/> -->
    	<input type="button" value="保存修改" class="btn btn-primary"/> &nbsp;<input type="reset" value="取消" class="btn btn-default"/>
    	
    </div>
    </div>
    </form>
  </body>
</html>
