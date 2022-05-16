<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>게시판</title>
</head>
<%@ include file="../main/header.jsp" %>
<style type="text/css">
	.cls1 {
		text-decoration: none;
		color: black;
	}
	
	.cls2 {
		text-align: center;
		font-size: 25px;
		margin-top: 25px;
	}
	
	.no_uline {
		text-decoration: none;
	}
	
	.sel-page {
		text-decoration: none;
		color: #2ebaae;
	}

</style>
<script type="text/javascript">
	function boardWrite() {
		var id = "${sessionScope.loginUser.userid}" // 아이디 취득
		if (id == "") {
			alert("회원만 이용할 수 있습니다.");
			location.href = "/member/login";
		} else {
			location.href = "/board/boardForm";
		}
	}
</script>	

<body>
<h2 class="cls2">일기장</h2>

	<div style="width: 80%; margin-left: auto; margin-right: auto;">
	
		<a href="javascript:boardWrite();"> <!-- 앵커태그에서 자바스크립트 메서드 호출하기 -->
			<p style="font-size: 20px; float: right; margin-bottom: 10px;">&nbsp;일기쓰기&nbsp;</p>
		</a>

		<table align="center" border="1" style="border-collapse: collapse;" width="80%">
			<thead>
				<tr height="10" align="center" bgcolor="lightgray">
					<th width="10%">글번호</th>
					<th width="35%">제목</th>
					<th width="20%">작성자</th>
					<th width="20%">작성일자</th>
					<th width="15%">조회수</th>				
				</tr>	
			</thead>
			<tbody>		
				<c:choose>
					<c:when test="${empty boardInfo}">
						<tr height="10">
							<th colspan="5">
								<p align="center" style="margin: 25px;">
									<b><span style="font-size: 20px;">등록된 글이 없습니다.</span></b>
								</p>
							</th>
						</tr>
					</c:when>
					<c:when test="${!empty boardInfo}">
						<c:forEach items="${boardInfo}" var="boardDto">
							<tr>
								<td width="10%" style="text-align: center;">${boardDto.bno}</td>			
								<td width="35%">
									<a class="read" href="/board/single?bno=${boardDto.bno}&pageNum=${pageMaker.cri.pageNum}&type=${pageMaker.cri.type}&keyword=${pageMaker.cri.keyword}">&nbsp;${boardDto.subject}</a>
								</td>
								<td width="20%" style="text-align: center;">${boardDto.userid}</td>
								<td width="20%" style="text-align: center;">
									<fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${boardDto.regdate }"/>
								</td>
								<td width="15%" style="text-align: center;">${boardDto.readcount}</td>
							</tr>
						</c:forEach>
					</c:when>
				</c:choose>				
			</tbody>
 			<tfoot>
 				<tr class="cls2">
 					<td align="center" colspan="5" style="font-size: 20px">
 						<c:if test="${pageMaker.prev }">
							<a href="/board/boardList?pageNum=${pageMaker.startPage - 1 }&type=${pageMaker.cri.type}&keyword=${pageMaker.cri.keyword }">prev</a>
 						</c:if>
 						
 						<c:forEach var="num" begin="${pageMaker.startPage }" end="${pageMaker.endPage }">
 							<c:choose>
	 							<c:when test="${num == pageMaker.cri.pageNum}">
	 								<a class="sel-page" href="/board/boardList?pageNum=${num}&type=${pageMaker.cri.type}&keyword=${pageMaker.cri.keyword }">&nbsp;${num }&nbsp;</a>
	 							</c:when>
	 							<c:otherwise>
									<a class="no-uline" href="/board/boardList?pageNum=${num}&type=${pageMaker.cri.type}&keyword=${pageMaker.cri.keyword }">&nbsp;${num}&nbsp;</a> 
								</c:otherwise>
							</c:choose>
 						</c:forEach>
 						
 						<c:if test="${pageMaker.next }">
                            <a href="/board/boardList?pageNum=${pageMaker.endPage + 1 }&type=${pageMaker.cri.type}&keyword=${pageMaker.cri.keyword }">next</a>
                        </c:if>
 					</td>
 				</tr>
 			</tfoot>
		</table>
 		 	
 		<div style="text-align: center; margin-left: auto; margin-right: auto;">
 			<form id="searchForm" action="/board/boardList" method="get" style="width: 300px; margin-left: auto; margin-right: auto;">
      			<select name="type" style="margin-bottom: 10px">
      				<option value="" <c:out value="${pageMaker.cri.type == null ? 'selected' : '' }"/>>----------</option>
      				<option value="T" <c:out value="${pageMaker.cri.type == 'T' ? 'selected' : '' }"/>>제목</option>
      				<option value="C" <c:out value="${pageMaker.cri.type == 'C' ? 'selected' : '' }"/>>내용</option>
      				<option value="W" <c:out value="${pageMaker.cri.type == 'W' ? 'selected' : '' }"/>>작성자</option>
      				<option value="TC" <c:out value="${pageMaker.cri.type == 'TC' ? 'selected' : '' }"/>>제목 OR 내용</option>
      				<option value="TW" <c:out value="${pageMaker.cri.type == 'TW' ? 'selected' : '' }"/>>제목 OR 작성자</option>
      				<option value="TCW" <c:out value="${pageMaker.cri.type == 'TCW' ? 'selected' : '' }"/>>제목 OR 내용 OR 작성자</option>
      			</select>
      			<input name="keyword" placeholder="검색어" value="${pageMaker.cri.keyword }" size="15">
      			<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
      			<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
      			<button class="btn btn-default" style="margin-left: 3px;">Search</button>
      		</form>
 		</div>
 						 		
	</div>
	<hr style="clear: both;">

<%@ include file="../main/footer.jsp" %>
</body>
	
<script type="text/javascript">
$(document).ready(function() {
	
	var searchForm = $("#searchForm");

	$("#searchForm button").on("click", function(e) {
		if (!searchForm.find("option:selected").val()) {
			alert("검색종류를 선택하세요.");
		
			return false;
		}
		
		if (!searchForm.find("input[name='keyword']").val()) {
			alert("키워드를 입력하세요.")
			
			return false;
		}
		
		searchForm.find("input[name='pageNum']").val("1");
		
		e.preventDefault();
		
		searchForm.submit();
		
	});
});
</script>
</html>