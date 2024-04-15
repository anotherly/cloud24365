<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-/\/W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
	<!-- 드롭다운 메뉴 -->
	<!-- css -->
	<link type="text/css" rel="stylesheet" href="/css/import.css" media="all">
	
	<!-- JS -->
	<script src="<%=request.getContextPath()%>/js/jquery3.5.1.js"></script>
	
	<script src="<%=request.getContextPath()%>/js/jquery.migrate.js"></script>
	<script src="<%=request.getContextPath()%>/js/jquery.form.js"></script>
	<script src="<%=request.getContextPath()%>/js/common/common.js"></script>
	<script src="<%=request.getContextPath()%>/js/common/validation.js"></script>
	<script src="<%=request.getContextPath()%>/js/common/dtb.js"></script>
	<script src="<%=request.getContextPath()%>/js/loginSC/login.js"></script>

	<!-- Custom style -->
	<link rel="stylesheet" href="<%=request.getContextPath()%>/css/button.css">
	<link rel="stylesheet" href="<%=request.getContextPath()%>/css/svc.css">
	<link rel="stylesheet" href="<%=request.getContextPath()%>/css/dtb.css">
	<link rel="stylesheet" href="<%=request.getContextPath()%>/css/user.css">
	<!-- DataTable -->
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/DataTables/datatables.min.css"/>
	<script type="text/javascript" src="<%=request.getContextPath()%>/DataTables/datatables.min.js"></script>

	<!-- DateTimePicker -->
	<script src="<%=request.getContextPath()%>/calender/moment.js"></script>
	<script src="<%=request.getContextPath()%>/calender/mo_ko.js"></script>
	<script src="<%=request.getContextPath()%>/calender/bootstrap-datetimepicker.js"></script>
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/calender/no-boot-calendar-custom.css" />
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/calender/datetimepickerstyle.css" />

	<!-- 로그인 시큐어코딩 관련 -->
	<script src="<%=request.getContextPath()%>/js/loginSC/login.js"></script>
	<script src="<%=request.getContextPath()%>/js/common/validation.js"></script>
	
	<script src="<%=request.getContextPath()%>/js/cloud.js"></script>
	
<title>탑</title>
</head>
<script>

$(document).ready(function() {
	console.log("top 참조화면");
	//메뉴 이벤트
	document.querySelector(".lnb-control").addEventListener("click",function(){
        document.body.classList.toggle('open')
    });
	
	var nowUrl = location.href;
	nowUrl=nowUrl.split("/")[4];
	console.log(nowUrl);
	//타이틀 부분
	$(".title-inner").load("/client/"+nowUrl+"/subTitle.do");
	
	$('#navbar').load("/cmn/client/menu.do");
	$('#header').load("/cmn/client/header.do");
});

</script>
</html>