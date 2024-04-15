/*var timeRefresh=null;
var pastSide="";//이전 사이드바 메뉴
*/
/************************************************************************
함수명 : ajaxMethod
설 명 : ajax 처리 함수 
인 자 : url(컨트롤러에 매핑된 주소), data(전송 값), 
	   callback(ajax 통신 후 이동 주소), 
	   message(전송 성공 시 메시지)
사용법 : 화면에서 서버로 ajax통신으로 값 전송시 사용
작성일 : 2020-07-30
작성자 : 솔루션사업팀 정다빈
수정일        수정자       수정내용
----------- ------ -------------------
2020.07.30   정다빈       최초작성
************************************************************************/
function ajaxMethod(url, data, callback, message,thDiv){
	var output = new Array();
	$.ajax({
		url : url,
		type : "post",
		dataType : "json",
		data : data,
		/*ajax는 비동기 식이지만 함수형태로 호출 시 success 이전에 
		*화면이 구성되어 값을 제대로 전송받지 못함
		*함수로 호출할 경우 false로 지정
		*/
		async : false,
		success : function(json) {
//			//console.log("아작스 서버 연동 성공");
//			//console.log(json);
//			//console.log(json.msg);
			if(json.msg=="" || typeof json.msg ==="undefined"){//서버 단에서 에러가 없을 경우
				if(message!="" && typeof message !== "undefined"){//에러는 아니지만 전달메시지가 있을경우
					alert(message);
				}
				//콜백 화면 이동 : div 값 변경일경우 사용
				//주소 자체 이동, body 전체 화면 변환일경우 수정 필요
				if(callback!="" && typeof callback!=="undefined"){
					if(callback=="goback"){
						history.go(-1);
					}else{
						location.href=callback;
					}
				}
			}else{
				//검색 결과가 없는 것이라면
				if(json.msg=="search_not"){
					json="";
				}else{
					alert(json.msg);
				}
			}
			output = json;
		},
		error : function() {
			//console.log("에러가 발생하였습니다.");
		},
		//finally 기능 수행
		complete : function() {

		}
	});
	return output;
}

/************************************************************************
함수명 : authAjax
설 명 : ajax 데이터 연동시 권한처리
인 자 : url(컨트롤러에 매핑된 주소), data(전송 값), 
	   callback(ajax 통신 후 이동 주소), 
	   message(전송 성공 시 메시지)
사용법 : 화면에서 서버로 ajax통신으로 값 전송시 사용
작성일 : 2020-07-30
작성자 : 솔루션사업팀 정다빈
수정일        수정자       수정내용
----------- ------ -------------------
2020.07.30   정다빈       최초작성
 ************************************************************************/
function authAjax(url, data, callback, message,thDiv){
	$.ajax({
		url: url,
		type: "POST",
		dataType: "json",
		data: data,
		// ajax 통신 성공 시 로직 수행
		success: function(json){
			if(json.msg=="" || typeof json.msg ==="undefined"){
				alert("정상 처리 되었습니다");
				
				if(callback!="" && typeof callback!=="undefined"){
					if(callback=="goback"){
						history.go(-1);
					}else{
						location.href=callback;
					}
				}
				
			}else{
				alert(json.msg);
			}
		},
		error : function() {
			alert("권한이 없습니다");
		},
		//finally 기능 수행
		complete : function() {
			console.log("파이널리.");
		}
	});
}

/************************************************************************
함수명 : blankInput
설 명 : 공백 처리 함수
인 자 : tag(공백을 가지고 있는 태그 요소들), cont(쓸 내용), 
	   callback(ajax 통신 후 이동 주소), 
	   message(전송 성공 시 메시지)
사용법 : 화면에서 서버로 ajax통신으로 값 전송시 사용
작성일 : 2020-07-30
작성자 : 솔루션사업팀 정다빈
수정일        수정자       수정내용
----------- ------ -------------------
2020.07.30   정다빈       최초작성
************************************************************************/
function blankInput(tag,cont){
	console.log("공백항목 체크");
	$(tag).each(function(i,list){
		if(list.innerText==''&& $(list).children().length==0 ){
			$(list).text(cont);
		}
	});
}

/************************************************************************
함수명 : reloadOrKill
설 명 : ajax 처리 함수 
인 자 : url(컨트롤러에 매핑된 주소), data(전송 값), 
	   callback(ajax 통신 후 이동 주소), 
	   message(전송 성공 시 메시지)
사용법 : 화면에서 서버로 ajax통신으로 값 전송시 사용
작성일 : 2020-07-30
작성자 : 솔루션사업팀 정다빈
수정일        수정자       수정내용
----------- ------ -------------------
2020.07.30   정다빈       최초작성
************************************************************************/
/*function reloadOrKill(isClose){
	//console.log("reloadOrKill 커먼 메소드 진입");
	ajaxMethod('/user/reloadOrKill.do',{"tagId":isClose});
}*/

/************************************************************************
함수명 : goMenuSite
설 명 : 메뉴 관련 항목 페이지 이동 
인 자 : 
사용법 : 
작성일 : 2020-07-30
작성자 : 솔루션사업팀 정다빈
수정일        수정자       수정내용
----------- ------ -------------------
2020.07.30   정다빈       최초작성
************************************************************************/
function goMenuSite(goUrl,thDiv){
	$.ajax({
		url: goUrl,
		type: "POST",
		async : false,
		// ajax 통신 성공 시 로직 수행
		success: function(json){
			console.log("성공");
			if(json==""){
				alert("권한이 없습니다");
				return false;
			}else{
				//서버측으로 부터 받은 별도의 에러메시지가 없을 경우 화면 이동
				if(json.msg=="" || typeof json.msg ==="undefined"){
					console.log("url 이동");
					location.href=goUrl;
				}else{
					alert(json.msg);
				}
			}
		},
		error : function(json) {
			console.log("에러가 발생하였습니다."+json.msg);
		},
		//finally 기능 수행
		complete : function(json) {
			console.log("파이널리.");
		}
	});
    
}



/************************************************************************
함수명 : chkArrValiF
설 명 : 체크박스 배열내 선택 구별 함수
인 자 : 
사용법 : 
작성일 : 2020-08-19
작성자 : 솔루션사업팀 정다빈
수정일        수정자       수정내용
----------- ------ -------------------
2020.08.19   정다빈       최초작성
************************************************************************/
function chkArrValiF(objArr,chkVal){
	for(var i =0;i<objArr.length;i++){
		if(chkVal==objArr[i]){
			return false;
		}
	}
	return true;
}

/*파일 업로드 또는 다운로드 시*/
/**
 * 사진 등록 또는 변경 시
 */
function changePicture(obj){
	console.log("사진 등록 또는 변경 시");
	$(obj).parent().children().first().val((obj.val()).replace("C:\\fakepath\\", ""));
}


