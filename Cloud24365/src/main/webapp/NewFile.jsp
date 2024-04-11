
<body>
	<div id="content" class="main-div">
		<div id="subCir" class="sub-div">
			<div class="title">
				<h3>문의하기 답변</h3>
			</div>
			<div>
				<form id="textFrm" name="textFrm" method="post" enctype="multipart/form-data">
					<table border="0" cellspacing="0" cellpadding="0" class="admin_list" style="width: 80vw;min-width: 1200px;line-height:1.1;">
						<tr>
							<td class="td-name">문의번호</td>
							<td>
								${reqVo.REQ_ID}
								<input type="hidden" class="input_base" id="REQ_ID" name="REQ_ID" value="${reqVo.REQ_ID}"/>
							</td>
							<td class="td-name">작성일자</td>
							<td>
								${reqVo.REQ_DT}							
							</td>
						</tr>
						<tr>
							<td class="td-name">발송자</td>
							<td>
								${reqVo.COMPANY_NAME}
							</td>
							<td class="td-name">문의유형</td>
							<td>
								${reqVo.REQ_TYPE}
							</td>
						</tr>
						<tr>
							<td class="td-name">답변유형</td>
							<td>
								<input type="radio" class="input_base" id="mon_1" name="ANS_TYPE" value="0" checked/>
								<label for="radio-choice-3">일반답변</label>
								<input type="radio" class="input_base" id="mon_1" name="ANS_TYPE" value="1"/>
								<label for="radio-choice-3">중간답변</label>
							</td>
							<td class="td-name">담당자</td>
							<td>
								<select class="table_sel"  style="width:120px;" id="areaCodeSel" name="USER_ID">
								    <c:forEach var="userVo" items="${userList}">
										<option value="${userVo.USER_ID}">${userVo.USER_NAME}</option>
								    </c:forEach>
								</select>
							</td>
						</tr>
						<tr>
							<td class="td-name">별첨파일</td>
							<td colspan='3'>
								<c:forEach var="fvo" items="${fileList}">
									<a href="/download.ajax?FILE_ID=${fvo.FILE_ID}">${fvo.FILE_NAME}</a>
							    </c:forEach>
							</td>
						</tr>
						<tr>
							<td class="td-name">제목</td>
							<td colspan='3'>
								${reqVo.REQ_TITLE}
							</td>
						</tr>
						<tr>
							<td class="td-name">문의 내용</td>
							<td colspan='3'>
								<textarea id="REQ_QUESTION" class="long-cont" style="width: 75vw;height: 20vh;" readonly>
									${reqVo.REQ_QUESTION}
								</textarea>
							</td>
						</tr>
						<tr>
							<td class="td-name">답변</td>
							<td colspan='3'>
								<textarea id="REQ_ANSWER" name="REQ_ANSWER" class="long-cont" style="width: 75vw;height: 20vh;"></textarea>		
							</td>
						</tr>
						<tr>
							<td class="td-name">파일첨부</td>
							<td>
								<input type="file" name="multiFile" multiple> 
								※ 첨부파일은 3개월 후 자동 삭제 됩니다 (첨부파일은 총 5MB 이내)
							</td>
						</tr>
						<tr>
							<td class="td-name">중요도</td>
							<td colspan='3'>
								<select class="table_sel"  style="width:120px;" id="areaCodeSel" name="REQ_IMPORTANT">
									<option value="2">상</option>
									<option value="1">중</option>
									<option value="0">하</option>
								</select>
							</td>						
						</tr>
						<tr>
							<td class="td-name">문의/답변<br>증적관리</td>
							<td colspan='3'>
								<input type="text" class="input_base" id="REQ_HISTORY" name="REQ_HISTORY" value="${reqVo.REQ_HISTORY}"/>		
							</td>
						</tr>
					</table>
					<div class="btnDiv" style="flex-direction: row-reverse;">
				   		<input type="button" id="btnSave" alt="저장" value="저장">
					</div>
				</form>
			</div>
		</div>
	</div>
</body>
</html>