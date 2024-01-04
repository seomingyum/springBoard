<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
 <title>Bootstrap demo</title>
<body>
<nav class="navbar navbar-expand-lg navbar-light bg-light">
  <div class="container-fluid">
    <a class="navbar-brand" href="${contextPath}/">MVC게시판</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
        <li class="nav-item">
          <a class="nav-link" href="${contextPath}/board/boardList.do?articleType=board1">공지게시판</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="${contextPath}/board/boardList.do?articleType=board2">자유게시판</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="${contextPath}/board/boardList.do?articleType=board3">질문게시판</a>
        </li>
      </ul>
      <div class="d-flex">
       <ul class="navbar-nav me-auto mb-2 mb-lg-0">
       <c:choose>
       	<c:when test="${empty userId}">
       		<li class="nav-item">
          <a class="nav-link" href="${contextPath}/member/signUpForm.do">회원가입</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="${contextPath}/member/loginForm.do">로그인</a>
        </li>
       	</c:when>
       	<c:otherwise>
       		<li class="nav-item" style="padding-top: 5px; padding-right: 20px">
          		반갑습니다. "${userId}" 님
        	</li>
       		<li class="nav-item">
          		<a class="nav-link" href="${contextPath}/member/logout.do">로그아웃</a>
        	</li>
       	</c:otherwise>
       </c:choose>
        
      </ul>
      </div>
    </div>
  </div>
</nav>
</body>
</html>