<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>회원정보수정</title>
</head>
<%@ include file="../main/header.jsp" %>
<script type="text/javascript">

var blankP = /[\s]/g;
var pwP = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{10,20}$/;
var nameP = /^[가-힣]{2,5}|[a-zA-Z]{2,10}\s[a-zA-Z]{2,10}$/;	
	
function fn_modify_memberInfo(obj) {
	
	var frm = document.frm;

	var notice = "";
	
	var pwd = frm.userpwd.value;
	var pwd_check = frm.userpwdChk.value;
	var name = frm.username.value;
	
	if(pwd == "" || pwd.length <= 0){
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
		document.getElementById("pwdmsg").style.color = "red";
		return false;
		
	} else if(pwd != pwd_check){
		notice = "비밀번호가 일치하지 않습니다.";
		document.getElementById("pwdChkmsg").innerHTML = notice;
		document.getElementById("pwdmsg").style.color = "red";
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
		
	} else {	
		alert("회원정보가 수정되었습니다. 다시 로그인 해주세요.");
		obj.action = "/member/member_modify";
		obj.submit();
		
	}
}

function backToList(obj) {
	obj.action = "/member/member_info";
	obj.submit();
}

</script>
<body>
	<h1 style="text-align: center; margin: 30px;">마이페이지</h1>
	<div style="width: 30%; margin-left: auto; margin-right: auto; margin-bottom: 50px;">
	<form name="frm" method="post">
		<table align="center" border="0">
			<tr>
				<td width="150" align="center">아이디</td>
				<td>
					<input type="text" value="${member.userid }" disabled="disabled">
					<input type="hidden" name="userid" value="${member.userid }">
				</td>
			</tr>
			<tr>
				<td width="150" align="center">비밀번호</td>
				<td>
					<input type="password" id="userpwd" name="userpwd" maxlength="20">
					<span id="pwdmsg"></span><br>
				</td>
			</tr>
			<tr>
				<td width="150" align="center">비밀번호 확인</td>
				<td>
					<input type="password" id="userpwdChk" name="userpwdChk" maxlength="20">
					<span id="pwdChkmsg"></span><br>
				</td>
			</tr>
			<tr>
				<td width="150" align="center">이름</td>
				<td>
					<input type="text" name="username" id="username" maxlength="10">
					<span id="irummsg"></span><br>
				</td>
			</tr>
			
			<tr>
				<td width="150" align="center">이메일</td>
				<td>
					<input type="text" name="email" value="${member.email }" disabled="disabled" id="i_email">
					<input type="hidden" name="email" value="${member.email }">
				</td>
			</tr>
			
			<tr>
				<td width="150" align="center">생일</td>
				<td>
					<input type="date" id="birthday" name="birthday">
				</td>
			</tr>
			
			<tr>
				<td width="150" align="center">가입일</td>
				<td>
					<input type="text" value='<fmt:formatDate value="${member.regdate }" pattern="yyyy-MM-dd"/>' disabled="disabled">
				</td>
			</tr>
			<tr id="tr_btn_modify">
				<td colspan="2" align="right">
					<input type="button" value="수정반영하기" onclick="fn_modify_memberInfo(frm)">
					<input type="button" value="취소" onclick="backToList(frm)"><br><br>
					<h5>수정 가능 항목 : 비밀번호, 이름, 생일</h5>
				</td>
			</tr>
		</table>
	</form>
	</div>
	<hr>

<%@ include file="../main/footer.jsp" %>
</body>
</html>