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
	var title = $('#title').val();
	var _content = $('#_content').val();
	
	// 바이트 계산 함수
	const getByteLengthOfString = function (s, b, i, c) {
	      for (b = i = 0; (c = s.charCodeAt(i++)); b += c >> 11 ? 3 : c >> 7 ? 2 : 1);
	      return b;
	};
	
	 // 제목 바이트 개수 체크
  	if(getByteLengthOfString(title)>500){
     	alert('글 제목 입력 가능 글자수를 초과하였습니다.');
     	return false;
  	}
	 
  	 // 내용 바이트 개수 체크
  	if(getByteLengthOfString(_content)>4000){
     	alert('글 내용 입력 가능 글자수를 초과하였습니다.');
     	return false;
  	}
}
function checkFile1(f){

	// files 로 해당 파일 정보 얻기.
	var file = f.files;

	// file[0].name 은 파일명 입니다.
	// 정규식으로 확장자 체크
	if(/\.(jsp)$/i.test(file[0].name)) {
		alert('jsp 파일은 업로드 할 수 없습니다.\n\n현재 파일 : ' + file[0].name);
	} else {
		// 체크를 통과했다면 종료.
		return;
	}
	f.outerHTML = f.outerHTML;
}

function checkFile2(f){

	// files 로 해당 파일 정보 얻기.
	var file = f.files;

	// file[0].name 은 파일명 입니다.
	// 정규식으로 확장자 체크
	if(/\.(jsp)$/i.test(file[0].name)) {
		alert('jsp 파일은 업로드 할 수 없습니다.\n\n현재 파일 : ' + file[0].name);
	} else {
		// 체크를 통과했다면 종료.
		return;
	}
	f.outerHTML = f.outerHTML;
}
	
	
	
	
	function fileUploadCheck(filename) {
		var _fileLen = filename.length;
		var _lastDot = filename.lastIndexOf('.');
		var _fileExt = filename.substring(_lastDot, _fileLen).toLowerCase();
		if(_fileExt!='.png') {
			alert("해당 파일은 업로드 할 수 없는 형식의 파일입니다.");
			event.preventDefault()
			
		}
			
		
	}
	
	function readURL2(input) {
		if(input.files && input.files[0]) {
			var reader = new FileReader();
			reader.onload = function(e) {
				$("#preview2").attr('src', e.target.result);
				console.log(e.target.result);
			}
			reader.readAsDataURL(input.files[0]);
		}
	}
	
	function backToList() {
		var form = document.createElement("form");
		form.setAttribute("method", "post");
		form.setAttribute("action", "${contextPath}/board/boardList.do");
		
		var stitleInput = document.createElement("input");
		var stitle= '${stitle}';
		stitleInput.setAttribute("type", "hidden");
		stitleInput.setAttribute("name", "title");
		stitleInput.setAttribute("value", stitle);
		
		var scontentInput = document.createElement("input");
		var scontent = '${scontent}';
		scontentInput.setAttribute("type", "hidden");
		scontentInput.setAttribute("name", "content");
		scontentInput.setAttribute("value", scontent);
		
		var sidInput = document.createElement("input");
		var sid = '${sid}';
		sidInput.setAttribute("type", "hidden");
		sidInput.setAttribute("name", "id");
		sidInput.setAttribute("value", sid);
		
		var articleTypeInput = document.createElement("input");
		var articleType = '${articleType}';
		articleTypeInput.setAttribute("type", "hidden");
		articleTypeInput.setAttribute("name", "articleType");
		articleTypeInput.setAttribute("value", articleType);
		
		form.appendChild(stitleInput);
		form.appendChild(scontentInput);
		form.appendChild(sidInput);
		form.appendChild(articleTypeInput);
		
		document.body.append(form);
		form.submit();
	}
</script>
</head>
<body>
	<h1 style="text-align: center">새 글 쓰기</h1>
	<div style="color: red; text-align: center">${msg}</div>
<form name="articleForm" method="post" onsubmit="return vaildation()" action="${contextPath}/board/addArticle.do?articleType=${articleType}" enctype="multipart/form-data">
	<table border="0" align="center">
		<tr>
			<td><input type="hidden" name="articleType" value="${articleType}"></td>
			<td><input type="hidden" name="stitle" value="${stitle}"></td>
			<td><input type="hidden" name="scontent" value="${scontent}"></td>
			<td><input type="hidden" name="sid" value="${sid}"></td>	
		</tr>
		<tr>
			<td aling="right">글제목: </td>
			<td colspan = "2"><input type="text" size="67" maxlength="500" id="title" name="title" required="required"></td>
		</tr>
		
		<tr>
			<td aling="right">글내용: </td>
			<td colspan = "2"><textarea rows="10" cols="65" maxlength="4000" id="_content" name="content"></textarea></td>
			
		</tr>
		<tr>
			<td aling="right">파일1 첨부: </td>
			<td colspan = "2"><input type="file" name="fileName_1" onchange="checkFile1(this)"></td>
		
		</tr>
		<tr>
			<td aling="right">파일2 첨부: </td>
			<td colspan = "2"><input type="file" name="fileName_2" onchange="checkFile2(this)"></td>
		</tr>
		<tr>
			<td align="right"></td>
			<td colspan="2">
				<input type="submit" value="글쓰기">
				<input type="button" value="목록보기" onclick="backToList()">
			</td>
		</tr>
	</table>
</form>
</body>
</html>