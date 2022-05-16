<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>프로필사진</title>
</head>
<%@ include file="../main/header.jsp" %>
<script type="text/javascript">
function readURL(input) {
	if (input.files && input.files[0]) {
		var reader = new FileReader();
		reader.onload = function(e) { //호출
			$("#preview").attr("src", e.target.result); // 속성값 바꾸기
		}
		reader.readAsDataURL(input.files[0]);
	}
}

</script>
<body>
	<div style="margin-left: auto; margin-right: auto; text-align: center;">
	<h1 style="margin: 30px; font-size: 1.5em;">프로필 사진</h1>
	
	   <form action="/member/profileUpload" method="post" enctype="multipart/form-data">
	   
         <img id="preview" onerror="this.src='/resources/images/default/default.jpg'" src="/displayProfile?userid=${sessionScope.loginUser.userid }&fileName=${sessionScope.loginUser.fileName }" width="350px" height="300px"/><br>
         <input type="file" name="uploadFile" onchange="readURL(this)"><br>
         <input type="hidden" name="userid" value="${sessionScope.loginUser.userid}" />
         
     	 <br>  	     
      	 <input type="submit" value="사진 변경" class="profile">
	   </form>
   </div>
<hr>
<%@ include file="../main/footer.jsp" %>
</body>
</html>