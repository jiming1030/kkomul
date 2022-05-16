<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>회원가입</title>
</head>
<%@ include file="../main/header.jsp" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		
		var idP = /^[a-z0-9]{5,20}$/;
		var emailP = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/;
		
 		$("#userid").blur(function() {
		    if($('#userid').val() == "") {
		      
		   		$('#idmsg').text('아이디는 필수 입력값입니다.');
		   	  	$('#idmsg').css('color', 'red');
		   		return false;
		   		
			} else {
	        	var userid = $("#userid").val();
	        	var idChk = false;
	        	
				$.ajax({
					type : "POST",
					url : "/member/id_check",
					dataType : "json",
					data : "userid=" + userid, // 파라미터 실어줄 부분
					success : function(data) { // success되면 서버에서 값을 data로 받아옴
						
						if (data == "1") {
							$("#idmsg").html("이미 사용중인 아이디입니다.").css("color", "red");	
							$("#idChk").val("false");
							
						} else {
							$("#idmsg").html("사용 가능한 아이디입니다.").css("color", "blue");								
							$("#idChk").val("true");
						}
					},
					fail : function() {
						alert("시스템 에러");
					}
				});
				
			}
		});
 		
 		$("#email").blur(function() {
		    if($('#email').val() == "") {
		      
		   		$('#emailmsg').text('이메일은 필수 입력값입니다.');
		   	  	$('#emailmsg').css('color', 'red');
		   		return false;
		   		
			} else {
	        	var email = $("#email").val();
	        	var emailChk = false;
	        	
				$.ajax({
					type : "POST",
					url : "/member/email_check",
					dataType : "json",
					data : "email=" + email, // 파라미터 실어줄 부분
					success : function(data) { // success되면 서버에서 값을 data로 받아옴
						if (data == "1") {
							
							$("#emailmsg").html("이미 사용중인 이메일입니다.").css("color", "red");	
							$("#emailChk").val("false");
							
						} else {
							$("#emailmsg").html("사용 가능한 이메일입니다.").css("color", "blue");								
							$("#emailChk").val("true");
						}
					},
					fail : function() {
						alert("시스템 에러");
					}
				});
				
			}	
		});		
	});
	
	
	function go_save() {

		var blankP = /[\s]/g;
		var idP = /^[a-z0-9]{5,20}$/;
		var pwP = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{10,20}$/;
		var nameP = /^[가-힣]{2,4}|[a-zA-Z]{2,10}\s[a-zA-Z]{2,10}$/;
		var emailP = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/;

		var frm = document.frm;
		
		var notice = "";
			
		var id = frm.userid.value;
		var idChk = frm.idChk.value;
		var pwd = frm.userpwd.value;
		var pwd_check = frm.userpwdChk.value;
		var name = frm.username.value;
		var email = frm.email.value;
		var emailChk = frm.emailChk.value;
		
		var id_length = id.length;
		
		var idChk = frm.idChk.value;
		
		if(id == "" || id.length <= 0){
			notice = "아이디는 필수 입력값입니다.";
			document.getElementById("idmsg").innerHTML = notice;
			document.getElementById("idmsg").style.color = "red";
			return false;
			
		} else if(idP.test(id) == false) {
			notice = "영어와 숫자 포함 5~20자만 사용 가능합니다.";
			document.getElementById("idmsg").innerHTML = notice;
			document.getElementById("idmsg").style.color = "red";
			return false;
			
		} else if(idChk == "false") {
			notice = "이미 사용중인 아이디입니다.";
			document.getElementById("idmsg").innerHTML = notice;
			document.getElementById("idmsg").style.color = "red";
			return false;
			
		} else if(pwd == "" || pwd.length <= 0){
			notice = "비밀번호는 필수 입력값입니다.";
			document.getElementById("pwdmsg").innerHTML = notice;
			document.getElementById("pwdmsg").style.color = "red";
			return false;
			
		} else if (pwP.test(pwd) == false) {
			notice = "영문, 숫자, 특수문자 포함 10~20자만 사용 가능합니다.";
			document.getElementById("pwdmsg").innerHTML = notice;
			document.getElementById("pwdmsg").style.color = "red";
			return false;
			
		} else if(pwd_check == "" || pwd_check.length <= 0){
			notice = "비밀번호 확인은 필수입니다.";
			document.getElementById("pwdChkmsg").innerHTML = notice;
			document.getElementById("pwdChkmsg").style.color = "red";
			return false;
			
		} else if(pwd != pwd_check){
			notice = "비밀번호가 일치하지 않습니다.";
			document.getElementById("pwdChkmsg").innerHTML = notice;
			document.getElementById("pwdChkmsg").style.color = "red";
			return false;
			
		} else if(name == "" || name.length <= 0){
			notice = "이름은 필수 입력값입니다.";
			document.getElementById("irummsg").innerHTML = notice;
			document.getElementById("irummsg").style.color = "red";
			return false;
			
		} else if(nameP.test(name) == false){
			notice = "이름 형식의 한글 2~5자, 영문 2~10자만 사용 가능합니다.";
			document.getElementById("irummsg").innerHTML = notice;
			document.getElementById("irummsg").style.color = "red";
			return false;
			
		} else if(email == "" || email.length <= 0){
			notice = "이메일은 필수 입력값입니다.";
			document.getElementById("emailmsg").innerHTML = notice;
			document.getElementById("emailmsg").style.color = "red";
			return false;
			
		} else if(emailP.test(email) == false){
			notice = "이메일 형식으로 입력해주세요.";
			document.getElementById("emailmsg").innerHTML = notice;
			document.getElementById("emailmsg").style.color = "red";
			return false;
			
		} else if(emailChk == "false") {
			notice = "이미 사용중인 이메일입니다.";
			document.getElementById("emailmsg").innerHTML = notice;
			document.getElementById("emailmsg").style.color = "red";
			return false;
			
		} else {
			alert("회원가입을 축하드립니다.");
			document.frm.action = "/member/join";
			document.frm.submit();
		
		}
	}
</script>

<body>
	<div id="join">
		<form method="post" name="frm" > 
		
			<h2 style="text-align: center;">회원가입</h2>
			<div style="text-align: right;"> * &nbsp;: &nbsp;필수 입력 항목</div>
			
			아이디 * (5 ~ 20자) : <input type="text" id="userid" name="userid" maxlength="20">
			<span id="idmsg"></span><input type="hidden" id="idChk" name="idChk" value=""><br>
			
			비밀번호 * (영문,숫자,특수문자 각 1자 이상 포함 10~20자) : <input type="password" id="userpwd" name="userpwd" maxlength="20">
			<span id="pwdmsg"></span><br>
			
			비밀번호 확인 * : <input type="password" id="userpwdChk" name="userpwdChk" maxlength="20">
			<span id="pwdChkmsg"></span><br>
			
			이름 * (이름 형식의 한글 2~5자, 영문 2~10자) : <input type="text" id="username" name="username" maxlength="10" placeholder="ex) 박지민 또는 jimin park">
			<span id="irummsg"></span><br>
			
			이메일 * (이메일 형식으로 입력) : <input type="text" id="email" name="email" placeholder="ex) member123@naver.com">
			<span id="emailmsg"></span><input type="hidden" id="emailChk" name="emailChk" value=""><br>
							
			생일 : <input type="date" id="birthday" name="birthday">
			
			<input type="button" value="가입" id="join" name="join" onclick="go_save();" style="margin-top: 30px; width: 100%;">
			
		</form>
	</div>
	<hr>
<%@ include file="../main/footer.jsp" %>
</body>
</html>