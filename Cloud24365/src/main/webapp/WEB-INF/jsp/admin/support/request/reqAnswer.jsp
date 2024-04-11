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
			console.log("문의하기 답변");
			ajaxMethod('/admin/support/request/reqAnswer.ajax',{"TEXT_VAL":$("#TEXT_VAL").val()},'/admin/edit/reqList.do','저장되었습니다');
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
					<button class="nav-link active" role="tab" aria-selected="false">문의내용 답변</button>
				</div>
			</div>
		</div>
		<!-- title end -->
		
		<!-- contents Start ------------------>
		<div id="contents" class="contents-wrap list_ani">
			<!-- work Start -->
			<div id="work" class="work-wrap list_page">
				
				
                <!-- search_box Start -->
               <div class="search_box">
				   <form action="#" method="post" id="searchFrm" onsubmit="return false;" class="search_form">

						<input type="hidden" class="input_base" id="REQ_DIV" name="REQ_DIV" value="1"/>
						<input type="hidden" class="input_base" id="REQ_STATUS" name="REQ_STATUS" value="0"/>
						<input type="hidden" class="input_base" id="INSERT_TYPE" name="INSERT_TYPE" value="0"/>
				   
                        <div class="ctn_tbl_row">
                            <div class="ctn_tbl_th fm_rep">제목</div>
                            <div class="ctn_tbl_td">
								<input type="text" class="input_base" id="REQ_TITLE" name="REQ_TITLE" value="${reqVo.REQ_TITLE}"/>
                            </div>
                        </div>
						<div class="ctn_tbl_row">
                            <div class="ctn_tbl_th fm_rep">문의유형</div>
                            <div class="ctn_tbl_td">
                                <select id="REQ_TYPE" name="REQ_TYPE" class="form-control mw_10">
									<option value="0">영업</option>
			                        <option value="1">기술</option>
			                        <option value="2">사용방법</option>
			                        <option value="3">장애</option>
								</select>
                            </div>
                        </div>
				   		
						<div class="ctn_tbl_row">
                            <div class="ctn_tbl_th">파일첨부</div>
                            <div class="ctn_tbl_td">
								<input type="hidden" class="input_base" id="CLIENT_FILE" name="CLIENT_FILE" value="${reqVo.CLIENT_FILE}" style="width:307px;" readonly />
								<input type="file" class="input_base" id="file" name="file" onchange="changePicture($(this));" style="width:377px; height: 20px;" />
								※ 첨부파일은 3개월 후 자동 삭제 됩니다 (첨부파일은 총 5MB 이내)
                            </div>
                        </div>
                                                
                        <div class="ctn_tbl_row">
                            <div class="ctn_tbl_th">문의내용</div>
                            <div class="ctn_tbl_td">
                                <textarea id="REQ_QUESTION" name="REQ_QUESTION" class="form-control" style="height:470px;"></textarea>
                            </div>
                        </div>
				   
				   </form>
				</div>
                <!-- search_box End -->
                
                <!-- grid_box Start -->
				<!-- grid_box End -->
					
				<div id="footer" class="footer-wrap">
			        <div id="footer-inner" class="footer-inner">
			            <!-- btn_box Start -->
			            <div class="btn_box">
			                <div class="right">
			                	<button class="btn btn_primary" style="" id="btnInsert" data-term="L.등록" title="등록"><span class="langSpan">등록</span></button>
				                    <button class="btn" id="btnSave" alt="저장" value="저장"><span class="langSpan">저장</span></button>
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