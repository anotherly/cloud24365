<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<script>

$(document).ready(function() {
	var nowUrl=location.href;
	nowUrl= nowUrl.split("/")[nowUrl.split("/").length-2].split(".do")[0];
	$(".title_segments button").each(function(i,list){
		if($(list).attr('id').replace("_menu","")==nowUrl){
			$(this).toggleClass("active");
		}
	});
});

</script>
<!-- 타이틀 텝 구성 -->
<div class="title_segments" role="tablist">
	<button id="notice_menu" class="nav-link" role="tab" aria-selected="false" onclick="location.href='/client/support/notice/noticeList.do'">공지사항</button>
	<button id="request_menu" class="nav-link" role="tab" aria-selected="false" onclick="location.href='/client/support/request/reqList.do'">문의관리</button>
	<button id="faq_menu" class="nav-link" role="tab" aria-selected="false" onclick="location.href='/client/support/faq/faqList.do'">FAQ관리</button>
	<button id="report_menu" class="nav-link" role="tab" aria-selected="false" onclick="location.href='/client/support/report/reportList.do'">보고서관리</button>
</div>
