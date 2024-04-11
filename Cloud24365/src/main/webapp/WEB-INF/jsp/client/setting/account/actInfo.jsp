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
					<button class="nav-link active" role="tab" aria-selected="false">내정보조회</button>
				</div>
			</div>
		</div>
		<!-- title end -->
		
		<!-- contents Start ------------------>
		<div id="contents" class="contents-wrap list_ani">
			<!-- work Start -->
			<div id="work" class="work-wrap">

				<div id="contents_box" class="contents_box">
					<!-- 컨텐츠 테이블 헤더 Start -->
					<div class="ctn_tbl_header">
						<div class="ttl_ctn" data-term="L.위협정보_등록" title="위협정보 등록">
							<span class="langSpan">정보조회 및 수정</span>
						</div>
						<!-- 컨텐츠 타이틀 -->
						<div class="txt_info" data-term="L.필수입력안내메세지" title="표시는 필수입력사항입니다.">
							<em class="txt_info_rep">*</em> <span class="langSpan">표시는 필수입력사항입니다.</span>
						</div>
						<!-- 설명글 -->
					</div>
					<!-- 컨텐츠 테이블 헤더 End -->
					<form name="insertForm" id="acDetailFrm" method="post" enctype="multipart/form-data">
						<!-- 컨텐츠 테이블 영역 Start -->
						<div class="ctn_tbl_area">
							
							<!-- 클라우드 구매관련 부 -->
							<table border="0" cellspacing="0" cellpadding="0" class="admin_list">
								<tr>
									<td class="td-name">고객번호</td>
									<td><input type="text" class="form-control" id="COMPANY_ID" name="COMPANY_ID" value="${cmsVo.COMPANY_ID}"   readonly/></td>
									<td class="td-name" rowspan="3">서비스 구분</td>
									<td class="td-name">MSP</td>
									<td colspan="3">
										<input type="checkbox" class="input_base" id="MSP_NHN" name="MSP_NHN" value="Y" <c:if test="${cmsVo.MSP_NHN eq 'Y'}">checked</c:if> disabled />
										<label for="radio-choice-3">NHN Cloud</label>
										<input type="checkbox" class="input_base" id="MSP_NAVER" name="MSP_NAVER" value="Y" <c:if test="${cmsVo.MSP_NAVER eq 'Y'}">checked</c:if>  disabled />
										<label for="radio-choice-3">Naver Cloud</label>
										<input type="checkbox" class="input_base" id="MSP_KT" name="MSP_KT" value="Y" <c:if test="${cmsVo.MSP_KT eq 'Y'}">checked</c:if>  disabled />
										<label for="radio-choice-3">KT Cloud</label>
										<input type="checkbox" class="input_base" id="MSP_AWS" name="MSP_AWS" value="Y" <c:if test="${cmsVo.MSP_AWS eq 'Y'}">checked</c:if>  disabled />
										<label for="radio-choice-3">AWS</label>
										<input type="checkbox" class="input_base" id="MSP_RESALE" name="MSP_RESALE" value="Y" <c:if test="${cmsVo.MSP_RESALE eq 'Y'}">checked</c:if> disabled />
										<label for="radio-choice-3">Resale</label>
									</td>
								</tr>
								<tr>
									<td class="td-name">기관명</td>
									<td><input type="text" class="input_base_require" id="COMPANY_NAME" name="COMPANY_NAME" value="${cmsVo.COMPANY_NAME}"  disabled /></td>
									<td class="td-name">IaaS</td>
									<td colspan="3">
									<input type="checkbox" class="input_base" id="IAAS_NHN" name="IAAS_NHN" value="Y" <c:if test="${cmsVo.IAAS_NHN eq 'Y'}">checked</c:if>  disabled />
									<label for="radio-choice-3">NHN Cloud</label>
									<input type="checkbox" class="input_base" id="IAAS_NAVER" name="IAAS_NAVER" value="Y" <c:if test="${cmsVo.IAAS_NAVER eq 'Y'}">checked</c:if>  disabled />
									<label for="radio-choice-3">Naver Cloud</label>
									<input type="checkbox" class="input_base" id="IAAS_KT" name="IAAS_KT" value="Y" <c:if test="${cmsVo.IAAS_KT eq 'Y'}">checked</c:if>  disabled />
									<label for="radio-choice-3">KT Cloud</label>
									<input type="checkbox" class="input_base" id="IAAS_AWS" name="IAAS_AWS" value="Y" <c:if test="${cmsVo.IAAS_AWS eq 'Y'}">checked</c:if> disabled  />
									<label for="radio-choice-3">AWS</label>
									</td>
								</tr>
								<tr>
									<td class="td-name">MSP 요금제</td>
									<td style="padding-left:15px;">
										Lite : <input type="text" style="width:50px" class="input_base_number" id="MSPB_LITE" name="MSPB_LITE" value="${cmsVo.MSPB_LITE}"  readonly />
										Standard : <input type="text" style="width:50px" class="input_base_number" id="MSPB_STANDARD" name="MSPB_STANDARD" value="${cmsVo.MSPB_STANDARD}"  readonly />
										<br>Premium : <input type="text" style="width:50px" class="input_base_number" id="MSPB_PREMIUM" name="MSPB_PREMIUM" value="${cmsVo.MSPB_PREMIUM}" readonly  />
									</td>
									<td class="td-name">Service (dataDR)</td>
									<td colspan="3">
										<input type="checkbox" class="input_base" id="SDR_NHN" name="SDR_NHN" value="Y" <c:if test="${cmsVo.SDR_NHN eq 'Y'}">checked</c:if> disabled  />
										<label for="radio-choice-3">NHN Cloud</label>
										<input type="checkbox" class="input_base" id="SDR_NAVER" name="SDR_NAVER" value="Y" <c:if test="${cmsVo.SDR_NAVER eq 'Y'}">checked</c:if> disabled  />
										<label for="radio-choice-3">Naver Cloud</label>
										<input type="checkbox" class="input_base" id="SDR_KT" name="SDR_KT" value="Y" <c:if test="${cmsVo.SDR_KT eq 'Y'}">checked</c:if> disabled  />
										<label for="radio-choice-3">KT Cloud</label>
									</td>
								</tr>
								<tr>
									<td class="td-name">계약 시작일</td>
									<td>
									
										<div class='input-group date' id='datetimepicker1'>
											<input type='text' style="width:100%;" class="form-control" name="CONTRACT_STDT" id="CONTRACT_STDT" value="${cmsVo.CONTRACT_STDT}" readonly/>
											<span class="input-group-addon">
												<span class="glyphicon glyphicon-calendar"></span>
											</span>
										</div>
									
									</td>
									<td class="td-name">계약 종료일</td>
									<td>
										<div class='input-group date' id='datetimepicker2'>
											<input type="text" class="form-control" id="CONTRACT_EDT" name="CONTRACT_EDT" value="${cmsVo.CONTRACT_EDT}"   readonly/>
											<span class="input-group-addon">
												<span class="glyphicon glyphicon-calendar"></span>
											</span>
										</div>
									</td>
									<td class="td-name">과금 시작일</td>
									<td>
										<div class='input-group date' id='datetimepicker3'>
											<input type="text" class="form-control" id="BILL_DT" name="BILL_DT" value="${cmsVo.BILL_DT}"  readonly />
											<span class="input-group-addon">
												<span class="glyphicon glyphicon-calendar"></span>
											</span>
										</div>
									</td>
								</tr>
							</table>
							
							<div class="ctn_tbl_row">
								
								<div class="ctn_tbl_th">
									<span class="langSpan">담당 영업</span>
								</div>
								<div class="ctn_tbl_td">
									<input type="text" name="RES_SALES" class="form-control" value="${cmsVo.RES_SALES}"   readonly>
								</div>
							
								<div class="ctn_tbl_th">
									<span class="langSpan">담당 매니저</span>
								</div>
								<div class="ctn_tbl_td">
									<input type="text" name="RES_MANAGER" class="form-control" value="${cmsVo.RES_MANAGER}"   readonly>
								</div>
								
								<div class="ctn_tbl_th">
									<span class="langSpan">계약서</span>
								</div>
								<div class="ctn_tbl_td">
									<input type="text" name="CONTRACT" class="form-control" value="${cmsVo.CONTRACT}"   readonly>
								</div>
								
							</div>
							
							<div class="ctn_tbl_row">
								
								<div class="ctn_tbl_th">
									<span class="langSpan">청구 기준일</span>
								</div>
								<div class="ctn_tbl_td">
									<div class='input-group date' id='datetimepicker4'>
										<input type="text" class="form-control" id="BILL_RFDT" name="BILL_RFDT" value="${cmsVo.BILL_RFDT}"  readonly />
										<span class="input-group-addon">
											<span class="glyphicon glyphicon-calendar"></span>
										</span>
									</div>
								</div>
							
								<div class="ctn_tbl_th">
									<span class="langSpan">세금계산서 발행일</span>
								</div>
								<div class="ctn_tbl_td">
									<div class='input-group date' id='datetimepicker5'>
										<input type="text" class="form-control" id="TAX_DT" name="TAX_DT" value="${cmsVo.TAX_DT}"  readonly />
										<span class="input-group-addon">
											<span class="glyphicon glyphicon-calendar"></span>
										</span>
									</div>
								</div>
								
								<div class="ctn_tbl_th">
									<span class="langSpan">증빙 자료</span>
								</div>
								<div class="ctn_tbl_td">
									<input type="text" name="EVIDENCE" class="form-control" value="${cmsVo.EVIDENCE}" readonly >
								</div>
								
							</div>
							
							<div class="ctn_tbl_row">
								<div class="ctn_tbl_th">
									<span class="langSpan">고객사 구분</span>
								</div>
								<div class="ctn_tbl_td">
									<div>
										<input type="radio" class="fm_radio" name="COM_DIV" id="COM_DIV_1"  value="0" <c:if test="${cmsVo.COM_DIV eq '0'}">checked</c:if> disabled />
										<label for="COM_DIV_1">민간</label>
										<input type="radio" class="fm_radio" name="COM_DIV" id="COM_DIV_2" value="1" <c:if test="${cmsVo.COM_DIV eq '1'}">checked</c:if>  disabled />
										<label for="COM_DIV_2">공공</label>
									</div>
								</div>
								
								<div class="ctn_tbl_th">
									<span class="langSpan">등록자</span>
								</div>
								<div class="ctn_tbl_td">
									<input type="hidden" class="form-control" id="ENROLL_ID" name="ENROLL_ID" value="${cmsVo.ENROLL_ID}" readonly/>
									<input type="text" class="form-control" id="ENROLL_NAME" name="ENROLL_NAME" value="${cmsVo.ENROLL_NAME}" readonly/>
								</div>
								<div class="ctn_tbl_th" style="background:#fff;"></div>
								<div class="ctn_tbl_td"></div>
							</div>
							
							<div class="ctn_tbl_row">
								<div class="ctn_tbl_th fm_rep">
									<span class="langSpan">사업자등록번호</span>
								</div>
								<div class="ctn_tbl_td fm_rep">
									<input type="text" class="form-control" id="BR_NUMBER" name="BR_NUMBER" value="${cmsVo.BR_NUMBER}" required/>
								</div>
								
								<div class="ctn_tbl_th fm_rep">
									<span class="langSpan">대표자명</span>
								</div>
								<div class="ctn_tbl_td">
									<input type="text" class="form-control" id="RP_NAME" name="RP_NAME" value="${cmsVo.RP_NAME}" required/>
								</div>
								<div class="ctn_tbl_th" style="background:#fff;"></div>
								<div class="ctn_tbl_td"></div>
							</div>
							
							<div class="ctn_tbl_row">
								<div class="ctn_tbl_th fm_rep">
									<span class="langSpan">사업자등록주소</span>
								</div>
								<div class="ctn_tbl_td">
									<input type="text" class="form-control" id="BR_ADDRESS" name="BR_ADDRESS" value="${cmsVo.BR_ADDRESS}"  required/>
								</div>
							</div>
							
							<div class="ctn_tbl_row">
								<div class="ctn_tbl_th fm_rep">
									<span class="langSpan">세금계산서(청구서)<br>담당자 연락처</span>
								</div>
								<div class="ctn_tbl_td">
									<input type="text" class="form-control" id="BILLER_PHONE" name="BILLER_PHONE" value="${cmsVo.BILLER_PHONE}"   required/>
								</div>
								<div class="ctn_tbl_th">
									<span class="langSpan">세금계산서(청구서)<br>이메일</span>
								</div>
								<div class="ctn_tbl_td">
									<input type="text" class="form-control" id="BILLER_EMAIL" name="BILLER_EMAIL" value="${cmsVo.BILLER_EMAIL}"   />
								</div>
								<div class="ctn_tbl_th fm_rep">
									<span class="langSpan">대표 유선번호</span>
								</div>
								<div class="ctn_tbl_td">
									<input type="text" class="form-control" id="RP_PHONE" name="RP_PHONE" value="${cmsVo.RP_PHONE}"   required/>
								</div>
							</div>
							
							
							<div class="ctn_tbl_row">
								<div class="ctn_tbl_th fm_rep">
									<span class="langSpan">계정관리자 ID</span>
								</div>
								<div class="ctn_tbl_td">
									<input type="text" class="form-control" id="MANAGER_ID" name="MANAGER_ID" value="${cmsVo.MANAGER_ID}"  required/>
								</div>
								<div class="ctn_tbl_th fm_rep">
									<span class="langSpan">담당자명</span>
								</div>
								<div class="ctn_tbl_td">
									<input type="text" class="form-control" id="MANAGER_NAME" name="MANAGER_NAME" value="${cmsVo.MANAGER_NAME}"  required/>
								</div>
								<div class="ctn_tbl_th">
									<span class="langSpan">담당자 이메일</span>
								</div>
								<div class="ctn_tbl_td">
									<input type="text" class="form-control" id="MANAGER_EMAIL" name="MANAGER_EMAIL" value="${cmsVo.MANAGER_EMAIL}"  />
								</div>
							</div>
							
							
							<div class="ctn_tbl_row">
								<div class="ctn_tbl_th fm_rep">
									<span class="langSpan">담당부서</span>
								</div>
								<div class="ctn_tbl_td">
									<input type="text" class="form-control" id="MANAGER_DEPT" name="MANAGER_DEPT" value="${cmsVo.MANAGER_DEPT}"  required/>
								</div>
								<div class="ctn_tbl_th">
									<span class="langSpan">담당자 직급</span>
								</div>
								<div class="ctn_tbl_td">
									<input type="text" class="form-control" id="MANAGER_RANK" name="MANAGER_RANK" value="${cmsVo.MANAGER_RANK}"  />
								</div>
								<div class="ctn_tbl_th fm_rep">
									<span class="langSpan">담당자 연락처</span>
								</div>
								<div class="ctn_tbl_td">
									<input type="text" class="form-control" id="MANAGER_PHONE" name="MANAGER_PHONE" value="${cmsVo.MANAGER_PHONE}"  required/>
								</div>
							</div>
							
							<div class="ctn_tbl_row">
								<div class="ctn_tbl_th">
									<span class="langSpan">서비스 사업장 주소</span>
								</div>
								<div class="ctn_tbl_td">
									<input type="text" class="form-control" id="COMPANY_ADDRESS" name="COMPANY_ADDRESS" value="${cmsVo.COMPANY_ADDRESS}"  />
									</div>
								</div>
								
							</div>
						</form>
					<!-- <div class="btnDiv" style="float:right;">
				   		<input type="button" id="btnSave" alt="저장" value="저장" />
					</div> -->
					
					<div id="footer" class="footer-wrap">
				        <div id="footer-inner" class="footer-inner">
				            <!-- btn_box Start -->
				            <div class="btn_box">
				                <div class="right">
				                    <button class="btn btn_primary" style="" id="btnSave" data-term="L.등록" title="등록"><span class="langSpan">저장</span></button>
				                </div>
				            </div>
				            <!-- btn_box End -->
				        </div>
				    </div>
				</div>
			</div>
		</div>		
	</div>
</body>
</html>