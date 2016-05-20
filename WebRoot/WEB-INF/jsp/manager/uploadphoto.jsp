<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
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
    <form action="manager/uploadCmt.html" enctype="multipart/form-data" method="post">
		<div id="localImag" style="border: 1px solid red;">

			<img id="preview" src="" width="100" height="100"
				style="display: block;border: 1px solid blue;" />

		</div>
		<div class="row2 col-md-12">
    	<div class="form-group">
    		图片路径:<input type="file" name="photo" id="photo" style="display:inline" onchange="javascript:setImagePreview();">
		</div>
	
    	<input type="submit" value="提交" class="btn btn-primary"/>
    </div>
    </form>
  </body>
  <script>
  function setImagePreview(avalue) {

      //input

          var docObj = document.getElementById("photo");

//img

          var imgObjPreview = document.getElementById("preview");

          //div

          var divs = document.getElementById("localImag");

          if (docObj.files && docObj.files[0]) {

              //火狐下，直接设img属性

              imgObjPreview.style.display = 'block';

              imgObjPreview.style.width = '100px';

              imgObjPreview.style.height = '100px';

              //imgObjPreview.src = docObj.files[0].getAsDataURL();

              //火狐7以上版本不能用上面的getAsDataURL()方式获取，需要一下方式

             imgObjPreview.src = window.URL.createObjectURL(docObj.files[0]);

          } else {

              //IE下，使用滤镜

              docObj.select();

              var imgSrc = document.selection.createRange().text;

              var localImagId = document.getElementById("localImag");

              //必须设置初始大小

              localImagId.style.width = "100px";

              localImagId.style.height = "100px";

              //图片异常的捕捉，防止用户修改后缀来伪造图片

              try {

                  localImagId.style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale)";

                  localImagId.filters.item("DXImageTransform.Microsoft.AlphaImageLoader").src = imgSrc;

              } catch(e) {

                  alert("您上传的图片格式不正确，请重新选择!");

                  return false;

              }

              imgObjPreview.style.display = 'none';

              document.selection.empty();

          }

          return true;

      }
  </script>
</html>
