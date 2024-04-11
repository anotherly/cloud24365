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
.ctn_tbl_th,.ctn_tbl_td{
	height:50px;
	min-height:50px !important;
}

.svc_cnt{
    display: flex;
    font-weight: bold;
    height: 50px;
    align-items: center;
    font-size: 17px;
}


</style>
<script>
	var updUrl="/admin/client/companyUpdate.do";
	var delUrl="/admin/client/companyDelete.ajax";
	var delbak="/admin/client/companyList.do";
	//데이터 테이블 관련
	var iidx;//날짜컬럼 인덱스
	var selectlang;
	
	$(document).ready( function() {
		//$("#sideDiv").load("/sidebar/company.do");
		//$("#tableList_filter input").css("background","black");
		//서비스 사용수
		var serviceCnt = ajaxMethod("/admin/client/serviceCnt.ajax").serviceCnt;
		$("#svcallCnt").text(serviceCnt.SVC_ALL);
		$("#svcnowCnt").text(serviceCnt.SVC_NOW);
		$("#svcendCnt").text(serviceCnt.SVC_END);
		
		iidx = 3;
		console.log("사용자 목록 화면 진입");
		var colCnt=0;
		var idxTb =0;

		//테이블 기본설정 세팅
		dtTbSetting();
		
		var tb2=$("#tableList").DataTable({
			ajax : {
                "url":"/admin/client/companyList.ajax",
                "type":"POST",
                "dataType": "json",
            },  
            columns: [
            	//vo에 설정한 변수가 안나올경우 아래 주석처리로 확인
            	{
            		data:   "company_ID",
	            	"render": function (data, type, row, meta) {
	            		if(colCnt==0){
	            			$("#svcallCnt").val(row.svc_ALL);
	            			$("#svcnowCnt").val(row.SVC_NOW);
	            			$("#svcendCnt").val(row.svc_END);
	            		}
	            		colCnt+=1;
	            		//console.log(meta.row+"	/	"+meta.col+"	/	"+data.company_NAME);
                        return '<input type="checkbox" id="chk" name="chk" value="'+data+'">';
	                },
            		/* ,className: "select-checkbox" */
                },
                {data:"company_ID"},
                {data:"SVC_YN"},
                {data:"manager_ID"},
                {data:"company_NAME"},
                {data:"rp_NAME"},
                {data:"rp_PHONE"},
                {data:"manager_EMAIL"},
                {data:"contract_STDT"},
                {data:"contract_EDT"}
            ],
            "lengthMenu": [ [5, 10, 20], [5, 10, 20] ],
			"pageLength": 10,
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
		tbAction("tableList");
		
		//등록 화면 조회
		$("#btnInsert").click(function() {
			location.href="/admin/client/companyInsert.do";
		});
		
		//상세 화면 조회
		$("#tableList").on("click", "tbody td:not(':first-child')", function(){
			console.log("목록에서 상세요소 클릭");
			var tagId = $(this).parent().children().first().children().first().val();
			$(this).attr('id');
			if(tagId!="chkTd"){
				$("#work").load("/admin/client/companyDetail.do",{"COMPANY_ID":tagId}); 
			}
		});

		//데이트타임피커
		var toDate = new Date();
		$('#datetimepicker1').datetimepicker({
			 format:"YYYY-MM-DD" ,
			 //defaultDate:moment().subtract(1, 'months'),
			 maxDate : moment()
		});
		/* .on('dp.change', function (e) {
			calculDate();
			tb.draw();
		}); */
		$('#datetimepicker2').datetimepicker({
			 format:"YYYY-MM-DD",
			 //defaultDate:moment(),
			 maxDate : moment()
		});
		/* .on('dp.change', function (e) {
			calculDate();
			tb.draw();
		}); */ 
	});
	
	/* 검색 */
	 function search(){
		 console.log("검색");
		 let frm = $("#searchFrm").serialize();
		 var tagUrl="/admin/client/companyList.ajax";
		 tbSearch("tableList",tagUrl,frm);
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
					<button class="nav-link active" role="tab" aria-selected="false">계약 현황</button>
				</div>
			</div>
		</div>
		<!-- title end -->
		
		<!-- contents Start ------------------>
		<div id="contents" class="contents-wrap list_ani">
			<!-- work Start -->
			<div id="work" class="work-wrap list_page">
				
				<!-- 전체/서비스중 서비스 종료 -->
				<div class="ctn_tbl_area" style="margin:20px 0;">
					<div class="form-group col_14">
						<div class="ctn_tbl_row" style="display: flex;height: 50px;align-items: center;">
							<div class="ctn_tbl_th "><span class="langSpan svc_cnt">전체</span></div>
							<div class="ctn_tbl_td"><span class="svc_cnt" id="svcallCnt"></span></div>
							<div class="ctn_tbl_th"><span class="langSpan svc_cnt">서비스 중</span></div>
							<div class="ctn_tbl_td"><span class="svc_cnt" id="svcnowCnt"></span></div>
							<div class="ctn_tbl_th"><span class="langSpan svc_cnt">서비스 종료</span></div>
							<div class="ctn_tbl_td"><span class="svc_cnt" id="svcendCnt"></span></div>
						</div>
					</div>
				</div>
                <!-- search_box Start -->
               <div class="search_box">
				   <form action="#" method="post" id="searchFrm" onsubmit="return false;" class="search_form">
				   
						<div class="form-group col_15">
							<label class="form-control-label"><span class="langSpan">상태</span></label>
							<div class="fm_checkbox_box">
								<label for="svcAll" class="fm_radio" ><input type="radio" class="checkMonth" name="searchRadio1" id="svcAll" value="1" checked><span class="checkmark"></span><span class="langSpan">전체</span></label>
								<label for="svcNow" class="fm_radio" ><input type="radio" class="checkMonth" name="searchRadio1" id="svcNow" value="svcNow"><span class="checkmark"></span><span class="langSpan">서비스 중</span></label>
								<label for="svcEnd" class="fm_radio" ><input type="radio" class="checkMonth" name="searchRadio1" id="svcEnd" value="svcEnd"><span class="checkmark"></span><span class="langSpan">서비스 종료</span></label>
							</div>
						</div>
						
						<div class="form-group col_14">
							<label class="form-control-label"><span class="langSpan">검색어</span></label>
							<select class="form-control mw_30" id="searchType" name="searchType">
		                        <option value="companyId">고객번호</option>
		                        <option value="companyName">이름</option>
		                        <option value="managerId">계정관리자 ID</option>
		                        <option value="rpName">대표자명</option>
		                    </select>
							<input class="form-control" type="text" id="searchValue" name="searchValue"  onkeyup="if(event.keyCode == 13)search();"/>
						</div>
						
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
								<label for="mon_r" class="fm_radio" ><input type="radio" class="checkMonth" name="searchRadio2" id="mon_r" value="" checked><span class="checkmark"></span><span class="langSpan">범위내 검색</span></label>
								<label for="mon_1" class="fm_radio" ><input type="radio" class="checkMonth" name="searchRadio2" id="mon_1" value="1"><span class="checkmark"></span><span class="langSpan">최근1개월</span></label>
								<label for="mon_3" class="fm_radio" ><input type="radio" class="checkMonth" name="searchRadio2" id="mon_3" value="3"><span class="checkmark"></span><span class="langSpan">최근3개월</span></label>
								<label for="mon_6" class="fm_radio" ><input type="radio" class="checkMonth" name="searchRadio2" id="mon_6" value="6"><span class="checkmark"></span><span class="langSpan">최근6개월</span></label>
							</div>
						</div>
						
				   </form>
				   <div class="search_btn">
					   <button class="btn btn_sch btn_primary" id='btnSearch' onclick="search();" ><i class="ico_sch"></i><span class="langSpan">조회</span></button>
				   </div>
				</div>
                <!-- search_box End -->
                
                <!-- grid_box Start -->
				<div class="datatable-list-01">
					<div class="page-description">
						<div class="rows">
							<table id="tableList" class="table table-bordered" style="width: 100%;">
								<thead>
									<tr>
										<th><input type="checkbox" id="chkAll" class="chk"></th>
										<th>고객번호</th>
										<th>상태</th>
										<th>계정 관리자 ID</th>
										<th>기관명</th>
										<th>대표자명</th>
										<th>대표 유선번호</th>
										<th>담당자 이메일</th>
										<th>계약일</th>
										<th>종료일</th>
									</tr>
								</thead>
							</table>
						</div>
					</div>
					
					<div id="footer" class="footer-wrap">
				        <div id="footer-inner" class="footer-inner">
				            <!-- btn_box Start -->
				            <div class="btn_box">
				                <div class="right">
				                    <button class="btn btn_primary" style="" id="btnInsert" data-term="L.등록" title="등록"><span class="langSpan">등록</span></button>
				                    <button class="btn" style="" id="btnUpdate" data-term="L.등록" title="등록" onclick='tbUpdate(this,updUrl,"COMPANY_ID")'><span class="langSpan">수정</span></button>
				                    <button class="btn" style="" id="btnDelete" data-term="L.등록" title="등록" onclick='tbDelete(this,delUrl,delbak)'><span class="langSpan">삭제</span></button>
				                </div>
				            </div>
				        </div>
				    </div>
		            <!-- btn_box End -->
				</div>
                <!-- grid_box End -->
            </div>
			<!-- work End -->
        </div>
		<!-- contents End ------------------>
    </div>
    <!-- container End ------------------>
</body>
</html>