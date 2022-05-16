<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="contextPath" value="<%= request.getContextPath()%>"></c:set>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
<link rel="stylesheet" href="/resources/assets/css/main.css" />

<!-- Header -->
	<header id="header" class="header">
		<h1 style="text-align: center;"><a href="/main/index">♡  KKOMUL KKOMUL ♡</a></h1>
  		<nav class="links">
			<ul style="text-align: center;">
				<li><a href="/board/boardList">Open Diary</a></li>
			</ul>
		</nav>
 		<nav class="main">
			<ul>
				<li class="menu">
					<a class="fa-bars" href="#menu">Menu</a>
				</li>
			</ul>
		</nav>
	</header>

<!-- Menu -->
	<section id="menu">

			<section>
				<div style="text-align: center; font-size: 20px; color: #2ebaae;">
					<a href="/board/boardList" style="color: #2ebaae;" class="button large fit">Open Diary</a>
				</div>
			</section>
			
		<!-- Actions -->
 			<c:choose>
				<c:when test="${empty sessionScope.loginUser}"> <!-- empty = null -->
					<section>
						<ul class="actions stacked">
							<li><a href="/member/login" class="button large fit">Log In</a></li>
						</ul>
					</section>
					<section>
						<ul class="actions stacked">
							<li><a href="/member/contract" class="button large fit">JOIN</a></li>
						</ul>
					</section>
				</c:when>
				<c:otherwise>
					<section>
 						<ul class="actions stacked">
							<li style = "margin-left: auto; margin-right: auto;">
							<a href="/member/profile_upload">
								<img style = "border-radius:50%; width: 170px; height: 170px;" onerror="this.src ='/resources/images/default/default.jpg'" 
								src="/displayProfile?userid=${sessionScope.loginUser.userid }&fileName=${sessionScope.loginUser.fileName }" "width="150px" height="150px" />
							</a>
							</li>
						</ul>
						<ul class="actions stacked">
							<li style = "margin-left: auto; margin-right: auto;">안녕하세요! </li>
							<li style="color: #2ebaae; margin-left: auto; margin-right: auto;">${sessionScope.loginUser.username}(${sessionScope.loginUser.userid}) 님 ʕ•ᴥ•ʔ</li> <!-- 이름, 아이디 가져오기 -->
						</ul>
					</section>
					<section>
						<ul class="actions stacked">
							<li>
								<a href="/member/member_info?userid=${sessionScope.loginUser.userid}" class="button large fit">MY PAGE</a>
							</li>
						</ul>
					</section>
					<section>
						<ul class="actions stacked">
							<li><a href="/member/logout" class="button large fit">LOGOUT</a></li>
						</ul>
					</section>
				</c:otherwise>
			</c:choose>
			
	</section>