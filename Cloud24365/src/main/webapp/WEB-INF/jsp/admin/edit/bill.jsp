<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title>CLOUD 24 365 관리자 페이지</title>
	<jsp:include page="/cmn/admin/top.do" flush="false" />
	<link type="text/css" rel="stylesheet" href="/css/imgTable.css">
<script>
function show_popup_insert(){
	console.log("고객사등록");
    document.getElementsByClassName('modal size_l normal')[0].classList.toggle('show');
    $("#modal_popup_insert #popupBody").load("/admin/edit/billInsert.do");
}

function show_popup_update(that){
	console.log("고객사상세");
    document.getElementsByClassName('modal size_l normal')[1].classList.toggle('show');
    $("#modal_popup_detail #popupBody").load("/admin/edit/billUpdate.do?BILL_FILE_ID="+$(that).attr('id')+"");
}

function numberUptop(that){
	ajaxMethod("/admin/edit/firstNumber.ajax",{"BILL_FILE_ID":$(that).attr('id')});
	location.href='/admin/edit/bill.do';
}

$(document).ready(function() {
	console.log("청구서양식 관리자 페이지");
	//테이블 기본설정 세팅
	dtTbSetting();
	iidx = 3;
	console.log("사용자 목록 화면 진입");
	var colCnt=0;//맨앞에 들어가는 순번
	var idxTb =0;
	var tb2=$("#tableList").DataTable({
		ajax : {
            "url":"/admin/edit/billList.ajax",
            "type":"POST",
            "dataType": "json",
        },  
        columns: [
        	{data:"bill_PRIOR"},
            {data:"bill_NAME"},
			/* +'<button class="btn" id="" name="upTop"><span class="langSpan">맨위로</span></button>' */
            {
        		data:   "bill_FILE_ID",
            	"render": function (data, type, row, meta) {
            		//console.log(meta.row+"	/	"+meta.col+"	/	"+row);
            		colCnt++;
            		var btnString ='';
            		btnString+='<button class="btn btn_primary" id="'+data+'" name="btnUpdate" onclick="show_popup_update(this)"><span class="langSpan">변경</span></button>';
            		if(row.bill_PRIOR!=1){
	            		btnString+='<button class="btn" id="'+data+'" name="upTop"  onclick="numberUptop(this)"><span class="langSpan">맨위로</span></button>';
            		}
                    return btnString;
				}
            },
            
        ],
        "lengthMenu": [ [5, 10, 20], [5, 10, 20] ],
        "pageLength": 20,
        pagingType : "full_numbers",
        columnDefs: [ 
        	 {orderable: false, targets: [0] }//특정 열(인덱스번호)에 대한 정렬 비활성화
        	,{className: "dt-center",targets: "_all"} 
        ],
        select: {
            style:    'multi',
            selector: 'td:first-child'
        }
        /* order: [[ 1, 'desc' ]] */
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
</script>
<body class="open">
    <!-- lnb Start ------------------>
    <aside id="lnb" class="lnb">
        <a class="lnb-control" title="메뉴 펼침/닫침"><span class="menu-toggle">메뉴 펼침/닫침</span></a>
        <nav id="navbar" class="navbar"></nav>
    </aside>
    <!-- lnb End ------------------>
        <!-- container Start ------------------>
    <div id="container" class="container-wrap" style="margin-top: 60px;background: none;" >
		<!-- header Start ------------------>
		<div id="header" class="header-wrap"></div>
		<!-- header End ------------------>
		<!-- title start -->
		<div id="title" class="title-wrap">
			<div class="title-inner">
				<!-- 타이틀 텝 구성 -->
				<div class="title_segments" role="tablist">
					<button id="contentInfo" class="nav-link" role="tab" aria-selected="false" onclick="location.href='/admin/edit/content.do'">컨텐츠 관리 현황</button>
					<button id="companyInfo" class="nav-link" role="tab" aria-selected="false" onclick="location.href='/admin/edit/client.do'">고객사 관리현황</button>
					<button id="billInfo" class="nav-link active" role="tab" aria-selected="false" onclick="location.href='/admin/edit/bill.do'">청구서양식 관리현황</button>
				</div>
			</div>
		</div>
		<!-- title end -->
		
		<!-- contents Start ------------------>
		<div id="contents" class="contents-wrap list_ani">
			<!-- work Start -->
			<div id="work" class="work-wrap list_page">
				<div class="ctn_tbl_area" style="margin:20px 0;">
					<div class="datatable-list-01">
						<div class="page-description">
							<div class="rows">
								<table id="tableList" class="table table-bordered" style="width: 100%;">
									<thead>
										<tr>
											<th>순번</th>
											<th>파일명</th>
											<th>삭제 및 등록</th>
										</tr>
									</thead>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>
			
			
			
		</div>
			
		<div id="footer" class="footer-wrap">
	        <div id="footer-inner" class="footer-inner">
	            <!-- btn_box Start -->
	            <div class="btn_box">
	                <div class="right">
	                	<button class="btn" onclick="show_popup_insert()">추가등록</button>
	                </div>
	            </div>
	        </div>
	    </div>
	</div>
	
<!-- 모달 Start -->
<div class="modal size_l normal" id="modal_popup_insert">
    <div class="popup_layer">
        <div class="pop_header">
            <div class="pop_header_ttl">청구서양식 등록</div>
            <button type="button" class="btn-close" onclick="show_popup_insert()">close</button>
        </div>
        <div class="pop_body" id="popupBody"></div>
    </div>
</div>
<div class="modal size_l normal" id="modal_popup_detail">
    <div class="popup_layer">
        <div class="pop_header">
            <div class="pop_header_ttl">청구서양식 변경</div>
            <button type="button" class="btn-close" onclick="show_popup_update()">close</button>
        </div>
        <div class="pop_body" id="popupBody"></div>
    </div>
</div>
<!-- 모달 End -->
</body>
</html>