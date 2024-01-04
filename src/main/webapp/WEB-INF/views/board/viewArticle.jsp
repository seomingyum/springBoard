<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<% request.setCharacterEncoding("utf-8"); %>        
<!DOCTYPE html>
<html>
<head>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
	
	function fn_reply_form(obj) {
		obj.action = "${contextPath}/board/replyForm.do";
		obj.enctype = "application/x-www-form-urlcencoded";
		obj.submit();
		
	}
	
	function fn_enable(obj) {
		document.getElementById("i_title").disabled = false;
		document.getElementById("i_content").disabled = false;
		if(document.getElementById("i_fileName1")!=null) {
			document.getElementById("i_fileName1").disabled = false;	
		}
		if(document.getElementById("i_fileName2")!=null) {
			document.getElementById("i_fileName2").disabled = false;	
		}
		document.getElementById("tr_btn_modify").style.display = "block";
		document.getElementById("tr_btn").style.display = "none";
	}
	
	function fn_modify_article(obj) {
		var title = $('#i_title').val();
		var _content = $('#i_content').val();
		
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
		

		obj.action = "${contextPath}/board/modArticle.do";
		obj.submit();
	}
	
	function fn_remove_article() {
		console.log('${article.fileName_1}');
		console.log('${article.fileName_2}');
		var form = document.createElement("form");
		form.setAttribute("method", "post");
		form.setAttribute("action", "${contextPath}/board/removeArticle.do");
		
		var articleTypeInput = document.createElement("input");
		articleTypeInput.setAttribute("type", "hidden");
		articleTypeInput.setAttribute("name", "articleType");
		articleTypeInput.setAttribute("value", '${article.articleType}');
		
		var	articleNOInput = document.createElement("input");
		articleNOInput.setAttribute("type", "hidden");
		articleNOInput.setAttribute("name", "articleNO");
		articleNOInput.setAttribute("value", '${article.articleNO}');
		
		var fileName_1Input = document.createElement("input");
		fileName_1Input.setAttribute("type", "hidden");
		fileName_1Input.setAttribute("name", "fileName_1");
		fileName_1Input.setAttribute("value", '${article.fileName_1}');
		
		var fileName_2Input = document.createElement("input");
		fileName_2Input.setAttribute("type", "hidden");
		fileName_2Input.setAttribute("name", "fileName_2");
		fileName_2Input.setAttribute("value", '${article.fileName_2}');
		
		
		
		var sidInput = document.createElement("input");
		sidInput.setAttribute("type", "hidden");
		sidInput.setAttribute("name", "sid");
		sidInput.setAttribute("value", '${sid}');
		
		var stitleInput = document.createElement("input");
		stitleInput.setAttribute("type", "hidden");
		stitleInput.setAttribute("name", "stitle");
		stitleInput.setAttribute("value", '${stitle}');
		
		var scontentInput = document.createElement("input");
		scontentInput.setAttribute("type", "hidden");
		scontentInput.setAttribute("name", "scontent");
		scontentInput.setAttribute("value", '${scontent}');
		
		form.appendChild(articleTypeInput);
		form.appendChild(articleNOInput);
		form.appendChild(fileName_1Input);
		form.appendChild(fileName_2Input);
		form.appendChild(sidInput);
		form.appendChild(stitleInput);
		form.appendChild(scontentInput);
		document.body.append(form);
		form.submit();
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
		var articleType = '${article.articleType}';
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
	
	/* function backToView(obj) {
	obj.action = "${contextPath}/board/viewArticle.do";
	obj.enctype = "application/x-www-form-urlcencoded";
	obj.method = "get";
	obj.submit();
		} */
	
	 /* function replyMod_enable(i, replyId) {
			if(replyId!='${userId}') {
				alert('다른 유저의 답글을 수정할 수 없습니다.');
			} else {
				$("#reply_content"+i).attr("disabled", false);
				$("#replyMod_enable"+i).hide();
				$("#replyMod"+i).show();
			}
	} */
	
	/* function replyMod(url, replyNO,i) {
		var form = document.createElement("form");
		form.setAttribute("method", "post");
		form.setAttribute("action", url);
		
		var articleNOInput = document.createElement("input");
		articleNOInput.setAttribute("type", "hidden");
		articleNOInput.setAttribute("name", "articleNO");
		articleNOInput.setAttribute("value", '${article.articleNO}');
		
		var idInput = document.createElement("input");
		idInput.setAttribute("type", "hidden");
		idInput.setAttribute("name", "id");
		idInput.setAttribute("value", '${article.id}');

		var replyNOInput = document.createElement("input");
		replyNOInput.setAttribute("type", "hidden");
		replyNOInput.setAttribute("name", "replyNO");
		replyNOInput.setAttribute("value", replyNO);
		
		var replyContentInput = document.createElement("input");
		var replyContent = $("#reply_content"+i).val();
		replyContentInput.setAttribute("type", "hidden");
		replyContentInput.setAttribute("name", "replyContent");
		replyContentInput.setAttribute("value", replyContent);
		
		var stitleInput = document.createElement("input");
		var stitle= '${stitle}';
		stitleInput.setAttribute("type", "hidden");
		stitleInput.setAttribute("name", "stitle");
		stitleInput.setAttribute("value", stitle);
		
		var scontentInput = document.createElement("input");
		var scontent = '${scontent}';
		scontentInput.setAttribute("type", "hidden");
		scontentInput.setAttribute("name", "scontent");
		scontentInput.setAttribute("value", scontent);
		
		var sidInput = document.createElement("input");
		var sid = '${sid}';
		sidInput.setAttribute("type", "hidden");
		sidInput.setAttribute("name", "sid");
		sidInput.setAttribute("value", sid);
		
		var articleIdInput = document.createElement("input");
		var articleId = '${article.id}';
		articleIdInput.setAttribute("type", "hidden");
		articleIdInput.setAttribute("name", "articleId");
		articleIdInput.setAttribute("value", articleId);
		
		var titleInput = document.createElement("input");
		var title = '${article.title}';
		titleInput.setAttribute("type", "hidden");
		titleInput.setAttribute("name", "title");
		titleInput.setAttribute("value", title);
		
		var contentInput = document.createElement("input");
		var content = '${article.content}';
		contentInput.setAttribute("type", "hidden");
		contentInput.setAttribute("name", "content");
		contentInput.setAttribute("value", content);
		
		var writeDateInput = document.createElement("input");
		var writeDate = '${article.writeDate}';
		writeDateInput.setAttribute("type", "hidden");
		writeDateInput.setAttribute("name", "writeDate");
		writeDateInput.setAttribute("value", writeDate);
		
		var fileNmae_1Input = document.createElement("input");
		var fileNmae_1 = '${article.fileName_1}';
		fileNmae_1Input.setAttribute("type", "hidden");
		fileNmae_1Input.setAttribute("name", "fileName_1");
		fileNmae_1Input.setAttribute("value", fileNmae_1);
		
		var fileNmae_2Input = document.createElement("input");
		var fileNmae_2 = '${article.fileName_2}';
		fileNmae_2Input.setAttribute("type", "hidden");
		fileNmae_2Input.setAttribute("name", "fileName_2");
		fileNmae_2Input.setAttribute("value", fileNmae_2);
		
		var articleTypeInput = document.createElement("input");
		var articleType = '${article.articleType}';
		articleTypeInput.setAttribute("type", "hidden");
		articleTypeInput.setAttribute("name", "articleType");
		articleTypeInput.setAttribute("value", articleType);
		
		form.appendChild(idInput);
		form.appendChild(articleNOInput);
		form.appendChild(replyNOInput);
		form.appendChild(replyContentInput);
		form.appendChild(stitleInput);
		form.appendChild(scontentInput);
		form.appendChild(sidInput);
		form.appendChild(articleIdInput);
		form.appendChild(titleInput);
		form.appendChild(contentInput);
		form.appendChild(writeDateInput);
		form.appendChild(fileNmae_1Input);
		form.appendChild(fileNmae_2Input);
		form.appendChild(articleTypeInput);
		
		document.body.append(form);
		form.submit();
	} */
	
	
	/* function deleteReply(url, replyNO, replyId) {
			if(replyId!='${userId}') {
				alert('다른 유저의 답글을 삭제할 수 없습니다.');
			} else {
				var form = document.createElement("form");
				form.setAttribute("method", "post");
				form.setAttribute("action", url);
				
				var articleNOInput = document.createElement("input");
				articleNOInput.setAttribute("type", "hidden");
				articleNOInput.setAttribute("name", "articleNO");
				articleNOInput.setAttribute("value", '${article.articleNO}');
				
				var idInput = document.createElement("input");
				idInput.setAttribute("type", "hidden");
				idInput.setAttribute("name", "id");
				idInput.setAttribute("value", '${article.id}');

				var replyNOInput = document.createElement("input");
				replyNOInput.setAttribute("type", "hidden");
				replyNOInput.setAttribute("name", "replyNO");
				replyNOInput.setAttribute("value", replyNO);
				
				var stitleInput = document.createElement("input");
				var stitle= '${stitle}';
				stitleInput.setAttribute("type", "hidden");
				stitleInput.setAttribute("name", "stitle");
				stitleInput.setAttribute("value", stitle);
				
				var scontentInput = document.createElement("input");
				var scontent = '${scontent}';
				scontentInput.setAttribute("type", "hidden");
				scontentInput.setAttribute("name", "scontent");
				scontentInput.setAttribute("value", scontent);
				
				var sidInput = document.createElement("input");
				var sid = '${sid}';
				sidInput.setAttribute("type", "hidden");
				sidInput.setAttribute("name", "sid");
				sidInput.setAttribute("value", sid);
				
				var articleIdInput = document.createElement("input");
				var articleId = '${article.id}';
				articleIdInput.setAttribute("type", "hidden");
				articleIdInput.setAttribute("name", "articleId");
				articleIdInput.setAttribute("value", articleId);
				
				var titleInput = document.createElement("input");
				var title = '${article.title}';
				titleInput.setAttribute("type", "hidden");
				titleInput.setAttribute("name", "title");
				titleInput.setAttribute("value", title);
				
				var contentInput = document.createElement("input");
				var content = '${article.content}';
				contentInput.setAttribute("type", "hidden");
				contentInput.setAttribute("name", "content");
				contentInput.setAttribute("value", content);
				
				var writeDateInput = document.createElement("input");
				var writeDate = '${article.writeDate}';
				writeDateInput.setAttribute("type", "hidden");
				writeDateInput.setAttribute("name", "writeDate");
				writeDateInput.setAttribute("value", writeDate);
				
				var fileNmae_1Input = document.createElement("input");
				var fileNmae_1 = '${article.fileName_1}';
				fileNmae_1Input.setAttribute("type", "hidden");
				fileNmae_1Input.setAttribute("name", "fileName_1");
				fileNmae_1Input.setAttribute("value", fileNmae_1);
				
				var fileNmae_2Input = document.createElement("input");
				var fileNmae_2 = '${article.fileName_2}';
				fileNmae_2Input.setAttribute("type", "hidden");
				fileNmae_2Input.setAttribute("name", "fileName_2");
				fileNmae_2Input.setAttribute("value", fileNmae_2);
				
				var articleTypeInput = document.createElement("input");
				var articleType = '${article.articleType}';
				articleTypeInput.setAttribute("type", "hidden");
				articleTypeInput.setAttribute("name", "articleType");
				articleTypeInput.setAttribute("value", articleType);
				
				form.appendChild(idInput);
				form.appendChild(articleNOInput);
				form.appendChild(replyNOInput);
				form.appendChild(stitleInput);
				form.appendChild(scontentInput);
				form.appendChild(sidInput);
				form.appendChild(articleIdInput);
				form.appendChild(titleInput);
				form.appendChild(contentInput);
				form.appendChild(writeDateInput);
				form.appendChild(fileNmae_1Input);
				form.appendChild(fileNmae_2Input);
				form.appendChild(articleTypeInput);
				
				document.body.append(form);
				form.submit();
			} 
	}*/
	
		
</script>
<meta charset="UTF-8">
<title>글내용</title>
</head>
<style>
	#replyTable > td {
		border: 1px solid black;"
	}
</style>
<body>
	<div style="color: red; text-align: center">${msg}</div>
	<form name="frmArticle" method="post" action="${contextPath}" enctype="multipart/form-data">
		<table border="0" align="center">
			<tr>
				<td>
					<input type="hidden" name="stitle" value="${stitle}">
					<input type="hidden" name="scontent" value="${scontent}">
					<input type="hidden" name="sid" value="${sid}">
					<!-- 글 수정 시 서버에서 글자 수 체크 후 글상세보기 페이지로 돌아왔을 때 article의 값들을 ㅂ루러오기 위한 파라미터 -->
					<input type="hidden" name="articleNO" value="${article.articleNO}">
					<input type="hidden" name="articleType" value="${article.articleType}">
				</td>
			</tr>
			<tr>
				<td width="150" align="center" bgcolor="#FF9933">작성자 아이디</td>
				<td>
				<input type="text" value="${article.id}" disabled="disabled">
				</td>
			</tr>
			<tr>
				<td width="150" align="center" bgcolor="#FF9933">제목</td>
				<td>
				<input id="i_title" type="text" name="title" value="<c:out value='${article.title}'/>" disabled="disabled">
				</td>
			</tr>
			<tr>
				<td width="150" align="center" bgcolor="#FF9933">내용</td>
				<td>
				<textarea id="i_content" rows="20" cols="60" name="content" id="i_content" disabled="disabled">${article.content}</textarea>
				</td>
			</tr>
			<tr>
				<td width="150" align="center" bgcolor="#FF9933">파일1</td>
				<td>
					<a href="#">${article.fileName_1}</a>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="file" id="i_fileName1" name="fileName_1" disabled="disabled">
				</td>
				<td>
					<input type="hidden" name="originalFileName_1" value="${article.fileName_1}">
				</td>
			</tr>
			<tr>
				<td width="150" align="center" bgcolor="#FF9933">파일2</td>
				<td>
					<a href="#">${article.fileName_2}</a>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="file" id="i_fileName2" name="fileName_2" disabled="disabled">
				</td>
				<td>
					<input type="hidden" name="originalFileName_2" value="${article.fileName_2}">
				</td>
			</tr>		
			<tr>
				<td width="150" align="center" bgcolor="#FF9933">등록일자</td>
				<td>
					<input type="text" value="${article.writeDate}" disabled="disabled">
					<input type="hidden" name="writeDate" value="${article.writeDate}">
				</td>
			</tr>
			<tr id="tr_btn_modify" style="display: none;">
				<td align="center">
					<input type="button" value="수정반영하기" onclick="fn_modify_article(frmArticle)">
				</td>
				<td>
					<input type="button" value="취소" onclick="backToView(frmArticle)">
				</td>
			</tr>
			
			<tr id="tr_btn">
				<td colspan="2" align="center">
				<c:if test="${article.id eq userId}">
					<input type="button" value="수정하기" onclick="fn_enable(this.form)">
					<input type="button" value="삭제하기" onclick="fn_remove_article()">
				</c:if>
					<input type="button" value="리스트로 돌아가기" onclick="backToList()">
				<%-- <c:if test="${not empty userId}">	
					 <input type="button" value="답글쓰기" onclick="fn_reply_form(this.form)">
				</c:if> --%>
				</td>
			</tr>
		</table>
	</form>
	
	
	
	<!-- 댓글 창  -->
	<%--<hr>
	<h1>답글</h1>
	 <table id="replyTable" align="center" border="1" width="80%" style="margin-top: 50px; margin-bottom: 100px;">
		<tr height="10" align="center" bgcolor="lightgreen" style="border: 1px solid black;">
			<td style="border: 1px solid black;">답글번호</td>
			<td style="border: 1px solid black;">작성자</td>
			<td style="border: 1px solid black;">내용</td>
			<td style="border: 1px solid black;">작성일</td>
			<c:if test="${not empty userId}">
				<td style="border: 1px solid black;">수정</td>
				<td style="border: 1px solid black;">삭제</td>
			</c:if>
		</tr>
		<c:choose>
			<c:when test="${empty replyList}">
			<tr>
				<td colspan="6">			
					<p align="center">
						<b><span style="font-size: 9pt">답글이 없습니다.</span></b>
					</p>
				</td>
			</tr>	
			</c:when>
			<c:when test="${not empty replyList}">
				<c:forEach var="reply" items="${replyList}" varStatus="i">
					<tr align="center">
						<td width="5%" style="border: 1px solid black;">${i.count}</td>
						<td width="10%" style="border: 1px solid black;">${reply.id}</td>
						<td style="border: 1px solid black;">
							<textarea id="reply_content${i.count}" rows="10" cols="60" name="replyContent" disabled="disabled">${reply.replyContent}</textarea>
						</td>
						<td width="10%" style="border: 1px solid black;">${reply.replyDate}</td>
						<c:if test="${not empty userId}">
							<td style="border: 1px solid black;">
								<button type="button" id="replyMod_enable${i.count}" onclick="replyMod_enable(${i.count}, '${reply.id}')">수정하기</button>
								<button type="button" id="replyMod${i.count}" onclick='replyMod("${contextPath}/board/modReply.do", ${reply.replyNO},${i.count})' style="display: none;" >수정반영하기</button>
							</td>
							<td style="border: 1px solid black;">
								<button type="button" id="deleteReply${i.count}" onclick='deleteReply("${contextPath}/board/deleteReply.do", ${reply.replyNO}, "${reply.id}")'>삭제하기</button>
							</td>
						</c:if>
					</tr>
				</c:forEach>	
			</c:when>
		</c:choose>
	</table> --%>	
</body>
</html>