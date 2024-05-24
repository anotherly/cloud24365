<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<script>
	$(document).ready(function() {
		console.log("메뉴 화면");
		var hideId ='${login.USER_ID}'
		$(".menu-inner > .menu-item a").on('click',function(){
			console.log("소메뉴 확장을 위한 메뉴 클릭");
			//메뉴확장이 된 경우
			if($("body").attr("class")!="open"){
				//서브메뉴가 활성화 된 경우 -> 비활성화
				if($(this).parent().attr("class").indexOf("open")!=-1){
					$(this).parent().removeClass("open");
				//서브메뉴 비활성일경우 -> 서브메뉴 표출 및 기존 활성화 제거
				}else{
					$(this).parent().parent().children().each(function(i,list){
						$(list).parent().removeClass("open");
					});
					$(this).parent().addClass("open");
				}
				
				//주소 이동
				if($(this).parent().find("ul").length==0){
					location.href=$(this).attr("id");
				}
				
			}else{
				location.href=$(this).attr("id");
			}
		});
		//240524 추가
		//기타 요청에 의해 사용자별로 메뉴 일부 hidden 처리해야할경우 사용
		$(".menu-inner > li").each(function(){
		    if($(this).attr("id")=="hideMenu"){
		    	$(this).hide();
		    }
		});
		
	});
</script>
<ul class="menu-inner">
	<li class="menu-item">
		<a id="/" class="menu-link menu-toggle"><i class="menu-icon n09"></i><div>서비스소개</div></a>
		<ul class="menu-sub">
			<li class="menu-item"><a id="/client/svcInfo/main.do" class="menu-link"><div>하이브시스템 MSP 서비스소개</div></a></li>
			<li class="menu-item"><a id="/client/svcInfo/company.do" class="menu-link"><div>주요 고객사</div></a></li>
		</ul>
	</li>
	<li class="menu-item" id="hideMenu">
		<a id="/client/charge/chargeList.do" class="menu-link"><i class="menu-icon n05"></i><div>과금 현황</div></a>
	</li>
	<li class="menu-item">
		<a id="/client/support/notice/noticeList.do" class="menu-link menu-toggle"><i class="menu-icon n02"></i><div>고객지원</div></a>
		<ul class="menu-sub">
			<li class="menu-item"><a id="/client/support/notice/noticeList.do" class="menu-link"><div>공지사항</div></a></li>
			<li class="menu-item"><a id="/client/support/request/reqList.do" class="menu-link"><div>내 문의</div></a></li>
			<li class="menu-item"><a id="/client/support/faq/faqList.do" class="menu-link"><div>FAQ</div></a></li>
			<li class="menu-item"><a id="/client/support/report/reportList.do" class="menu-link"><div>보고서</div></a></li>
		</ul>
	</li>
	<li class="menu-item"  id="hideMenu">
		<a id="/client/setting/account/actInfo.do" class="menu-link menu-toggle"><i class="menu-icon n07"></i><div>설정</div></a>
		<ul class="menu-sub">
			<li class="menu-item"><a id="/client/setting/account/actInfo.do" class="menu-link"><div>내정보조회</div></a></li>
			<li class="menu-item"><a id="/client/setting/user/userList.do" class="menu-link"><div>멤버관리</div></a></li>
		</ul>
	</li>
</ul>
