<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title>CLOUD 24 365</title>
	<jsp:include page="/cmn/client/top.do" flush="false" />
<script>

	$(document).ready( function() {
		console.log("보고서 상세");
		var tagId='${data.REPORT_ID}';
		var sibal = '${login.AUTH_CODE}';
		//목록 버튼 클릭 시
		$("#btnList").click(function(){
			location.href="/client/support/report/reportList.do"; 
		});
		//수정 버튼 클릭 시
		$("#btnUpdate").click(function(){
			 location.href="/client/support/report/reportUpdate.do?REPORT_ID="+tagId; 
		});
		//삭제 버튼 클릭 시
		$("#btnDelete").click(function(){
			if(confirm("선택하신 항목을 삭제하시겠습니까?")==true){
				var idArr=[]; // 회원 id값 배열
				idArr.push(tagId);//배열에 아이디 값 삽입
				//console.log("보낼 값 : "+ idArr);
				var url="/client/support/report/reportDelete.do";
				var data = {"idArr":idArr};
				var callback= "/client/support/report/reportList.do";
				ajaxMethod(url, data, callback);
    		}
		});//btnDelte
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
		
		<div id="title" class="title-wrap">
			<div class="title-inner">
			</div>
		</div>
		<!-- title end -->
		<!-- contents Start ------------------>
		<div id="contents" class="contents-wrap">
			<!-- work Start -->
			<div id="work" class="work-wrap">
	<!-- contents_box Start -->
	<div id="contents_box" class="contents_box">
	    <!-- 컨텐츠 테이블 헤더 Start -->
	    <div class="ctn_tbl_header">
	        <div class="ttl_ctn">보고서 상세</div><!-- 컨텐츠 타이틀 -->
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
	</div>
	<!-- contents_box End -->
	
	<!-- footer Start ------------------>
	<div id="footer" class="footer-wrap">
	    <div id="footer-inner" class="footer-inner">
	        <c:if test="${fn:length(login.AUTH_CODE)>2}">
	         <!-- btn_box Start -->
				<div class="btn_box">
		           	 <div class="right">
						<button  id="btnList"  class="btn">
							<span class="langSpan">목록</span>
						</button>
						<button  id="btnUpdate"  class="btn">
							<span class="langSpan">수정</span>
						</button>
						<button  id="btnDelete"  class="btn">
							<span class="langSpan">삭제</span>
						</button>
					</div>
				</div>
			<!-- btn_box End -->
	        </c:if>
	    </div>
	</div>
	<!-- footer End ------------------>
            </div>
			<!-- work End -->
        </div>
		<!-- contents End ------------------>
    </div>
    <!-- container End ------------------>
</body>
</html>