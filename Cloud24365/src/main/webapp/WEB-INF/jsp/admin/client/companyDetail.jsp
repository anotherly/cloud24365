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
			console.log("고객 상세 화면");
			var tagId='${data.COMPANY_ID}';
			
			//동적테이블의 옆 th 높이를 동적으로 맞춰준다...
			//css적으로 처리하는 방법이 있을텐데 안먹네;;;
			//$("#table_th").css("height",$("#table_th").parent().height());
			
			//console.log("상세정보 진입 : "+tagId);
			//목록 버튼 클릭 시
			$("#btnList").click(function(){
				location.href="/admin/client/companyList.do"; 
			});
			

			//수정 버튼 클릭 시
			$("#btnUpdate").click(function(){
				 $("#work").load("/admin/client/companyUpdate.do",{"COMPANY_ID":tagId}); 
			});
			//삭제 버튼 클릭 시
			$("#btnDelete").click(function(){
				if(confirm("선택하신 항목을 삭제하시겠습니까?")==true){
					var idArr=[]; // 회원 id값 배열
					idArr.push(tagId);//배열에 아이디 값 삽입
//					//console.log("보낼 값 : "+ idArr);
					var url="/admin/client/companyDelete.ajax";
					var data = {"idArr":idArr};
					var callback= "/admin/client/companyList.do";
					ajaxMethod(url, data, callback);
	    		}
			});//btnDelte
			
		});
	</script>
	
</head>
<body>
	<div id="contents_box" class="contents_box">
		<!-- 컨텐츠 테이블 헤더 Start -->
		<div class="ctn_tbl_header">
			<div class="ttl_ctn" data-term="L.위협정보_등록" title="위협정보 등록">
				<span class="langSpan">고객사 상세정보</span>
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
						${data.COMPANY_ID}
					</div>
					<div class="ctn_tbl_th ">
						<span class="langSpan">고객사명</span>
					</div>
					<div class="ctn_tbl_td">
						${data.COMPANY_NAME}
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
							<input type="checkbox" name="IAAS_NHN" id="IAAS_NHN" value="Y" <c:if test="${data.IAAS_NHN eq 'Y'}">checked</c:if> disabled>
							<span class="checkmark"></span>
						</label>
						<label class="fm_checkbox">
							<span class="langSpan">Naver Cloud</span>
							<input type="checkbox" name="IAAS_NAVER" id="IAAS_NAVER" value="Y" <c:if test="${data.IAAS_NAVER eq 'Y'}">checked</c:if> disabled>
							<span class="checkmark"></span>
						</label>
						<label class="fm_checkbox">
							<span class="langSpan">KT Cloud</span>
							<input type="checkbox" name="IAAS_KT" id="IAAS_KT" value="Y" <c:if test="${data.IAAS_KT eq 'Y'}">checked</c:if> disabled>
							<span class="checkmark"></span>
						</label>
						<label class="fm_checkbox">
							<span class="langSpan">AWS</span>
							<input type="checkbox" name="IAAS_AWS" id="IAAS_AWS" value="Y" <c:if test="${data.IAAS_AWS eq 'Y'}">checked</c:if> disabled>
							<span class="checkmark"></span>
						</label>
					</div>
					
					<div class="ctn_tbl_th">
						<span class="langSpan">dataDR</span>
					</div>
					<div class="ctn_tbl_td">
						<label class="fm_checkbox">
							<span class="langSpan">NHN Cloud</span>
							<input type="checkbox" name="SDR_NHN" id="SDR_NHN" value="Y" <c:if test="${data.SDR_NHN eq 'Y'}">checked</c:if> disabled>
							<span class="checkmark"></span>
						</label>
						<label class="fm_checkbox">
							<span class="langSpan">Naver Cloud</span>
							<input type="checkbox" name="SDR_NAVER" id="SDR_NAVER" value="Y" <c:if test="${data.SDR_NAVER eq 'Y'}">checked</c:if> disabled>
							<span class="checkmark"></span>
						</label>
						<label class="fm_checkbox">
							<span class="langSpan">KT Cloud</span>
							<input type="checkbox" name="SDR_KT" id="SDR_KT" value="Y" <c:if test="${data.SDR_KT eq 'Y'}">checked</c:if> disabled>
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
							<input type='text' style="width:100%;" class="form-control" name="CONTRACT_STDT" id="CONTRACT_STDT" value="${data.CONTRACT_STDT}"  onkeyup="valiChkAll(this,1)" required/>
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
							<input type="text" class="form-control" id="CONTRACT_EDT" name="CONTRACT_EDT" value="${data.CONTRACT_EDT}" onkeyup="valiChkAll(this,1)"  required/>
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
						<input type="radio" class="fm_radio" name="COM_DIV" id="COM_DIV_1"value="0" <c:if test="${data.COM_DIV eq '0'}">checked</c:if> disabled/>
						<label for="COM_DIV_1">민간</label>
						<input type="radio" class="fm_radio" name="COM_DIV" id="COM_DIV_2" value="1" <c:if test="${data.COM_DIV eq '1'}">checked</c:if> disabled/>
						<label for="COM_DIV_2">공공</label>
					</div>
				</div>
				
				<div class="ctn_tbl_th">
					<span class="langSpan">등록자</span>
				</div>
				<div class="ctn_tbl_td">
					${login.USER_NAME}
				</div>
				<div class="ctn_tbl_th" style="background:#fff;"></div>
				<div class="ctn_tbl_td"></div>
			</div>
			
			<div class="ctn_tbl_row">
				<div class="ctn_tbl_th">
					<span class="langSpan">사업자등록번호</span>
				</div>
				<div class="ctn_tbl_td">
					${data.BR_NUMBER}
				</div>
				
				<div class="ctn_tbl_th">
					<span class="langSpan">대표자명</span>
				</div>
				<div class="ctn_tbl_td">
					${data.RP_NAME}
				</div>
				<div class="ctn_tbl_th" style="background:#fff;"></div>
				<div class="ctn_tbl_td"></div>
			</div>
			
			<div class="ctn_tbl_row">
				<div class="ctn_tbl_th">
					<span class="langSpan">사업자등록주소</span>
				</div>
				<div class="ctn_tbl_td">
					${data.BR_ADDRESS}
				</div>
			</div>
			
			<div class="ctn_tbl_row">
				<div class="ctn_tbl_th">
					<span class="langSpan">세금계산서(청구서)<br>담당자 연락처</span>
				</div>
				<div class="ctn_tbl_td">
					${data.BILLER_PHONE}
				</div>
				<div class="ctn_tbl_th">
					<span class="langSpan">세금계산서(청구서)<br>이메일</span>
				</div>
				<div class="ctn_tbl_td">
					${data.BILLER_EMAIL}
				</div>
				<div class="ctn_tbl_th">
					<span class="langSpan">대표 유선번호</span>
				</div>
				<div class="ctn_tbl_td">
					${data.RP_PHONE}
				</div>
			</div>
			
			
			<div class="ctn_tbl_row">
				<div class="ctn_tbl_th">
					<span class="langSpan">계정관리자 ID</span>
				</div>
				<div class="ctn_tbl_td">
					${data.MANAGER_ID}
				</div>
				<div class="ctn_tbl_th">
					<span class="langSpan">담당자명</span>
				</div>
				<div class="ctn_tbl_td">
					${data.MANAGER_NAME}
				</div>
				<div class="ctn_tbl_th">
					<span class="langSpan">담당자 이메일</span>
				</div>
				<div class="ctn_tbl_td">
					${data.MANAGER_EMAIL}
				</div>
			</div>
			
			
			<div class="ctn_tbl_row">
				<div class="ctn_tbl_th">
					<span class="langSpan">담당부서</span>
				</div>
				<div class="ctn_tbl_td">
					${data.MANAGER_DEPT}
				</div>
				<div class="ctn_tbl_th">
					<span class="langSpan">담당자 직급</span>
				</div>
				<div class="ctn_tbl_td">
					${data.MANAGER_RANK}
				</div>
				<div class="ctn_tbl_th">
					<span class="langSpan">담당자 연락처</span>
				</div>
				<div class="ctn_tbl_td">
					${data.MANAGER_PHONE}
				</div>
			</div>
			
			<div class="ctn_tbl_row">
				<div class="ctn_tbl_th">
					<span class="langSpan">서비스 사업장 주소</span>
				</div>
				<div class="ctn_tbl_td">
					${data.COMPANY_ADDRESS}
				</div>
			</div>
			
		</div>
	
	<div id="footer" class="footer-wrap">
        <div id="footer-inner" class="footer-inner">
            <!-- btn_box Start -->
            <div class="btn_box">
               	 <div class="right">
					<button  id="btnList"  class="btn">
						<span class="langSpan">목록</span>
					</button>
					<button  id="btnUpdate"  class="btn">
						<span class="langSpan">수정</span>
					</button>
					<button  id="btnDelete"  class="btn">
						<span class="langSpan">삭제</span>
					</button>
				</div>
            </div>
            <!-- btn_box End -->
        </div>
    </div>
</div>
</body>
</html>