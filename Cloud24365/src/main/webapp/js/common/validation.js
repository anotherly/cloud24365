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


/************************************************************************
함수명 : pwReg
설 명 : 비밀번호 정규식(유효성 검사)
인 자 : pwVal(받아온 비밀번호 값)
사용법 : 비밀번호 형식 체크할 때
(형식 달라질 때마다 정규식 핸들링 필요)
작성일 : 2024-04-08
작성자 : 기술연구소 정다빈
수정일        수정자       수정내용
----------- ------ -------------------
2024-04-08   정다빈       최초작성
************************************************************************/
function pwReg(inputVal){
	var rst=true;
	let reg = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,15}$/;
	if( !reg.test(inputVal) ) {
		alert("비밀번호 형식에 위배됩니다.(영문+특수+숫자 8~15자)");
		rst= false;
		return rst;
	}
	return rst;
}

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
function idPwChk(form) {
	var rst=true;
	
	//특수문자 정규식
	var regExp = /[\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"]/gi;
	
	for (var i = 0; i < form.length; i++) {
		//pw : (영문 특수문자 포함 8자이상 10자 이하)
		if(form[i].name =='USER_PW' && form[i].value != ''){
			if(!pwReg(form[i].value)){
				form[i].focus();
				rst= false;
				return rst;
			}
		}
	}
	//확인 비밀번호와 비밀번호가 다를 때
	if($("#userPw1").val()!=$("#userPw2").val()){
		alert("비밀번호가 서로 일치하지 않습니다.");
		rst= false;
		return rst;
	}
	return rst;
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
	var rst=true;
	//부분 전화번호에 하나라도 값 기입시
	if($("#userPhone2").val().length>0 || $("#userPhone3").val().length>0){
		//1,2,3번째가 지정 자리수 이상일때만 값 주입
		if($("#userPhone1").val().length>1 && $("#userPhone2").val().length>2 && $("#userPhone3").val().length>3){
			var phone = $("#userPhone1").val()+"-"+$("#userPhone2").val()+"-"+$("#userPhone3").val();
			$("#userPhone").val(phone);
		}else{
			alert("전화번호 형식이 올바르지 않습니다.");
			rst=false;
			return rst;
		}
	}else{
		$("#userPhone").val("");
	}
	return rst;
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
인 자 : 사용자 id를 입력받는 텍스트박스의 name값, 1 : alert창 띄울지말지 여부
사용법 : 
작성일 : 2020-08-30
작성자 : 솔루션사업팀 정다빈
수정일        수정자       수정내용
----------- ------ -------------------
2020.08.30   정다빈       최초작성
2024.04.08   정다빈       기능에 맞게 재작성
*************************************************************************/
function schChkKey(tagName,alt){
	var rst=true;
	
	var inputVal = $("input[name="+tagName+"]").val();
	
	if(inputVal==''){
		alert("항목을 입력해 주세요");
	}else{
		if(inputVal.length<6){//길이체크
			alert("id는 6자 이상으로 작성바랍니다");
		}else{
			var sndUrl="/user/findUserId.do";
			//json 키값에 파라미터 동적 할당
			const jsonKey = tagName;
			const jsonData = { [jsonKey]: inputVal}; //ex-> {'USER_ID' : '밸류값'}
			
			var schData=ajaxMethod(sndUrl, jsonData);
			
			//id일 경우는 값이 없을때 사용가능하고 시험코드는 값이 있을때 사용가능함
			if(schData == "" || typeof schData.data === "undefined"){//db에 값 미존재
				if(typeof alt !=="undefined" && alt !=''){
					alert("사용 가능한 id입니다.");
				}
				rst=true;
				return rst;
			}else{//db에 값 존재
				alert("이미 사용중인 id입니다.");
				rst=false;
				return rst;
			}
		}

	}
	

	return rst;
}
