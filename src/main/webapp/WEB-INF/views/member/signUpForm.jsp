<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<% request.setCharacterEncoding("utf-8"); %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
	 function vaildation() {
		// 아이디 영어대소문자만 가능
		var id = $('#id').val();
		var pwd = $('#pwd').val();
		var name = $('#name').val();
		var email = $('#email').val();
		var idRegex = /^[a-zA-Z0-9]*$/;
		var pwdRgx = /^(?=.*?[0-9])(?=.*?[#?!@$ %^&*-]).{8,}$/;
		// 아이디 영대소문자 및 숫자만 출력 가능
		if (!idRegex.test(id)) {
			alert("아이디는 영대소문자와 숫자만 입력 가능합니다.");
			return false;
			}
		// 비밀번호 영대소문자 및 숫자만 출력 가능
		if (!pwdRgx.test(pwd)) {
			alert("비밀번호는 최소 8자리 이상 숫자, 특수문자가 각각 1개 이상 입력해야 합니다.");
			return false;
			}
		
		// 바이트 계산 함수
		const getByteLengthOfString = function (s, b, i, c) {
		      for (b = i = 0; (c = s.charCodeAt(i++)); b += c >> 11 ? 3 : c >> 7 ? 2 : 1);
		      return b;
		};
		
		 // 아이디 바이트 개수 체크
      	if(getByteLengthOfString(id)>20){
         	alert('아이디 입력 가능 글자수를 초과하였습니다.');
         	return false;
      	}
		   	
      	 // 비밀번호 바이트 개수 체크
      	if(getByteLengthOfString(pwd)>20){
         	alert('비밀번호 입력 가능 글자수를 초과하였습니다.');
         	return false;
      	}
      	 
      	 // 이름 바이트 개수 체크
      	if(getByteLengthOfString(name)>50){
         	alert('이름 입력 가능 글자수를 초과하였습니다.');
         	return false;
      	}
      	
      	 // 이메일 바이트 개수 체크
      	if(getByteLengthOfString(email)>50){
         	alert('이메일 입력 가능 글자수를 초과하였습니다.');
         	return false;
      	}
      	 
      		
		}
		
      	 

	
</script>


</head>
<body>
	<form method="post" onsubmit="return vaildation();" action="${contextPath}/member/signUp.do">
		<h1  style="text-align:center">회원 가입창</h1>
		<div style="color: red; text-align: center">${msg}</div>
		<table align="center">
		      <tr>
		         <td width="200"><p align="right">아이디</td>
		         <td width="400"><input type="text" id="id" name="id" required="required"></td>
		      </tr>
		      <tr>
		          <td width="200"><p align="right">비밀번호</td>
		          <td width="400"><input type="password" id="pwd"  name="pwd" required="required"></td>
		      	  
		      </tr>
		      <tr>
		          <td width="200"><p align="right">이름</td>
		          <td width="400"><p><input type="text" id="name"  name="name" required="required"></td>
		      </tr>
		      <tr>
		          <td width="200"><p align="right">이메일</td>
		          <td width="400"><p><input type="email" id="email"  name="email" required="required"></td>
		      </tr>
		      <tr>
		          <td width="200"><p>&nbsp;</p></td>
		          <td width="400">
					<input type="submit" value="가입하기">
					<input type="reset" value="다시입력">
				  </td>
		      </tr>
		</table>
	</form>
</body>
</html>