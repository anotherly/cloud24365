<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title>CLOUD 24 365</title>
	<jsp:include page="/cmn/client/top.do" flush="false" />
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

/* #tableList input{
    width: 80px;
} */

</style>
<script>
	//데이터 테이블 관련
	var iidx;//날짜컬럼 인덱스
	var selectlang;
	
	function show_popup_insert(){
		console.log("고객사등록");
	    document.getElementsByClassName('modal size_l normal')[0].classList.toggle('show');
	    $("#modal_popup_insert #popupBody").load("/client/charge/billInsert.do");
	}
	
	$(document).ready( function() {
		
		iidx = 3;
		console.log("수동청구서 목록 화면 진입");
		var colCnt=0;
		var idxTb =0;

		//테이블 기본설정 세팅
		dtTbSetting();
		
		var tb2=$("#tableList").DataTable({
			ajax : {
                "url":"/client/charge/billList.ajax",
                "type":"POST",
                "dataType": "json",
            },  
            columns: [
                {data:"snd_DT"
                	,"render": function (data, type, row, meta) {
                        return data;
	                },
                },
                {data:"bill_PRICE"},
                {data:"bill_FILE"
                	,"render": function (data, type, row, meta) {
                		//console.log(data);
                        return '<a href="/download.ajax?FILE_ID='+row.file_ID+'">'+row.file_NAME+'</a>';
	                },
                },
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
            }
            //,order: [[ 1, 'desc' ]]
            ,responsive: true
			,language : lang_kor // //or lang_eng
		});
		
		//테이블 액션에 대한 설정
		tbAction("tableList");
		
		//수동청구서 페이지로 이동
		$("#billManuel").on("click",function(){
			console.log("수동청구서 화면으로 이동");
			location.href='/client/charge/billList.do';
		});

		//데이트타임피커
		var toDate = new Date();
		$('#datetimepicker1').datetimepicker({
			 format:"YYYY-MM-DD" ,
			 //defaultDate:moment().subtract(1, 'months'),
			 maxDate : moment()
		});
		$('#datetimepicker2').datetimepicker({
			 format:"YYYY-MM-DD",
			 //defaultDate:moment(),
			 maxDate : moment()
		});
		$("tbody tr td:first-child").css("font-size","13px");
	});
	
	/* 검색 */
	 function search(){
		 console.log("검색");
		 
		 var searchType=$("#searchType").val();
		 var searchValue=$("#searchValue").val();
		 var searchRadio2=$('input[name="searchRadio2"]:checked').val();
		 var sDate=$("#sDate").val();
		 var eDate=$("#eDate").val();
		 
		 let frm =
			 {
				 "searchType" :searchType,
				 "searchValue" :searchValue,
				 "searchRadio2" :searchRadio2
			 };
		 var tagUrl="/client/charge/billList.ajax";
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
					<button class="nav-link active" role="tab" aria-selected="false">수동청구서 목록</button>
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
					
					<div class="form-group col_3" style="width: 80%;display: flex;flex-direction: row;margin-top: 13px;" >
						<label class="form-control-label">
							<span class="langSpan">기간설정 : </span>
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
					
				   <div class="search_btn">
					   <button class="btn btn_sch btn_primary" id='btnSearch' onclick="search();" ><i class="ico_sch"></i><span class="langSpan">조회</span></button>
				   </div>
				</div>
	            <!-- search_box End -->
				<div class="datatable-list-01">
					<div class="page-description">
						<div class="rows">
						
							<table id="tableList" class="table table-bordered" style="width: 100%;">
								<thead>
									<tr>
										<th>발송일</th>
										<th>청구액</th>
										<th>첨부파일</th>
									</tr>
								</thead>
							</table>
						
						</div>
					</div>
					
					<div id="footer" class="footer-wrap">
						<%@include file="/footer.jsp" %>
				    </div>
					
				</div>
	            <!-- grid_box End -->
            </div>
			<!-- work End -->
        </div>
		<!-- contents End ------------------>
    </div>
    <!-- container End ------------------>
    
<!-- 모달 End -->
</body>
</html>