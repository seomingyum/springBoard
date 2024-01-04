<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<% request.setCharacterEncoding("utf-8"); %>        
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>답글 작성 창</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
	/* function backToArticle(obj) {
		obj.action = "${contextPath}/board/viewBoard.do";
		obj.submit();
	} */
	
	function vaildation() {
		var _content = $('#_content').val();
		
		// 바이트 계산 함수
		const getByteLengthOfString = function (s, b, i, c) {
		      for (b = i = 0; (c = s.charCodeAt(i++)); b += c >> 11 ? 3 : c >> 7 ? 2 : 1);
		      return b;
		};
		
		 
	  	 // 아이디 바이트 개수 체크
	  	if(getByteLengthOfString(_content)>4000){
	     	alert('답글 내용 입력 가능 글자수를 초과하였습니다.');
	     	return false;
	  	}
	}

</script>
</head>
<body>
	<h1 style="text-align: center">답글 쓰기</h1>
<form name="articleForm" onsubmit="return vaildation()" method="post" action="${contextPath}/board/addReply.do">

	<table border="0" align="center">
		<tr>
			<td><input type="hidden" name="id" value="${userId}"></td>
			<td><input type="hidden" name="stitle" value="${stitle}"></td>
			<td><input type="hidden" name="scontent" value="${scontent}"></td>
			<td><input type="hidden" name="sid" value="${sid}"></td>
			<td><input type="hidden" name="articleId" value="${article.id}"></td>
			<td><input type="hidden" name="title" value="${article.title}"></td>
			<td><input type="hidden" name="content" value="${article.content}"></td>
			<td><input type="hidden" name="articleNO" value="${article.articleNO}"></td>
			<td><input type="hidden" name="articleType" value="${article.articleType}"></td>
			<td><input type="hidden" name="writeDate" value="${article.writeDate}"></td>
			<td><input type="hidden" name="fileName_1" value="${fileName_1}"></td>
			<td><input type="hidden" name="fileName_2" value="${fileName_2}"></td>
		</tr>
		<tr>
			<td aling="right">글내용: </td>
			<td colspan = "2"><textarea rows="10" cols="65" id="_content" maxlength="4000" name="replyContent"></textarea></td>
		</tr>
		<tr>
			<td align="right"></td>
			<td colspan="2">
				<input type="submit" value="답글쓰기">
				<!-- <input type="button" value="돌아가기" onclick="backToArticle(this.form)"> -->
			</td>
		</tr>
	</table>
</form>
</body>
</html>