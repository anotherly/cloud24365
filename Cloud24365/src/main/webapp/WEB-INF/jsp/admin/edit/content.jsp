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
		
		//표 이동
		$("#mspInsert").on("click",function(){
			location.href='/admin/edit/mspInsert.do';
		});
		
		$("#mspDelete").on("click",function(){
			ajaxMethod("/admin/edit/mspDelete.ajax");
		});
		
		$("#touInsert").on("click",function(){
			location.href='/admin/edit/touInsert.do';
		});
		
		$("#touList").on("click",function(){
			location.href="/admin/edit/touList.do";
		});
		
		$("#privacyInsert").on("click",function(){
			location.href='/admin/edit/privacySvcInsert.do';
		});
		
		$("#privacyList").on("click",function(){
			location.href="/admin/edit/privacySvcList.do";
		});
		
	});
	
</script>
</head>
<body class="open">
    <!-- lnb Start ------------------>
    <aside id="lnb" class="lnb">
        <a class="lnb-control" title="메뉴 펼침/닫침"><span class="menu-toggle">메뉴 펼침/닫침</span></a>
        <nav id="navbar" class="navbar navbar-expand-sm navbar-default"></nav>
    </aside>
    <!-- lnb End ------------------>

    <!-- container Start ------------------>
    <div id="container" class="container-wrap">
		<!-- header Start ------------------>
		<div id="header" class="header-wrap">
		</div>
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
                <!-- grid_box Start -->
				<table class="simpleTb">
					<thead>
						<tr>
							<th>순번</th>
							<th>내용</th>
							<th>등록</th>
							<th>삭제/현황보기</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>1</td>
							<td>
								<a href='/admin/edit/mspSvcList.do'>MSP 서비스소개</a>
							</td>
							<td>
								<div id="btnInsert" >
									<input type='button' id='mspInsert' value='등록'>
								</div>
							</td>
							<td>
								<div id="btnDelete" >
									<input type='button' id='mspDelete' value='삭제'>
								</div>
							</td>
						</tr>
						<tr>
							<td>2</td>
							<td>
								이용약관
							</td>
							<td>
								<div id="btnInsert" >
									<input type='button' id='touInsert' value='등록'>
								</div>
							</td>
							<td>
								<div id="btnList" >
									<input type='button' id='touList' value='이용약관 현황 보기'>
								</div>
							</td>
						</tr>
						<tr>
							<td>3</td>
							<td>
								개인정보처리방침
							</td>
							<td>
								<div id="btnInsert" >
									<input type='button' id='privacyInsert' value='등록'>
								</div>
							</td>
							<td>
								<div id="btnList" >
									<input type='button' id='privacyList' value='개인정보처리방침 현황 보기'>
								</div>
							</td>
						</tr>
					</tbody>
				</table>
				<!-- grid_box End -->
					
				<div id="footer" class="footer-wrap">
			        <div id="footer-inner" class="footer-inner">
			            <!-- btn_box Start -->
			            <div class="btn_box">
			                <div class="right">
			                	<button class="btn btn_primary" style="" id="btnInsert" data-term="L.등록" title="등록"><span class="langSpan">등록</span></button>
				                <button class="btn" style="" id="btnUpdate" data-term="L.등록" title="등록" onclick='tbUpdate(this,updUrl)'><span class="langSpan">수정</span></button>
				                <button class="btn" style="" id="btnDelete" data-term="L.등록" title="등록" onclick='tbDelete(this,delUrl,delbak)'><span class="langSpan">삭제</span></button>
			                </div>
			            </div>
			        </div>
			    </div>
	            <!-- btn_box End -->
            </div>
			<!-- work End -->
        </div>
		<!-- contents End ------------------>
    </div>
    <!-- container End ------------------>
</body>
</html>
</html>