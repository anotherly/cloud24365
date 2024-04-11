<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>CLOUD 24 365 관리자 페이지</title>
	<jsp:include page="/cmn/admin/top.do" flush="false" />
	<script>
		$(document).ready(function() {
			console.log("문의하기");
			/* $("#acDetailFrm").submit(function(e){
				console.log("문의하기 등록");
				let frm = $("#acDetailFrm").serialize();
				var options = {
		            url:'/admin/report/insertReport.ajax',
		            type:"post",
		            dataType: "json",
		            data : frm,
		            success: function(res){
		                if(res.cnt > 0){
		                    alert("저장되었습니다.");
		                    location.href="/admin/report/reportList.do"
		                } else {
		                	if(res.badFileType != null){
		                		alert("사진파일 첨부는 이미지 파일만 가능합니다.");
		                	} else if(typeof res.createFileError !== "undefined" && res.createFileError) {
		                	    alert("사진파일 저장에 실패했습니다.");
		                	} else if(typeof res.msg !== "undefined" && res.msg != null) {
		                		alert(res.msg);
		                	} else {
		                		alert("저장에 실패했습니다.");
		                	}
		                }
		            } ,
		            error: function(res,error){
		                alert("에러가 발생했습니다."+error);
		            }
			    };
				$('#acDetailFrm').ajaxSubmit(options);
			}); */
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
				<!-- 타이틀 텝 구성 -->
				<div class="title_segments" role="tablist">
					<button class="nav-link active" role="tab" aria-selected="false">보고서 등록</button>
				</div>
			</div>
		</div>
		<!-- title end -->

		<!-- contents Start ------------------>
		<div id="contents" class="contents-wrap">
			<!-- work Start -->
			<div id="work" class="work-wrap">
				<form name="insertForm" id="acDetailFrm" method="post"  enctype="multipart/form-data">
                <!-- contents_box Start -->
                <div id="contents_box" class="contents_box">
				    <!-- 컨텐츠 테이블 영역 Start -->
					     <div class="ctn_tbl_area">
					         <div class="ctn_tbl_row">
					             <div class="ctn_tbl_th fm_rep">보고서명</div>
					             <div class="ctn_tbl_td">
									<input type="text" class="form-control" name="REPORT_NAME" maxlength='20' required/>
							    </div>
							</div>
							<div class="ctn_tbl_row">
				               <div class="ctn_tbl_th fm_rep">프로젝트명</div>
				               <div class="ctn_tbl_td">
									<input type="text" class="form-control" name="PROJECT_NAME"  maxlength='20' required/>
				               </div>
				           </div>
				           
				                       
							<div class="ctn_tbl_row">
								<div class="ctn_tbl_th">고객사</div>
								<div class="ctn_tbl_td">
									<select class="form-control mw_50"  style="width:120px;" id="areaCodeSel" name="ANS_USER">
									    <c:forEach var="cVo" items="${companyList}">
											<option value="${cVo.COMPANY_ID}">${cVo.COMPANY_NAME}</option>
									    </c:forEach>
									</select>
								</div>
							</div>
				           
							<div class="ctn_tbl_row">
							    <div class="ctn_tbl_th fm_rep">보고서유형</div>
								<div class="ctn_tbl_td">
	                            	<select id="REPORT_TYPE" name="REPORT_TYPE" class="form-control mw_40">
										<option value="0">주간보고</option>
				                        <option value="1">월간보고</option>
				                        <option value="2">ETC</option>
									</select>
	                            </div>
							</div>
							
							<div class="ctn_tbl_row">
								<div class="ctn_tbl_th">보고서별첨</div>
								<div class="ctn_tbl_td">
									<input type="file" name="multiFile">
								</div>
							</div>
						</div>
					
				</div>
				<!-- contents_box End -->
                
                <!-- footer Start ------------------>
                <div id="footer" class="footer-wrap">
                    <div id="footer-inner" class="footer-inner">
                        <!-- btn_box Start -->
                        <div class="btn_box">
                            <div class="right">
			                    <button type="submit" class="btn btn_primary" style="" id="btnSave" data-term="L.등록" title="등록">
			                    	<span class="langSpan">등록</span>
			                    </button>
					            <button type="button"  class="btn" id="btnList" data-term="L.목록" title="목록" onclick="location.href='/admin/report/reportList.do'">
									<span class="langSpan">취소</span>
								</button>
			                </div>
                        </div>
                        <!-- btn_box End -->
                    </div>
                </div>
                <!-- footer End ------------------>
                </form>
            </div>
			<!-- work End -->
        </div>
		<!-- contents End ------------------>
    </div>
    <!-- container End ------------------>
</body>
</html>