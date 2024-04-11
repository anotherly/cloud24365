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


<script>
	var updUrl="/admin/client/companyUpdate.do";
	var delUrl="/admin/client/companyDelete.ajax";
	var delbak="/admin/client/companyList.do";
	
	$(document).ready( function() {
		
		console.log("운영지표 목록 화면 진입");
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
					<button class="nav-link active" role="tab" aria-selected="false">운영지표</button>
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
            <!-- 컨텐츠 테이블 영역 Start -->
			<div class="ctn_tbl_area" style="padding:20px;">
				<div class="title">
					<h3>계약 현황(고객수)</h3>
				</div>
				<div class="ctn_tbl_row">
					<div class="ctn_tbl_th">
						<span class="langSpan">전체</span>
					</div>
					<div class="ctn_tbl_td">
						${cmsVo.SVC_ALL}
					</div>
					
					<div class="ctn_tbl_th">
						<span class="langSpan">서비스 중</span>
					</div>
					<div class="ctn_tbl_td">
						${cmsVo.SVC_NOW}
					</div>
					
					<div class="ctn_tbl_th">
						<span class="langSpan">서비스 종료</span>
					</div>
					<div class="ctn_tbl_td">
						${cmsVo.SVC_END}
					</div>
					<div class="ctn_tbl_th" style="background:#fff;"></div>
					<div class="ctn_tbl_td"></div>
				</div>
				<div class="title">
					<h3>매출 현황</h3>
				</div>
				<div class="ctn_tbl_row">
					<div class="ctn_tbl_th">
						<span class="langSpan">전체</span>
					</div>
					<div class="ctn_tbl_td">
						${cmsVo.SVC_ALL}
					</div>
					
					<div class="ctn_tbl_th">
						<span class="langSpan">MSP</span>
					</div>
					<div class="ctn_tbl_td">
						${cmsVo.SVC_NOW}
					</div>
					
					<div class="ctn_tbl_th">
						<span class="langSpan">IaaS</span>
					</div>
					<div class="ctn_tbl_td">
						${cmsVo.SVC_END}
					</div>
						
					<div class="ctn_tbl_th">
						<span class="langSpan">Service (dataDR)</span>
					</div>
					<div class="ctn_tbl_td">
						${cmsVo.SVC_END}
					</div>
				</div>
				<div class="title">
					<h3>고객 분류(고객수)</h3>
				</div>
				<div class="ctn_tbl_row">
					<div class="ctn_tbl_th">
						<span class="langSpan">전체</span>
					</div>
					<div class="ctn_tbl_td">
						${cmsVo.SVC_ALL}
					</div>
					
					<div class="ctn_tbl_th">
						<span class="langSpan">서비스 중</span>
					</div>
					<div class="ctn_tbl_td">
						${cmsVo.SVC_NOW}
					</div>
					
					<div class="ctn_tbl_th">
						<span class="langSpan">서비스 종료</span>
					</div>
					<div class="ctn_tbl_td">
						${cmsVo.SVC_END}
					</div>
					<div class="ctn_tbl_th" style="background:#fff;"></div>
					<div class="ctn_tbl_td"></div>
				</div>
				
				<div class="ctn_tbl_row">
					<div class="ctn_tbl_th">
						<span class="langSpan">전체</span>
					</div>
					<div class="ctn_tbl_td">
						${cmsVo.SVC_ALL}
					</div>
					
					<div class="ctn_tbl_th">
						<span class="langSpan">MSP</span>
					</div>
					<div class="ctn_tbl_td">
						${cmsVo.SVC_NOW}
					</div>
					
					<div class="ctn_tbl_th">
						<span class="langSpan">IaaS</span>
					</div>
					<div class="ctn_tbl_td">
						${cmsVo.SVC_END}
					</div>
						
					<div class="ctn_tbl_th">
						<span class="langSpan">Service (dataDR)</span>
					</div>
					<div class="ctn_tbl_td">
						${cmsVo.SVC_END}
					</div>
				</div>
				
				<div class="title">
					<h3>VM 사용량 현황</h3>
				</div>
				<div class="ctn_tbl_row">
					<div class="ctn_tbl_th">
						<span class="langSpan">전체</span>
					</div>
					<div class="ctn_tbl_td">
						${cmsVo.SVC_ALL}
					</div>
					
					<div class="ctn_tbl_th">
						<span class="langSpan">서비스 중</span>
					</div>
					<div class="ctn_tbl_td">
						${cmsVo.SVC_NOW}
					</div>
					
					<div class="ctn_tbl_th">
						<span class="langSpan">서비스 종료</span>
					</div>
					<div class="ctn_tbl_td">
						${cmsVo.SVC_END}
					</div>
					<div class="ctn_tbl_th" style="background:#fff;"></div>
					<div class="ctn_tbl_td"></div>
				</div>
				
             </div>   
				<!-- grid_box End -->
					
				<div id="footer" class="footer-wrap">
			        <div id="footer-inner" class="footer-inner">
			            <!-- btn_box Start -->
			            <div class="btn_box">
			                <div class="right"></div>
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