<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title>CLOUD 24 365 관리자 페이지</title>
	<jsp:include page="/cmn/admin/top.do" flush="false" />
 	

<script>
	var updUrl="/admin/edit/touUpdate.do";
	var delUrl="/admin/edit/touDelete.ajax";
	var delbak="/admin/edit/touList.do";
	
	
	//상세 화면 조회
	function touDetail(that){
		console.log("목록에서 상세요소 클릭");
		var tagId = $(that).attr("id");
		$(this).attr('id');
		if(tagId!="chkTd"){
			$("#work").load("/admin/edit/touDetail.do",{"DOCUMENT_ID":tagId}); 
		}
	}
	//삭제
	function touDelete(that){
		console.log("삭제");
		var tagId = $(that).attr('name');
		ajaxMethod('/admin/edit/touDelete.ajax',{"DOCUMENT_ID":tagId},'/admin/edit/touList.do','삭제되었습니다');
	}
	
	$(document).ready( function() {
		//테이블 기본설정 세팅
		dtTbSetting();
		iidx = 3;
		console.log("사용자 목록 화면 진입");
		var colCnt=0;
		var idxTb =0;
		
		var tb2=$("#tableList").DataTable({
			
			ajax : {
	            "url":"/admin/edit/touList.ajax",
	            "type":"POST",
	            "dataType": "json",
	        },  
	        columns: [
	        	//순번
	        	{
	        		data:   "document_ID",
	        	
	            	"render": function (data, type, row, meta) {
	                    return meta.row+1;
	                }
	            },
	            {data:"reg_DT"},
	            //내용
	        	{
	        		data:   "document_ID",
	        	
	            	"render": function (data, type, row, meta) {
	                    return '<label id="'+data+'" onclick="touDetail(this)">이용약관 v'+data+'</label>';
	                }
	            },
	        	{
	        		data:   "document_ID",
	        	
	            	"render": function (data, type, row, meta) {
	            		
	                    return '<a href="/admin/edit/touDownload.ajax?DOCUMENT_ID='+data+'">다운로드</a>';
	                }
	            },
	        	{
	        		data:   "document_ID",
	        	
	            	"render": function (data, type, row, meta) {
	                    return '<input type="button" id="btnDelete" name="'+data+'" value="삭제" onclick="touDelete(this)">';
	                }
	            }
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
	        order: [[ 1, 'asc' ]]
	        ,responsive: true
	       ,language : 'lang_kor' // //or lang_eng
		});
		//테이블 필터 숨기기
		$('#tableList_filter').hide();
		//테이블 액션에 대한 설정
		tbAction("tableList");
	
		//등록 화면 조회
		$("#btnInsert").click(function() {
			location.href="/admin/edit/touInsert.do";
		});
		
	});
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
					<button id="contentInfo" class="nav-link active" role="tab" aria-selected="false" onclick="location.href='/admin/edit/content.do'">컨텐츠 관리 현황</button>
					<button id="companyInfo" class="nav-link" role="tab" aria-selected="false" onclick="location.href='/admin/edit/client.do'">고객사 관리현황</button>
					<button id="billInfo" class="nav-link" role="tab" aria-selected="false" onclick="location.href='/admin/edit/bill.do'">청구서양식 관리현황</button>
				</div>
			</div>
		</div>
		<!-- title end -->
		
		<!-- contents Start ------------------>
		<div id="contents" class="contents-wrap list_ani">
			<!-- work Start -->
			<div id="work" class="work-wrap list_page">
				<div class="title">
					<h3> Editor > 컨텐츠 관리현황 > 이용약관 현황 </h3>
				</div>
	
				<div class="datatable-list-01">
					<div class="page-description">
						<div class="rows">
							<table id="tableList" class="table table-bordered" style="width: 100%;">
								<thead>
									<tr>
										<th>순번</th>
										<th>등록일자</th>
										<th>내용</th>
										<th>다운로드</th>
										<th>삭제</th>
									</tr>
								</thead>
							</table>
						</div>
					</div>
				</div>
				
				<div id="footer" class="footer-wrap">
			        <div id="footer-inner" class="footer-inner">
			            <!-- btn_box Start -->
			            <div class="btn_box">
			                <div class="right">
			                    <button class="btn btn_primary" style="" id="btnInsert" ><span class="langSpan">등록</span></button>
			                </div>
			            </div>
			        </div>
			    </div>
			</div><!-- work -->
		</div><!-- contents -->
	</div><!-- container -->
</body>
</html>