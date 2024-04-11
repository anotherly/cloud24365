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
	var updUrl="/admin/auth/userUpdate.do";
	var delUrl="/admin/auth/userDelete.ajax";
	var delbak="/admin/auth/userList.do";
	$(document).ready( function() {
		var schChkId=false;
		//console.log("회원가입 페이지");
		
		var form = document.userInsertForm;
		form.userId.focus();
		
		//로고 클릭 시 메인화면
		$("#loginHeader").on("click", function(){
		});
		
		//전화번호 선택
		$('#selectPhone').change(function(){
			$("#selectPhone option:selected").each(function () { 
				if($(this).val()== '1'){ //직접입력일 경우
					$("#userPhone1").val(''); //값 초기화 
					$("#userPhone1").attr("disabled",false); //활성화 
				}else{ //직접입력이 아닐경우
					$("#userPhone1").val($(this).text()); //선택값 입력 
					$("#userPhone1").attr("disabled",true); //비활성화 
				} 
			}); 
		});
		//이메일 선택
		$('#selectEmail').change(function(){ 
			$("#selectEmail option:selected").each(function () { 
				if($(this).val()== '1'){ //직접입력일 경우
					$("#userEmail2").val(''); //값 초기화 
					$("#userEmail2").attr("disabled",false); //활성화 
				}else{ //직접입력이 아닐경우
					$("#userEmail2").val($(this).text()); //선택값 입력 
					$("#userEmail2").attr("disabled",true); //비활성화 
				} 
			}); 
		});

		$("#userInsertForm").submit( function(event){
			//console.log("회원가입 등록 버튼 클릭");
			event.preventDefault();
			//분리된 email,전화번호 통합
			if($("#userEmail1").val().length>0){
				var email = $("#userEmail1").val()+"@"+$("#userEmail2").val();
				$("#userEmail").val(email);
			}else{
				$("#userEmail").val("");
			}
			
			//유효성 체크
			schChkId=schChkKey($("#searchBtn"),schChkId);
			
			if(boardWriteCheck(form) && telChk() && schChkId){
				
				// serialize는 form의 <input> 요소들의 name이 배열형태로 그 값이 인코딩되어 URL query string으로 하는 메서드
				let queryString = $(this).serialize();
				$.ajax({
					url: "/user/insertUser.ajax",
					type: "POST",
					dataType: "json",
					data: queryString,
					// ajax 통신 성공 시 로직 수행
					success: function(json){
						//console.log("성공 msg : "+json.msg);
						if(json.msg=="" || typeof json.msg ==="undefined"){
							alert("정상적으로 회원가입 되셨습니다");
							$("#content").empty();
							location.href="/admin/auth/userList.do";
						}else{
							alert(json.msg);
						}
					},
					error : function() {
						//console.log("에러가 발생하였습니다."+json.msg);
					},
					//finally 기능 수행
					complete : function() {
						//console.log("파이널리.");
					}
				});
			}
		});
		
		//키워드 조회시
		$("#searchBtn").on("click",function(){
			schChkId=schChkKey(this,schChkId);
		});
		
		//취소
		$("#btnCancel").on("click",function(){
			$("#content").empty();
			location.href="/admin/auth/userList.do"; 
		});
		
	});//ready

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
					<button class="nav-link active" role="tab" aria-selected="false">사용자 등록</button>
				</div>
			</div>
		</div>
		<!-- title end -->
		<!-- contents Start ------------------>
		<div id="contents" class="contents-wrap">
			<!-- work Start -->
			<div id="work" class="work-wrap">
                <!-- contents_box Start -->
                <div id="contents_box" class="contents_box">
                    <!-- 컨텐츠 테이블 헤더 Start -->
                    <div class="ctn_tbl_header">
                        <div class="ttl_ctn">등록</div><!-- 컨텐츠 타이틀 -->
                        <div class="txt_info"><em class="txt_info_rep">*</em> 표시는 필수 입력 항목입니다.</div><!-- 설명글 -->
                    </div>
                    <!-- 컨텐츠 테이블 헤더 End -->
                    <!-- 컨텐츠 테이블 영역 Start -->
                    <form name="userInsertForm" id="userInsertForm" method="post" enctype="multipart/form-data">
                    <div class="ctn_tbl_area">
                        <div class="ctn_tbl_row">
							<div class="ctn_tbl_row">
								<div class="ctn_tbl_th fm_rep">ID</div>
								<div class="ctn_tbl_td">
									<input type="text" class="form-control" id="USER_ID" name="USER_ID" value="${data.NOTICE_TITLE}"  maxlength="10" onkeyup="spaceChk(this);" onkeydown="spaceChk(this);" required/>
								</div>
							</div>
						</div>
						<div class="ctn_tbl_row">
							<div class="ctn_tbl_th fm_rep">비밀번호</div>
							<div class="ctn_tbl_td">
								<input type="password" id="userPw" name="USER_PW" class="form-control"  maxlength="10" onkeyup="spaceChk(this);" onkeydown="spaceChk(this);" required>
							</div>
						</div>
					
						<div class="ctn_tbl_row">
							<div class="ctn_tbl_th fm_rep">비밀번호 확인</div>
							<div class="ctn_tbl_td">
								<input type="password" id="userPw2" name="USER_PW2" class="form-control"  maxlength="10" onkeyup="spaceChk(this);" onkeydown="spaceChk(this);" required>
							</div>
						</div>
						
						<div class="ctn_tbl_row">
							<div class="ctn_tbl_th fm_rep">이름</div>
							<div class="ctn_tbl_td">
								<input type="text" name="USER_NAME" class="form-control"  maxlength="20" onkeyup="spaceChk(this);" onkeydown="spaceChk(this);" required>
							</div>
						</div>
						
						<div class="ctn_tbl_row">
							<div class="ctn_tbl_th fm_rep">권한 등급</div>
							<div class="ctn_tbl_td">
								<select class="table_sel"  style="width:120px;" id="areaCodeSel" name="AUTH_CODE">
									<c:forEach var="authVo" items="${authList}">
										<option value="${authVo.authCode}">${authVo.authName}</option>
									</c:forEach>
								</select>
							</div>
						</div>

						<div class="ctn_tbl_row">
							<div class="ctn_tbl_th fm_rep">직급</div>
							<div class="ctn_tbl_td">
								<input type="text" name="USER_RANK"  maxlength="10" onkeyup="spaceChk(this);" onkeydown="spaceChk(this);" class="form-control">					
							</div>
						</div>

						<div class="ctn_tbl_row">
							<div class="ctn_tbl_th fm_rep">부서</div>
							<div class="ctn_tbl_td">
								<input type="text" name="USER_DEPT"  maxlength="20" onkeyup="spaceChk(this);" onkeydown="spaceChk(this);" class="form-control">					
							</div>
						</div>
						
						<div class="ctn_tbl_row">
							<div class="ctn_tbl_th fm_rep">전화번호</div>
							<div class="ctn_tbl_td">
								<input type="hidden" id ="userPhone" name="USER_PHONE" class="form-control">
								<div class= inputPhone>
									<select style="width:50px;margin-right:10px" name="selectPhone" id="selectPhone">
										<option value="02">02</option><!-- 서울 -->
										<option value="010" selected>010</option>
										<option value="1">직접입력</option>
									</select>
									<input type="text" id="userPhone1" class="form-control" maxlength="4" onkeydown='onlyNumber(this)' onkeyup='onlyNumber(this)' disabled value="010">
									<p> - </p>
									<input type="text" id="userPhone2" maxlength="4" onkeydown='onlyNumber(this)' onkeyup='onlyNumber(this)' class="form-control">
									<p> - </p>
									<input type="text" id="userPhone3" maxlength="4" onkeydown='onlyNumber(this)' onkeyup='onlyNumber(this)' class="form-control">
								</div>		
							</div>
						</div>
                        
						<div class="ctn_tbl_row">
							<div class="ctn_tbl_th fm_rep">이메일주소</div>
							<div class="ctn_tbl_td">
								<input type="hidden" id ="userEmail" name="USER_EMAIL" class="form-control">
								<div class= inputPhone>
									<input type="text" class="form-control" id="userEmail1" style="width:70px;"  maxlength="20" onkeyup="spaceChk(this);" onkeydown="spaceChk(this);">
									<p> @ </p>
									<input type="text" class="form-control" id="userEmail2" style="width:100px;" maxlength="20" onkeyup="spaceChk(this);" onkeydown="spaceChk(this);" disabled value="gmail.com">
									<select style="width:100px;margin-right:10px" id="selectEmail">
										<option value="gmail.com" selected>gmail.com</option> 
										<option value="naver.com">naver.com</option> 
										<option value="daum.net">daum.net</option> 
										<option value="nate.com">nate.com</option> 
										<option value="1">직접입력</option> 
									</select>
								</div>		
							</div>
						</div>
                    </div>
                    </form>
                </div>
                <!-- contents_box End -->
                
                <!-- footer Start ------------------>
                <div id="footer" class="footer-wrap">
                    <div id="footer-inner" class="footer-inner">
                        
                        <!-- btn_box Start -->
                        <div class="btn_box">
                            <div class="right">
			                    <button class="btn btn_primary" style="" id="btnSave" data-term="L.등록" title="등록">
			                    	<span class="langSpan">등록</span>
			                    </button>
					            <button class="btn" id="btnCancel" data-term="L.목록" title="목록" onclick="location.href='/admin/support/notice/noticeList.do'">
									<span class="langSpan">취소</span>
								</button>
			                </div>
                        </div>
                        <!-- btn_box End -->
                    </div>
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