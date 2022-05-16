<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="../main/header.jsp" %>
<title>게시글</title>
  
<style type="text/css">
	#tr_btn_modify {
		display: none;
	}

 	.uploadResult {
		width: 100%;
		height: 100%;
	}
	
	.uploadResult ul {
   		/* display: flex;
   		flex-flow: row; */
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
		width: 50%;
	}
	
	.uploadResult ul li span {
		color: white;
	} 	
</style>
  
<script type="text/javascript">

	function boardModify(obj) {
		obj.action = "/board/boardModify_form";
		obj.submit();
	}
	
	function boardRemove(obj) {
		if (confirm("정말 삭제하시겠습니까?") == true){
			alert("게시글이 삭제되었습니다.");
			obj.action = "/board/remove";
			obj.submit();
	
		} else {
			return false;     
		}
	}
	
	function backToList(obj) {
	 	obj.action = "/board/boardList";
		obj.submit();
	}

</script>
</head>

<body>
	<!-- Main -->
	<div id="main">
	
		<!-- Post -->
		<article class="post">
			<header>
				<div class="title">
					<p>${boardInfo.bno }번 글</p>
<%-- 							<input type="hidden" name="bno" value="${boardInfo.bno }"> --%>
					<h2>${boardInfo.subject }</h2>
				</div>
				<div class="meta">
					<fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${boardInfo.regdate }"/><br>
					<span class="name">${boardInfo.userid}</span>
				</div>
			</header>
			
			<!-- 첨부파일 -->
			<!-- <div class="bigPictureWrapper">
				<div class="bigPicture">
				</div>
			</div> -->
			<div class="uploadResult flexslider">
				<ul class="slides">
				</ul>
			</div>
				
			<!-- 글내용 -->
			<textarea cols="50" rows="8" disabled="disabled">${boardInfo.content}</textarea>
			<hr>
			
			<footer>
				<div style="margin-left: auto; margin-right: auto;">
				
		
					<c:choose>
						<c:when test="${boardInfo.userid == sessionScope.loginUser.userid}">
							<input type="button" value="수정하기" onclick="boardModify(frm)">
							<input type="button" value="삭제하기" onclick="boardRemove(frm)">						
							<input type="button" value="목록보기" onclick="backToList(frm)">
						</c:when>
						<c:otherwise>
							<input type="button" value="목록보기" onclick="backToList(frm)">
						</c:otherwise>
					</c:choose>
				</div>
			</footer>
				
			<form name="frm" method="post" enctype="multipart/form-data">
				<input type="hidden" id="bno" name="bno" value="${boardInfo.bno}">
				<input type="hidden" id="pageNum" name="pageNum" value="${cri.pageNum}">
				<input type="hidden" id="amount" name="amount" value="${cri.amount}">
				<input type="hidden" name="type" value="${cri.type}">
				<input type="hidden" name="keyword" value="${cri.keyword}">
			</form>
			<hr>
		
			<!-- 댓글작성 -->
			<div>
				<form action="/reply/register" method="post" role="form" style="display: flex; width: 100%;">
					<input type="text" placeholder="댓글을 입력해주세요" id="replytext" name="replytext">
					<input type="hidden" name="bno" value="${boardInfo.bno }">
					<input type="hidden" id="pageNum" name="pageNum" value="${cri.pageNum}">
					<input type="hidden" id="amount" name="amount" value="${cri.amount}">
					<input type="hidden" name="type" value="${cri.type}">
					<input type="hidden" name="keyword" value="${cri.keyword}">
					<input type="hidden" id="replyer" name="replyer" value="${sessionScope.loginUser.userid}">
					<input type="button" id="replyRegister" value="댓글달기">
				</form>
			</div>
			<!-- 댓글 출력 -->
			<div>
				<table class="replyList" style="width: 100%;">
					<c:choose>
						<c:when test="${!empty replies}">
							<c:forEach items="${replies}" var="replies">
								<tr>
									<td width="20%" align="center">${replies.replyer}</td>
									<td width="60%">${replies.replytext }</td>
									<td width="20%" align="center">
										<fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${replies.regdate }"/>
									</td>
								</tr>
							</c:forEach>
						</c:when>							
					</c:choose>
				</table> 
			</div>
			<hr>
		</article>
	</div>	
<%@ include file="../main/footer.jsp" %>
</body>
<script>
	$(document).on("click", "#replyRegister", function() {
		var content = $('#replytext').val();
		console.log(content);
		var formObj = $("form[role='form']");
		
		if (content == null || content == "") {
			alert("댓글 내용을 입력해주세요!");
	   		return false;
	   		
		} else if (content != null || content != "") {
			formObj.attr("action", "/reply/register");
			formObj.attr("method", "post");
			formObj.submit();
		}
	});
	
	$(document).ready(function() {	
		/* 첨부파일 출력 */
		var bno = "${boardInfo.bno}";
		
		$.getJSON("/board/getAttachList", {bno: bno}, function(arr) {
			console.log(arr);
			
			var str = "";
			
			$(arr).each(function(i, attach) {
				
				//image type
				if (attach.filetype) {
					var fileCallPath = encodeURIComponent(attach.uploadPath + "/" + attach.uuid + "_" + attach.fileName);
					
					str += "<li data-path='" + attach.uploadPath + "'data-uuid='" + attach.uuid 
							+ "'data-filename='" + attach.fileName + "'data-type='" + attach.filetype + "'><div>";
					
					str += "<img src='/display?fileName=" + fileCallPath + "'>";
					str += "</div>";
					str +"</li>";
				}
			});
			
			$(".uploadResult ul").html(str);
		});
	});
</script>
</html>