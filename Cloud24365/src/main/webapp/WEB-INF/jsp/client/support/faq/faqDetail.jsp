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
		console.log("보고서 상세");
		var tagId='${data.FAQ_ID}';
		var sibal = '${login.AUTH_CODE}';
		//목록 버튼 클릭 시
		$("#btnList").click(function(){
			location.href="/client/support/faq/faqList.do"; 
		});
	});
	
</script>
</head>
                <!-- contents_box Start -->
                <div id="contents_box" class="contents_box">
                    <!-- 컨텐츠 테이블 헤더 Start -->
                    <div class="ctn_tbl_header">
                        <div class="ttl_ctn">보고서 상세</div><!-- 컨텐츠 타이틀 -->
                    </div>
                    <!-- 컨텐츠 테이블 헤더 End -->
                    <!-- 컨텐츠 테이블 영역 Start -->
                    <div class="ctn_tbl_area">
					
						<div class="ctn_tbl_row">
                            <div class="ctn_tbl_th">번호</div>
                            <div class="ctn_tbl_td">
                                ${data.FAQ_ID}
                            </div>
                            <div class="ctn_tbl_th">작성자</div>
                            <div class="ctn_tbl_td">
                                ${data.FAQ_TITLE}
                            </div>
                        </div>
					
						<div class="ctn_tbl_row">
                            <div class="ctn_tbl_th">작성일자</div>
                            <div class="ctn_tbl_td">
                                ${data.FAQ_DT}
                            </div>
                            <div class="ctn_tbl_th">분류</div>
                            <div class="ctn_tbl_td">
                                ${data.FAQ_TYPE_NM}
                            </div>
                        </div>
                        
                                                
                        <div class="ctn_tbl_row">
                            <div class="ctn_tbl_th">내용</div>
                            <div class="ctn_tbl_td">
                                <textarea id="CONTENT" name="CONTENT" class="long-cont" style="height:470px;" readonly>
                                ${data.CONTENT}
                                </textarea>
                            </div>
                        </div>
                    </div>
                    
                    <div class="btn_box">
		               	 <div class="right">
							<button  id="btnList"  class="btn">
								<span class="langSpan">목록으로</span>
							</button>
                    	</div>
                    </div>
                </div>
                <!-- contents_box End -->
                
                <!-- footer Start ------------------>
                <%@include file="/footer.jsp" %>
                <!-- footer End ------------------>
</html>