<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<title>CLOUD 24 365 관리자 페이지</title>
<script>

	$(document).ready( function() {
		console.log("협력사 등록");
		$("#btnSave").on("click",function(){
			console.log("협력사 등록 시도");
			let frm = $("#acDetailFrm").serialize();
			//let param = encodeURI(frm);
		    var options = {
	            url:'/admin/edit/insertBill.ajax',
	            type:"post",
	            dataType: "json",
	            //contentType: "application/x-www-form-urlencoded; charset=euc-kr",
	            data : frm,
	            success: function(res){
	                if(res.cnt > 0){
	                    alert("저장되었습니다.");
	                    location.href="/admin/edit/bill.do"
	                } else {
	                	if(res.badFileType != null){
	                		alert("사진파일 첨부는 이미지 파일만 가능합니다.");
	                	} else if(typeof res.createFileError !== "undefined" && res.createFileError) {
	                	    alert("사진파일 저장에 실패했습니다.");
	                	} else if(typeof res.msg !== "undefined" && res.msg != null) {
	                		alert(res.msg);
	                	} else {
	                		alert("저장에 실패했습니다.");
	                	}
	                }
	            } ,
	            error: function(res,error){
	                alert("에러가 발생했습니다."+error);
	            }
		    };
		    $('#acDetailFrm').ajaxSubmit(options);
		});
	});
	
</script>
</head>
	<form name="insertForm" id="acDetailFrm" method="post" enctype="multipart/form-data">
		<div class="ctn_tbl_row">
			<div class="ctn_tbl_th fm_rep">청구서명</div>
			<div class="ctn_tbl_td">
				<input type="text" class="form-control" name="BILL_NAME" value="${data.BILL_NAME}"/>
			</div>
		</div>
       
       <div class="ctn_tbl_row">
           <div class="ctn_tbl_th">파일첨부</div>
           <div class="ctn_tbl_td">
				<input type="file" name="multiFile">
           </div>
       </div>
           
		<!-- btn_box Start -->
		<div class="btn_box">
			<div class="right">
				<button class="btn btn_primary" style="" id="btnSave" data-term="L.등록" title="등록">
					<span class="langSpan">등록</span>
				</button>
			</div>
		</div>
		<!-- btn_box End -->
	</form>
</html>