//고객사 이미지 목록에 쓰임
function imgTable(alData,num){
	for (var i = 0; i < alData.length; i++) {
		var backName="";
		if(i==0){
			oldName=alData[i].teamName;
		}
		/*공백처리안함*/
		//배경 선택
		backName=selectBackgra(alData[i].teamName,alData[i].obsCount);
		//td 내부 만듬
		tbM+= tdCreate(alData[i].lteRIp,backName,alData[i].lteRUsed); 
		tbCnt++;
		//7열 초과시 줄바꿈
		if(parseInt((enterLine)%num)==0){
			var tbCont = "<tr id='tr"+trCnt+"'>"+tbM+"</tr>";
			$("#lteTbd").append(tbCont);	
			tbM="";
			trCnt++;
		}else{
			//데이터의 마지막
			if(i==alData.length-1){
				//행을 생성
				trCreate();
			}
		}
		enterLine++;
	}
}


function ansHistoryList(tagId){
	console.log("tagId : "+tagId);
	//먼저 문의id 파라미터 받아서 
	//해당 문의에 대한 답변리스트 가져온다
	//그 답변리스트 각각에 대한 파일리스트를 가져온다
	var dataList = ajaxMethod('/request/ansHistoryList.ajax',{"REQ_ID":tagId});
	var ansList = dataList.ansList;
	var fileList = dataList.fileList;
	
	//데이터가 존재할 경우
	if(ansList.length!=0){
		$("#ansHistory").show();
		
		for (var i = 0; i < ansList.length; i++) {
			var ansContents='';
			ansContents+=
				'<div class="ctn_tbl_row">'
				    +'<div class="ctn_tbl_th">답변일자</div>'
				    +'<div class="ctn_tbl_td">'+ansList[i].ANS_DT+'</div>'
				    +'<div class="ctn_tbl_th">답변자</div>'
				    +'<div class="ctn_tbl_td">'+ansList[i].USER_NAME+'</div>'
				    +'<div class="ctn_tbl_th">별첨파일</div>'
				    +'<div class="ctn_tbl_td" id="ansFileList_'+ansList[i].ANS_ID+'"></div>'
			+'</div>'
			/*;	    
	    	for (var j = 0; j < fileList.length; j++) {
	    		ansContents+='<a href="/download.ajax?FILE_ID='+fileList[j].FILE_ID+'">'+fileList[j].FILE_NAME+'</a>';
			}
				    
	    	ansContents+=*/
				+'<div class="ctn_tbl_row">'
					+'<div class="ctn_tbl_th">답변내용</div>'
				    +'<div class="ctn_tbl_td">'
				      	+'<textarea id="REQ_ANSWER" class="long-cont" style="height:200px;" readonly>'+ansList[i].REQ_ANSWER+'</textarea>'
				    +'</div>'
				+'</div>'
			;
			$("#ansList").append(ansContents);
			
			for (var j = 0; j < fileList.length; j++) {
				if(ansList[i].ANS_ID == fileList[j].file_ORIGIN){
					var fileCont ='<a href="/download.ajax?FILE_ID='+fileList[j].file_ID+'">'+fileList[j].file_NAME+'</a>';
		    		$("#ansFileList_"+ansList[i].ANS_ID).append(fileCont);
				}
			}
		}
	}
	return ansList.length;
}

function loadFaq(){
	console.log("간추린 faq");
	//먼저 문의id 파라미터 받아서 
	//해당 문의에 대한 답변리스트 가져온다
	//그 답변리스트 각각에 대한 파일리스트를 가져온다
	var dataList = ajaxMethod('/client/support/faq/faqList.ajax');
	var ansList = dataList.data;
	
	//데이터가 존재할 경우
	if(ansList.length!=0){
		$("#ansHistory").show();
		
		for (var i = 0; i < ansList.length; i++) {
			var ansContents='';
			if(i<5){
				ansContents+=
					'<div class="ctn_tbl_row" style="display: flex;flex-direction: column;">'
					+'<div class="ctn_tbl_row">'
					    +'<div class="ctn_tbl_td">'
					    	+ansList[i].faq_TITLE
					    	+'<span id="faq_show" class="show_hide" value="'+[i]+'">펼치기 ▼</span>'
					    	+'<span id="faq_hide" class="show_hide" value="'+[i]+'" style="display:none;">접기 ▲</span>'
					    +'</div>'
					+'</div>'
					+'<div class="ctn_tbl_row"  id="FAQ_ANSWER"  value="'+[i]+'" style="display:none;">'
					    +'<div class="ctn_tbl_td">'
					      	+'<textarea id="CONTENT" class="long-cont" style="height:200px;" disabled>'+ansList[i].content+'</textarea>'
					    +'</div>'
					+'</div>'
				+'</div>'
				;
				$("#faqDiv").append(ansContents);
			}else{
				return;
			}
		}
	}
	return;
}
