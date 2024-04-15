<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title>CLOUD 24 365</title>
	<jsp:include page="/cmn/client/top.do" flush="false" />
<script>
	var updUrl="/client/setting/user/userUpdate.do";
	var delUrl="/client/setting/user/userDelete.do";
	var delbak="/client/setting/user/userList.do";
	$(document).ready( function() {
		var schChkId=false;
		//console.log("회원가입 페이지");
		
		var form = document.userInsertForm;
		//form.userId.focus();
		
		//전화번호 선택
		$('#selectPhone').on('change',function(){
			console.log("전화번호 선택");
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
		$('#selectEmail').on('change',function(){ 
			console.log("이메일 선택");
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
		
		//회원가입 또는 사용자 등록하다 하나라도 위배되서 서브밋되서 리셋되면 빡치니 
		//서브밋을 안하거나 리턴 false로...
		$("#userInsertForm").submit( function(event){
			console.log("회원가입 등록 버튼 클릭");
			//event.preventDefault();
			//분리된 email,전화번호 통합
			if($("#userEmail1").val().length>0){
				var email = $("#userEmail1").val()+"@"+$("#userEmail2").val();
				$("#userEmail").val(email);
			}else{
				$("#userEmail").val("");
			}
			
			//유효성 체크
			if(idPwChk(form) && telChk() && schChkKey('USER_ID')){
				console.log("사용자등록 유효성 chk 성공");
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
							alert("정상 등록 되었습니다");
							location.href="/client/setting/user/userList.do";
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
		
		//키워드 조회시(id체크)
		$("#schChkKey").on("click",function(){
			schChkId=schChkKey('USER_ID',1);
		});
		
		//취소
		$("#btnCancel").on("click",function(){
			$("#content").empty();
			location.href="/client/setting/user/userList.do"; 
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
			<!--onsubmit에 return false면 action이 실행되지 않는다. (그냥 가만히 있음)
				또는 온서브밋을 함수로 리턴함 onsubmit="return chkSum();" -->
				<form name="userInsertForm" id="userInsertForm" method="post" enctype="multipart/form-data" onsubmit="return false">
                <!-- contents_box Start -->
                <div id="contents_box" class="contents_box">
                    <!-- 컨텐츠 테이블 헤더 Start -->
                    <div class="ctn_tbl_header">
                        <div class="ttl_ctn">등록</div><!-- 컨텐츠 타이틀 -->
                        <div class="txt_info"><em class="txt_info_rep">*</em> 표시는 필수 입력 항목입니다.</div><!-- 설명글 -->
                    </div>
                    <!-- 컨텐츠 테이블 헤더 End -->
                    <!-- 컨텐츠 테이블 영역 Start -->
                    
                    <div class="ctn_tbl_area">
                        <div class="ctn_tbl_row">
							<div class="ctn_tbl_row">
								<div class="ctn_tbl_th fm_rep" style="display: flex;flex-direction: column;align-items: flex-start;">ID
								<div class="txt_info">6~10자</div>
								</div>
								<div class="ctn_tbl_td mw_50">
									<input type="text" class="form-control" id="USER_ID" name="USER_ID" maxlength="10" onkeyup="valiChkAll(this,1,1);" onkeydown="valiChkAll(this,1,1);" required/>
									<div class="search_btn">
									   <button type="button" class="btn btn_sch btn_primary" id="schChkKey"><i class="ico_sch"></i><span class="langSpan">조회</span></button>
								   </div>
								</div>
							</div>
						</div>
						<div class="ctn_tbl_row">
							<div class="ctn_tbl_th fm_rep" style="display: flex;flex-direction: column;align-items: flex-start;">
								비밀번호
								<div class="txt_info">영문+특수+숫자 8~15자</div>
							</div>
							<div class="ctn_tbl_td">
								<input type="password" id="userPw1" name="USER_PW" class="form-control"  maxlength="15"  onkeyup="valiChkAll(this,1,1,1,1);" onkeydown="valiChkAll(this,1,1,1,1);" required>
							</div>
						</div>
					
						<div class="ctn_tbl_row">
							<div class="ctn_tbl_th fm_rep">비밀번호 확인</div>
							<div class="ctn_tbl_td">
								<input type="password" id="userPw2" name="USER_PW2" lass="form-control"  maxlength="15"  onkeyup="valiChkAll(this,1,1,1,1);" onkeydown="valiChkAll(this,1,1,1,1);" required>
							</div>
						</div>
						
						<div class="ctn_tbl_row">
							<div class="ctn_tbl_th fm_rep">이름</div>
							<div class="ctn_tbl_td">
								<input type="text" name="USER_NAME" class="form-control"  maxlength="20" onkeyup="valiChkAll(this,1,1);" onkeydown="valiChkAll(this,1,1);" required>
							</div>
						</div>
						
						<div class="ctn_tbl_row">
							<div class="ctn_tbl_th fm_rep">권한 등급</div>
							<div class="ctn_tbl_td">
								<select class="form-control mw_30"  style="width:120px;" id="areaCodeSel" name="AUTH_CODE">
									<c:forEach var="authVo" items="${authList}">
										<option value="${authVo.authCode}">${authVo.authName}</option>
									</c:forEach>
								</select>
							</div>
						</div>
						<div class="ctn_tbl_row">
							<div class="ctn_tbl_th fm_rep">소속 회사</div>
							<div class="ctn_tbl_td">
								<input type="text" name="USER_NAME" class="form-control"  value="${login.COMPANY_NAME}" readonly>
								<!-- <select class="form-control mw_30"  style="width:120px;" id="companyCodeSel" name="COMPANY_ID">
									<c:forEach var="companyVo" items="${companyList}">
										<option value="${companyVo.COMPANY_ID}">${companyVo.COMPANY_NAME}</option>
									</c:forEach>
								</select>	 -->				
							</div>
						</div>
						<div class="ctn_tbl_row">
							<div class="ctn_tbl_th">직급</div>
							<div class="ctn_tbl_td">
								<input type="text" name="USER_RANK"  maxlength="10" onkeyup="valiChkAll(this,1,1);" onkeydown="valiChkAll(this,1,1);" class="form-control">					
							</div>
						</div>

						<div class="ctn_tbl_row">
							<div class="ctn_tbl_th">부서</div>
							<div class="ctn_tbl_td">
								<input type="text" name="USER_DEPT"  maxlength="20" onkeyup="valiChkAll(this,1,1);" onkeydown="valiChkAll(this,1,1);" class="form-control">					
							</div>
						</div>
						
						<div class="ctn_tbl_row">
							<div class="ctn_tbl_th">전화번호</div>
							<div class="ctn_tbl_td">
								<input type="hidden" id ="userPhone" name="USER_PHONE" class="form-control">
								<div class= inputPhone>
									<select class="form-control mw_50" style="width:50px;margin-right:10px" name="selectPhone" id="selectPhone">
										<option value="02">02</option><!-- 서울 -->
										<option value="010" selected>010</option>
										<option value="1">직접입력</option>
									</select>
									<input type="text" id="userPhone1" class="form-control" maxlength="4" onkeydown='valiChkAll(this,1)' onkeyup='valiChkAll(this,1)' disabled value="010">
									<p> - </p>
									<input type="text" id="userPhone2" maxlength="4" onkeydown='valiChkAll(this,1)' onkeyup='valiChkAll(this,1)' class="form-control">
									<p> - </p>
									<input type="text" id="userPhone3" maxlength="4" onkeydown='valiChkAll(this,1)' onkeyup='valiChkAll(this,1)' class="form-control">
								</div>		
							</div>
						</div>
                        
						<div class="ctn_tbl_row">
							<div class="ctn_tbl_th">이메일주소</div>
							<div class="ctn_tbl_td">
								<input type="hidden" id ="userEmail" name="USER_EMAIL" class="form-control">
								<div class= inputPhone style="width: 500px;">
									<input type="text" class="form-control" id="userEmail1" style="width:70px;"  maxlength="20" onkeyup="valiChkAll(this,1,1);" onkeydown="valiChkAll(this,1,1);">
									<p> @ </p>
									<input type="text" class="form-control" id="userEmail2" style="width:100px;" maxlength="20" onkeyup="valiChkAll(this,1,1);" onkeydown="valiChkAll(this,1,1);" disabled value="gmail.com">
									<select class="form-control mw_50"  id="selectEmail">
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
                    
                </div>
                <!-- contents_box End -->
                
                <!-- footer Start ------------------>
                <div id="footer" class="footer-wrap">
                    <div id="footer-inner" class="footer-inner">
                        
                        <!-- btn_box Start -->
                        <div class="btn_box">
                            <div class="right">
			                    <button type="submit" class="btn btn_primary" style="" id="btnSave" data-term="L.등록" title="등록">
			                    	<span class="langSpan">등록</span>
			                    </button>
					            <button type="button" class="btn" id="btnCancel" data-term="L.목록" title="목록" onclick="location.href='/client/setting/user/userList.do'">
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