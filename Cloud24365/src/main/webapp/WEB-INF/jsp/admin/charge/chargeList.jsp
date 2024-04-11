<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title>CLOUD 24 365 관리자 페이지</title>
	<jsp:include page="/cmn/admin/top.do" flush="false" />

<!-- DateTimePicker -->
	<script src="<%=request.getContextPath()%>/calender/moment.js"></script>
	<script src="<%=request.getContextPath()%>/calender/mo_ko.js"></script>
	<script src="<%=request.getContextPath()%>/calender/bootstrap-datetimepicker.js"></script>
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/calender/no-boot-calendar-custom.css" />
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/calender/datetimepickerstyle.css" />
<style>
	td{
		text-align:center;	
	}
</style>
<script>
	var updUrl="/admin/charge/chargeUpdate.do";
	var delUrl="/admin/charge/chargeDelete.ajax";
	var delbak="/admin/charge/chargeList.do";
	
	$(document).ready( function() {
		//테이블 기본설정 세팅
		dtTbSetting();
		iidx = 3;
		console.log("사용자 목록 화면 진입");
		var colCnt=0;
		var idxTb =0;
		$('input:checkbox[name="chk"]').trigger('click');
		
		/* var tb2=$("#tableList").DataTable({
			ajax : {
                "url":"/admin/charge/chargeList.ajax",
                "type":"POST",
                "dataType": "json",
            },  
            columns: [
            	
            	{
            		data:   "charge_ID",
	            	"render": function (data, type, row, meta) {
	            		console.log(meta.row+"	/	"+meta.col+"	/	"+row);
                        return '<input type="checkbox" id="chk" name="chk" value="'+data+'">';
	                },
                },
            	
                {data:"charge_ID"},
                {data:"charge_TYPE_NM"},
                {data:"company_NAME"},
                {data:"project_NAME"},
                {data:"charge_NAME"},
                {data:"reg_DT"},
            ],
            "lengthMenu": [ [5, 10, 20], [5, 10, 20] ],
            "pageLength": 20,
            pagingType : "full_numbers",
            columnDefs: [ 
            	{ orderable: false, targets: [0] }//특정 열(인덱스번호)에 대한 정렬 비활성화
            	,{className: "dt-center",targets: "_all"} 
            ],
            select: {
                style:    'multi',
                selector: 'td:first-child'
            },
            order: [[ 1, 'desc' ]]
            ,responsive: true
           ,language : lang_kor // //or lang_eng
		});
		
		//테이블 액션에 대한 설정
		tbAction("tableList"); */
		
		//전체체크박스 선택시
		$("#searchChkAll").on("click",function(){
			if ($("#searchChkAll").is(":checked")){
				$('input:checkbox[name="searchChk"]').prop("checked", true);
			}else{//선택->취소 : 전체 체크 해지시
				$('input:checkbox[name="searchChk"]').prop("checked", false);
			}
		});
		//타 체크박스 관련
		$('input:checkbox[name="searchChk"]').on('click',function(){
			if($('input:checkbox[name="searchChk"]:checked').length==3){
	    		$("#searchChkAll").prop("checked", true);
	    	}else{
	    		$("#searchChkAll").prop("checked", false);
	    	}
		});
		
		//상세 화면 조회
		/* $("#tableList").on("click", "tbody td:not(':first-child')", function(){
			console.log("목록에서 상세요소 클릭");
			var tagId = $(this).parent().children().first().children().first().val();
			$(this).attr('id');
			if(tagId!="chkTd"){
				$("#work").load("/admin/charge/chargeDetail.do",{"charge_ID":tagId}); 
			}
		}); */

		//데이트타임피커
		 var toDate = new Date();
		 $('#datetimepicker1').datetimepicker({
			 format:"YYYY-MM-DD" ,
			 maxDate : moment()
		});
		 $('#datetimepicker2').datetimepicker({
			 format:"YYYY-MM-DD",
			 maxDate : moment()
		});
	});
	
	/* 검색 */
	function search(){
		
		 console.log("검색");
		 let frm = $("#searchFrm").serialize();
		 var listArr = new Array();
		
		 $('input:checkbox[name="searchChk"]').each(function(i,list){
			 console.log($(this));
			if($(this).is(':checked')){
				listArr.push(Number($(this).val()));
			}
		 });
		 
		 if(listArr.length==0){
			 alert('상태는 최소 1개 이상 선택하셔야 합니다');
		 }else{
			 frm+="&listArr="+listArr;
			 var tagUrl="/admin/charge/chargeList.ajax";
			 tbSearch("tableList",tagUrl,frm); 
		 }
	}
	
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
		<!-- header End ------------------>
		<!-- title start -->
		<div id="title" class="title-wrap">
			<div class="title-inner">
				<!-- 타이틀 텝 구성 -->
				<div class="title_segments" role="tablist">
					<button class="nav-link active" role="tab" aria-selected="false">과금 현황</button>
				</div>
			</div>
		</div>
		<!-- title end -->
		
		<!-- contents Start ------------------>
		<div id="contents" class="contents-wrap list_ani">
			<!-- work Start -->
			<div id="work" class="work-wrap list_page" style="max-width:1800px;">
 				<!-- search_box Start -->
               <div class="search_box">
				   <form action="#" method="post" id="searchFrm" onsubmit="return false;" class="search_form">
						
						<div class="form-group col_3">
							<label class="form-control-label">
								<span class="langSpan">기간설정</span>
							</label>
							<div class="form_daterange" style="display: inline-flex;align-items: center;gap: 5px;" id="schDtBody">
								<!-- 기간 -->
								<div class='input-group date' id='datetimepicker1'>
									<input type='text' class="form-control dt_search" name=sDate id="sDate" required/>
									<span class="input-group-addon">
										<span class="glyphicon glyphicon-calendar"></span>
									</span>
								</div>
								 ~ 
								<div class='input-group date' id='datetimepicker2'>
									<input type="text" class="form-control dt_search" id="eDate" name="eDate" required/>
									<span class="input-group-addon">
										<span class="glyphicon glyphicon-calendar"></span>
									</span>
								</div>
							</div>

							<div class="fm_checkbox_box">
								<label for="mon_r" class="fm_radio" ><input type="radio" class="checkMonth" name="searchRadio" id="mon_r" value=""><span class="checkmark"></span><span class="langSpan">범위내 검색</span></label>
								<label for="mon_1" class="fm_radio" ><input type="radio" class="checkMonth" name="searchRadio" id="mon_1" value="1"><span class="checkmark"></span><span class="langSpan">최근1개월</span></label>
								<label for="mon_3" class="fm_radio" ><input type="radio" class="checkMonth" name="searchRadio" id="mon_3" value="3"><span class="checkmark"></span><span class="langSpan">최근3개월</span></label>
								<label for="mon_6" class="fm_radio" ><input type="radio" class="checkMonth" name="searchRadio" id="mon_6" value="6"><span class="checkmark"></span><span class="langSpan">최근6개월</span></label>
							</div>
						</div>
						
						<div class="form-group col_14">
							<label class="form-control-label"><span class="langSpan">검색어</span></label>
							<select class="form-control mw_30" id="searchType" name="searchType">
								<option value="companyName">기관명</option>
								<option value="chargeId">서비스상품명</option>
								<option value="chargeTitle">프로젝트명</option>
								<option value="userName">보고서명</option>
		                    </select>
							<input class="form-control" type="text" id="searchValue" name="searchValue"  onkeyup="if(event.keyCode == 13)search();"/>
						</div>
						
				   </form>
					<div class="search_btn">
						<button class="btn btn_sch btn_primary" id='btnSearch' onclick="search();" ><i class="ico_sch"></i><span class="langSpan">조회</span></button>
					</div>
				</div>
	            <!-- search_box End -->
		
			<!-- 엑셀저장 -->
			<div class="btn_box">
				<div class="right">
					<button class="btn btn_primary" id="btnDownload" onclick="location.href='/admin/charge/excelDownload.ajax'">
						<span class="langSpan">다운로드</span>
					</button>
				</div>
			</div>
		
			<div class="datatable-list-01">
				<div class="page-description">
					<div class="rows">
						<table id="tableList" class="table table-bordered" style="width: 100%;">
							<thead>
								<tr>
									<th rowspan="2">구매번호</th>
									<th rowspan="2">기관명</th>
									<th colspan="3">MSP 구매 현황</th>
									<th rowspan="2">과금 시작일</th>
									<th rowspan="2">청구기준일</th>
									<th rowspan="2">사용일수</th>
									<th rowspan="2">납일기일</th>
									<th rowspan="2">사업자번호</th>
									<th rowspan="2">MSP요금 (VAT포함)</th>
									<th rowspan="2">Iaas요금 (VAT포함)</th>
									<th rowspan="2">Service (dataDR)</th>
									<th rowspan="2">요금 합계 (VAT포함)</th>
								</tr>
								<tr>
									<th>클라우드 종류</th>
									<th>요금제</th>
									<th>구매 수량</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>sadfsdaf</td>
									<td>테스트컴패니</td>
									<td colspan="3">
										
									<div>
										<table border="0" cellspacing="0" cellpadding="0" id="chargeList" class="admin_list">
											<thead>
												<tr>
													<th>클라우드 종류</th>
													<th>요금제</th>
													<th>구매 수량</th>
												</tr>
											</thead>
											<tbody>
												<tr id="tr0">
													<td style="display:none;">
														<input type="text" id="COMPANY_ID" name="mspList[0].COMPANY_ID" value="0016" class="form-control">
													</td>											
													<td>NAVER</td>
													<td>LITE</td>
													<td>5</td>
												</tr>
											
												<tr id="tr1">
													<td style="display:none;">
														<input type="text" id="COMPANY_ID" name="mspList[1].COMPANY_ID" value="0016" class="form-control">
													</td>											
													<td>NAVER</td>
													<td>STANDARD</td>
													<td>1</td>
												</tr>
											
												<tr id="tr2">
													<td style="display:none;">
														<input type="text" id="COMPANY_ID" name="mspList[2].COMPANY_ID" value="0016" class="form-control">
													</td>											
													<td>NHN</td>
													<td>STANDARD</td>
													<td>2</td>
												</tr>
											
												<tr id="tr3">
													<td style="display:none;">
														<input type="text" id="COMPANY_ID" name="mspList[3].COMPANY_ID" value="0016" class="form-control">
													</td>											
													<td>AWS</td>
													<td>PREMIUM</td>
													<td>3</td>
												</tr>
												<!-- <tr id="addTr" onclick="addTr($('#mspList'),this)"><td colspan="3"><span class="langSpan">+ 요금제 추가</span></td></tr> -->	
											</tbody>
										</table>
										</div>

									</td>
									<td>2023-04-01</td>
									<td>2023-04-30</td>
									<td>30</td>
									<td>2023-05-31</td>
									<td>123-59-12356</td>
									<td>
										<input type="text" class="form-control mw_30" value="7,700,000"  placeholder="수기입력"/>
									</td>
									<td>
										<input type="text" class="form-control mw_30"  placeholder="수기입력"/>
										<!-- <button class="btn">
											<span class="langSpan">수기입력</span>
										</button> -->
									</td>
									<td>
										<input type="text" class="form-control mw_30" value="" placeholder="수기입력"/>
										<!-- <button class="btn">
											<span class="langSpan">수기입력</span>
										</button> -->
									</td>
									<td>7,700,000</td>
								</tr>
								
								<tr>
									<td>sadfsdaf</td>
									<td>테스트컴패니</td>
									<td colspan="3">
										<div>
										<table border="0" cellspacing="0" cellpadding="0" id="mspList" class="admin_list">
											<thead>
												<tr>
													<th>클라우드 종류</th>
													<th>요금제</th>
													<th>구매 수량</th>
												</tr>
											</thead>
											<tbody>
												<tr id="tr0">
													<td style="display:none;">
														<input type="text" id="COMPANY_ID" name="mspList[0].COMPANY_ID" value="0016" class="form-control">
													</td>											
													<td>NAVER</td>
													<td>LITE</td>
													<td>5</td>
												</tr>
											
												<tr id="tr1">
													<td style="display:none;">
														<input type="text" id="COMPANY_ID" name="mspList[1].COMPANY_ID" value="0016" class="form-control">
													</td>											
													<td>NAVER</td>
													<td>STANDARD</td>
													<td>1</td>
												</tr>
											
												<tr id="tr2">
													<td style="display:none;">
														<input type="text" id="COMPANY_ID" name="mspList[2].COMPANY_ID" value="0016" class="form-control">
													</td>											
													<td>NHN</td>
													<td>STANDARD</td>
													<td>2</td>
												</tr>
											
												<tr id="tr3">
													<td style="display:none;">
														<input type="text" id="COMPANY_ID" name="mspList[3].COMPANY_ID" value="0016" class="form-control">
													</td>											
													<td>AWS</td>
													<td>PREMIUM</td>
													<td>3</td>
												</tr>
												<!-- <tr id="addTr" onclick="addTr($('#mspList'),this)"><td colspan="3"><span class="langSpan">+ 요금제 추가</span></td></tr> -->	
											</tbody>
										</table>
										</div>

									</td>
									<td>2023-04-01</td>
									<td>2023-04-30</td>
									<td>30</td>
									<td>2023-05-31</td>
									<td>123-59-12356</td>
									<td>
										<input type="text" class="form-control mw_30" value="7,700,000"  placeholder="수기입력"/>
									</td>
									<td>
										<input type="text" class="form-control mw_30"  placeholder="수기입력"/>
										<!-- <button class="btn">
											<span class="langSpan">수기입력</span>
										</button> -->
									</td>
									<td>
										<input type="text" class="form-control mw_30" value="" placeholder="수기입력"/>
										<!-- <button class="btn">
											<span class="langSpan">수기입력</span>
										</button> -->
									</td>
									<td>7,700,000</td>
								</tr>
								
							</tbody>
						</table>
					</div>
				</div>
			</div>
			
			<div id="footer" class="footer-wrap">
		        <div id="footer-inner" class="footer-inner">
		            <!-- btn_box Start -->
		            <div class="btn_box">
		                <div class="right">
		                    <button class="btn btn_primary" style="" id="btnInsert" onclick="location.href='/admin/charge/chargeInsert.do'"><span class="langSpan">저장</span></button>
		                </div>
		            </div>
		        </div>
		    </div>
		</div>
	</div>
</div>	
</body>
</html>