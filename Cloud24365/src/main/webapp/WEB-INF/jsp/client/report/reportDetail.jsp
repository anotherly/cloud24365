<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title>CLOUD 24 365 관리자 페이지</title>
<script>

	$(document).ready( function() {
		console.log("공지사항 상세");
		var tagId='${data.REPORT_ID}';
		var sibal = '${login.AUTH_CODE}';
		//목록 버튼 클릭 시
		$("#btnList").click(function(){
			location.href="/client/report/reportList.do"; 
		});
	});
	
</script>
</head>
	<!-- contents_box Start -->
	<div id="contents_box" class="contents_box">
	    <!-- 컨텐츠 테이블 헤더 Start -->
	    <div class="ctn_tbl_header">
	        <div class="ttl_ctn">공지사항 상세</div><!-- 컨텐츠 타이틀 -->
	    </div>
	    <!-- 컨텐츠 테이블 헤더 End -->
	    <!-- 컨텐츠 테이블 영역 Start -->
	    <form name="insertForm" id="acDetailFrm" method="post" enctype="multipart/form-data">
		     <div class="ctn_tbl_area">
		         <div class="ctn_tbl_row">
		             <div class="ctn_tbl_th fm_rep">보고서명</div>
		             <div class="ctn_tbl_td">
						${data.REPORT_NAME}
				    </div>
				</div>
				<div class="ctn_tbl_row">
	               <div class="ctn_tbl_th fm_rep">프로젝트명</div>
	               <div class="ctn_tbl_td">
	                   ${data.PROJECT_NAME}
	               </div>
	           </div>
				<div class="ctn_tbl_row">
				     <div class="ctn_tbl_th fm_rep">보고서유형</div>
				     <div class="ctn_tbl_td">
				         ${data.REPORT_TYPE_NM}
				    </div>
				</div>
				<div class="ctn_tbl_row">
				     <div class="ctn_tbl_th fm_rep">고객사</div>
				     <div class="ctn_tbl_td">
				         ${data.COMPANY_NAME}
				    </div>
				</div>
		                  
				<div class="ctn_tbl_row">
					<div class="ctn_tbl_th">보고서별첨</div>
					<div class="ctn_tbl_td">
						<c:forEach var="fvo" items="${fileList}">
							<a href="/download.ajax?FILE_ID=${fvo.FILE_ID}">${fvo.FILE_NAME}</a>
						</c:forEach>
					</div>
				</div>
			</div>
		</form>
		
		<!-- btn_box Start -->
		<div class="btn_box">
           	 <div class="right">
				<button  id="btnList"  class="btn">
					<span class="langSpan">목록</span>
				</button>
			</div>
		</div>
		<!-- btn_box End -->
	</div>
	<!-- contents_box End -->
	
	<!-- footer Start ------------------>
	<%@include file="/footer.jsp" %>
	<!-- footer End ------------------>
</html>