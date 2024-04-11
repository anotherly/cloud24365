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
		console.log("협력사 상세 진입");
		$("#btnUpdate").on("click", function(event){
			console.log("고객사 수정");
			let frm = $("#acDetailFrm").serialize();
			//let param = encodeURI(frm);
		    var options = {
	            url:'/admin/edit/partnerUpdate.ajax',
	            type:"post",
	            dataType: "json",
	            //contentType: "application/x-www-form-urlencoded; charset=euc-kr",
	            data : frm,
	            success: function(res){
	                if(res.cnt > 0){
	                    alert("저장되었습니다.");
	                    location.href="/admin/edit/client.do"
	                } else {
	                	if(res.badFileType != null){
	                		alert("사진파일 첨부는 이미지 파일만 가능합니다.");
	                	} else if(typeof res.createFileError !== "undefined" && res.createFileError){
	                	    alert("사진파일 저장에 실패했습니다.");
	                	} else if(typeof res.msg !== "undefined" && res.msg != null){
	                		alert(res.msg);
	                	}else {
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
		
		$("#btnDelete").on("click",function(){
			if(confirm("선택하신 고객사를 삭제하시겠습니까?")==true){
				let frm = $("#acDetailFrm").serialize();
				var url='/admin/edit/partnerDelete.ajax';
				var data = frm;
				var callback= "/admin/edit/client.do";
				ajaxMethod(url, data, callback);
				location.href="/admin/edit/client.do"
    		}
		});
		
	});
	
</script>
</head>
	
	<form name="insertForm" id="acDetailFrm" method="post" enctype="multipart/form-data">
		<input type="hidden" class="form-control" name="FILE_ID" value="${data.FILE_ID}"/>
		<input type="hidden" class="form-control" name="PARTNER_ID" value="${data.PARTNER_ID}"/>
		<div class="ctn_tbl_row">
			<div class="ctn_tbl_th fm_rep">고객사명</div>
			<div class="ctn_tbl_td">
				<input type="text" class="form-control" name="PARTNER_NAME" value="${data.PARTNER_NAME}"/>
			</div>
		</div>
       
       <div class="ctn_tbl_row">
           <div class="ctn_tbl_th">파일첨부</div>
           <div class="ctn_tbl_td">
				<input type="file" name="multiFile">
				※ 권장 이미지 크기 : 320px X 200px 
           </div>
           <div>
				<li style="list-style-type: none;"><a>
					<figure id='${data.PARTNER_ID }'>
						<img src='/resources${data.FILE_DIR}${data.FILE_NAME }'alt='' style='height: 100px;'>
					</figure>
				</a></li>
           </div>
       </div>
       
       <div class="ctn_tbl_row">
           <div class="ctn_tbl_th">고객사 사이트 주소</div>
           <div class="ctn_tbl_td">
				<input type="text" class="form-control" name="PARTNER_URL" value="${data.PARTNER_URL}"/>
    		</div>
		</div>
           
		<!-- btn_box Start -->
		<div class="btn_box">
			<div class="right">
				<button class="btn" style="" id="btnUpdate" data-term="L.등록" title="등록">
					<span class="langSpan">수정</span>
				</button>
				<button class="btn" style="" id="btnDelete" data-term="L.등록" title="등록">
					<span class="langSpan">삭제</span>
				</button>
			</div>
		</div>
		<!-- btn_box End -->
	</form>
	
</html>