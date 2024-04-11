<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title>CLOUD 24 365 관리자 페이지</title>
	<!-- JS -->
	<script src="<%=request.getContextPath()%>/js/jquery.js"></script>
	<script src="<%=request.getContextPath()%>/js/jquery.migrate.js"></script>
 	 
 	 <!-- DateTimePicker -->
	<script src="<%=request.getContextPath()%>/calender/moment.js"></script>
	<script src="<%=request.getContextPath()%>/calender/mo_ko.js"></script>
	<script src="<%=request.getContextPath()%>/calender/bootstrap-datetimepicker.js"></script>
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/calender/no-boot-calendar-custom.css" />
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/calender/datetimepickerstyle.css" />
 	 
 	 
	<script>
		$(document).ready(function() {
			console.log("고객 수정 화면");
			
			//최대일과 현재일이 같을 경우 발생할수 있는 문제에 대해 최대일에 +1초 
			//먼저 변수 선언
			var maxD = moment().add(1, 'seconds').format("YYYY-MM-DD");
			var defaultD  = moment().format("YYYY-MM-DD");
			$('#datetimepicker1,#datetimepicker2,#datetimepicker3,#datetimepicker4,#datetimepicker5').datetimepicker({
				 format:"YYYY-MM-DD",
				 //maxDate : maxD, 
				 defaultDate: defaultD
			 });
			
			$('.glyphicon-calendar').hover(function(){
				console.log('달력 체크2');
			});
			
			$("#acDetailFrm").submit(function(e){
				event.preventDefault();
				console.log("정보 저장");
				//저장 전 인덱스 맞춤
				mspListVo($('#mspList'));
				let queryString = $("#acDetailFrm").serialize();
				ajaxMethod('/admin/client/companyUpdate.ajax',queryString,"/admin/client/companyList.do",'저장되었습니다');
			}); 
			
			//취소
			$("#btnCancel").on("click",function(){
				location.href="/admin/client/companyList.do";
			});
			
		});

	</script>
	
</head>

<form name="insertForm" id="acDetailFrm" method="post" action="/admin/client/companyList.do"  enctype="multipart/form-data">
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
				<div class="ctn_tbl_row" >
					<div class="ctn_tbl_th">
						<span class="langSpan">고객번호</span>
					</div>
					<div class="ctn_tbl_td">
						<input type="text" name="COMPANY_ID" class="form-control" value="${data.COMPANY_ID}" readonly>
					</div>
					<div class="ctn_tbl_th fm_rep">
						<span class="langSpan">고객사명</span>
					</div>
					<div class="ctn_tbl_td">
						<input type="text" name="COMPANY_NAME" class="form-control" value="${data.COMPANY_NAME}" required>
					</div>
				</div>
				
				<div class="ctn_tbl_row" >
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
										<tr id="tr1">
											<td style="display:none;">
												<input type="text" id="COMPANY_ID" name="mspList[0].COMPANY_ID" value="${data.COMPANY_ID}" class="form-control" >
											</td>											
											<td>
												<select id="CLOUD_TYPE" name="mspList[0].CLOUD_TYPE" class="form-control mw_40">
													<option value="">선택하지 않음</option>
							                        <option value="0">NAVER</option>
							                        <option value="1">NHN</option>
							                        <option value="2">KT</option>
							                        <option value="3">AWS</option>
							                        <option value="4">RESALE</option>
												</select>
											</td>
											<td>
				                            	<select id="SERVICE_TYPE" name="mspList[0].SERVICE_TYPE" class="form-control mw_40">
													<option value="0">LITE</option>
							                        <option value="1">STANDARD</option>
							                        <option value="2">PREMIUM</option>
												</select>
											</td>
											<td style="display: flex;">
												<input type="text" id="BUY_CNT" name="mspList[0].BUY_CNT" class="form-control" onkeyup="valiChkAll(this,1)">
											</td>
										</tr>
									</c:when>
									<c:otherwise>
										<c:forEach var="mspVo" items="${mspList}" varStatus="status">
											<tr id="tr${status.index}">
												<td style="display:none;">
													<input type="text" id="COMPANY_ID" name="mspList[${status.index}].COMPANY_ID" value="${mspVo.COMPANY_ID}" class="form-control" >
												</td>											
												<td>
													<select id="CLOUD_TYPE" name="mspList[${status.index}].CLOUD_TYPE" class="form-control mw_40">
														<option value="">선택하지 않음</option>
								                        <option value="0" <c:if test="${mspVo.CLOUD_TYPE == 0}">selected</c:if> >NAVER</option>
								                        <option value="1" <c:if test="${mspVo.CLOUD_TYPE == 1}">selected</c:if> >NHN</option>
								                        <option value="2" <c:if test="${mspVo.CLOUD_TYPE == 2}">selected</c:if> >KT</option>
								                        <option value="3" <c:if test="${mspVo.CLOUD_TYPE == 3}">selected</c:if> >AWS</option>
								                        <option value="4" <c:if test="${mspVo.CLOUD_TYPE == 4}">selected</c:if> >RESALE</option>
													</select>
												</td>
												<td>
					                            	<select id="SERVICE_TYPE" name="mspList[${status.index}].SERVICE_TYPE" class="form-control mw_40">
														<option value="0" <c:if test="${mspVo.SERVICE_TYPE == 0}">selected</c:if> >LITE</option>
								                        <option value="1" <c:if test="${mspVo.SERVICE_TYPE == 1}">selected</c:if> >STANDARD</option>
								                        <option value="2" <c:if test="${mspVo.SERVICE_TYPE == 2}">selected</c:if> >PREMIUM</option>
													</select>
												</td>
												<td style="display: flex;">
													<input type="text" id="BUY_CNT" name="mspList[${status.index}].BUY_CNT" class="form-control" value="${mspVo.BUY_CNT}" onkeyup="valiChkAll(this,1)">
												</td>
											</tr>
										</c:forEach>
									</c:otherwise>
								</c:choose>
								<tr id="addTr" onclick="addTr($('#mspList'),this)"><td colspan="3"><span class="langSpan">+ 요금제 추가</span></td></tr>	
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
							<input type="checkbox" name="IAAS_NHN" id="IAAS_NHN" value="Y" <c:if test="${data.IAAS_NHN eq 'Y'}">checked</c:if>   >
							<span class="checkmark"></span>
						</label>
						<label class="fm_checkbox">
							<span class="langSpan">Naver Cloud</span>
							<input type="checkbox" name="IAAS_NAVER" id="IAAS_NAVER" value="Y" <c:if test="${data.IAAS_NAVER eq 'Y'}">checked</c:if>   >
							<span class="checkmark"></span>
						</label>
						<label class="fm_checkbox">
							<span class="langSpan">KT Cloud</span>
							<input type="checkbox" name="IAAS_KT" id="IAAS_KT" value="Y" <c:if test="${data.IAAS_KT eq 'Y'}">checked</c:if>   >
							<span class="checkmark"></span>
						</label>
						<label class="fm_checkbox">
							<span class="langSpan">AWS</span>
							<input type="checkbox" name="IAAS_AWS" id="IAAS_AWS" value="Y" <c:if test="${data.IAAS_AWS eq 'Y'}">checked</c:if>   >
							<span class="checkmark"></span>
						</label>
					</div>
					
					<div class="ctn_tbl_th">
						<span class="langSpan">dataDR</span>
					</div>
					<div class="ctn_tbl_td">
						<label class="fm_checkbox">
							<span class="langSpan">NHN Cloud</span>
							<input type="checkbox" name="SDR_NHN" id="SDR_NHN" value="Y" <c:if test="${data.SDR_NHN eq 'Y'}">checked</c:if>   >
							<span class="checkmark"></span>
						</label>
						<label class="fm_checkbox">
							<span class="langSpan">Naver Cloud</span>
							<input type="checkbox" name="SDR_NAVER" id="SDR_NAVER" value="Y" <c:if test="${data.SDR_NAVER eq 'Y'}">checked</c:if>   >
							<span class="checkmark"></span>
						</label>
						<label class="fm_checkbox">
							<span class="langSpan">KT Cloud</span>
							<input type="checkbox" name="SDR_KT" id="SDR_KT" value="Y" <c:if test="${data.SDR_KT eq 'Y'}">checked</c:if>   >
							<span class="checkmark"></span>
						</label>
					</div>
				</div>
				
				<div></div>
				
				<div class="ctn_tbl_row">
					<div class="ctn_tbl_th fm_rep">
						<span class="langSpan">계약 시작일</span>
					</div>
					<div class="ctn_tbl_td">
						<div class='input-group date' id='datetimepicker1'>
							<input type='text' style="width:100%;" class="form-control" name="CONTRACT_STDT" id="CONTRACT_STDT" value="${data.CONTRACT_STDT}" onkeyup="valiChkAll(this,1)" required/>
							<span class="input-group-addon">
								<span class="glyphicon glyphicon-calendar"></span>
							</span>
						</div>
					</div>
					<div class="ctn_tbl_th fm_rep">
						<span class="langSpan">계약 종료일</span>
					</div>
					<div class="ctn_tbl_td">
						<div class='input-group date' id='datetimepicker2'>
							<input type="text" class="form-control" id="CONTRACT_EDT" name="CONTRACT_EDT" value="${data.CONTRACT_EDT}" onkeyup="valiChkAll(this,1)"  required/>
							<span class="input-group-addon">
								<span class="glyphicon glyphicon-calendar"></span>
							</span>
						</div>
					</div>
					<div class="ctn_tbl_th fm_rep">
						<span class="langSpan">과금 시작일</span>
					</div>
					<div class="ctn_tbl_td">
						<div class='input-group date' id='datetimepicker3'>
							<input type="text" class="form-control" id="BILL_DT" name="BILL_DT" value="${data.BILL_DT}" onkeyup="valiChkAll(this,1)" required />
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
						<input type="text" name="RES_SALES" class="form-control">
					</div>
				
					<div class="ctn_tbl_th">
						<span class="langSpan">담당 매니저</span>
					</div>
					<div class="ctn_tbl_td">
						<input type="text" name="RES_MANAGER" class="form-control">
					</div>
					
					<div class="ctn_tbl_th">
						<span class="langSpan">계약서</span>
					</div>
					<div class="ctn_tbl_td">
						<input type="text" name="CONTRACT" class="form-control">
					</div>
				</div>
				
				<div class="ctn_tbl_row">
					<div class="ctn_tbl_th fm_rep">
						<span class="langSpan">청구 기준일</span>
					</div>
					<div class="ctn_tbl_td">
						<div class='input-group date' id='datetimepicker4'>
							<input type="text" class="form-control" id="BILL_RFDT" name="BILL_RFDT" value="${data.BILL_RFDT}"  onkeyup="valiChkAll(this,1)" required/>
							<span class="input-group-addon">
								<span class="glyphicon glyphicon-calendar"></span>
							</span>
						</div>
					</div>
				
					<div class="ctn_tbl_th fm_rep">
						<span class="langSpan">세금계산서 발행일</span>
					</div>
					<div class="ctn_tbl_td">
						<div class='input-group date' id='datetimepicker5'>
							<input type="text" class="form-control" id="TAX_DT" name="TAX_DT" value="${data.TAX_DT}" onkeyup="valiChkAll(this,1)" required/>
							<span class="input-group-addon">
								<span class="glyphicon glyphicon-calendar"></span>
							</span>
						</div>
					</div>
					
					<div class="ctn_tbl_th">
						<span class="langSpan">증빙 자료</span>
					</div>
					<div class="ctn_tbl_td">
						<input type="text" name="EVIDENCE" class="form-control">
					</div>
					
				</div>
				
				<div class="ctn_tbl_row">
					<div class="ctn_tbl_th">
						<span class="langSpan">고객사 구분</span>
					</div>
					<div class="ctn_tbl_td">
						<div>
							<input type="radio" class="fm_radio" name="COM_DIV" id="COM_DIV_1" value="0" checked />
							<label for="COM_DIV_1">민간</label>
							<input type="radio" class="fm_radio" name="COM_DIV" id="COM_DIV_2" value="1"/>
							<label for="COM_DIV_2">공공</label>
						</div>
					</div>
					
					<div class="ctn_tbl_th">
						<span class="langSpan">등록자</span>
					</div>
					<div class="ctn_tbl_td">
						<input type="hidden" class="form-control" id="ENROLL_ID" name="ENROLL_ID" value="${login.USER_ID}" readonly/>
						<input type="text" class="form-control" id="ENROLL_NAME" name="ENROLL_NAME" value="${login.USER_NAME}" readonly/>
					</div>
					<div class="ctn_tbl_th" style="background:#fff;"></div>
					<div class="ctn_tbl_td"></div>
				</div>
				
				<div></div>
				
				<div class="ctn_tbl_row">
					<div class="ctn_tbl_th">
						<span class="langSpan">사업자등록번호</span>
					</div>
					<div class="ctn_tbl_td">
						<input type="text" class="form-control" id="BR_NUMBER" name="BR_NUMBER" value="${data.BR_NUMBER}" disabled/>
					</div>
					
					<div class="ctn_tbl_th">
						<span class="langSpan">대표자명</span>
					</div>
					<div class="ctn_tbl_td">
						<input type="text" class="form-control" id="RP_NAME" name="RP_NAME" value="${data.RP_NAME}" disabled/>
					</div>
					<div class="ctn_tbl_th" style="background:#fff;"></div>
					<div class="ctn_tbl_td"></div>
				</div>
				
				<div class="ctn_tbl_row">
					<div class="ctn_tbl_th">
						<span class="langSpan">사업자등록주소</span>
					</div>
					<div class="ctn_tbl_td">
						<input type="text" class="form-control" id="BR_ADDRESS" name="BR_ADDRESS" value="${data.BR_ADDRESS}"  disabled/>
					</div>
				</div>
				
				<div class="ctn_tbl_row">
					<div class="ctn_tbl_th">
						<span class="langSpan">세금계산서(청구서)<br>담당자 연락처</span>
					</div>
					<div class="ctn_tbl_td">
						<input type="text" class="form-control" id="BILLER_PHONE" name="BILLER_PHONE" value="${data.BILLER_PHONE}"   disabled/>
					</div>
					<div class="ctn_tbl_th">
						<span class="langSpan">세금계산서(청구서)<br>이메일</span>
					</div>
					<div class="ctn_tbl_td">
						<input type="text" class="form-control" id="BILLER_EMAIL" name="BILLER_EMAIL" value="${data.BILLER_EMAIL}"   disabled/>
					</div>
					<div class="ctn_tbl_th">
						<span class="langSpan">대표 유선번호</span>
					</div>
					<div class="ctn_tbl_td">
						<input type="text" class="form-control" id="RP_PHONE" name="RP_PHONE" value="${data.RP_PHONE}"   disabled/>
					</div>
				</div>
				
				
				<div class="ctn_tbl_row">
					<div class="ctn_tbl_th">
						<span class="langSpan">계정관리자 ID</span>
					</div>
					<div class="ctn_tbl_td">
						<input type="text" class="form-control" id="MANAGER_ID" name="MANAGER_ID" value="${data.MANAGER_ID}"  disabled/>
					</div>
					<div class="ctn_tbl_th">
						<span class="langSpan">담당자명</span>
					</div>
					<div class="ctn_tbl_td">
						<input type="text" class="form-control" id="MANAGER_NAME" name="MANAGER_NAME" value="${data.MANAGER_NAME}"  disabled/>
					</div>
					<div class="ctn_tbl_th">
						<span class="langSpan">담당자 이메일</span>
					</div>
					<div class="ctn_tbl_td">
						<input type="text" class="form-control" id="MANAGER_EMAIL" name="MANAGER_EMAIL" value="${data.MANAGER_EMAIL}"  disabled/>
					</div>
				</div>
				
				
				<div class="ctn_tbl_row">
					<div class="ctn_tbl_th">
						<span class="langSpan">담당부서</span>
					</div>
					<div class="ctn_tbl_td">
						<input type="text" class="form-control" id="MANAGER_DEPT" name="MANAGER_DEPT" value="${data.MANAGER_DEPT}"  disabled/>
					</div>
					<div class="ctn_tbl_th">
						<span class="langSpan">담당자 직급</span>
					</div>
					<div class="ctn_tbl_td">
						<input type="text" class="form-control" id="MANAGER_RANK" name="MANAGER_RANK" value="${data.MANAGER_RANK}"  disabled/>
					</div>
					<div class="ctn_tbl_th">
						<span class="langSpan">담당자 연락처</span>
					</div>
					<div class="ctn_tbl_td">
						<input type="text" class="form-control" id="MANAGER_PHONE" name="MANAGER_PHONE" value="${data.MANAGER_PHONE}"  disabled/>
					</div>
				</div>
				
				<div class="ctn_tbl_row">
					<div class="ctn_tbl_th">
						<span class="langSpan">서비스 사업장 주소</span>
					</div>
					<div class="ctn_tbl_td">
						<input type="text" class="form-control" id="COMPANY_ADDRESS" name="COMPANY_ADDRESS" value="${data.COMPANY_ADDRESS}"  disabled/>
					</div>
				</div>
				
			</div>
		
			<div id="footer" class="footer-wrap">
		        <div id="footer-inner" class="footer-inner">
		            <!-- btn_box Start -->
		            <div class="btn_box">
		                <div class="right">
		                    <button type="submit" class="btn btn_primary" style="" id="btnSave" data-term="L.등록" title="등록"><span class="langSpan">등록</span></button>
				            <button type="button" class="btn" id="btnList" data-term="L.목록" title="목록" onclick="location.href='/admin/client/companyList.do'"><span class="langSpan">취소</span></button>
		                </div>
		            </div>
		            <!-- btn_box End -->
		        </div>
		    </div>
		</div>
	</form>

</html>