/************************************************************************
함수명 : valiChkAll
설 명 : input 태그 등의 파라미터로 사용여부 분기 (허용치가 높은 순으로 파라미터 생성)
인 자 : that(태그 자기 자신),num(숫자),en(영문),kr(한글),ex(특수),sp(공백)
사용법 : 각 파라미터가 0(또는 null) 일때 미사용 1일때 사용
작성일 : 2024-02-11
작성자 : 기술연구소 정다빈
수정일        수정자       수정내용
----------- ------ -------------------
2024-02-11   정다빈       최초작성
************************************************************************/
function valiChkAll(that,num,en,kr,ex,sp){
	//숫자 허용 방지
	if(num!=1){
		that.value=that.value.replace(/[0-9]/g,'');	
	}
	//영문 허용 방지
	if(en!=1){
		that.value=that.value.replace(/[a-zA-Z]/g,'');	
	}
	//한글 허용 방지
	if(kr!=1){
		that.value=that.value.replace(/[ㄱ-ㅎㅏ-ㅡ가-핳]/g,'');	
	}
	//특수 허용 방지
	if(ex!=1){
		that.value=that.value.replace(/[\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"]/gi,'');	
	}
	//공백 허용 방지
	if(sp!=1){
		that.value=that.value.replace(' ','');	
	}
}

//내가 폼기능을 제대로 못 썻기 때문에 뻘짓을 하고있었던 거임 ㅡㅡ
/*이 함수는 등록,수정 폼 구조가 바뀌면 핸들링이 필요해보인다..*/
//특정 부분 div가 필수값으로 체크되어있는지 판별하여
//저장 시 필수값을 체크함
//form : 받아온 폼값 , reqName : 필수값 체크할 id
/*function requireChk(form,reqName){
	var rst = true;
	
	for (var i = 0; i < form.length; i++) {
		//hidden 항목은 유효성 검사 처리를 하지 않음
		if(form[i].type!='hidden'){
			var that = form[i];
			console.log("i : "+i+"	/	form[i] : "+form[i]);
			//체크할 div 요소에 reqName값이 포함되있는지 체크
			var chkDiv=$(that).parent().parent().children().first();
			
			if(typeof $(chkDiv).attr('class') !=="undefined" 
				&& $(chkDiv).attr('class').indexOf(reqName)!=-1 
				&& form[i].value==''
			){
				console.log("필수값입니다");
				alert($(chkDiv).text()+"은(는) 필수값입니다");
				form[i].focus();
				return false;
			}
		}
	}
	return rst;
}*/


/*############################# old #############################*/

/************************************************************************
함수명 : boardWriteCheck
설 명 : 입력정보 null 체크
인 자 : form
사용법 : 로그인 회원가입, 등록 등의 입력정보 체크시 사용
작성일 : 2020-07-30
작성자 : 솔루션사업팀 정다빈
수정일        수정자       수정내용
----------- ------ -------------------
2020.07.30   정다빈       최초작성
************************************************************************/
function boardWriteCheck(form) {
	//특수문자 정규식
	var regExp = /[\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"]/gi;
	
	$(form).find('span').text("");	
	
	for (var i = 0; i < form.length; i++) {
		//id의 경우 6자 이상인지
		if(form[i].name =='USER_ID'){
			if(form[i].value.length<5){
				alert("id 형식이 올바르지 않습니다.");
				form[i].focus();
				return false;
			}
		}
		//pw : (영문 특수문자 포함 8자이상 10자 이하)
		if(form[i].name =='USER_PW' && form[i].value.length >0){
			if(form[i].value.length<8 /*|| !(regExp.test(form[i].value)) */){
				alert("비밀번호 형식이 올바르지 않습니다.");
				form[i].focus();
				return false;
			}
		}
	}
	//확인 비밀번호와 비밀번호가 다를 때
	if($("#USER_PW").val()!=$("#USER_PW2").val()){
		alert("비밀번호가 서로 일치하지 않습니다.");
		return false;
	}
	return true;
}

/************************************************************************
함수명 : onlyNumber
설 명 : 숫자만 입력
인 자 : 
사용법 : 
작성일 : 2020-08-25
작성자 : 솔루션사업팀 정다빈
수정일        수정자       수정내용
----------- ------ -------------------
2020.08.25   정다빈       최초작성
************************************************************************/
function onlyNumber(event){
    event = event || window.event;
    var keyID = (event.which) ? event.which : event.keyCode;
    if ( (keyID >= 48 && keyID <= 57) || (keyID >= 96 && keyID <= 105) || keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 ) 
        return;
    else
        return false;
}

/************************************************************************
함수명 : removeChar
설 명 : 불필요 문자열 제거
인 자 : 
사용법 : 
작성일 : 2020-08-25
작성자 : 솔루션사업팀 정다빈
수정일        수정자       수정내용
----------- ------ -------------------
2020.08.25   정다빈       최초작성
************************************************************************/
function removeChar(event) {
    event = event || window.event;
    var keyID = (event.which) ? event.which : event.keyCode;
    if ( keyID == 8 || keyID == 46 || keyID == 37 || keyID == 39 ){
    	return;
    }else{
    	event.target.value = event.target.value.replace(/[^0-9]/g, "");
    }
}

/************************************************************************
함수명 : telChk
설 명 : 전화번호 체크
인 자 : 
사용법 : 
작성일 : 2020-08-25
작성자 : 솔루션사업팀 정다빈
수정일        수정자       수정내용
----------- ------ -------------------
2020.08.25   정다빈       최초작성
************************************************************************/
function telChk() {
	//부분 전화번호에 하나라도 값 기입시
	if($("#userPhone2").val().length>0 || $("#userPhone3").val().length>0){
		//1,2,3번째가 지정 자리수 이상일때만 값 주입
		if($("#userPhone1").val().length>1 && $("#userPhone2").val().length>2 && $("#userPhone3").val().length>3){
			var phone = $("#userPhone1").val()+"-"+$("#userPhone2").val()+"-"+$("#userPhone3").val();
			$("#userPhone").val(phone);
		}else{
			alert("전화번호 형식이 올바르지 않습니다.");
			return false;
		}
	}else{
		$("#userPhone").val("");
	}
	return true;
}

/************************************************************************
함수명 : spaceChk
설 명 : 공백 및 특수문자를 입력방지해주는 함수(영문,숫자 입력 가능)
인 자 : 
사용법 : 
작성일 : 2020-08-25
작성자 : 솔루션사업팀 정다빈
수정일        수정자       수정내용
----------- ------ -------------------
2020.08.25   정다빈       최초작성
************************************************************************/
function spaceChk(obj){//공백입력방지
	var str_space = /\s/; //공백체크변수선언
	
	//특수문자 정규식
	var regExp = /[\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"]/gi;
	
	if (str_space.exec(obj.value)){ //공백체크
        obj.focus();
        obj.value = obj.value.replace(' ',''); // 공백제거
        return false;	
	}
	//패스워드,시험코드 제외 특수문자 입력 불가
	if(!(obj.name=="USER_PW" || obj.name == "USER_PW2")){
		if(regExp.test(obj.value)){
			obj.focus();
	        obj.value = obj.value.replace(obj.value,''); // 공백제거
	        return false;
		}
	}
	//이름,직급,부서, 회사명의 경우 제외하고 한글입력 불가능
	if(!(obj.name == "USER_NAME" || obj.name == "USER_RANK"|| obj.name == "USER_DEPT")){
		//좌우 방향키, 백스페이스, 딜리트, 탭키에 대한 예외
		if(event.keyCode == 8  || event.keyCode == 9 
		|| event.keyCode == 37 || event.keyCode == 39){
			return false;
		}
		obj.value=obj.value.replace(/[ㄱ-ㅎㅏ-ㅡ가-핳]/g,'');
	}
}


/************************************************************************
함수명 : schChkKey
설 명 : 검색 값 유효성 검사
인 자 : 
사용법 : 
작성일 : 2020-08-30
작성자 : 솔루션사업팀 정다빈
수정일        수정자       수정내용
----------- ------ -------------------
2020.08.30   정다빈       최초작성
*************************************************************************/
function schChkKey(that,schFlag){
	console.log("id조회");
	var sndUrl='';
	var dat;
	//키워드가 무엇인지 판별
	var schId= $(that).attr("name").split("_")[1];
	//텍스트에 값을 입력 안했다면
	if(schId!="empCode" && $(that).parent().children().first().val()==""){
		$(that).parent().parent().children().last().css("color","red");
		$(that).parent().parent().children().last().text("값을 입력해주세요");
	}else{
		//검색버튼이 2개이상일때는 어디로 보낼지 값이 무엇인지 분기처리
		if(schId=="userId"){
			sndUrl="/user/findUserId.ajax";
			dat={"USER_ID":$(that).parent().children().first().val()};
			
			var schData=ajaxMethod(sndUrl, dat);
			//id일 경우는 값이 없을때 사용가능하고 시험코드는 값이 있을때 사용가능함
			if(schData == "" || typeof schData.data === "undefined"){//db에 값 미존재
				$(that).parent().parent().children().last().css("color","blue");
				$(that).parent().parent().children().last().text("사용 가능한 id입니다.");
				schFlag=true;
			}else{//db에 값 존재0
				$(that).parent().parent().children().last().css("color","red");
				$(that).parent().parent().children().last().text("이미 사용중인 id입니다.");
				schFlag=false;
			}
		}
	}
	return schFlag;
}
