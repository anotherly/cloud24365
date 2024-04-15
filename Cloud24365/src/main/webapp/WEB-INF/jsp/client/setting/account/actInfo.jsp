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
	
	//데이터 테이블 관련
	var iidx;//날짜컬럼 인덱스
	var selectlang;
	var lang_kor;
	var lang_eng;
	
	$(document).ready( function() {
		console.log("현재 로그인 사용자 정보조회 및 변경화면");
		
		$("#chgPw").on('click',function(){
			console.log("비밀번호 변경 버튼 클릭");
			location.href='/client/setting/account/chgPw.do';
		});
		
		$("#btnSave").on('click',function(){
			console.log("정보 저장");
			var validChk = true;
			$(".input_base_require").each(function(i,list){
				console.log("필수값체크");
				if($(this).val()==null||$(this).val()==''){
					alert("필수 항목을 기재해 주세요");
					$(this).focus();
					validChk=false;
					return false;
				}
			});
			if(validChk){
				let queryString = $("#acDetailFrm").serialize();
				ajaxMethod('/client/setting/account/saveActInfo.do',queryString,'','저장되었습니다');
			}
		}); 
		
		//y면 체크 아니면 비체크인데 비체크값을 n으로 변경
		$('input[type="checkbox"]').each(function(i,list){
			console.log("하단체크박스 : "+i+"	/	"+$(this).attr("id"));
			if($(this).is(':checked')){
				$(this).val('Y');
			}else{
				$(this).val('N');
			}
		});
		
		//input 하위 모든 체크박스 클릭 시
		$('input[type="checkbox"]').on('click',function(){
			console.log("하단체크박스클릭");
			if($(this).is(':checked')){
				$(this).val('Y');
			}else{
				$(this).val('N');
			}
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
				<!-- 타이틀 텝 구성 -->
				<div class="title_segments" role="tablist">
					<button class="nav-link active" role="tab" aria-selected="false">계약 현황</button>
				</div>
			</div>
		</div>
		<!-- title end -->
		
		<!-- contents Start ------------------>
		<div id="contents" class="contents-wrap list_ani">
			<!-- work Start -->
			<div id="work" class="work-wrap">

				<form name="insertForm" id="acDetailFrm" method="post" action="return false;"  enctype="multipart/form-data">
					<div id="contents_box" class="contents_box">
						<!-- 컨텐츠 테이블 헤더 Start -->
						<div class="ctn_tbl_header">
							<div class="ttl_ctn" data-term="L.위협정보_등록" title="위협정보 등록">
								<span class="langSpan">고객 수정</span>
							</div>
							<!-- 컨텐츠 타이틀 -->
							<div class="txt_info" data-term="L.필수입력안내메세지" title="표시는 필수입력사항입니다.">
								<em class="txt_info_rep">*</em> <span class="langSpan">표시는 필수입력사항입니다.</span>
							</div>
							<!-- 설명글 -->
						</div>
						<!-- 컨텐츠 테이블 헤더 End -->
							<!-- 컨텐츠 테이블 영역 Start -->
							<div class="ctn_tbl_area">
								<!-- style="width:50%;" -->
								<div class="ctn_tbl_row" >
									<div class="ctn_tbl_th">
										<span class="langSpan">고객번호</span>
									</div>
									<div class="ctn_tbl_td">
										<input type="text" name="COMPANY_ID" class="form-control" value="${data.COMPANY_ID}" readonly>
									</div>
									<div class="ctn_tbl_th ">
										<span class="langSpan">고객사명</span>
									</div>
									<div class="ctn_tbl_td">
										<input type="text" name="COMPANY_NAME" class="form-control" value="${data.COMPANY_NAME}" required>
									</div>
								</div>
								
								<div class="ctn_tbl_row">
									<div class="ctn_tbl_th" id="table_th" style="height: auto;" >
										<span class="langSpan">MSP</span>
									</div>
									 <div class="ctn_tbl_td" style="height: auto;" >
										<table border="0" cellspacing="0" cellpadding="0" id="mspList" class="admin_list">
											<thead>
												<tr>
													<th>클라우드 종류</th>
													<th>요금제</th>
													<th>구매 수량</th>
												</tr>
											</thead>
											<tbody>
												<c:choose>
													<c:when test="${mspList.size()==0}">
														<tr>
															<td colspan='3'>구매한 요금제가 존재하지 않습니다</td>
														</tr>
													</c:when>
													<c:otherwise>
														<c:forEach var="mspVo" items="${mspList}" varStatus="status">
															<tr id="tr${status.index}">
																<td style="display:none;">
																	<input type="text" id="COMPANY_ID" name="mspList[${status.index}].COMPANY_ID" value="${mspVo.COMPANY_ID}" class="form-control" >
																</td>											
																<td>${mspVo.CLOUD_TYPE_NM}</td>
																<td>${mspVo.SERVICE_TYPE_NM}</td>
																<td>${mspVo.BUY_CNT}</td>
															</tr>
														</c:forEach>
													</c:otherwise>
												</c:choose>
												<!-- <tr id="addTr" onclick="addTr($('#mspList'),this)"><td colspan="3"><span class="langSpan">+ 요금제 추가</span></td></tr> -->	
											</tbody>
										</table>
									</div>
								</div>
									
								<div class="ctn_tbl_row" >
									<div class="ctn_tbl_th">
										<span class="langSpan">Iaas</span>
									</div>
									<div class="ctn_tbl_td">
										<label class="fm_checkbox">
											<span class="langSpan">NHN Cloud</span>
											<input type="checkbox" name="IAAS_NHN" id="IAAS_NHN" value="Y" <c:if test="${data.IAAS_NHN eq 'Y'}">checked</c:if> readonly>
											<span class="checkmark"></span>
										</label>
										<label class="fm_checkbox">
											<span class="langSpan">Naver Cloud</span>
											<input type="checkbox" name="IAAS_NAVER" id="IAAS_NAVER" value="Y" <c:if test="${data.IAAS_NAVER eq 'Y'}">checked</c:if> readonly>
											<span class="checkmark"></span>
										</label>
										<label class="fm_checkbox">
											<span class="langSpan">KT Cloud</span>
											<input type="checkbox" name="IAAS_KT" id="IAAS_KT" value="Y" <c:if test="${data.IAAS_KT eq 'Y'}">checked</c:if> readonly>
											<span class="checkmark"></span>
										</label>
										<label class="fm_checkbox">
											<span class="langSpan">AWS</span>
											<input type="checkbox" name="IAAS_AWS" id="IAAS_AWS" value="Y" <c:if test="${data.IAAS_AWS eq 'Y'}">checked</c:if> readonly>
											<span class="checkmark"></span>
										</label>
									</div>
									
									<div class="ctn_tbl_th">
										<span class="langSpan">dataDR</span>
									</div>
									<div class="ctn_tbl_td">
										<label class="fm_checkbox">
											<span class="langSpan">NHN Cloud</span>
											<input type="checkbox" name="SDR_NHN" id="SDR_NHN" value="Y" <c:if test="${data.SDR_NHN eq 'Y'}">checked</c:if> readonly>
											<span class="checkmark"></span>
										</label>
										<label class="fm_checkbox">
											<span class="langSpan">Naver Cloud</span>
											<input type="checkbox" name="SDR_NAVER" id="SDR_NAVER" value="Y" <c:if test="${data.SDR_NAVER eq 'Y'}">checked</c:if> readonly>
											<span class="checkmark"></span>
										</label>
										<label class="fm_checkbox">
											<span class="langSpan">KT Cloud</span>
											<input type="checkbox" name="SDR_KT" id="SDR_KT" value="Y" <c:if test="${data.SDR_KT eq 'Y'}">checked</c:if> readonly>
											<span class="checkmark"></span>
										</label>
									</div>
								</div>
								
								<div></div>
								
								<div class="ctn_tbl_row">
									<div class="ctn_tbl_th ">
										<span class="langSpan">계약 시작일</span>
									</div>
									<div class="ctn_tbl_td">
										<div class='input-group date' id='datetimepicker1'>
											<input type='text' style="width:100%;" class="form-control" name="CONTRACT_STDT" id="CONTRACT_STDT" value="${data.CONTRACT_STDT}"  onkeyup="valiChkAll(this,1)" readonly/>
											<span class="input-group-addon">
												<span class="glyphicon glyphicon-calendar"></span>
											</span>
										</div>
									</div>
									<div class="ctn_tbl_th ">
										<span class="langSpan">계약 종료일</span>
									</div>
									<div class="ctn_tbl_td">
										<div class='input-group date' id='datetimepicker2'>
											<input type="text" class="form-control" id="CONTRACT_EDT" name="CONTRACT_EDT" value="${data.CONTRACT_EDT}" onkeyup="valiChkAll(this,1)"  readonly/>
											<span class="input-group-addon">
												<span class="glyphicon glyphicon-calendar"></span>
											</span>
										</div>
									</div>
									<div class="ctn_tbl_th ">
										<span class="langSpan">과금 시작일</span>
									</div>
									<div class="ctn_tbl_td">
										<div class='input-group date' id='datetimepicker3'>
											<input type="text" class="form-control" id="BILL_DT" name="BILL_DT" value="${data.BILL_DT}" onkeyup="valiChkAll(this,1)" readonly />
											<span class="input-group-addon">
												<span class="glyphicon glyphicon-calendar"></span>
											</span>
										</div>
									</div>
								</div>
							
							<div class="ctn_tbl_row">
								
								<div class="ctn_tbl_th">
									<span class="langSpan">담당 영업</span>
								</div>
								<div class="ctn_tbl_td">
									<input type="text" name="RES_SALES" class="form-control" value="${data.RES_SALES}"   readonly/>
								</div>
							
								<div class="ctn_tbl_th">
									<span class="langSpan">담당 매니저</span>
								</div>
								<div class="ctn_tbl_td">
									<input type="text" name="RES_MANAGER" class="form-control" value="${data.RES_MANAGER}"   readonly/>
								</div>
								
								<div class="ctn_tbl_th">
									<span class="langSpan">계약서</span>
								</div>
								<div class="ctn_tbl_td">
									<input type="text" name="CONTRACT" class="form-control" value="${data.CONTRACT}"   readonly/>
								</div>
								
							</div>
							
							<div class="ctn_tbl_row">
								
								<div class="ctn_tbl_th ">
									<span class="langSpan">청구 기준일</span>
								</div>
								<div class="ctn_tbl_td">
									<div class='input-group date' id='datetimepicker4'>
										<input type="text" class="form-control" id="BILL_RFDT" name="BILL_RFDT" value="${data.BILL_RFDT}"   readonly/>
										<span class="input-group-addon">
											<span class="glyphicon glyphicon-calendar"></span>
										</span>
									</div>
								</div>
							
								<div class="ctn_tbl_th ">
									<span class="langSpan">세금계산서 발행일</span>
								</div>
								<div class="ctn_tbl_td">
									<div class='input-group date' id='datetimepicker5'>
										<input type="text" class="form-control" id="TAX_DT" name="TAX_DT" value="${data.TAX_DT}"   readonly/>
										<span class="input-group-addon">
											<span class="glyphicon glyphicon-calendar"></span>
										</span>
									</div>
								</div>
								
								<div class="ctn_tbl_th">
									<span class="langSpan">증빙 자료</span>
								</div>
								<div class="ctn_tbl_td">
									<input type="text" name="EVIDENCE" class="form-control" value="${data.EVIDENCE}"   readonly/>
								</div>
								
							</div>
							
							<div class="ctn_tbl_row">
								<div class="ctn_tbl_th">
									<span class="langSpan">고객사 구분</span>
								</div>
								<div class="ctn_tbl_td">
									<div>
										<input type="radio" class="fm_radio" name="COM_DIV" id="COM_DIV_1"value="0" <c:if test="${data.COM_DIV eq '0'}">checked</c:if> readonly/>
										<label for="COM_DIV_1">민간</label>
										<input type="radio" class="fm_radio" name="COM_DIV" id="COM_DIV_2" value="1" <c:if test="${data.COM_DIV eq '1'}">checked</c:if> readonly/>
										<label for="COM_DIV_2">공공</label>
									</div>
								</div>
								
								<div class="ctn_tbl_th">
									<span class="langSpan">등록자</span>
								</div>
								<div class="ctn_tbl_td">
									${data.ENROLL_NAME}
								</div>
								<div class="ctn_tbl_th" style="background:#fff;"></div>
								<div class="ctn_tbl_td"></div>
							</div>
								
								<div></div>
<!-- #######################  ###################################일반사용자 기재란  ################################### ################################### ################################### ################################### ################################### -->
								<div class="ctn_tbl_row">
									<div class="ctn_tbl_th fm_rep">
										<span class="langSpan">사업자등록번호</span>
									</div>
									<div class="ctn_tbl_td">
										<input type="text" class="form-control" id="BR_NUMBER" name="BR_NUMBER"  onkeyup="valiChkAll(this,1)" value="${data.BR_NUMBER}" required/>
									</div>
									
									<div class="ctn_tbl_th fm_rep">
										<span class="langSpan">대표자명</span>
									</div>
									<div class="ctn_tbl_td">
										<input type="text" class="form-control" id="RP_NAME" name="RP_NAME"  value="${data.RP_NAME}" required/>
									</div>
									<div class="ctn_tbl_th" style="background:#fff;"></div>
									<div class="ctn_tbl_td"></div>
								</div>
								
								<div class="ctn_tbl_row">
									<div class="ctn_tbl_th fm_rep">
										<span class="langSpan">사업자등록주소</span>
									</div>
									<div class="ctn_tbl_td">
										<input type="text" class="form-control" id="BR_ADDRESS" name="BR_ADDRESS" value="${data.BR_ADDRESS}"  required/>
									</div>
								</div>
								
								<div class="ctn_tbl_row">
									<div class="ctn_tbl_th fm_rep">
										<span class="langSpan">세금계산서(청구서)<br>담당자 연락처</span>
									</div>
									<div class="ctn_tbl_td">
										<input type="text" class="form-control" id="BILLER_PHONE" name="BILLER_PHONE" value="${data.BILLER_PHONE}"  onkeyup="valiChkAll(this,1)"   required/>
									</div>
									<div class="ctn_tbl_th fm_rep">
										<span class="langSpan">세금계산서(청구서)<br>이메일</span>
									</div>
									<div class="ctn_tbl_td">
										<input type="text" class="form-control" id="BILLER_EMAIL" name="BILLER_EMAIL" value="${data.BILLER_EMAIL}"   required/>
									</div>
									<div class="ctn_tbl_th fm_rep">
										<span class="langSpan">대표 유선번호</span>
									</div>
									<div class="ctn_tbl_td">
										<input type="text" class="form-control" id="RP_PHONE" name="RP_PHONE" value="${data.RP_PHONE}"  onkeyup="valiChkAll(this,1)"  required/>
									</div>
								</div>
								
								
								<div class="ctn_tbl_row">
									<div class="ctn_tbl_th fm_rep">
										<span class="langSpan">계정관리자 ID</span>
									</div>
									<div class="ctn_tbl_td">
										<input type="text" class="form-control" id="MANAGER_ID" name="MANAGER_ID" value="${data.MANAGER_ID}"  required/>
									</div>
									<div class="ctn_tbl_th fm_rep">
										<span class="langSpan">담당자명</span>
									</div>
									<div class="ctn_tbl_td">
										<input type="text" class="form-control" id="MANAGER_NAME" name="MANAGER_NAME" value="${data.MANAGER_NAME}"  required/>
									</div>
									<div class="ctn_tbl_th fm_rep">
										<span class="langSpan">담당자 이메일</span>
									</div>
									<div class="ctn_tbl_td">
										<input type="text" class="form-control" id="MANAGER_EMAIL" name="MANAGER_EMAIL" value="${data.MANAGER_EMAIL}"  required/>
									</div>
								</div>
								
								
								<div class="ctn_tbl_row">
									<div class="ctn_tbl_th fm_rep">
										<span class="langSpan">담당부서</span>
									</div>
									<div class="ctn_tbl_td">
										<input type="text" class="form-control" id="MANAGER_DEPT" name="MANAGER_DEPT" value="${data.MANAGER_DEPT}"  required/>
									</div>
									<div class="ctn_tbl_th">
										<span class="langSpan">담당자 직급</span>
									</div>
									<div class="ctn_tbl_td">
										<input type="text" class="form-control" id="MANAGER_RANK" name="MANAGER_RANK" value="${data.MANAGER_RANK}"  />
									</div>
									<div class="ctn_tbl_th fm_rep">
										<span class="langSpan">담당자 연락처</span>
									</div>
									<div class="ctn_tbl_td">
										<input type="text" class="form-control" id="MANAGER_PHONE" name="MANAGER_PHONE" value="${data.MANAGER_PHONE}"  onkeyup="valiChkAll(this,1)" required/>
									</div>
								</div>
								
								<div class="ctn_tbl_row">
									<div class="ctn_tbl_th">
										<span class="langSpan">서비스 사업장 주소</span>
									</div>
									<div class="ctn_tbl_td">
										<input type="text" class="form-control" id="COMPANY_ADDRESS" name="COMPANY_ADDRESS" value="${data.COMPANY_ADDRESS}"  />
									</div>
								</div>
								
							</div>
						
							<div id="footer" class="footer-wrap">
						        <div id="footer-inner" class="footer-inner">
						            <!-- btn_box Start -->
						            <div class="btn_box">
						                <div class="right">
						                    <button type="submit" class="btn btn_primary" style="" id="btnSave" data-term="L.등록" title="등록"><span class="langSpan">변경하기</span></button>
						                </div>
						            </div>
						            <!-- btn_box End -->
						        </div>
						    </div>
						</div>
					</form>
			</div>
		</div>		
	</div>
</body>
</html>