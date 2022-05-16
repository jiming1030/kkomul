<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>게시글 작성</title>
</head>
<%@ include file="../main/header.jsp" %>
<c:set var="contextPath" value="${pageContext.request.contextPath == '/' ? '' : pageContext.request.contextPath }" scope="application" />

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">
	// 게시판 목록 보기
	function backToList(obj) {
		obj.action = "/board/boardList";
		obj.submit();
	}
	
</script>
<script type="text/javascript">
$(document).ready(function() {
	var formObj = $("form[role='form']");
	
	$("input[type='submit']").on("click", function(e){
		e.preventDefault();
		    
		console.log("submit clicked");
		
		var subject = $('#subject').val();
		var content = $('#content').val();
		
		if(subject == "" || subject == null) {
	      
			alert("글제목을 입력해주세요.");
	   		return false;
	   		
		} else if(content == "" || content == null){
	    	 
			alert("글내용을 입력해주세요.")
			return false;
			 
		} 
        
		var str = "";
		    
		$(".uploadResult ul li").each(function(i, obj){
			var jobj = $(obj);
		      
			console.dir(jobj);
			console.log("-------------------------");
			console.log(jobj.data("filename"));
		      
			str += "<input type='hidden' name='attachList["+i+"].fileName' value='"+jobj.data("filename")+"'>";
			str += "<input type='hidden' name='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"'>";
			str += "<input type='hidden' name='attachList["+i+"].uploadPath' value='"+jobj.data("path")+"'>";
			str += "<input type='hidden' name='attachList["+i+"].filetype' value='"+ jobj.data("type")+"'>";
		});
		    
		console.log(str);
		formObj.append(str).submit();
	});
		  
	var regex = new RegExp("(.*?)\.(jpg|jpeg|png)$");
	var maxSize = 5242880; //5MB
		  
	function checkExtension(fileName, fileSize) {
		if(fileSize >= maxSize) {
			alert("파일 사이즈 초과");
			return false;
		}
		    
		if(!regex.test(fileName)) {
			alert("해당 종류의 파일은 업로드할 수 없습니다.");
			return false;
		}
		
		return true;
	}
	
	$("input[type='file']").change(function(e){

		var formData = new FormData();
		    
		var inputFile = $("input[name='uploadFile']");
		    
		var files = inputFile[0].files;
        
		for(var i = 0; i < files.length; i++){

			if(!checkExtension(files[i].name, files[i].size)){
				return false;
			}
			
			formData.append("uploadFile", files[i]);
		}
		    
		$.ajax({
			url: "${contextPath}/uploadAjaxAction",
			processData: false, 
			contentType: false,data: 
			formData,type: "POST",
			dataType:"json",
			success: function(result){
				console.log(result); 
				showUploadResult(result); 
			}
		}); //$.ajax
	});  

	function showUploadResult(uploadResultArr) {
		    
	    if(!uploadResultArr || uploadResultArr.length == 0) { 
	    	return;
	    }
		    
	    var uploadUL = $(".uploadResult ul");
	    var str ="";
		    
	    $(uploadResultArr).each(function(i, obj) {
			var fileCallPath = encodeURIComponent(obj.uploadPath+ "/s_" + obj.uuid + "_" + obj.fileName);
			str += "<li data-path='" + obj.uploadPath + "'";
			str +=" data-uuid='" + obj.uuid + "' data-filename='" + obj.fileName + "' data-type='" + obj.image + "'"
			str +" ><div>";
			str += "<span> " + obj.fileName + "</span>";
			str += "<button type='button' data-file=\'" + fileCallPath + "\' "
			str += "data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
			str += "<img src='${contextPath}/display?fileName=" + fileCallPath + "'>";
			str += "</div>";
			str +"</li>";
		});
		    
		uploadUL.append(str);
	}

	$(".uploadResult").on("click", "button", function(e) {
		    
		console.log("delete file");
		      
		var targetFile = $(this).data("file");
		var type = $(this).data("type");
		var targetLi = $(this).closest("li");
		    
		$.ajax({
			url: "${contextPath}/deleteFile",
			data: {fileName: targetFile, type:type},
			dataType:"text",
			type: "POST",
			success: function(result){
// 				alert(result);
		           
				targetLi.remove();
			}
		}); //$.ajax
	});
});
</script>
<body>

	<h1 style="text-align: center; margin-top: 30px; font-size: 1.3em;">새글 쓰기</h1>
	
	<form action="/board/boardAdd" name="articleForm" method="post" enctype="multipart/form-data" role="form"> <!-- enctype > 브라우저에게 타입 알려줌 -->
		
		<input type="hidden" name="userid" value="${sessionScope.loginUser.userid}"> <!-- 세션에서 꺼내옴 -->
		
		<table border="0" align="center">
			<tr>
				<td align="right">글제목 : </td>
				<td colspan="2"><input type="text" size="68" maxlength="500" name="subject" id="subject"></td>
			</tr>
			<tr>
				<td align="right" valign="top">글내용 : </td> <!-- valign 열에서 탑인지 중간인지 바텀인지 -->
				<td colspan="2"><textarea rows="10" cols="65" name="content" id="content" maxlength="4000"></textarea></td>
			</tr>
 			<tr>
				<td align="right">파일 첨부 : </td>
				<td>
					<input type="file" name="uploadFile" multiple style="width: 100%; height: 100%;">
				</td>
				<td>        
					<div class="uploadResult"> 
			          <ul style="list-style: none;">
			          
			          </ul>
			        </div>
				</td><!-- 이미지 미리보기 영역 -->
 			</tr>
			<tr>
				<td align="right"></td>
				<td  colspan="2" align="right">
					<input class="write" type="submit" value="글쓰기">
					<input type="button" value="목록보기" onclick="backToList(this.form)">
				</td>
			</tr>
		</table>
	</form>
	
<script type="text/javascript">

</script>
<%@ include file="../main/footer.jsp" %>
</body>
</html>