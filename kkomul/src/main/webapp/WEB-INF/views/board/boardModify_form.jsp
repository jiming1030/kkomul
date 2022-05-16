<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>게시글 상세</title>
</head>
<%@ include file="../main/header.jsp" %>
<style>
	.uploadResult {
		width: 100%;
		height: 100%;
	}
	
	.uploadResult ul {
   		display: flex;
   		flex-flow: row;
		justify-content: center;
		align-items: center;
	}
	
	.uploadResult ul li {
		list-style: none;
		padding: 10px;
		align-content: center;
		text-align: center;
	}
	
	.uploadResult ul li img {
		width: 100%;
	}
	
</style>
<script type="text/javascript">

function readURL(input) {
	if (input.files && input.files[0]) {
		var reader = new FileReader();
		reader.onload = function(e) {
			$("#preview").attr("src", e.target.result);
		}
		reader.readAsDataURL(input.files[0]);
	}
}

</script>
</head>
<body>
	<form action="/board/boardModify" name="frm" method="post" enctype="multipart/form-data" role="form">
		<table border="0" align="center">
			<tr>
				<td width="150" align="center">글번호</td>
				<td>
					<input type="text" value="${boardInfo.bno }" disabled="disabled">
					<input type="hidden" name="bno" value="${boardInfo.bno }">
				</td>
			</tr>
			<tr>
				<td width="150" align="center">작성자</td>
				<td>
					<input type="text" name="userid" value="${boardInfo.userid}" disabled="disabled">
				</td>
			</tr>
			<tr>
				<td width="150" align="center">제목</td>
				<td>
					<input type="text" name="subject" value="${boardInfo.subject }" id="subject">
				</td>
			</tr>
			<tr>
				<td width="150" align="center">내용</td>
				<td><textarea rows="10" cols="65" name="content" id="content">${boardInfo.content}</textarea></td>
			</tr>
			<tr>
				<td align="center">파일 첨부</td>
				<td>
					<div>
						<input type="file" name="uploadFile" multiple="multiple">
					</div>
					<div class="uploadResult">
						<ul style="list-style: none;">
						</ul>
					</div>
				</td>
			</tr>
			<tr>
				<td width="150" align="center">등록일자</td>
				<td>
					<input type="text" value='<fmt:formatDate value="${boardInfo.regdate }" pattern="yyyy-MM-dd HH:mm:ss"/>' disabled="disabled">
				</td>
			</tr>
			<tr id="tr_btn_modify">
				<td colspan="2" align="center">
					
					<button type="submit" data-oper="modify">수정반영하기</button>
			        <button type="submit" data-oper="cancel">취소</button>
					
				</td>
			</tr>
		</table>
	</form>
<%@ include file="../main/footer.jsp" %>
</body>
<script>
	$(document).ready(function() {
		(function(){
			var bno = "${boardInfo.bno}";
			
			$.getJSON("/board/getAttachList", {bno: bno}, function(arr) {
				console.log(arr);
				
				var str = "";
				
				$(arr).each(function(i, attach) {
					
					//image type
					if (attach.filetype) {
						var fileCallPath = encodeURIComponent(attach.uploadPath + "/s_" + attach.uuid + "_" + attach.fileName);
						
						str += "<li data-path='" + attach.uploadPath + "'data-uuid='" + attach.uuid 
								+ "'data-filename='" + attach.fileName + "'data-type='" + attach.filetype + "'><div>";
						
						str += "<span> " + attach.fileName + "</span>";
						str += "<button type='button' data-file=\'" + fileCallPath + "\' data-type='image'"
						str += "class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
						
						str += "<img src='/display?fileName=" + fileCallPath + "'>";
						str += "</div>";
						str +"</li>";
					
					} else {
						str += "<li data-path='" + attach.uploadPath + "'data-uuid='" + attach.uuid 
								+ "'data-filename='" + attach.fileName + "'data-type='" + attach.filetype + "'><div>";
						str += "<span>" + attach.fileName + "</span><br/>";
						
						str += "<button type='button' data-file=\'" + fileCallPath + "\' data-type='image'"
						str += "class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";

						str += "<img src='/resources/images/attach.png'>";
						str += "</div>";
						str +"</li>";
					}
				});
				
				$(".uploadResult ul").html(str);
			}); // end getjson
		})(); // end function

		$(".uploadResult").on("click", "button", function(e) {
			console.log("delete file");
			
			if(confirm("Remove this file?")) {
				
				var targetLi = $(this).closest("li");
				targetLi.remove();
			}
		});
		
		var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
		var maxSize = 5242880; //5MB
			  
		function checkExtension(fileName, fileSize) {
			if(fileSize >= maxSize) {
				alert("파일 사이즈 초과");
				return false;
			}
			    
			if(regex.test(fileName)) {
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

				if(!checkExtension(files[i].name, files[i].size) ){
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
				if(obj.image){
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
				} else {
					var fileCallPath = encodeURIComponent(obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName);			      
				    var fileLink = fileCallPath.replace(new RegExp(/\\/g),"/");
					      
					str += "<li "
					str += "data-path='" + obj.uploadPath + "' data-uuid='" + obj.uuid + "' data-filename='" + obj.fileName + "' data-type='" + obj.image + "' ><div>";
					str += "<span> " + obj.fileName + "</span>";
					str += "<button type='button' data-file=\'" + fileCallPath + "\' data-type='file' " 
					str += "class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
					str += "<img src='${contextPath}/resources/images/attach.png''></a>";
					str += "</div>";
					str +"</li>";
				}
			});
			    
			uploadUL.append(str);
		}

		var formObj = $("form");
		
		$('button').on("click", function(e) {
			
			e.preventDefault();
			
			var operation = $(this).data("oper");
			
			console.log(operation);
			
			if(operation === 'cancel') {
				history.go(-1);
			
			} else if(operation === 'modify') {
				
				console.log("submit clicked");
				
				var str = "";
				
				$(".uploadResult ul li").each(function(i, obj) {
					
					var jobj = $(obj);
					
					console.dir(jobj);
					
					str += "<input type='hidden' name='attachList[" + i + "].fileName' value='" + jobj.data("filename") + "'>";
					str += "<input type='hidden' name='attachList[" + i + "].uuid' value='" + jobj.data("uuid") + "'>";
					str += "<input type='hidden' name='attachList[" + i + "].uploadPath' value='" + jobj.data("path") + "'>";
					str += "<input type='hidden' name='attachList[" + i + "].filetype' value='" +jobj.data("type") + "'>";
				});
				
				formObj.append(str).submit();
			}

			formObj.submit();
		});
	});
</script>
</html>