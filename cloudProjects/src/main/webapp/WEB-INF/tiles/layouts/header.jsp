<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="sessionVo" value="${sessionScope.S_USER}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-light bg-light">
  <div class="container-fluid">
    <button class="navbar-toggler" type="button" data-mdb-toggle="collapse" data-mdb-target="#navbarSupportedContent" aria-controls="navbarSupportedContent"
      aria-expanded="false" aria-label="Toggle navigation"><i class="fas fa-bars"></i>
    </button>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
     <nav aria-label="breadcrumb">
	     <ol class="breadcrumb">
	        <li class="breadcrumb-item"><a href="/main/loginhist">Login History</a></li>
	        <li class="breadcrumb-item"><a href="/main/view">Users</a></li>
	        <li class="breadcrumb-item"><a href="/board/main/view">Main Contents</a></li>
	        <li class="breadcrumb-item"><a href="/board/main/myMain">My Contents</a></li>
	        <li class="breadcrumb-item"><a href="/todo/main/view">To do List</a></li>
	        <li class="breadcrumb-item"><a href="/chat/main/view">❤Chat❤</a></li>
	      </ol>
      </nav>
    </div>
    <div class="d-flex align-items-center">
      <div class="d-flex align-items-center">
        <button type="button" class="btn btn-link px-3 me-2">❤ 닉네임&nbsp;&nbsp;: &nbsp;[ ${sessionVo.user_nm} ] 님 ❤</button>
        <a class="btn btn-dark px-3" href="https://github.com/cloud0990" role="button" style="margin-right:5px;"><i class="fab fa-github"></i></a>
        <button type="button" class="btn btn-primary me-3" onclick="location.href='/logout';">LOGOUT</button>
      </div>
    </div>
  </div>
</nav>

</body>
</html>