<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title>CLOUD 24 365 관리자 페이지</title>
<script>

	$(document).ready( function() {
		console.log("이용약관 상세 페이지");
		var tagId=${data.DOCUMENT_ID};
		$("#btnList").on("click",function(){
			console.log("이용약관 저장");
			location.href='/admin/edit/privacySvcList.do';
		});
		$("#btnDelete").on("click",function(){
			console.log("이용약관 삭제");
			ajaxMethod('/admin/edit/privacySvcDelete.ajax',{"DOCUMENT_ID":tagId},'/admin/edit/privacySvcList.do','삭제되었습니다');
		});
	});
	
</script>
</head>
<body>
	<div class="title">
		<h3>개인정보처리방침 ${data.DOCUMENT_ID}</h3>
	</div>
	<div>
		<textarea id="TEXT_VAL" class="long-cont" style="width: 75vw;height: 55vh;resize:none;" readonly>
			${data.TEXT_VAL}
		</textarea>
		
		<div id="footer" class="footer-wrap">
	        <div id="footer-inner" class="footer-inner">
	            <!-- btn_box Start -->
	            <div class="btn_box">
	                <div class="right">
	                    <button class="btn" style="" id="btnList" ><span class="langSpan">목록으로</span></button>
	                    <button class="btn" style="" id="btnDelete" ><span class="langSpan">삭제</span></button>
	                </div>
	            </div>
	        </div>
	    </div>
	</div>
</body>
</html>