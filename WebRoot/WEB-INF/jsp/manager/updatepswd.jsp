<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="library/tags" prefix="library"%>
<!DOCTYPE>
<html>
<head>
<base href="<%=basePath%>">
	<title><library:pageTitle/></title>
	<script type="text/javascript" src="js/jquery-1.11.2.js"></script>
	<script type="text/javascript" src="bootstrap/js/bootstrap.js"></script>
	<link rel="stylesheet" href="bootstrap/css/bootstrap.css">
	<link rel="stylesheet" href="css/base.css">	
	<style type="text/css">
		#EEE1,#EEE2,#EEE3 {
			color:red
		}
	</style>
</head>

<body>
	<library:navigation cssClass="breadcrumb" />
	<form class="form-horizontal" action="manager/updateMgrPswdCmt.html" method="post">
	  <div class="form-group">
	    <label class="col-sm-2 control-label">原密码</label>
	    <div class="col-sm-4">
	      <input type="password" class="form-control" id="oldPswd" name="oldPswd" placeholder="原密码"/>
	    </div>
	    <div class="col-sm-4" id="EEE1"></div>
	  </div>
	  <div class="form-group">
	    <label class="col-sm-2 control-label">新密码</label>
	    <div class="col-sm-4">
	      <input type="password" class="form-control" id="newPswd" name="newPswd" placeholder="新密码">
	    </div>
	    <div class="col-sm-4" id="EEE2"></div>
	  </div>
	  <div class="form-group">
	    <label class="col-sm-2 control-label">确认密码</label>
	    <div class="col-sm-4">
	      <input type="password" class="form-control" id="confirm" placeholder="确认新密码">
	    </div>
	    <div class="col-sm-4" id="EEE3"></div>
	  </div>
	  <div class="form-group">
	    <div class="col-sm-offset-2 col-sm-10">
	      <button type="button" class="btn btn-primary">修改密码</button>
	    </div>
	  </div>
	</form>
</body>

<script>
	$(document).ready(function(){
		$("#newPswd").blur(function(){
			var newPswd=$("#newPswd").val();
			var oldPswd=$("#oldPswd").val();
			newPswd=newPswd.replace(/\s/g,"");
			oldPswd=oldPswd.replace(/\s/g,"");
			if(newPswd.length<6){
				$("#EEE2").html("*新密码长度不能小于6个字符");
			}
			if(oldPswd==newPswd){
				$("#EEE2").html("*新密码和原密码相同");
			}
		});
		$("button").click(function(){
			var newPswd=$("#newPswd").val();
			var cfmPswd=$("#confirm").val();
			newPswd=newPswd.replace(/\s/g,"");
			cfmPswd=cfmPswd.replace(/\s/g,"");
			if(newPswd!=cfmPswd){
				$("#EEE3").html("*确认密码与新密码不一致");
				return ;
			}
			var oldPswd=$("#oldPswd").val();
			oldPswd=oldPswd.replace(/\s/g,"");
			if(oldPswd==newPswd){
				$("#EEE2").html("*新密码和原密码相同");
				return ;
			}
			$("form")[0].submit();
		});
	});
</script>

</html>
