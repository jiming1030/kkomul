<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>게시글 상세</title>
</head>
<%@ include file="../main/header.jsp" %>

<style type="text/css">
	#tr_btn_modify {
		display: none;
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
	<form name="frm" method="post" enctype="multipart/form-data">
		<table border="0" align="center">
			<tr>
				<td width="150" align="center">글번호</td>
				<td>
					<input type="text" value="${boardInfo.bno }" disabled="disabled">
					<input type="hidden" name="bno" value="${boardInfo.bno }">
				</td>
			</tr>
			<tr>
				<td width="150" align="center">작성자아이디</td>
				<td>
					<input type="text" name="userid" value="${boardInfo.userid}" disabled="disabled">
				</td>
			</tr>
			<tr>
				<td width="150" align="center">제목</td>
				<td>
					<input type="text" name="subject" value="${boardInfo.subject }" disabled="disabled" id="subject">
				</td>
			</tr>
			<tr>
				<td width="150" align="center">내용</td>
				<td><textarea rows="10" cols="65" name="content" id="content" disabled="disabled">${boardInfo.content}</textarea></td>
			</tr>
<%-- 			<c:if test="${not empty selBoardView.filename && selBoardView.filename != 'null' }"> --%>
<!-- 				<tr>
					<td width="150" align="center" rowspan="2">이미지</td>
					<td>
						<input type="hidden" name="originalFilename" value="${selBoardView.filename}">
						<img alt="첨부 이미지" src="/km/board/imagesPreView.kkomul?articleNo=${selBoardView.articleNo}&filename=${selBoardView.filename }" id="preview" style="width: 300px; height: 300px"><br>
					</td>
				</tr>
				<tr>
					<td>
						<input type="file" name="filename" id="i_filename" disabled="disabled" onchange="readURL(this);" >
					</td>
				</tr> -->
<%-- 			</c:if> --%>
			<tr>
				<td width="150" align="center">등록일자</td>
				<td>
					<input type="text" value='<fmt:formatDate value="${boardInfo.regdate }" pattern="yyyy-MM-dd HH:mm:ss"/>' disabled="disabled">
				</td>
			</tr>
			<tr id="tr_btn">
				<td colspan="2" align="center">
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
				</td>
			</tr>
		</table>
		
		<input type="hidden" id="bno" name="bno" value="${boardInfo.bno}">
		<input type="hidden" id="pageNum" name="pageNum" value="${cri.pageNum}">
		<input type="hidden" id="amount" name="amount" value="${cri.amount}">
		<input type="hidden" name="type" value="${cri.type}">
		<input type="hidden" name="keyword" value="${cri.keyword}">
		
	</form>
<%@ include file="../main/footer.jsp" %>
</body>
</html>