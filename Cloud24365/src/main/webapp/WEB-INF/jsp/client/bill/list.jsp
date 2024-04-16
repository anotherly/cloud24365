<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title>CLOUD 24 365</title>
	<jsp:include page="/cmn/top.do" flush="false" />
 	<!-- Custom style -->
	<link rel="stylesheet" href="<%=request.getContextPath()%>/css/svc.css">

	<!-- JS -->
	<script src="<%=request.getContextPath()%>/js/jquery.js"></script>
	<script src="<%=request.getContextPath()%>/js/jquery.migrate.js"></script>

	<!-- 로그인 시큐어코딩 관련 -->
	<script src="<%=request.getContextPath()%>/js/loginSC/login.js"></script>
	<script src="<%=request.getContextPath()%>/js/common/validation.js"></script>
 	 
	<script>
		$(document).ready(function() {
			console.log("과금 리스트");
		});
	</script>
	
</head>
<body>
	<div id="mspDiv" class="msp-div">
		<h1>과금 리스트</h1>	
	</div>
	<%@include file="/footer.jsp" %>
</body>
</html>