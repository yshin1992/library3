<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
pageContext.setAttribute("basePath", basePath);
%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<!DOCTYPE html>
<html>
  <head>
    <title>login.html</title>
	<meta charset="UTF-8">
    <meta name="keywords" content="libray,图书馆">
    <meta name="description" content="图书馆管理系统">
	<style>
		#EEE,#errorId,#errorPswd,#errorVrCode{
			color:red
		}
	</style>
	 <script type="text/javascript" src="js/jquery-1.11.2.js"></script>
    <script type="text/javascript" src="bootstrap/js/bootstrap.js"></script>
	<script type="text/javascript" src="js/displaytag.js"></script>
	<link rel="stylesheet" href="bootstrap/css/bootstrap.css">
	<script>
	if (window != top){
		top.location.href ="<c:out value='${basePath }'/>";
	}
	
	function checkForm(){
		var userId = $("input[name='userId']").val();
		var pswd = $(":password").val();
		var verifyCode=$("input[name='verifyCode']").val();
		//清除空格
		userId = userId.replace(/\s/g, "");
		pswd = pswd.replace(/\s/g, "");
		verifyCode=verifyCode.replace(/\s/g, "");
		if (userId == "") {
			$("#errorId").html("*用户名不能为空");
		}
		if (pswd == "") {
			$("#errorPswd").html("*密码不能为空");
		}
		if (verifyCode == "") {
			$("#errorVrCode").html("*验证码不能为空");
		}
		if (userId != "" && pswd != ""&&verifyCode!=""){
			$("#form1").attr("action","<c:url value='/login.html'/>");
			$("#form1").submit();
		}
	}
	
	$(document).ready(function() {
		$("img").click(function(){
			$("img").attr("src","<c:url value='/verifyCode.do'/>?time="+new Date());
		})
	})
</script>
  </head>
  
  <body>
  	<nav class="navbar navbar-default">
	  <div class="container">
	    <div class="navbar-header">
	      <span class="navbar-brand">
	        	图书馆管理系统
	      </span>
	    </div>
	  </div>
	</nav>
	<div class="container">
    <form class="form-horizontal"  method="post" id="form1">
	  <div class="form-group">
	    <label for="userId" class="col-sm-2 control-label col-sm-offset-2">账号</label>
	    <div class="col-sm-4">
	      <input type="text" name="userId" class="form-control" placeholder="身份证号"  maxlength="30"/></span>
	    </div>
	    <div class="col-sm-2" id="errorId"></div>
	  </div>
	  <div class="form-group">
	    <label for="password" class="col-sm-2 control-label col-sm-offset-2">密码</label>
	    <div class="col-sm-4">
	      <input type="password" name="password" class="form-control" placeholder="密码"  maxlength="30"/></span>
	    </div>
	    <div class="col-sm-2" id="errorPswd"></div>
	  </div>
	  <div class="form-group">
	    <label for="userId" class="col-sm-2 control-label col-sm-offset-2">验证码</label>
	    <div class="col-sm-2">
	      <input type="text" name="verifyCode" class="form-control col-sm-5" placeholder="验证码" autocomplete="off" maxlength="4"/>
	    </div>
	    <div class="col-sm-2"><img src="<c:url value='/verifyCode.do'/>" title="看不清，换一张"/></div>
	    <div class="col-sm-2" id="errorVrCode">${verifyError }</div>
	  </div>
	  <div class="col-sm-8 col-sm-offset-4">
	  			<input type="button" value="提交" onclick="checkForm();" class="btn btn-primary"/>&nbsp;&nbsp;
    			<input type="reset" name="reset" value="重置" class="btn btn-default"/>
	  </div>
	  
    <div id="EEE" class="col-sm-8 col-sm-offset-2">
	    <c:if test="${not empty error}">
	    	<font color="red"><c:out value="${error }"/></font>
	    </c:if>
    </div>
     
    </form>
    </div>
  </body>
</html>

