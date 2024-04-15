<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title>CLOUD 24 365</title>
	<jsp:include page="/cmn/client/top.do" flush="false" />
	<link type="text/css" rel="stylesheet" href="/css/imgTable.css">
<script>

$(document).ready(function() {
	console.log("협력사사진 관리자 페이지");
	$("#partnerList").empty();
	var ajaxData = ajaxMethod("/client/edit/partnerList.ajax").data;
	var divContents="";
	for (var i = 0; i < ajaxData.length; i++) {
		if(i==0){
			divContents+="<ul style='padding: 0 70px 0 0;'>"
		}
		divContents+=
			"<li id='"+ajaxData[i].file_ID+"' class=''><a>"
				+"<figure>"
					+"<img src='/usr/local/tomcat/share_data/resources"+ajaxData[i].file_DIR+ajaxData[i].file_NAME+"' alt='' title=''>"
				+"</figure>"
			+"</a></li>"
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
					<button id="companyInfo" class="nav-link active" role="tab" aria-selected="false" onclick="location.href='/client/edit/client.do'">고객사</button>
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
					<div id="partnerList" class="bo_list event_list">
						<ul>
							<li class=''><a><figure><img src='/resources/partner/PTN0020240213/111.jpg' alt='' title=''></figure></a></li>
						</ul>
					</div>
				</div>
			</div>
		</div>
		
		<%@include file="/footer.jsp" %>
		
	</div>
	
	
</body>
</html>
