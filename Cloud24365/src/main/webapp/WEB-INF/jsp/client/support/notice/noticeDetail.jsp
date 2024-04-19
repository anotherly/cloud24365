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
		console.log("공지사항 상세");
		var tagId='${data.NOTICE_ID}';
		var sibal = '${login.AUTH_CODE}';
		//목록 버튼 클릭 시
		$("#btnList").click(function(){
			location.href="/client/support/notice/noticeList.do"; 
		});
		//수정 버튼 클릭 시
		$("#btnUpdate").click(function(){
			 location.href="/client/support/notice/noticeUpdate.do?NOTICE_ID="+tagId; 
		});
		//삭제 버튼 클릭 시
		$("#btnDelete").click(function(){
			if(confirm("선택하신 항목을 삭제하시겠습니까?")==true){
				var idArr=[]; // 회원 id값 배열
				idArr.push(tagId);//배열에 아이디 값 삽입
//				//console.log("보낼 값 : "+ idArr);
				var url="/client/support/notice/noticeDelete.do";
				var data = {"idArr":idArr};
				var callback= "/client/support/notice/noticeList.do";
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
                        <div class="ttl_ctn">공지사항 상세</div><!-- 컨텐츠 타이틀 -->
                    </div>
                    <!-- 컨텐츠 테이블 헤더 End -->
                    <!-- 컨텐츠 테이블 영역 Start -->
                    <form name="insertForm" id="acDetailFrm" method="post" enctype="multipart/form-data">
                    <div class="ctn_tbl_area">
					
                        <div class="ctn_tbl_row">
                            <div class="ctn_tbl_th fm_rep">분류</div>
                            <div class="ctn_tbl_td">
 								${data.NOTICE_TYPE_NM}
                            </div>
                            <div class="ctn_tbl_th">추가 발송</div>
                            <div class="ctn_tbl_td">
								<label class="fm_checkbox">
									<span class="langSpan">이메일</span>
									<input type="checkbox" name="FLAG_EMAIL" id="chk_status0" value="Y"
										<c:if test="${data.FLAG_EMAIL eq 'Y'}">checked</c:if>
									disabled>
									<span class="checkmark"></span>
								</label>
								
								<label class="fm_checkbox">
									<span class="langSpan">SMS</span>
									<input type="checkbox" name="FLAG_SMS" id="chk_status1" value="Y"
										<c:if test="${data.FLAG_SMS eq 'Y'}">checked</c:if>									
									disabled>
									<span class="checkmark"></span>
								</label>
                            </div>
                        </div>
						<div class="ctn_tbl_row">
                            <div class="ctn_tbl_th fm_rep">제목</div>
                            <div class="ctn_tbl_td">
                                ${data.NOTICE_TITLE}
                            </div>
                        </div>
                        
						<div class="ctn_tbl_row">
                            <div class="ctn_tbl_th">파일첨부</div>
                            <div class="ctn_tbl_td">
	                            <c:forEach var="fvo" items="${fileList}">
									<a href="/download.ajax?FILE_ID=${fvo.FILE_ID}">${fvo.FILE_NAME}</a>
							    </c:forEach>
                            </div>
                        </div>

                        <div class="ctn_tbl_row">
                            <div class="ctn_tbl_th fm_rep">작성자</div>
                            <div class="ctn_tbl_td">
                                ${data.USER_NAME}
                            </div>
                        </div>

                        <div class="ctn_tbl_row">
                            <div class="ctn_tbl_th">내용</div>
                            <div class="ctn_tbl_td">
                                <textarea id="CONTENT" name="CONTENT" class="long-cont" style="height:400px;" disabled>${data.CONTENT}</textarea>
                            </div>
                        </div>
                    </div>
                    </form>
                </div>
                <!-- contents_box End -->
                
                <!-- footer Start ------------------>
                <div id="footer" class="footer-wrap">
					<%@include file="/footer.jsp" %>
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