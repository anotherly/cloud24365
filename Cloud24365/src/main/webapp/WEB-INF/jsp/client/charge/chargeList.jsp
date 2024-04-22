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
	<title>CLOUD 24 365 관리자 페이지</title>
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
	
	$(document).ready( function() {
		
		iidx = 3;
		console.log("고객과금 목록 화면 진입");
		var colCnt=0;
		var idxTb =0;

		//테이블 기본설정 세팅
		dtTbSetting();
		
		var tb2=$("#tableList").DataTable({
			ajax : {
                "url":"/client/charge/chargeList.ajax",
                "type":"POST",
                "dataType": "json",
            },  
            columns: [
            	{data:"charge_ID"},
            	{data:"company_NAME"},
                {data:"service_TYPE_NM"},
            	{data:"pre_PRICE"},
                {data:"bill_DT"},
                {data:"bill_RFDT"},
                {data:"use_DT"},
                {data:"due_DATE"},
                {data:"br_NUMBER"},
                {data:"msp_PRICE"},
                {data:"iaas_PRICE"},
                {data:"datadr_PRICE"},
                {data:"sum_PRICE"}
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
       	   /* ,"drawCallback": function() {
       		   	console.log("공백처리함수");
	       		//입력정보 없을시
	       		blankInput($("td"),"입력정보 없음");
       		} */
		});
		
		//테이블 액션에 대한 설정
		tbAction("tableList");
		
		//수동청구서 페이지로 이동
		$("#billManuel").on("click",function(){
			console.log("수동청구서 화면으로 이동");
			location.href='/client/charge/billList.do';
		});
		
		//등록 화면 조회
		$("#acDetailFrm").submit(function(e){
				event.preventDefault();
				console.log("정보 저장");
				//저장 전 인덱스 맞춤
				console.log("과금 수정");
				let frm = $("#acDetailFrm").serialize();
				var chargeList = {};
				var mspPrice=[];
				var iaasPrice=[];
				var datadrPrice=[];
				var chargeId=[];
				////나중에 개량하자...
				$("#tableList tbody td input").each(function(){
					if($(this).attr("id")=='MSP_PRICE'){
						mspPrice.push($(this).val());
					}
					if($(this).attr("id")=='IAAS_PRICE'){
						iaasPrice.push($(this).val());
					}
					if($(this).attr("id")=='DATADR_PRICE'){
						datadrPrice.push($(this).val());
					}
					if($(this).attr("id")=='CHARGE_ID'){
						chargeId.push($(this).val());
					}
				});
				/////////
				//$("#CHARG").val($("#tableList"));
				
				//$("#inputList").val(frm);
			    var options = {
		            url:'/client/charge/updatePriceList.ajax?',
		            type:"post",
		            dataType: "json",
		            data : frm, 
		            /* {
		            	 'companyVO':frm,
						'CHARGE_ID':chargeId,	            	
						'DATADR_PRICE':datadrPrice,	            	
						'IAAS_PRICE':iaasPrice,         	
						'MSP_PRICE':mspPrice
		            } */
		            success: function(res){
		                if(res.cnt > 0){
		                    alert("저장되었습니다.");
		                    location.href="/client/charge/chargeList.do"
		                } else {
		                	if(res.badFileType != null){
		                		alert("올바른 확장자명인지 확인해주세요");
		                	} else if(typeof res.createFileError !== "undefined" && res.createFileError) {
		                	    alert("파일 저장에 실패했습니다.");
		                	} else if(typeof res.msg !== "undefined" && res.msg != null) {
		                		alert(res.msg);
		                	} else {
		                		alert("저장에 실패했습니다.");
		                	}
		                }
		            } ,
		            error: function(res,error){
		                alert("에러가 발생했습니다."+error);
		            }
			    };
			    $('#acDetailFrm').ajaxSubmit(options);
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
				 "searchRadio2" :searchRadio2,
				 "sDate" :sDate,
				 "eDate" :eDate
			 };
		 var tagUrl="/client/charge/chargeList.ajax";
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
				<!-- search_box Start -->
	            <div class="search_box">
			   
					<div class="form-group col_14" style="width: 100%;">
						<label class="form-control-label"><span class="langSpan">검색어 : </span></label>
						<select class="form-control mw_30" id="searchType" name="searchType">
	                        <option value="serviceNm">서비스상품명</option>
	                        <option value="chargeId">청구번호</option>
	                    </select>
						<input class="form-control" type="text" id="searchValue" name="searchValue"  onkeyup="if(event.keyCode == 13)search();"/>
					</div>
					
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
                
	            <!-- grid_box Start -->
	            <h4>※각 요금들은 VAT이 포함</h4>
	            <form name="insertForm" id="acDetailFrm" method="post" action="return false"  enctype="multipart/form-data">
	            <!-- <input type="hidden" id="COMPANYID" name="COMPANY_ID" VALUE='0021'/> -->
	            <!-- <input type="hidden" id="CHARG" name="chgList" VALUE=''/> -->
				<div class="datatable-list-01">
					<div class="page-description">
						<div class="rows">
						
							<table id="tableList" class="table table-bordered" style="width: 100%;">
								<thead>
									<tr>
										<th>청구번호</th>
										<th>기관명</th>
										<th>서비스상품명</th>
										<th>예상 MSP 요금</th>
										<th>과금 시작일</th>
										<th>청구 기준일</th>
										<th>사용일수</th>
										<th>납입기일</th>
										<th>사업자번호</th>
										<th>MSP요금</th>
										<th>Iaas요금</th>
										<th>data DR</th>
										<th>요금합계</th>
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
				                    <button type="submit" class="btn btn_primary" style="" id="btnUpdate"><span class="langSpan">저장</span></button>
				                    <button type="button" class="btn" style="" id="billManuel" ><span class="langSpan">수동청구서 발송</span></button>
				                </div>
				            </div>
				            <!-- btn_box End -->
				        </div>
				    </div>
					
				</div>
	            <!-- grid_box End -->
	            </form>
            </div>
			<!-- work End -->
        </div>
		<!-- contents End ------------------>
    </div>
    <!-- container End ------------------>
</body>
</html>