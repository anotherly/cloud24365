<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title>CLOUD 24 365</title>
	<jsp:include page="/cmn/top.do" flush="false" />
 	

<script>
	var updUrl="/client/setting/user/userUpdate.do";
	var delUrl="/client/setting/user/userDelete.ajax";
	var delbak="/client/setting/user/userList.do";
	
	//데이터 테이블 관련
	var iidx;//날짜컬럼 인덱스
	var selectlang;
	var lang_kor;
	var lang_eng;
	
	$(document).ready( function() {
		
		//$("#sideDiv").load("/sidebar/user.do");
		$("#tableList_filter input").css("background","black");
		iidx = 3;
		console.log("사용자 목록 화면 진입");
		  
		var idxTb =0;
		
		var tb2=$("#tableList").DataTable({
			
			ajax : {
                "url":"/client/setting/user/userList.ajax",
                "type":"POST",
                "dataType": "json",
            },  
            columns: [
            	//도대체 무슨 네이밍룰로 시발 정하는지 모르겠으나
            	//서버단에서 설정한 변수가 아니라 지좆대로 설정되니
            	//반드시 아래의 랜더함수처럼 row 파라미터 확인해볼것!!!!
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
          //"pageLength": 5,
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
           ,language : 'lang_kor' // //or lang_eng
		});
		
		//날짜 검색 기능 추가
		/* $('#tableList_filter').prepend('<label style="margin-right: 50px;"><div class="input-group date" id="datetimepicker2" style="width: 256px;"><input type="text" id="toDate" ><span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span></div></label>');
 	    $('#tableList_filter').prepend('<label><div class="input-group date" id="datetimepicker1" style="width: 256px;"><input type="text" id="fromDate" placeholder="날짜를 선택해주세요 ->"><span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span><p style="margin-left:15px; margin-bottom:0px">~</p></div></label>');
		 */
		//체크박스 클릭 시 이벤트
		$("#tableList").on("click", 'input:checkbox', function() {
			chkBoxFunc(this);
		});
		//마우스 올릴시 
		$("#tableList").on("mouseenter", "tbody tr", function(){
			$(this).addClass('active');
		});
		//마우스 내릴시
		$("#tableList").on("mouseleave", "tbody tr", function(){
			$(this).removeClass('active');
		});
		
		//체크박스영역 제외 마우스 올릴시 포인터로
		$("#tableList").on("mouseleave", "tbody td:not(':first-child')", function(){
			$(this).css('cursor','pointer');
		});
		
		
		//페이지 이동이나 열 개수 변경시 전체체크박스 관련 이벤트
		$('#tableList').on('draw.dt', function(){
			//console.log("데이터테이블 값 변경");
			//인덱스 번호 재설정
			$('#tableList input:checkbox[name="chk"]').each(function(i,list) {
				$(this).attr("id","chk"+i)
			});
			
			//행개수에 따라 수정삭제버튼 생성여부
			//행 개수 0개일때
			if($('input:checkbox[name="chk"]').length !=0 && typeof $('input:checkbox[name="chk"]').length !== "undefined"){
				if(typeof $("#btnUpdate").val()==="undefined"){
					$("#btnIns").append("<input type='button' id='btnUpdate' value='수정' onclick='tbUpdate(this,updUrl)'>");
				}
				if(typeof $("#btnDelete").val()==="undefined"){
					$("#btnIns").append("<input type='button' id='btnDelete' value='삭제' onclick='tbDelete(this,delUrl,delbak)'>");
				}
			}else{
				//$("#btnIns").empty();	
				if(typeof $("#btnUpdate").val()==="undefined"){
					$("#btnUpdate").remove();
				}
				if(typeof $("#btnDelete").val()==="undefined"){
					$("#btnDelete").remove();
				}
			}
			
			if($('input:checkbox[name="chk"]:checked').length==$("tbody tr").length){
	    		$("#chkAll").prop("checked", true);
	    	}else{
	    		$("#chkAll").prop("checked", false);
	    	}
		});


		//등록 화면 조회
		$("#btnInsert").click(function() {
			location.href="/client/setting/user/userInsert.do";
		});
		
		//상세 화면 조회
		$("#tableList").on("click", "tbody td:not(':first-child')", function(){
			//console.log("목록에서 상세요소 클릭");
			var tagId = $(this).parent().children().first().children().first().val();
			$(this).attr('id');
			if(tagId!="chkTd"){
				$("#work").load("/client/setting/user/userDetail.do",{"USER_ID":tagId}); 
			}
		});

		//데이트타임피커
		/* var toDate = new Date();
		 $('#datetimepicker1').datetimepicker({
			 format:"YYYY-MM-DD" ,
			 //defaultDate:moment().subtract(6, 'months'),
			 maxDate : moment()
		}).on('dp.change', function (e) {
			calculDate();
			tb.draw();
		});
		 $('#datetimepicker2').datetimepicker({
			 format:"YYYY-MM-DD",
			 defaultDate:moment()
			 ,maxDate : moment()
		}).on('dp.change', function (e) {
			calculDate();
			tb.draw();
		}); */
	});
</script>
</head>
<body>
	<div id="content" class="main-div">
		<div id="subCir" class="sub-div">
			<div class="datatable-list-01">
				<div class="title">
					<h3>사용자 목록</h3>
				</div>
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
				
				<div id ="btnDiv" class="btnDiv" style="display: flex;flex-direction: row-reverse;">
					<div id="btnIns" style="display: flex;justify-content: space-around;width: 230px;">
						<input type='button' id='btnInsert' value='등록'>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%@include file="/footer.jsp" %>
</body>
</html>