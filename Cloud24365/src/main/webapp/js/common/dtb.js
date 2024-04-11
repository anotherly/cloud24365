var lang_kor;
var lang_eng;
/************************************************************************
함수명 : tbSearch
설 명 : 검색결과에 따른 테이블 갱신
인 자 : tbId(테이블 id),url(이동할 주소), frm(검색 폼 데이터)
사용법 :  
작성일 : 2023-08-24
작성자 : 기술연구소 정다빈
수정일        수정자       수정내용
----------- ------ -------------------
2023.08.24   정다빈       최초작성
************************************************************************/
function tbSearch(tbId,tagUrl,frm){
	 $.ajax({
			url : tagUrl,
			type : "post",
			dataType : "json",
			data : frm,
			async : false,
			success : function(json) {
				console.log("데이터테이블 검색 성공");
				
				if(json.data.length != 0){
					//성공시 테이블 갱신하고 신규 데이터 생성
					$("#"+tbId).dataTable().fnClearTable();//갱신
					$('#'+tbId).dataTable().fnAddData(json.data);//데이터 적용
				}else{
					$("#"+tbId).dataTable().fnClearTable();//갱신
				}
			},
			error : function(e) {
				alert("검색 시 오류가 발생했습니다 : "+e);
			},
			complete : function() {

			}
	 });
}


/************************************************************************
함수명 : tbUpdate
설 명 : 수정 기능 함수(동적 버튼)
인 자 : that(테이블 this), paramUrl(이동할 주소)
사용법 : 3번째 파라미터에 vo를 직접 받아올려했더니 그냥 객체의 속성값이
key로 고정되어버림 ㅡㅡ 그래서 그냥 분기처리를 해야할듯
작성일 : 2020-08-24
작성자 : 솔루션사업팀 정다빈
수정일        수정자       수정내용
----------- ------ -------------------
2020.08.24   정다빈       최초작성
************************************************************************/
function tbUpdate(that,paramUrl,key){
	var tagId;
	var cnt = $('input:checkbox[name="chk"]:checked').length;
	if($('input:checkbox[name="chk"]:checked').length==0){
		alert("수정할 항목을 선택해 주세요");
	}else if($('input:checkbox[name="chk"]:checked').length!=1){
		alert("수정할 항목을 하나만 선택해 주세요");
	}else{
		for(i=0;i<$("tbody tr").length;i++){
			if($("#chk"+i).is(":checked")){
				tagId = $("#chk"+i).val();
			}
		}
		//사용하는 vo에 따른 분기처리
		//향후 개선이 필요함...함수자체적으로
		//걍 여기서 리턴값을 tagId로 넘겨서 화면에서 처리할것인지
		//이거근데 암만생각해도 미개한 방법인데 ㅡㅡ
		if(paramUrl.indexOf("user")!=-1){
			$("#work").load(paramUrl,{"USER_ID":tagId});
		}
		if(paramUrl.indexOf("company")!=-1){
			$("#work").load(paramUrl,{"COMPANY_ID":tagId});
		}
		if(paramUrl.indexOf("notice")!=-1){
			$("#work").load(paramUrl,{"NOTICE_ID":tagId});
		}
		if(paramUrl.indexOf("request")!=-1){
			$("#work").load(paramUrl,{"REQ_ID":tagId});
		}
		if(paramUrl.indexOf("faq")!=-1){
			$("#work").load(paramUrl,{"FAQ_ID":tagId});
		}
		if(paramUrl.indexOf("report")!=-1){
			$("#work").load(paramUrl,{"REPORT_ID":tagId});
		}
	}
}


/************************************************************************
함수명 : tbDelete
설 명 : 삭제 기능 함수(동적 버튼)
인 자 : that(테이블 this), paramUrl(이동할 주소)
사용법 : 
작성일 : 2020-08-24
작성자 : 솔루션사업팀 정다빈
수정일        수정자       수정내용
----------- ------ -------------------
2020.08.24   정다빈       최초작성
************************************************************************/
function tbDelete(that,paramUrl,callback,tb){
	var idArr=[]; 

	for(i=0;i<$("tbody tr").length;i++){
		if($("#chk"+i).is(":checked")){
			idArr.push($("#chk"+i).val());//배열에 아이디 값 삽입
		}
	}
	if(typeof idArr.length==="undefined" || idArr.length==0){
		alert("삭제할 항목을 선택해 주세요");
	}else{
		if(confirm("선택하신 항목을 삭제하시겠습니까?")==true){
			var url=paramUrl;
			var data = {"idArr":idArr};
			ajaxMethod(url, data, callback);
			chkArr=[];
		}
	}
}


/************************************************************************
함수명 : calculDate
설 명 : 삭제 기능 함수(동적 버튼)
인 자 : idx(날짜가 존재하는 칼럼)
사용법 : 
작성일 : 2020-08-24
작성자 : 솔루션사업팀 정다빈
수정일        수정자       수정내용
----------- ------ -------------------
2020.08.26   정다빈       최초작성
************************************************************************/
function calculDate(){
	console.log("계산함수 들어옴 idx : "+iidx);
	$.fn.dataTable.ext.search.push(
        function(settings, data, dataIndex){
            var min = Date.parse($('#fromDate').val()+" 00:00:00");
            var max = Date.parse(moment($('#toDate').val()).add(1,'days').format('YYYY-MM-DD'))
            var targetDate = Date.parse(data[iidx]);

            if( (isNaN(min) && isNaN(max) ) || 
                (isNaN(min) && targetDate <= max )|| 
                ( min <= targetDate && isNaN(max) ) ||
                ( targetDate >= min && targetDate <= max) ){ 
                    return true;
            }
            return false;
        }
    )
}

function dtTbSetting(){
 
    // DataTables Default
    lang_eng = {
        "decimal" : "",
        "emptyTable" : "No data available in table",
        "info" : "Showing _START_ to _END_ of _TOTAL_ entries",
        "infoEmpty" : "Showing 0 to 0 of 0 entries",
        "infoFiltered" : "(filtered from _MAX_ total entries)",
        "infoPostFix" : "",
        "thousands" : ",",
        "lengthMenu" : "Show _MENU_ entries",
        "loadingRecords" : "Loading...",
        "processing" : "Processing...",
        "search" : "Search : ",
        "zeroRecords" : "No matching records found",
        "paginate" : {
        	 "first" : "<<",
             "last" : ">>",
             "next" : ">",
             "previous" : "<"
        },
        "aria" : {
            "sortAscending" : " :  activate to sort column ascending",
            "sortDescending" : " :  activate to sort column descending"
        }
    };
 
    // Korean
    lang_kor = {
        "decimal" : "",
        "emptyTable" : "데이터가 없습니다.",
        "info" : "_START_ - _END_ (총 _TOTAL_ 행)",
        "infoEmpty" : "0행",
        "infoFiltered" : "(전체 _MAX_ 행 중 검색결과)",
        "infoPostFix" : "",
        "thousands" : ",",
        "lengthMenu" : "_MENU_ 개씩 보기",
        "loadingRecords" : "로딩중...",
        "processing" : "처리중...",
        "search" : "검색 : ",
        "zeroRecords" : "검색된 데이터가 없습니다.",
        "paginate" : {
            "first" : "<<",
            "last" : ">>",
            "next" : ">",
            "previous" : "<"
        },
        "aria" : {
            "sortAscending" : " :  오름차순 정렬",
            "sortDescending" : " :  내림차순 정렬"
        }
    };
}



function tbAction(tbId){

	//테이블 필터 숨기기
	$('#'+tbId+'_filter').hide();

	//체크박스 클릭 시 이벤트
	$("#"+tbId).on("click", 'input:checkbox', function() {
		chkBoxFunc(this);
	});
	//마우스 올릴시 
	$("#"+tbId).on("mouseenter", "tbody tr", function(){
		$(this).addClass('active');
	});
	//마우스 내릴시
	$("#"+tbId).on("mouseleave", "tbody tr", function(){
		$(this).removeClass('active');
	});
	
	//체크박스영역 제외 마우스 올릴시 포인터로
	$("#"+tbId).on("mouseleave", "tbody td:not(':first-child')", function(){
		$(this).css('cursor','pointer');
	});
	
	//페이지 이동이나 열 개수 변경시 전체체크박스 관련 이벤트
	$("#"+tbId).on('draw.dt', function(){
		//console.log("데이터테이블 값 변경");
		//인덱스 번호 재설정
		$('#tableList input:checkbox[name="chk"]').each(function(i,list) {
			$(this).attr("id","chk"+i)
		});
		
		if($('input:checkbox[name="chk"]:checked').length==$("tbody tr").length){
    		$("#chkAll").prop("checked", true);
    	}else{
    		$("#chkAll").prop("checked", false);
    	}
	});
}


/************************************************************************
함수명 : chkBoxFunc
설 명 : 테이블 내 체크박스 관련 이벤트 처리
인 자 : 테이블(this)를 받음(that으로)
사용법 : 체크박스 선택 시 이벤트
		(id가 chk는 일반 체크박스 chkAll은 전체 체크박스임)
작성일 : 2020-08-17
작성자 : 솔루션사업팀 정다빈
수정일        수정자       수정내용
----------- ------ -------------------
2024.01.29   정다빈       데이터 테이블 처리 js로 이동
************************************************************************/
function chkBoxFunc(that){
	var chkId=$(that).attr("id");
	var chkVal=$(that).val();
	var temp =[];//지금 체크한 체크박스에 관한 배열
	console.log("tbody의 체크된 체크박스 수 : "+$('input:checkbox[name="chk"]:checked').length);
	//클릭한게 전체선택일 경우
	if(chkId=="chkAll"){
		//console.log("전체선택");
		//체크된 경우
		if ($("#chkAll").is(":checked")){
			//console.log("전체 체크박스 선택됨");
			//console.log("현재 페이지 넘버 : ");
			//하위 체크박스들도 모두 선택
			$("tbody input:checkbox").prop("checked", true);
			
		}else{//선택->취소 : 전체 체크 해지시
			//console.log("전체 체크박스 해지됨");
		    $("tbody input:checkbox").prop("checked", false);
		}
		 
	}else{//단일 선택일 경우
//		console.log("단일체크박스 클릭"+$(that).val());
//		console.log("@@@체크된 값들 길이: "+$('input:checkbox[name="chk"]:checked').length);
//		console.log("@@@tbody 길이: "+$("tbody tr").length);
		//단일선택->전체
		if($('input:checkbox[name="chk"]:checked').length==$("input:checkbox[name='chk']").length){
    		$("#chkAll").prop("checked", true);
    	}else{//단일해지->전체해지
    		$("#chkAll").prop("checked", false);
    	}
		if($(that).is(":checked")){//체크박스가 체크된 경우
			//console.log("단일선택"+$(that).val());
		}else{//체크 해지된 경우
			//console.log("단일해지"+$(that).val());
			
		}
	}
	
}



//파라미터로 받아온 테이블에 행(tr)을 추가
function addTr(table,that){
	console.log(table);
	var trList = $('table tbody tr');
	var ansContents=$(trList).eq($(trList).length-2);
	var tdClone = ansContents.clone(true);
	//추가 버튼 위에있는 행을 !복제!한다
	//-> 기존 존재하는 tr을 그냥 before append 등 한다면
	//기존거 위치가 바뀌는 거임
	
	if($(tdClone).children().find('#trDelete').length==0){
		$(tdClone).children(":last").append('<div class="btn" style="width: 75px;background: #f5f5f5;font-weight: bold;" id="trDelete" onclick=addTrDelete(this)><span class="langSpan"> X </span></div>');
	}
	$(that).before(tdClone);
}

//추가된 행을 삭제할 경우
function addTrDelete(that){
	console.log("that : "+that);
	var inputTr = $(that).parent().parent();
	$(inputTr).remove();
}

//삭제됬을때 인덱스값이 변경될 경우 등을 대비하여
//저장전에 행추가 테이블 인덱스 맞추는 역할
function mspListVo(table){
	$("table tbody tr:not(':last-child')").each(function(i,list){//tr 조회
		console.log("i : "+i);
		console.log("list : "+list);
		
		//구매 개수가 0또는 빈칸이거나
		//서비스를 선택하지 않은 경우는 컨트롤러로 보내주지 않음
		if( $(list).children().find('#CLOUD_TYPE').val()==''
			||$(list).children().find('#BUY_CNT').val()==''
			||$(list).children().find('#BUY_CNT').val()==0
		){
			$(list).children().find('#COMPANY_ID').attr('name',"");
			$(list).children().find('#CLOUD_TYPE').attr('name',"");
			$(list).children().find('#SERVICE_TYPE').attr('name',"");
			$(list).children().find('#BUY_CNT').attr('name',"");
		}else{
			$(list).children().find('#COMPANY_ID').attr('name',"mspList["+i+"].COMPANY_ID");
			$(list).children().find('#CLOUD_TYPE').attr('name',"mspList["+i+"].CLOUD_TYPE");
			$(list).children().find('#SERVICE_TYPE').attr('name',"mspList["+i+"].SERVICE_TYPE");
			$(list).children().find('#BUY_CNT').attr('name',"mspList["+i+"].BUY_CNT");
		}
	});
	$("#inputMspList").val(mspList);
	return mspList;
}


