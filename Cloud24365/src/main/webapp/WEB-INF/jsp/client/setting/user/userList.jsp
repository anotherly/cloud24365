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
	var updUrl="/client/setting/user/userUpdate.do";
	var delUrl="/client/setting/user/userDelete.do";
	var delbak="/client/setting/user/userList.do";
	//데이터 테이블 관련
	var iidx;//날짜컬럼 인덱스
	var selectlang;
	var lang_kor;
	var lang_eng;
	
	$(document).ready( function() {
		
		dtTbSetting();
		iidx = 3;
		console.log("사용자 목록 화면 진입");
		var colCnt=0;
		var idxTb =0;
		
		var tb2=$("#tableList").DataTable({
			
			ajax : {
                "url":"/client/setting/user/userList.ajax",
                "type":"POST",
                "dataType": "json",
            },  
            columns: [
            	{
            		data:   "user_ID",
	            	"render": function (data, type, row, meta) {
	            		//console.log(data);
                        return '<input type="checkbox" id="chk" name="chk" value="'+data+'">';
	                },
            	
            		/* ,className: "select-checkbox" */
                },
                {data:"user_ID"},
                {data:"auth_NAME"},
                {data:"user_NAME"},
                {data:"user_EMAIL"},
                {data:"user_PHONE"},
                {data:"reg_DT"}
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
            order: [[ 6, 'desc' ]]
            ,responsive: true
           ,language : lang_kor // //or lang_eng
       	   ,"drawCallback": function() {
       		   	console.log("공백처리함수");
	       		//입력정보 없을시
	       		blankInput($("td"),"입력정보 없음");
       		}
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
			if ($('input:checkbox[name="searchChk"]:checked').length==3){
	    		$("#searchChkAll").prop("checked", true);
	    	} else {
	    		$("#searchChkAll").prop("checked", false);
	    	}
		});
		
		//상세 화면 조회
		$("#tableList").on("click", "tbody td:not(':first-child')", function(){
			//console.log("목록에서 상세요소 클릭");
			var tagId = $(this).parent().children().first().children().first().val();
			$(this).attr('id');
			if(tagId!="chkTd"){
				location.href="/client/setting/user/userDetail.do?USER_ID="+tagId;
			}
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
		
	});
	
	/* 검색 */
	 function search(){
		 console.log("검색");
		 let frm = $("#searchFrm").serialize();
		 var tagUrl="/client/setting/user/userList.ajax";
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
				   
						<div class="form-group col_3">
							<label>
								<span class="langSpan">등록일</span>
							</label>
							<!-- 기간 -->
							<div class='input-group date' id='datetimepicker1'>
								<input type='text' class="form-control" name=sDate id="sDate" required/>
								<span class="input-group-addon">
									<span class="glyphicon glyphicon-calendar"></span>
								</span>
							</div>
							 ~ 
							<div class='input-group date' id='datetimepicker2'>
								<input type="text" class="form-control" id="eDate" name="eDate" required/>
								<span class="input-group-addon">
									<span class="glyphicon glyphicon-calendar"></span>
								</span>
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
							<select class="form-control" id="searchType" name="searchType">
		                        <option value="companyName">이름</option>
		                        <option value="companyId">ID</option>
		                    </select>
							<input class="form-control" type="text" id="searchValue" name="searchValue"  onkeyup="if(event.keyCode == 13)search();"/>
						</div>
				   </form>
				   <div class="search_btn">
					   <button class="btn btn_sch btn_primary" id='btnSearch' onclick="search();" ><i class="ico_sch"></i><span class="langSpan">조회</span></button>
					   <!-- <button class="btn btn_reset"><i class="ico_reset"></i><span class="langSpan">초기화</span></button> -->
				   </div>
				</div>
                <!-- search_box End -->
                
                <!-- grid_box Start -->
				<div class="page-description">
					<div class="rows">
						<table id="tableList" class="table table-bordered" style="width: 100%;">
							<thead>
								<tr>
									<th><input type="checkbox" id="chkAll" class="chk"></th>
									<th>ID</th>
									<th>사용자 권한</th>
									<th>사용자명</th>
									<th>이메일</th>
									<th>휴대폰번호</th>
									<th>등록일</th>
								</tr>
							</thead>
						</table>
					</div>
				</div>
				<!-- grid_box End -->
					
				<div id="footer" class="footer-wrap">
			        <div id="footer-inner" class="footer-inner">
			            <!-- btn_box Start -->
			            <div class="btn_box">
			                <div class="right">
			                <button class="btn btn_primary" style="" id="btnInsert" onclick="location.href='/client/setting/user/userInsert.do'"><span class="langSpan">등록</span></button>
		                    <button class="btn" style="" id="btnUpdate" data-term="L.등록" title="등록" onclick='tbUpdate(this,updUrl,"USER_ID")'><span class="langSpan">수정</span></button>
				            <button class="btn" style="" id="btnDelete" data-term="L.등록" title="등록" onclick='tbDelete(this,delUrl,delbak)'><span class="langSpan">삭제</span></button>
			                </div>
			            </div>
			        </div>
			    </div>
	            <!-- btn_box End -->
            </div>
			<!-- work End -->
        </div>
		<!-- contents End ------------------>
    </div>
    <!-- container End ------------------>
</body>

</html>
</html>