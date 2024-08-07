<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>CLOUD 24 365</title>
	<jsp:include page="/cmn/client/top.do" flush="false" />
	<script>
		$(document).ready(function() {
			console.log("문의하기");
			loadFaq();
			$("#acDetailFrm").submit(function(e){
				console.log("문의하기 등록");
				let frm = $("#acDetailFrm").serialize();
				//let param = encodeURI(frm);
			    var options = {
		            url:'/client/support/request/insertReq.ajax',
		            type:"post",
		            dataType: "json",
		            //contentType: "application/x-www-form-urlencoded; charset=euc-kr",
		            data : frm,
		            async : false,
		            success: function(res){
		                if(res.cnt > 0){
		                    alert("저장되었습니다.");
		                    window.location.href='/client/support/request/reqList.do';
		                } else {
		                	if(res.badFileType != null){
		                		alert("사진파일 첨부는 이미지 파일만 가능합니다.")
		                	} else if(typeof res.createFileError !== "undefined" && res.createFileError){
		                	    alert("사진파일 저장에 실패했습니다.");
		                	} else if(typeof res.msg !== "undefined" && res.msg != null){
		                		alert(res.msg);
		                	}else {
		                		alert("저장에 실패했습니다.");
		                	}
		                }
		            } ,
		            error: function(res,error){
		                alert("에러가 발생했습니다."+error);
		            }
			    };
			    $('#acDetailFrm').ajaxSubmit(options);

			});
		});
		
		//jquery 동적으로 생성한 요소에 이벤트 바인딩 적용하기
		$(document).on("click", "#faq_show", function(){
			$(this).parent().parent().find("#faq_show").hide();
			$(this).parent().parent().find("#faq_hide").show();
			$(this).parent().parent().parent().find("#FAQ_ANSWER").show();
		});
		$(document).on("click", "#faq_hide", function(){
			$(this).parent().parent().find("#faq_show").show();
			$(this).parent().parent().find("#faq_hide").hide();
			$(this).parent().parent().parent().find("#FAQ_ANSWER").hide();
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
					<button class="nav-link active" role="tab" aria-selected="false">문의하기</button>
				</div>
			</div>
		</div>
		<!-- title end -->

		<!-- contents Start ------------------>
		<div id="contents" class="contents-wrap">
			<!-- work Start -->
			<div id="work" class="work-wrap" style="display:flex;flex-direction: row;justify-content: space-between;">
			<form name="insertForm" id="acDetailFrm" method="post"  action='/client/support/request/reqList.do'  enctype="multipart/form-data">
                <!-- contents_box Start -->
                <div id="contents_box" class="contents_box" style="width: 900px;">
                    <!-- 컨텐츠 테이블 헤더 Start -->
                    <div class="ctn_tbl_header">
                        <div class="ttl_ctn">문의하기</div><!-- 컨텐츠 타이틀 -->
                        <div class="txt_info"><em class="txt_info_rep">*</em> 표시는 필수 입력 항목입니다.</div><!-- 설명글 -->
                    </div>
                    <!-- 컨텐츠 테이블 헤더 End -->
                    <!-- 컨텐츠 테이블 영역 Start -->
                    
                    <div class="ctn_tbl_area">
					
                        <div class="ctn_tbl_row">
                            <div class="ctn_tbl_th fm_rep">제목</div>
                            <div class="ctn_tbl_td">
                                <input type="text" class="form-control mw_50" id="REQ_TITLE" name="REQ_TITLE" value="${reqVo.REQ_TITLE}" required/>
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
								<input type="file" name="multiFile" multiple> 
								※ 첨부파일은 3개월 후 자동 삭제 됩니다 <br>(첨부파일은 총 5MB 이내)
								<c:forEach var="fvo" items="${fileList}">
									<a href="/download.ajax?FILE_ID=${fvo.FILE_ID}">${fvo.FILE_NAME}</a>
							    </c:forEach>
                            </div>
                        </div>
                                                
                        <div class="ctn_tbl_row">
                            <div class="ctn_tbl_th fm_rep">문의내용</div>
                            <div class="ctn_tbl_td">
                                <textarea id="REQ_QUESTION" name="REQ_QUESTION" class="long-cont" style="height:405px;" required></textarea>
                            </div>
                        </div>
                    </div>
                    <!-- area end -->
                    
                </div>
                <!-- contents_box End -->
                        <!-- btn_box Start -->
                       <div class="btn_box" style="margin-top:30px;">
                           <div class="right">
		                    <button type="submit"  class="btn btn_primary" style="" id="btnSave" data-term="L.등록" title="등록">
								<span class="langSpan">등록</span>
							</button>
				             <button type="button"  class="btn" id="btnList" data-term="L.목록" title="목록"
							onclick="location.href='/client/support/request/reqList.do'">
							<span class="langSpan">취소</span></button>
		                </div>
                       </div>
                       <!-- btn_box End -->
                </form>
                                
                 
                <div id="faqDiv" class="faqClass" style="display:flex;width: 550px;height: 756px;background:#fff;flex-direction: column;padding: 30px;overflow: auto;">
                	<h2>자주하는 질문 먼저 확인해보세요!</h2>
                	<h4>TOP FAQ</h4>
                </div>
                                
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

