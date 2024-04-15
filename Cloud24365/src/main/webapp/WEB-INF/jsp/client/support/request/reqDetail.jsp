<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title>CLOUD 24 365</title>
<script src="<%=request.getContextPath()%>/js/cloud.js"></script>
<jsp:include page="/cmn/client/top.do" flush="false" />

<script>
	$(document).ready( function() {
		console.log("문의하기 답변");
		/* 기존 답변리스트 생성 */
		var tagId='${reqVo.REQ_ID}';
		ansHistoryList(tagId);
		
		/* 답변리스트 펼치기/접기 */
		$("#anslist_show").on("click",function(){
			$("#anslist_show").hide();
			$("#ansList").show();
			$("#anslist_hide").show();
		});
		$("#anslist_hide").on("click",function(){
			$("#anslist_hide").hide();
			$("#ansList").hide();
			$("#anslist_show").show();
		});
		
		$("#btnSet").on("click",function(){
			let frm = $("#acDetailFrm").serialize();
			ajaxMethod('/client/support/request/reqAnsUser.ajax',frm);
			location.href='/client/support/request/reqList.do';
		});
		
		$("#acDetailFrm").submit(function(e){
			console.log("문의하기 상세 업데이트");
			let frm = $("#acDetailFrm").serialize();
		    var options = {
	            url:'/client/support/request/reqUpdate.ajax',
	            type:"post",
	            dataType: "json",
	            data : frm,
	            //contentType: "application/x-www-form-urlencoded; charset=euc-kr",
	            success: function(res){
	                if(res.cnt > 0){
	                    alert("저장되었습니다.");
	                    location.href='/client/support/request/reqList.do';
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
		
		$("#btnList").on("click",function(){
			location.href='/client/support/request/reqList.do';
		});
		
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

<div class="ctn_tbl_header">
    <div class="ttl_ctn">문의하기 상세</div><!-- 컨텐츠 타이틀 -->
</div>
<!-- 컨텐츠 테이블 헤더 End -->
<!-- 컨텐츠 테이블 영역 Start -->
<form name="insertForm" id="acDetailFrm" method="post"  action="/client/support/request/reqList.do" enctype="multipart/form-data">
<div class="ctn_tbl_area">
	<input type="hidden" class="input_base" id="REQ_DIV" name="REQ_DIV" value="1"/>
	 
	<div class="ctn_tbl_row">
	    <div class="ctn_tbl_th">문의번호</div>
	    <div class="ctn_tbl_td">
			${reqVo.REQ_ID}
			<input type="hidden" class="input_base" id="REQ_ID" name="REQ_ID" value="${reqVo.REQ_ID}"/>
	    </div>
	    <div class="ctn_tbl_th">작성일자</div>
	    <div class="ctn_tbl_td">
			${reqVo.REQ_DT}		
	    </div>
	</div>
	
	<div class="ctn_tbl_row">
	    <div class="ctn_tbl_th">발송자</div>
	    <div class="ctn_tbl_td">
			${reqVo.COMPANY_NAME}
	    </div>
		<div class="ctn_tbl_th">문의유형</div>
		<div class="ctn_tbl_td">
		    ${reqVo.REQ_TYPE_NM}
	    </div>
	</div>
	
	<div class="ctn_tbl_row">
		<div class="ctn_tbl_th">담당자</div>
		<div class="ctn_tbl_td">
			<select class="form-control mw_50"  style="width:120px;" id="areaCodeSel" name="ANS_USER">
			    <c:forEach var="userVo" items="${userList}">
					<option value="${userVo.USER_ID}"  
						<c:if test="${userVo.USER_ID == reqVo.ANS_USER}">selected</c:if>
					>${userVo.USER_NAME}</option>
			    </c:forEach>
			</select>
		</div>	
	</div>
	 		
	<div class="ctn_tbl_row">
		<div class="ctn_tbl_th">별첨파일</div>
		<div class="ctn_tbl_td" >
			<c:forEach var="fvo" items="${fileList}">
				<a href="/download.ajax?FILE_ID=${fvo.FILE_ID}">${fvo.FILE_NAME}</a>
		    </c:forEach>
	    </div>
	</div>
	
	<div class="ctn_tbl_row">
		<div class="ctn_tbl_th">제목</div>
		<div class="ctn_tbl_td" >
			${reqVo.REQ_TITLE}
	    </div>
	</div>
	                                        
	<div class="ctn_tbl_row">
	    <div class="ctn_tbl_th">문의내용</div>
	    <div class="ctn_tbl_td">
	        <textarea id="REQ_QUESTION" name="REQ_QUESTION" class="long-cont" style="height:200px;" readonly>${reqVo.REQ_QUESTION}</textarea>
	    </div>
	</div>
	 <c:if test="${reqVo.REQ_STATUS!=0}">
		<div id="ansHistory" style="display:none;">
			<div class="ctn_tbl_row">
			    <div class="ctn_tbl_th">기존 답변내역</div>
			    <div class="ctn_tbl_td">
			    	<span id="anslist_show" class="show_hide">펼치기 ▼</span>
			    	<span id="anslist_hide" class="show_hide" style="display:none;">접기 ▲</span>
			    </div>
			</div>
			<div id="ansList" style="display:none;"></div>
		</div>       
		                                        
		<div class="ctn_tbl_row">
		    <div class="ctn_tbl_th fm_rep">답변</div>
		    <div class="ctn_tbl_td">
		        <textarea id="REQ_ANSWER" name="REQ_ANSWER" class="long-cont" style="height:200px;" required></textarea>
		    </div>
		</div>
		
		<div class="ctn_tbl_row">
			<div class="ctn_tbl_th">파일첨부</div>
			<div class="ctn_tbl_td">
				<input type="file" name="multiFile" multiple> 
				※ 첨부파일은 3개월 후 자동 삭제 됩니다 (첨부파일은 총 5MB 이내)
			</div>
		</div>
		<div class="ctn_tbl_row">
			<div class="ctn_tbl_th fm_rep">답변유형</div>
		    <div class="ctn_tbl_td">
				<label for="ans0" class="fm_radio" ><input type="radio" class="form_control" id="ans0" name="ANS_TYPE" value="0" checked/>
					<span class="checkmark"></span><span class="langSpan">일반답변</span>
				</label>
				<label for="ans1" class="fm_radio" ><input type="radio" class="form_control" id="ans1" name="ANS_TYPE" value="1"/>
					<span class="checkmark"></span><span class="langSpan">중간답변</span>
				</label>
		    </div>		
		    
		    <div class="ctn_tbl_th fm_rep">중요도</div>
		    <div class="ctn_tbl_td">
				<select class="form-control mw_50"  style="width:120px;" id="areaCodeSel" name="REQ_IMPORTANT">
					<option value="2">상</option>
					<option value="1">중</option>
					<option value="0">하</option>
				</select>
		    </div>
	    </div>
	 </c:if>
	
	<!-- search_box End -->
	
	<!-- grid_box Start -->
	<!-- grid_box End -->
		
	<div id="footer" class="footer-wrap">
	       <div id="footer-inner" class="footer-inner">
	           <!-- btn_box Start -->
	       <div class="btn_box">
	           <div class="right">
		           <c:choose>
			           <c:when test="${reqVo.REQ_STATUS!=0}">
							<button type="submit"  class="btn btn_primary" style="" id="btnSave" data-term="L.등록" title="등록"><span class="langSpan">답변하기</span></button>
			           </c:when>
			           <c:otherwise>
							<button type="submit"  class="btn btn_primary" style="" id="btnSet" data-term="L.등록" title="등록"><span class="langSpan">담당자배정</span></button>
			           </c:otherwise>
		           </c:choose>
					<button type="button" class="btn" id="btnList" onclick="history.back();" alt="저장" value="저장"><span class="langSpan">목록으로</span></button>
	            </div>
	        </div>
	    </div>
	</div>
	<!-- btn_box End -->
</div>
</form>
			            </div>
			<!-- work End -->
        </div>
		<!-- contents End ------------------>
    </div>
    <!-- container End ------------------>
</body>
</html>