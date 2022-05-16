<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>로그인</title>
</head>
<%@ include file="../main/header.jsp" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		
		var blankP = /[\s]/g;
		var idP = /^[a-z0-9]{5,20}$/;
		var pwP = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{10,20}$/;
		
		$(".login").click(function() {
		    
			if($('#userid').val() == "") {
		      
		   		$('#idmsg').text('아이디를 입력해주세요.');
		   	  	$('#idmsg').css('color', 'red');
		   		$('#userid').focus();
		   		return false;
		   		
			} else if($('#userpwd').val() == ""){
		    	 
		    	$('#pwdmsg').text('비밀번호를 입력해주세요.');
			   	$('#pwdmsg').css('color', 'red');
			   	$('#userpwd').focus();
				 return false;
				 
			 } else if(blankP.test($('#userid').val())) {
				$('#loginmsg').text('아이디와 비밀번호를 다시 확인해주세요.');
				$('#loginmsg').css('color', 'red');
				$('#userid').focus();
		   		return false;
			   		
			} else if(idP.test($(this).val())) {
				$('#loginmsg').text('아이디와 비밀번호를 다시 확인해주세요.');
				$('#loginmsg').css('color', 'red');
				$('#userid').focus();
		   		return false;
		   		
			} else if(blankP.test($('#userpwd').val())) {
				$('#loginmsg').text('아이디와 비밀번호를 다시 확인해주세요.');
				$('#loginmsg').css('color', 'red');
				$('#userid').focus();
		   		return false;
			   		
			 } else if (pwP.test($(this).val())){
				$('#loginmsg').text('아이디와 비밀번호를 다시 확인해주세요.');
				$('#loginmsg').css('color', 'red') ;
				$('#userid').focus();
				return false;
				
		     } else {  

			     $('#idmsg').hide();    
			     $('#pwdmsg').hide();
			     
		         return true;
			 }
		});

	});
	
</script>
<body>
	<h2 style="text-align: center; margin-top: 20px">로그인</h2>
	<div>
	<article>		
		<form action="/member/login" method="post" name="login" onsubmit="">
			<fieldset id="login">
				<legend></legend>
				<div id="inputId">
				<label>아이디</label>
				<input name="userid" type="text" id="userid" class="userid" placeholder="아이디를 입력해주세요." maxlength="20">
				<span id="idmsg"></span><br>
				</div>
				
				<div id="inputPwd">
				<label>비밀번호</label>
				<input name="userpwd" type="password" id="userpwd" class="userid" placeholder="비밀번호를 입력해주세요." maxlength="20">
				<span id="pwdmsg"></span>
				</div>
			</fieldset>
		
			<div id="buttons" style="text-align: center; margin: 30px;">
				<input type="submit" value="로그인" class="login" onclick="" style="width: 300px;"><br>
				<span id="loginmsg"></span><br>
				
				<ul class="actions stacked">
					<li><a href="#">아이디 · 비밀번호 찾기</a></li>
				</ul>
				<ul class="actions stacked">
					<li><a href="/member/contract">회원가입</a></li>
				</ul>
				<br>
			</div>
		</form>
	</article>
	</div>
	<hr>
<%@ include file="../main/footer.jsp" %>
</body>
</html>