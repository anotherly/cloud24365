<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title>CLOUD 24 365 관리자 페이지</title>
	<link rel="stylesheet" href="<%=request.getContextPath()%>/css/option.css">
	<script src="<%=request.getContextPath()%>/js/option/option.js"></script>
	<script src="<%=request.getContextPath()%>/js/option/reportType.js"></script>
	<script src="<%=request.getContextPath()%>/js/option/colorCode.js"></script>
<jsp:include page="/cmn/admin/top.do" flush="false" />
<script>
var menuList = new Array();
var authSlt;
var chgFlg;
$(document).ready(function(){
	console.log("권한 관리");
	loadAuthMenu($('#AUTH_DIV option:selected').val());
	$('#AUTH_DIV').on("change",function(){
		authSlt = $('#AUTH_DIV').val();
	});	
	$(".board_list input[type='checkbox']").on("change",function(){
		chgFlg=1;
	});	
	
})

/**
 * 메뉴 정보
 */
function loadAuthMenu(param){
	$("#menuListDiv2").empty();
	$("#menuListDiv3").empty();
	var options2 = {
        url: "/admin/auth/authList2.do",
        data:{cdFlag:"2",authCode:param},
        success: function(res){
        	$('#menuListDiv2').html(res);
        },
        error: function(res,error){
            alert("에러가 발생했습니다."+error);
        }
    };
	
	 $.ajax(options2); 
	
	var options3 = {
        url: "/admin/auth/authList3.do",
        data:{cdFlag:"3",authCode:param},
        success: function(res){
        	$('#menuListDiv3').html(res);
        },
        error: function(res,error){
            alert("에러가 발생했습니다."+error);
        }
    };
   
    $.ajax(options3); 
    
}

/**
 * 중분류와 소분류의 체크박스 연계
 */
function saveChkArr(that,flg){
	console.log(" id / val : "+$(that).attr("id")+" / "+$(that).val());
	var num = $(that).val().substring(0,1);
	if(flg==2){
		console.log("중분류");
		//소분류 하위 레이어에 항목이 존재시
		if($("#db_layer5 input[type='checkbox']").length != 0 ){
			if($(that).is(":checked")){
				$("#ulTypeCode3 input[id^='check"+num+"']").prop("checked",true);
			}else{
				$("#ulTypeCode3 input[id^='check"+num+"']").prop("checked",false);
			}
		}
	}else{
		console.log("소분류");
		//전체 선택해야만 중분류가 체크되도록 변경
		//사용자관리 등이나 코드관리에서 맨 앞에거 안나오게 하려고
		if($("#ulTypeCode3 input[id^='check"+num+"']:checked").length
		==$("#ulTypeCode3 input[id^='check"+num+"']").length
					){
			$("#ulTypeCode2").find("#check"+num).prop("checked",true);
		}else{
			$("#ulTypeCode2").find("#check"+num).prop("checked",false);
		}
	}
}
 
 
/**
 * 권한 저장
 */
function saveAuth(){
	console.log("권한 저장");
	var menuList = new Array();
	$("#ulTypeCode2 input[type=checkbox]").each(function(){
		var chkArr=$(this).val();
		if($(this).is(":checked")){
			chkArr+="-Y";
		}else{
			chkArr+="-N";
		}
		menuList.push(chkArr);
	});
	$("#ulTypeCode3 input[type=checkbox]").each(function(){
		var chkArr=$(this).val();
		if($(this).is(":checked")){
			chkArr+="-Y";
		}else{
			chkArr+="-N";
		}
		menuList.push(chkArr);
	});
	
	var options = {
            url: '/admin/auth/updateAuth.do',
            data: {authCode:$('#AUTH_DIV').val(),menuList:menuList},
            async : false,
            success: function(json){
            	alert(json.msg);
            },
            error: function(json){
            	alert(json.msg);
            }
    };
    //화면이동 방지
	event.preventDefault();
    $.ajax(options);
}
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
					<button class="nav-link active" role="tab" aria-selected="false">권한 관리</button>
				</div>
			</div>
		</div>
		<!-- title end -->
		
		<!-- contents Start ------------------>
		<div id="contents" class="contents-wrap list_ani">
			<!-- work Start -->
			<div id="work" class="work-wrap list_page">
				
				<form id="authFrm" name="authFrm" method="post">
			           <!-- <div id="posi"><img src="../images/ico_home.gif" alt="home" />정보관리 > 등급관리</div> -->
			           <!-- contents -->
			           <div id="contents" style="/* z-index: 1000; */display: flex;flex-direction: column;align-items: center;/* justify-content: space-around; */height: calc(95vh - 200px);padding-top: 50px;">
			               <!-- board_list -->
			               <div class="board_list" style="width: 1200px;display: flex;align-items: stretch;justify-content: center;flex-direction: row;">
			                   <!-- 대분류선택 시작 -->
			                   <div id="db_layer11">
				                   <div class="tit11 txt_right mgr_lb">
				                   <span>대분류</span>
				                   </div>
				                   <div class="tit11_1 scroll">
				                       <ul>
				                           <li>
				                           	<select class="table_sel2" id="AUTH_DIV" name="AUTH_DIV" onchange="loadAuthMenu(this.value);">
										        <c:forEach var="authInfo" items="${authList}">
										            <option value="${authInfo.authCode}"><c:out value="${authInfo.authName}"/></option>
										        </c:forEach>
										    </select>
				                           </li>
				                       </ul>
				                   </div>
				                </div>
			                    <!-- 중분류선택 시작 -->
								<div id="db_layer4">
									<div class="tit4 txt_right mgr_lb">
									<span>중분류</span>
									</div>
								    <!-- 중분류 리스트 -->
								    <div class="tit4_1 scroll" id="menuListDiv2"></div>
								</div>
								<!-- 소분류선택 시작 -->
								<div id="db_layer5">
								    <div class="tit5 txt_right mgr_lb">
								    	<span>소분류</span>
								    </div>
									<div class="tit5_1 scroll" id="menuListDiv3"></div>
								</div>
			                   <!-- 유형별관리 선택구분 끝-->
			               </div>
			           </div>
			           <!-- //contents -->
			           
			           <!-- //contentWrap -->
						
				</form>
			</div>
		</div>
		
		<div id="footer" class="footer-wrap">
	        <div id="footer-inner" class="footer-inner">
	            <!-- btn_box Start -->
	            <div class="btn_box">
	                <div class="right">
	                    <button class="btn btn_primary" style="" id="btnInsert" data-term="L.등록" title="등록" onclick="saveAuth(event);"><span class="langSpan">저장</span></button>
	                </div>
	            </div>
	        </div>
	    </div>
				
</div>

</body>
</html>