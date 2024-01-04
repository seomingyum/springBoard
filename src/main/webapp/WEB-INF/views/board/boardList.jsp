<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.spring.springBoard.board.vo.BoardVo" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<% request.setCharacterEncoding("utf-8"); %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
	function searchArticle(url) {
		var form = document.createElement("form");
		form.setAttribute("method", "post");
		form.setAttribute("action", url);
		
		var articleTypeInput = document.createElement("input");
		articleTypeInput.setAttribute("type", "hidden");
		articleTypeInput.setAttribute("name", "articleType");
		articleTypeInput.setAttribute("value", '${articleType}');
		
		var titleInput = document.createElement("input");
		var title = $("#title").val();
		console.log(title);
		titleInput.setAttribute("type", "hidden");
		titleInput.setAttribute("name", "title");
		titleInput.setAttribute("value", title);
		
		var contentInput = document.createElement("input");
		var content = $("#content").val();
		contentInput.setAttribute("type", "hidden");
		contentInput.setAttribute("name", "content");
		contentInput.setAttribute("value", content);
		
		var idInput = document.createElement("input");
		var id = $("#id").val();
		idInput.setAttribute("type", "hidden");
		idInput.setAttribute("name", "id");
		idInput.setAttribute("value", id);
		
		form.appendChild(articleTypeInput);
		form.appendChild(titleInput);
		form.appendChild(contentInput);
		form.appendChild(idInput);
		document.body.append(form);
		form.submit();
	}

</script>
<style type="text/css">
		.cls1 {
			text-decoration: none;
		}
		.cls2 {
			text-align: center;
			font-size: 30px;
		}
		
        .btn {
          
            border: 0; 
            border-radius: 0;
            padding: 5px 10px; 
            margin: 20px 0px;
        }
        
        ul {
        	list-style: none;
        }
        
        li {
        	margin: 0px 10px;
        	float: left;
        }
	</style>
</head>
<body>
<form action="${contextPath}/board/boardList.do" method="get">
	<table align="center" border="1" width="80%" style="margin-top: 50px">
		<tr>
			<td>
				<input name="articleType" type="hidden" value="${articleType}">
			</td>
			<td>
				제목 : <input name="title" type="text">
			</td>
			<td>
				내용 : <input name="content" type="text">
			</td>
			<td>
				작성자 : <input name="id" type="text">
			</td>
			<td>
				<button type="submit">검색</button>
			</td>
		</tr>
	</table>
</form>	
	<table align="center" border="1" width="80%">
		<tr height="10" align="center" bgcolor="lightgreen">
			<td>글번호</td>
			<td>작성자</td>
			<td>제목</td>
			<td>작성일</td>
		</tr>
		<c:choose>
			<c:when test="${empty boardList}">
			<tr>
				<td colspan="4">			
					<p align="center">
						<b><span style="font-size: 9pt">게시물이 없습니다.</span></b>
					</p>
				</td>
			</tr>	
			</c:when>
			<c:when test="${not empty boardList}">
				<c:forEach var="article" items="${boardList}" varStatus="i">
					<tr align="center">
						<td width="5%">${i.count}</td>
						<td width="10%">${article.id}</td>
						<td align="left" width="35%">
							<span style="padding-right: 30px"></span>
							<a href="${contextPath}/board/viewArticle.do?articleNO=${article.articleNO}&articleType=${articleType}&stitle=${stitle}&scontent=${scontent}&sid=${sid}" class="cls1"><c:out value="${article.title}"/></a>
						</td>
						<td width="10%">${article.writeDate}</td>
					</tr>
				</c:forEach>
					<tr>
						<td colspan="4">
						<ul style="display: table; margin-left: auto; margin-right: auto;">
							<c:if test="${pageVo.prev}">
								<li><a href="${contextPath}/board/boardList.do?pageNum=${pageVo.startPage-1}&amount=${pageVo.amount}&articleType=${articleType}">이전</a></li>
							</c:if>
							<c:forEach var="num" begin="${pageVo.startPage}" end="${pageVo.endPage}">
								<li class="${pageVo.pageNum eq num ? 'active' : '' }">
									<c:if test="${num!=0}">
	                        			<a style="text-decoration: none;" href="${contextPath}/board/boardList.do?pageNum=${num}&amount=${pageVo.amount}&articleType=${articleType}">${num}</a>
	                        		</c:if>
	                        	</li>
							</c:forEach>	
							<c:if test="${pageVo.next}">
	                        	<li>
	                        		<a href="${contextPath}/board/boardList.do?pageNum=${pageVo.endPage + 1 }&amount=${pageVo.amount}&articleType=${articleType}">다음</a>
	                        	</li>
                        	</c:if>
						</ul>
						</td>
					</tr>
			</c:when>
		</c:choose>
	</table>
	<a class="cls1" href="${contextPath}/board/articleForm.do?articleType=${articleType}&stitle=${info.title}&scontent=${info.content}&sid=${info.id}">
		<p style="margin-top: 50px;" class="cls2">글쓰기</p>
	</a>
</body>
</html>