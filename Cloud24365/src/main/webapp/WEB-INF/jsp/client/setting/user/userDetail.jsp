<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title>CLOUD 24 365</title>
	<jsp:include page="/cmn/client/top.do" flush="false" />
<script>
	//이메일 체크
	$(document).ready( function() {
		console.log("사용자 상세");
		var tagId='${data.USER_ID}';
		
		//입력정보 없을시
		blankInput($(".ctn_tbl_td"),"입력정보 없음");
		
		//console.log("상세정보 진입 : "+tagId);
		//목록 버튼 클릭 시
		$("#btnList").click(function(){
			location.href="/client/setting/user/userList.do"; 
		});
		
		//수정 버튼 클릭 시
		$("#btnUpdate").click(function(){
			 location.href="/client/setting/user/userUpdate.do?USER_ID="+tagId; 
		});
		//삭제 버튼 클릭 시
		$("#btnDelete").click(function(){
			if(confirm("선택하신 회원을 삭제하시겠습니까?")==true){
				var idArr=[]; // 회원 id값 배열
				idArr.push(tagId);//배열에 아이디 값 삽입
//				//console.log("보낼 값 : "+ idArr);
				var url="/client/setting/user/userDelete.do";
				var data = {"idArr":idArr};
				var callback= "/client/setting/user/userList.do";
				ajaxMethod(url, data, callback);
    		}
		});//btnDelte

	});//ready

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
		
		<div id="title" class="title-wrap">
			<div class="title-inner">
			</div>
		</div>
		<!-- title end -->
		<!-- contents Start ------------------>
		<div id="contents" class="contents-wrap">
			<!-- work Start -->
			<div id="work" class="work-wrap">
                <!-- contents_box Start -->
                <div id="contents_box" class="contents_box">
                    <!-- 컨텐츠 테이블 헤더 Start -->
                    <div class="ctn_tbl_header">
                        <div class="ttl_ctn">사용자 조회</div><!-- 컨텐츠 타이틀 -->
                        <div class="txt_info"><em class="txt_info_rep">*</em> 표시는 필수 입력 항목입니다.</div><!-- 설명글 -->
                    </div>
                    <!-- 컨텐츠 테이블 헤더 End -->
                    <!-- 컨텐츠 테이블 영역 Start -->
                    <form name="userInsertForm" id="userInsertForm" method="post" enctype="multipart/form-data">
	                    <div class="ctn_tbl_area">
	                        <div class="ctn_tbl_row">
								<div class="ctn_tbl_row">
									<div class="ctn_tbl_th fm_rep">ID</div>
									<div class="ctn_tbl_td">
										${data.USER_ID}
									</div>
								</div>	
							</div>
							
							<div class="ctn_tbl_row">
								<div class="ctn_tbl_th fm_rep">이름</div>
								<div class="ctn_tbl_td">
									${data.USER_NAME}
								</div>
							</div>
							
							<div class="ctn_tbl_row">
								<div class="ctn_tbl_th fm_rep">권한 등급</div>
								<div class="ctn_tbl_td">
									${data.AUTH_NAME}
								</div>
							</div>
	
							<div class="ctn_tbl_row">
								<div class="ctn_tbl_th">직급</div>
								<div class="ctn_tbl_td">
									${data.USER_RANK}
								</div>
							</div>
	
							<div class="ctn_tbl_row">
								<div class="ctn_tbl_th">부서</div>
								<div class="ctn_tbl_td">
									${data.USER_DEPT}				
								</div>
							</div>
							
							<div class="ctn_tbl_row">
								<div class="ctn_tbl_th">전화번호</div>
								<div class="ctn_tbl_td">
									${data.USER_PHONE}	
								</div>
							</div>
	                        
							<div class="ctn_tbl_row">
								<div class="ctn_tbl_th">이메일주소</div>
								<div class="ctn_tbl_td">
									${data.USER_EMAIL}	
								</div>
							</div>
	                    </div>
                    </form>
                </div>
                <!-- contents_box End -->
                
				<div id="footer" class="footer-wrap">
			        <div id="footer-inner" class="footer-inner">
			            <!-- btn_box Start -->
			            <div class="btn_box">
			               	 <div class="right">
								<button  id="btnList"  class="btn">
									<span class="langSpan">목록</span>
								</button>
								<button  id="btnUpdate"  class="btn">
									<span class="langSpan">수정</span>
								</button>
								<button  id="btnDelete"  class="btn">
									<span class="langSpan">삭제</span>
								</button>
							</div>
			            </div>
			            <!-- btn_box End -->
			        </div>
			    </div>
                <!-- footer End ------------------>
            </div>
			<!-- work End -->
        </div>
		<!-- contents End ------------------>
    </div>
    <!-- container End ------------------>
</body>
</html>