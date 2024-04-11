<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script>
	$(document).ready(function(){
		//var tt = ${authMenuList};
		console.log("권한2 : ");
		
		$("#ulTypeCode2 span").on("click",function(){
			//$("#menuListDiv3").empty();
			$("#ulTypeCode3 input[type='checkbox']").parent().hide();
			$("#ulTypeCode2 span").css('font-weight','');
			$(this).css('font-weight','bold');
			var thIdx = $(this).attr("id");
			var thAc = $(this).attr("class");
			console.log("thIdx : "+thIdx);
			//$('#ulTypeCode3 input[id^="check'+thIdx+'"]').parent().show();
			$("#ulTypeCode3 input[id^='check"+thIdx+"']").parent().show();
			/* var options = {
		            url: "/option/auth/authList3.do",
		            data:{cdFlag:"3",authCode:thAc,idx:thIdx},
		            success: function(res){
		            	$('#menuListDiv3').html(res);
		            },
		            error: function(res,error){
		                alert("에러가 발생했습니다."+error);
		            }
		    };
		    $.ajax(options); */
		});
	});
</script>

<ul id="ulTypeCode2">
	<c:forEach var="list" items="${authMenuList}" step="1" varStatus="status2">
		<li id="liTypeCode_${list.idx}">
			<input type="checkbox" id="check${list.idx}" name="check${list.authCode}" value="${list.idx}" <c:if test="${list.useYn eq 'Y'}">checked</c:if>
				onchange=""/>
			<span id="${list.idx}" class="${list.authCode}"  style="cursor: pointer;">
       			${list.authUrlName1}
       		</span>
		</li>
	</c:forEach>
</ul>
