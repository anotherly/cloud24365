<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title>CLOUD 24 365 관리자 페이지</title>
	<jsp:include page="/cmn/admin/top.do" flush="false" />
	<link type="text/css" rel="stylesheet" href="/css/imgTable.css">
<script>
function show_popup_insert(){
	console.log("고객사등록");
    document.getElementsByClassName('modal size_l normal')[0].classList.toggle('show');
    $("#modal_popup_insert #popupBody").load("/admin/edit/partnerInsert.do");
}

function show_popup_detail(that){
	console.log("고객사상세");
    document.getElementsByClassName('modal size_l normal')[1].classList.toggle('show');
    $("#modal_popup_detail #popupBody").load("/admin/edit/partnerDetail.do?PARTNER_ID="+$(that).attr('id')+"");
}

$(document).ready(function() {
	console.log("협력사사진 관리자 페이지");
	$("#partnerList").empty();
	var ajaxData = ajaxMethod("/admin/edit/partnerList.ajax").data;
	var divContents="";
	for (var i = 0; i < ajaxData.length; i++) {
		if(i==0){
			divContents+="<ul style='padding: 0 70px 0 0;'>"
		}
		divContents+="<li class=''><a><figure id="+ajaxData[i].PARTNER_ID+" onclick='show_popup_detail(this)'><img src='/resources"+ajaxData[i].file_DIR+ajaxData[i].file_NAME+"' alt='' title=''></figure></a></li>"
		if(i==ajaxData.length-1){
			divContents+="</ul>"
		}
	}
	$("#partnerList").append(divContents);
});
</script>
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
					<button id="contentInfo" class="nav-link" role="tab" aria-selected="false" onclick="location.href='/admin/edit/content.do'">컨텐츠 관리 현황</button>
					<button id="companyInfo" class="nav-link active" role="tab" aria-selected="false" onclick="location.href='/admin/edit/client.do'">고객사 관리현황</button>
					<button id="billInfo" class="nav-link" role="tab" aria-selected="false" onclick="location.href='/admin/edit/bill.do'">청구서양식 관리현황</button>
				</div>
			</div>
		</div>
		<!-- title end -->
		
		<!-- contents Start ------------------>
		<div id="contents" class="contents-wrap list_ani">
			<!-- work Start -->
			<div id="work" class="work-wrap list_page" style="max-width: 2200px;">
				<div class="ctn_tbl_area" style="margin:20px 0;">
					
					<!-- <img src="/images/company.png" > -->
					<!-- 사진영역 넣을것 -->
					<div id="partnerList" class="bo_list event_list"></div>
				</div>
			</div>
		</div>
		
		<div id="footer" class="footer-wrap">
	        <div id="footer-inner" class="footer-inner">
	            <!-- btn_box Start -->
	            <div class="btn_box">
	                <div class="right">
	                	<button class="btn" onclick="show_popup_insert()">고객사등록</button>
	                </div>
	            </div>
	        </div>
	    </div>
	</div>
	
<!-- 모달 Start -->
<div class="modal size_l normal" id="modal_popup_insert">
    <div class="popup_layer">
        <div class="pop_header">
            <div class="pop_header_ttl">고객사 등록</div>
            <button type="button" class="btn-close" onclick="show_popup_insert()">close</button>
        </div>
        <div class="pop_body" id="popupBody"></div>
    </div>
</div>
<div class="modal size_l normal" id="modal_popup_detail">
    <div class="popup_layer">
        <div class="pop_header">
            <div class="pop_header_ttl">고객사 상세보기</div>
            <button type="button" class="btn-close" onclick="show_popup_detail()">close</button>
        </div>
        <div class="pop_body" id="popupBody"></div>
    </div>
</div>
<!-- 모달 End -->
</body>
</html>