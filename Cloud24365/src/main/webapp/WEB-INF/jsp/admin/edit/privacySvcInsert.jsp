<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title>CLOUD 24 365 관리자 페이지</title>
	<jsp:include page="/cmn/admin/top.do" flush="false" />
 	

<script>

	$(document).ready( function() {
		$("#btnSave").on("click",function(){
			console.log("이용약관 저장");
			ajaxMethod('/admin/edit/privacySvcInsert.ajax',{"TEXT_VAL":$("#TEXT_VAL").val()},'/admin/edit/privacySvcList.do','저장되었습니다');
		});
	});
	
</script>
</head>
<body class="open">
    <!-- lnb Start ------------------>
    <aside id="lnb" class="lnb">
        <a class="lnb-control" title="메뉴 펼침/닫침"><span class="menu-toggle">메뉴 펼침/닫침</span></a>
        <nav id="navbar" class="navbar navbar-expand-sm navbar-default">
            <ul class="menu-inner"></ul>
        </nav>
    </aside>
    <!-- lnb End ------------------>
    
    <!-- container Start ------------------>
    <div id="container" class="container-wrap">
		<!-- header Start ------------------>
		<div id="header" class="header-wrap"></div>
		<!-- header End ------------------>
		<!-- title start -->
		<div id="title" class="title-wrap">
			<div class="title-inner">
				<!-- 타이틀 텝 구성 -->
				<div class="title_segments" role="tablist">
					<button id="contentInfo" class="nav-link active" role="tab" aria-selected="false" onclick="location.href='/admin/edit/content.do'">컨텐츠 관리 현황</button>
					<button id="companyInfo" class="nav-link" role="tab" aria-selected="false" onclick="location.href='/admin/edit/client.do'">고객사 관리현황</button>
					<button id="billInfo" class="nav-link" role="tab" aria-selected="false" onclick="location.href='/admin/edit/bill.do'">청구서양식 관리현황</button>
				</div>
			</div>
		</div>
		<!-- title end -->
		
		<!-- contents Start ------------------>
		<div id="contents" class="contents-wrap list_ani">
			<!-- work Start -->
			<div id="work" class="work-wrap list_page">
				<div class="title">
					<h3> Editor > 컨텐츠 관리현황 > 개인정보처리방침 등록 </h3>
				</div>
				<div>
					<textarea id="TEXT_VAL" class="long-cont"></textarea>
				</div>
	
				<div id="footer" class="footer-wrap">
			        <div id="footer-inner" class="footer-inner">
			            <!-- btn_box Start -->
			            <div class="btn_box">
			                <div class="right">
			                    <button class="btn btn_primary" style="" id="btnSave" ><span class="langSpan">저장</span></button>
			                    <button class="btn" style="" id="btnCancel" onclick="history.back();"><span class="langSpan">취소</span></button>
			                </div>
			            </div>
			        </div>
			    </div>
			</div><!-- work -->
		</div><!-- contents -->
	</div><!-- container -->
	
</body>
</html>