<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>마이페이지</title>
</head>
<style type="text/css">
	#tr_btn_modify {
		display: none;
	}
</style>

<%@ include file="../main/header.jsp" %>

<script type="text/javascript">

function fn_modify(obj) {
	
	var userPwd = "${sessionScope.loginUser.userpwd}";
	var inputPwd = document.getElementById("userpwd").value;

	if (userPwd == inputPwd) {		
		obj.action = "/member/member_modify_form";
		obj.submit();
		
	} else if(inputPwd == "") {
		alert("비밀번호를 입력해주세요.");	
		return false;
		
	} else {
		alert("비밀번호를 다시 확인해주세요.");
		return false;
	}
}

function removeCheck(obj) {

	var userPwd = "${sessionScope.loginUser.userpwd}";
	var inputPwd = document.getElementById("userpwd").value;

	if (userPwd == inputPwd) {	
		if (confirm("정말 탈퇴하시겠습니까?") == true){
			alert("회원정보가 삭제되었습니다.");
			obj.action = "/member/member_remove";
			obj.submit();

		} else {
			return false;     
		}
		
	} else if(inputPwd == "") {
		alert("비밀번호를 입력해주세요.");	
		return false;
		
	} else {
		alert("비밀번호를 다시 확인해주세요.");
		return false;
	}
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
				<td width="150" align="center">이름</td>
				<td>
					<input type="text" name="username" value="${member.username}" disabled="disabled" id="username">
				</td>
			</tr>
			
			<tr>
				<td width="150" align="center">이메일</td>
				<td>
					<input type="text" name="email" value="${member.email }" disabled="disabled" id="email">
				</td>
			</tr>
			
			<tr>
				<td width="150" align="center">생일</td>
				<td>
					<input type="date" value="${member.birthday }" id="birthday" name="birthday" disabled="disabled">
				</td>
			</tr>
			
			<tr>
				<td width="150" align="center">가입일</td>
				<td>
					<input type="text" value='<fmt:formatDate value="${member.regdate }" pattern="yyyy-MM-dd"/>' disabled="disabled">
				</td>
			</tr>
			<tr>
				<td width="150" align="center">비밀번호</td>
				<td>
					<input type="password" id="userpwd" name="userpwd">
				</td>
			</tr>
			
			<tr id="tr_btn">
				<td  colspan="2" align="right">
					<input type="button" value="회원정보수정" onclick="fn_modify(this.form)">
					<input type="button" value="회원탈퇴" onclick="removeCheck(frm)"><br><br>
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