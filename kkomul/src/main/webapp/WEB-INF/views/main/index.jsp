<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>    
<!DOCTYPE html>
<html>
<head>
<title>꼬물꼬물</title>
</head>
<%@ include file="./header.jsp" %>
<body class="is-preload">
	<!-- Wrapper -->
	<div id="wrapper">
	
		<!-- Main -->
 		<div id="main">
			<!-- Post -->
 			<h1 style="color: #2ebaae;">인기글</h1>
 				<c:choose>
					<c:when test="${empty bestBoard}">
						<h3>등록된 글이<br>없습니다.</h3>
					</c:when>
					<c:when test="${!empty bestBoard}">
						<c:forEach items="${bestBoard }" var="bestBoard">
							<article class="post">
								<header>
									<div class="title">
										<h2><a href="/board/single?bno=${bestBoard.bno}">${bestBoard.subject }</a></h2>
									</div>
									<div class="meta">
										<fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${bestBoard.regdate }"/><br>
										<span class="name">${bestBoard.userid}</span>
									</div>
								</header>
								<footer>
									<ul class="actions">
										<li><a href="/board/single?bno=${bestBoard.bno}" class="button large">Continue Reading</a></li>
									</ul>
								</footer>
							</article>
						</c:forEach>
					</c:when>
				</c:choose>
		</div>
		
		<!-- Sidebar -->
 				<section id="sidebar">

					<!-- Intro -->
 						<section id="intro" style="padding-top: 25px; padding-bottom: 30px; padding-right: 20px;">
							<a href="/main/index" class="logo"><img src="/resources/images/heartlogo.png" alt=""></a>
							<header>
								<h2>꼬물꼬물</h2>
								<p>
								KKOMUL KKOMUL<br>
								</p>
								<p>
								우리들의 일기장
								</p>
							</header>
						</section>
						
					<!-- Posts List -->
	 					<section>
						<h1 style="color: #2ebaae;">최신글</h1>
							<ul class="posts">
								<c:choose>
									<c:when test="${empty newBoard}">
										<h2>등록된 글이<br>없습니다.</h2>
									</c:when>
									<c:when test="${!empty newBoard}">
										<c:forEach items="${newBoard }" var="newBoard">
											<li>
												<article>
													<header>
														<h3><a href="/board/single?bno=${newBoard.bno}">${newBoard.subject }</a></h3>
														<fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${newBoard.regdate }"/>
													</header>
												</article>
											</li>
										</c:forEach>								
									</c:when>
								</c:choose>
							</ul>
						</section>
				</section>
	</div>
	<hr>
<%@ include file="./footer.jsp" %>
</body>
</html>