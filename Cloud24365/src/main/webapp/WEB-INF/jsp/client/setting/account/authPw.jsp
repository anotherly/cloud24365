<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title>CLOUD 24 365</title>
	<jsp:include page="/cmn/top.do" flush="false" />
 	<!-- Custom style -->
	<link rel="stylesheet" href="<%=request.getContextPath()%>/css/svc.css">

	<!-- JS -->
	<script src="<%=request.getContextPath()%>/js/jquery.js"></script>
	<script src="<%=request.getContextPath()%>/js/jquery.migrate.js"></script>

	<!-- 로그인 시큐어코딩 관련 -->
	<script src="<%=request.getContextPath()%>/js/loginSC/login.js"></script>
	<script src="<%=request.getContextPath()%>/js/common/validation.js"></script>
 	 
	<script>
		$(document).ready(function() {
			console.log("비밀번호 인증 페이지");
			
			
			$("#loginForm").submit( function(event){
				event.preventDefault();
				// serialize는 form의 <input> 요소들의 name이 배열형태로 그 값이 인코딩되어 URL query string으로 하는 메서드
				let queryString = $(this).serialize();
				//id,pw,전화번호 체크
				//if(boardWriteCheck(form)){
					$.ajax({
						url: "/client/setting/account/chkPw.do",
						type: "POST",
						dataType: "json",
						data: queryString,
						// ajax 통신 성공 시 로직 수행
						success: function(json){
							//console.log("성공 msg : "+json.msg);
							if(json.msg=="" || typeof json.msg ==="undefined"){
								location.href="/client/setting/account/actInfo.do";
							}else{
								alert(json.msg);
							}
						},
						error : function() {
							//console.log("에러가 발생하였습니다."+json.msg);
						},
						//finally 기능 수행
						complete : function() {
							//console.log("파이널리.");
						}
					});
				//}
			});//btnSub
			
			
		});
	</script>
	
</head>
<body>
	<div id="content" class="main-div">
	
		<div id="subCir" class="sub-cir-div" style="width:800px;height:600px;">
			<form id="loginForm" name="loginForm" method="post" enctype="multipart/form-data">
				<h2>비밀번호 인증 페이지</h2>
				<table class="semi-tb" border="1" align="center">
					<thead>
				        <tr>
				        	<th colspan="2">비밀번호를 확인후에 정보 변경 처리가 진행 됩니다.</th>
				        </tr>
				      </thead>
					<tbody>
						<tr>
							<td>비밀번호</td>
							<td>
								<input type="password" id="USER_PW" name="USER_PW" maxlength="15" onkeyup="spaceChk(this);" onkeydown="spaceChk(this);"  required>
							</td>
						</tr>
					</tbody>
				</table>
				<div class="btnDiv">
					<button id="btnSub" class="buttonDf">확인</button>
				</div>
			</form>	
		</div>
	</div>
		<%@include file="/footer.jsp" %>
</body>
</html>