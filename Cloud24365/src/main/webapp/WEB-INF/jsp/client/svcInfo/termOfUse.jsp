<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title>CLOUD 24 365</title>
	<jsp:include page="/cmn/client/top.do" flush="false" />
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
			console.log("msp 서비스소개 : ");
		});
	</script>
	
</head>
<body class="open">
    <!-- lnb Start ------------------>
    <aside id="lnb" class="lnb">
        <a class="lnb-control" title="메뉴 펼침/닫침"><span class="menu-toggle">메뉴 펼침/닫침</span></a>
        <nav id="navbar" class="navbar"></nav>
    </aside>
    <!-- lnb End ------------------>
        <!-- container Start ------------------>
    <div id="container" class="container-wrap" style="margin-top: 60px;background: none;" >
		<!-- header Start ------------------>
		<div id="header" class="header-wrap"></div>
		<!-- header End ------------------>
		<!-- title start -->
		<div id="title" class="title-wrap">
			<div class="title-inner">
				<!-- 타이틀 텝 구성 -->
				<div class="title_segments" role="tablist">
					<button class="nav-link active" role="tab" aria-selected="false">
					하이브시스템 MSP 서비스소개
					</button>
				</div>
			</div>
		</div>
		<!-- title end -->
		
		<!-- contents Start ------------------>
		<div id="contents" class="contents-wrap list_ani">
			<!-- work Start -->
			<div id="work" class="work-wrap list_page">
				<!-- <div class="title">
					<h3>이 용 약 관</h3>
				</div> -->
					<textarea id="TEXT_VAL" class="long-cont" style="margin-top:50px;resize: none;" disabled>${data.TEXT_VAL}</textarea>
			</div>	
		</div>
		<%@include file="/footer.jsp" %>
	</div>	
</body>
</html>

