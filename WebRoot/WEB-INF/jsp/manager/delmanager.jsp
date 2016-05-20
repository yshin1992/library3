<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="fmt" %>
<%@ taglib uri="library/tags" prefix="library" %>
<%@ taglib uri="http://displaytag.sf.net/el" prefix="display" %>
<!DOCTYPE HTML>
<html>
<head>
<base href="<%=basePath%>">
<title><library:pageTitle/></title>
    <link rel="stylesheet" href="css/displaytag.css">
    <script type="text/javascript" src="js/jquery-1.11.2.js"></script>
	<script type="text/javascript" src="bootstrap/js/bootstrap.js"></script>
	<script type="text/javascript" src="js/displaytag.js"></script>
	<link rel="stylesheet" href="bootstrap/css/bootstrap.css">
	<link rel="stylesheet" href="css/base.css">
    <script type="text/javascript">
    	$(document).ready(function(){
    		/* $("#cboxs").click(
    			function(){
    				if($(this).prop("checked")){
    					$(":checkbox").prop("checked",true);
    				}else{
    					$(":checkbox").prop("checked",false);
    				}
    			}
    		); */
    		$("#query").click(function(){
    			document.forms[0].action="manager/delmanager.html";
    			$("form")[0].submit();
    		});
			$("#delete").click(function(){
				document.forms[0].action="manager/delMgrCmt.html";
				$("form")[0].submit();
    		});
    	});
    </script>
    <style type="text/css">
    	label {
    		margin-left:1em;
    		margin-right:1em;
    		line-height:2
    	}
    
    </style>
</head>
<body>
	<library:navigation cssClass="breadcrumb"/>
	<div class="row2">
  	<div class="col-md-12">
  	
  	<form action="manager/delmanager.html" class="form-inline" method="post">
    	<div class="form-group">
    		<label>查询方式</label>
    				<select name="fuzzy" class="form-control input-sm">
    					<option value="false" <c:if test="${bean.fuzzy == false }">selected="selected"</c:if>>精确查询</option>
    					<option value="true" <c:if test="${bean.fuzzy == true }">selected="selected"</c:if>>模糊查询</option>
    				</select>
    		<label>管理员ID</label><input type="text" name="model.managerID" value="${bean.model.managerID }" class="form-control input-sm " placeholder="身份证号"/>
    		<label>姓名</label><input type="text" name="model.userName" value="${bean.model.userName }" class="form-control input-sm " placeholder="例:张三"/>
    		<label>电话</label><input type="text" name="model.telephone" value="${bean.model.telephone }" class="form-control input-sm " placeholder="例:13053015666"/>
    		<label>电子邮件</label><input type="text" name="model.email" value="${bean.model.email }" class="form-control input-sm " placeholder="例:lisan@163.com"/>
    		<label>创建时间</label><input type="text" name="model.createTime" value="${bean.model.createTime }" class="form-control input-sm " placeholder="例:2011-06-23"/>
    		<label>性别</label>
    				<select name="model.sex" class="form-control input-sm">
    					<option value="">&nbsp;</option>
    					<option value="男" <c:if test="${bean.model.sex eq '男' }">selected="selected"</c:if>>男</option>
    					<option value="女" <c:if test="${bean.model.sex eq '女' }">selected="selected"</c:if>>女</option>
    				</select>
    				
    		<label>用户角色</label>
    				<select name="model.roleId" class="form-control input-sm">
    					<option value="">&nbsp;</option>
    					<option value="1" <c:if test="${bean.model.roleId eq '1' }">selected="selected"</c:if>>普通管理员</option>
    					<option value="2" <c:if test="${bean.model.roleId eq '2' }">selected="selected"</c:if>>超级管理员</option>
    				</select>
    				
    	<div style="float:right"><input type="button" id="query" value="查询" class="btn btn-default"/>&nbsp;<input type="button" id="delete" value="删除" class="btn btn-danger"/></div>
    	</div>
    <!-- </form> -->
    <!-- <form action="manager/delMgrCmt.html" method="post"> -->
	    <div id="data_container" class="data_container" pagenum="${mgrList.pageNumber }">
		    	<display:table name="mgrList" id="manager" defaultsort="3"  class="data_content_tb" requestURI="manager/delmanager.html" export="false" htmlId="displaytag_table">
			    	<display:column title="<input type='checkbox' id='cboxs' name='cboxs'>">
						<input type="checkbox" id="${manager.managerID}ID" name="ids" value="${manager.managerID}" <c:if test="${manager.managerID eq 'admin' }">disabled="disabled"</c:if> />
					</display:column>
					<display:column title="头像">
    					<img src="manager/showPhoto.do?managerID=${manager.managerID }" width="59" height="82" style="vertical-align:middle"/>
    				</display:column>
			    	<display:column title="管理员ID" sortable="true"  sortProperty="manager_id" property="managerID"  />
			    	<display:column title="姓名" property="userName" />
			    	<display:column title="性别" property="sex" />
			    	<display:column title="电话" property="telephone" />
			    	<display:column title="电子邮件" property="email" />
			    	<display:column title="用户角色" sortable="true"  sortProperty="role_id">
				    	<c:if test="${manager.roleId eq 1 }">普通管理员</c:if>
			    		<c:if test="${manager.roleId eq 2 }">超级管理员</c:if>
			    	</display:column>
			    	<display:column title="创建时间">
			    		<fmt:formatDate value="${manager.createTime }" pattern="yyyy-MM-dd HH:mm:ss"/>
			    	</display:column>
		    	</display:table>
    	</div>
    	<input type="hidden" name="pageSize" value="${bean.pageSize }" id="displaytag_page_size">
    </form>
    </div>
    </div>
</body>
</html>