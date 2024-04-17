<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title>CLOUD 24 365</title>
	<jsp:include page="/cmn/client/top.do" flush="false" />

<!-- DateTimePicker -->
	<script src="<%=request.getContextPath()%>/calender/moment.js"></script>
	<script src="<%=request.getContextPath()%>/calender/mo_ko.js"></script>
	<script src="<%=request.getContextPath()%>/calender/bootstrap-datetimepicker.js"></script>
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/calender/no-boot-calendar-custom.css" />
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/calender/datetimepickerstyle.css" />

<script>
	var updUrl="/client/support/report/reportUpdate.do";
	var delUrl="/client/support/report/reportDelete.do";
	var delbak="/client/support/report/reportList.do";
	
	$(document).ready( function() {
		//테이블 기본설정 세팅
		dtTbSetting();
		iidx = 3;
		console.log("사용자 목록 화면 진입");
		var colCnt=0;
		var idxTb =0;
		$('input:checkbox[name="chk"]').trigger('click');
		
		var tb2=$("#tableList").DataTable({
			ajax : {
                "url":"/client/support/report/reportList.ajax",
                "type":"POST",
                "dataType": "json",
            },  
            columns: [
            	
            	{
            		data:   "report_ID",
	            	"render": function (data, type, row, meta) {
	            		console.log(meta.row+"	/	"+meta.col+"	/	"+row);
                        return '<input type="checkbox" id="chk" name="chk" value="'+data+'">';
	                },
                },
            	
                {data:"report_ID"},
                {data:"report_TYPE_NM"},
                {data:"company_NAME"},
                {data:"project_NAME"},
                {data:"report_NAME"},
                {data:"reg_DT"},
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
		$("#tableList").on("click", "tbody td:not(':first-child')", function(){
			console.log("목록에서 상세요소 클릭");
			var tagId = $(this).parent().children().first().children().first().val();
			$(this).attr('id');
			if(tagId!="chkTd"){
				location.href="/client/support/report/reportDetail.do?REPORT_ID="+tagId; 
			}
		});

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
			 var tagUrl="/client/support/report/reportList.ajax";
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
		<div id="header" class="header-wrap">
		</div>
		<!-- header End ------------------>
		<!-- title start -->
		<div id="title" class="title-wrap">
			<div class="title-inner">
				<!-- 타이틀 텝 구성 -->
				<div class="title_segments" role="tablist">
					<button class="nav-link active" role="tab" aria-selected="false">보고서관리</button>
				</div>
			</div>
		</div>
		<!-- title end -->
		
		<!-- contents Start ------------------>
		<div id="contents" class="contents-wrap list_ani">
			<!-- work Start -->
			<div id="work" class="work-wrap list_page">
 				<!-- search_box Start -->
               <div class="search_box">
				   <form action="#" method="post" id="searchFrm" onsubmit="return false;" class="search_form">
				   
						<div class="form-group col_15">
							<label class="form-control-label"><span class="langSpan">상태</span></label>
							<div class="fm_checkbox_box">
								
								<label class="fm_checkbox">
									<span class="langSpan">전체</span>
									<input type="checkbox" name="searchChkAll" id="searchChkAll" checked>
									<span class="checkmark"></span>
								</label>
								
								<label class="fm_checkbox">
									<span class="langSpan">주간보고</span>
									<input type="checkbox" name="searchChk" id="chk_status0" value="0" checked>
									<span class="checkmark"></span>
								</label>
								
								<label class="fm_checkbox">
									<span class="langSpan">월간보고</span>
									<input type="checkbox" name="searchChk" id="chk_status1" value="1" checked>
									<span class="checkmark"></span>
								</label>
								
								<label class="fm_checkbox">
									<span class="langSpan">ETC</span>
									<input type="checkbox" name="searchChk" id="chk_status2" value="2" checked>
									<span class="checkmark"></span>
								</label>

							</div>
						</div>
						
						<div class="form-group col_14">
							<label class="form-control-label"><span class="langSpan">검색어</span></label>
							<select class="form-control mw_30" id="searchType" name="searchType">
								<!-- <option value="reportId">보고서번호</option> -->
								<option value="reportTitle">기관명</option>
								<option value="reportTitle">프로젝트명</option>
								<option value="userName">보고서명</option>
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
								<label for="mon_r" class="fm_radio" ><input type="radio" class="checkMonth" name="searchRadio" id="mon_r" value=""><span class="checkmark"></span><span class="langSpan">범위내 검색</span></label>
								<label for="mon_1" class="fm_radio" ><input type="radio" class="checkMonth" name="searchRadio" id="mon_1" value="1"><span class="checkmark"></span><span class="langSpan">최근1개월</span></label>
								<label for="mon_3" class="fm_radio" ><input type="radio" class="checkMonth" name="searchRadio" id="mon_3" value="3"><span class="checkmark"></span><span class="langSpan">최근3개월</span></label>
								<label for="mon_6" class="fm_radio" ><input type="radio" class="checkMonth" name="searchRadio" id="mon_6" value="6"><span class="checkmark"></span><span class="langSpan">최근6개월</span></label>
							</div>
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
					<button class="btn btn_primary" id="btnDownload" onclick="location.href='/client/support/report/excelDownload.ajax'">
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
									<th><input type="checkbox" id="chkAll" class="chk"></th>
									<th>보고서번호</th>
									<th>보고서유형</th>
									<th>기관명</th>
									<th>프로젝트명</th>
									<th>보고서명</th>
									<th>일자</th>
								</tr>
							</thead>
						</table>
					</div>
				</div>
			</div>
			
			<div id="footer" class="footer-wrap">
		        <%@include file="/footer.jsp" %>
		    </div>
		</div>
	</div>
</div>	
</body>
</html>