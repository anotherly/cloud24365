<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="ko" lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>CLOUD 24 365</title>
<jsp:include page="/cmn/client/top.do" flush="false" />
<script>
	$(document).ready(function() {
		console.log("공지사항 수정 화면");
		$("#acDetailFrm").submit(function(e) {
			console.log("문의하기 등록");
			let frm = $("#acDetailFrm").serialize();
			//let param = encodeURI(frm);
			var options = {
				url : '/client/support/notice/noticeUpdate.ajax',
				type : "post",
				dataType : "json",
				//contentType: "application/x-www-form-urlencoded; charset=euc-kr",
				data : frm,
				success : function(res) {
					if (res.cnt > 0) {
						alert("저장되었습니다.");
						location.href = "/client/support/notice/noticeList.do"
					} else {
						if (res.badFileType != null) {
							alert("사진파일 첨부는 이미지 파일만 가능합니다.");
						} else if (typeof res.createFileError !== "undefined"
								&& res.createFileError) {
							alert("사진파일 저장에 실패했습니다.");
						} else if (typeof res.msg !== "undefined"
								&& res.msg != null) {
							alert(res.msg);
						} else {
							alert("저장에 실패했습니다.");
						}
					}
				},
				error : function(res, error) {
					alert("에러가 발생했습니다." + error);
				}
			};
			$('#acDetailFrm').ajaxSubmit(options);
		});

		//취소
		$("#btnCancel").on("click",function() {
			location.href = "/client/support/notice/noticeList.do";
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

<!-- contents_box Start -->
<form name="insertForm" id="acDetailFrm" method="post" enctype="multipart/form-data" action="/client/support/notice/noticeList.do">
<div id="contents_box" class="contents_box">
	<!-- 컨텐츠 테이블 헤더 Start -->
	<div class="ctn_tbl_header">
		<div class="ttl_ctn">공지사항 수정</div>
		<!-- 컨텐츠 타이틀 -->
		<div class="txt_info">
			<em class="txt_info_rep">*</em> 표시는 필수 입력 항목입니다.
		</div>
		<!-- 설명글 -->
	</div>
	<!-- 컨텐츠 테이블 헤더 End -->
	<!-- 컨텐츠 테이블 영역 Start -->
		<div class="ctn_tbl_area">
			<input type="hidden" class="form-control" id="NOTICE_ID"
				name="NOTICE_ID" value="${data.NOTICE_ID}" />
			<div class="ctn_tbl_row">
				<div class="ctn_tbl_th fm_rep">분류</div>
				<div class="ctn_tbl_td">
					<select id="NOTICE_TYPE" name="NOTICE_TYPE"
						class="form-control mw_40">
						<option value="0" <c:if test="${data.NOTICE_TYPE == 0}">selected</c:if>>작업공지</option>
						<option value="1" <c:if test="${data.NOTICE_TYPE == 1}">selected</c:if>>기타공지</option>
						<option value="2" <c:if test="${data.NOTICE_TYPE == 2}">selected</c:if>>장애공지</option>
					</select>
				</div>
				<div class="ctn_tbl_th">추가 발송</div>
				<div class="ctn_tbl_td">
					<label class="fm_checkbox"> <span class="langSpan">이메일</span>
						<input type="checkbox" name="FLAG_EMAIL" id="chk_status0" value="Y" <c:if test="${data.FLAG_EMAIL eq 'Y'}">checked</c:if>>
						<span class="checkmark"></span>
					</label> <label class="fm_checkbox"> <span class="langSpan">SMS</span>
						<input type="checkbox" name="FLAG_SMS" id="chk_status1" value="Y" <c:if test="${data.FLAG_SMS eq 'Y'}">checked</c:if>>
						<span class="checkmark"></span>
					</label>
				</div>
			</div>
			<div class="ctn_tbl_row">
				<div class="ctn_tbl_th fm_rep">제목</div>
				<div class="ctn_tbl_td">
					<input type="text" class="form-control" id="NOTICE_TITLE" name="NOTICE_TITLE" value="${data.NOTICE_TITLE}" required/>
				</div>
			</div>

			<div class="ctn_tbl_row">
				<div class="ctn_tbl_th">파일첨부</div>
				<div class="ctn_tbl_td">
					<input type="file" name="multiFile" multiple> ※ 변경시 기존 파일과 교체
					<c:forEach var="fvo" items="${fileList}">
						<a href="/download.ajax?FILE_ID=${fvo.FILE_ID}">${fvo.FILE_NAME}</a>
					</c:forEach>
				</div>
			</div>

			<div class="ctn_tbl_row">
				<div class="ctn_tbl_th">내용</div>
				<div class="ctn_tbl_td">
					<textarea id="CONTENT" name="CONTENT" class="long-cont"style="height: 470px;resize:none;" required>${data.CONTENT}</textarea>
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
					<button type="submit"  class="btn btn_primary" style="" id="btnSave" data-term="L.등록" title="등록">
						<span class="langSpan">저장</span>
					</button>
					<button type="button"  class="btn" id="btnList" data-term="L.목록" title="목록" onclick="location.href='/client/support/notice/noticeList.do'">
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

