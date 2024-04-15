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
	<button id="account_menu" class="nav-link" role="tab" aria-selected="false" onclick="location.href='/client/support/account/actInfo.do'">내정보조회</button>
	<button id="user_menu" class="nav-link" role="tab" aria-selected="false" onclick="location.href='/client/support/user/userList.do'">멤버관리</button>
</div>
