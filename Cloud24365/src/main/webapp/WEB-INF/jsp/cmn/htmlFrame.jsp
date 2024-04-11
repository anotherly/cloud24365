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
				   <form action="#" method="post" id="searchFrm" onsubmit="return false;" class="search_form">
				   </form>
				   <div class="search_btn">
					   <button class="btn btn_sch btn_primary" id='btnSearch' onclick="search();" ><i class="ico_sch"></i><span class="langSpan">조회</span></button>
					   <!-- <button class="btn btn_reset"><i class="ico_reset"></i><span class="langSpan">초기화</span></button> -->
				   </div>
				</div>
                <!-- search_box End -->
                
                <!-- grid_box Start -->
				<!-- grid_box End -->
					
				<div id="footer" class="footer-wrap">
			        <div id="footer-inner" class="footer-inner">
			            <!-- btn_box Start -->
			            <div class="btn_box">
			                <div class="right">
			                	<button class="btn btn_primary" style="" id="btnInsert" data-term="L.등록" title="등록"><span class="langSpan">등록</span></button>
				                    <button class="btn" style="" id="btnUpdate" data-term="L.등록" title="등록" onclick='tbUpdate(this,updUrl)'><span class="langSpan">수정</span></button>
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