<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin_header.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin_board_config.css">
<link href="https://fonts.googleapis.com/css?family=Manjari|family=Lato|Nanum+Gothic&display=swap" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<title></title>
</head>
<script>
	var hiddenvalue = "";
</script>
<body oncontextmenu="return false" onselectstart="return false" ondragstart="return false">
	<jsp:include page="admin_header.jsp" flush="true" />
	<div id="wrap">
		<div id="wrapping">
			<div id="subMenu">
				<ul>
					<li class="subOn" onclick="window.location.href='/main/admin/board/list'">게시판 리스트</li>
					<li onclick="window.location.href='/main/admin/board/write'">공지사항 작성</li>
				</ul>
			</div>
			<section>
				<div id="section">
					<div id="shadowDiv">
						<div id="titleDiv">
							<h1>관리자 > 시스템관리 > 게시판 관리 (${bdName})</h1>
						</div>
						<table id="writeTbl">
							<colgroup>
								<col width="15%" />
								<col width="35%" />
								<col width="15%" />
								<col width="35%" />
							</colgroup>
							<tr>
								<th scope="col">게시판 명</th>
								<td scope="col" colspan="3">
									<input type="text" style="width: 700px" id="txtBdName" name="brd_name" class="input-text" value="${bdName}" maxlength="100" />
								</td>
							</tr>

							<tr>
								<th scope="col">게시판 번호</th>
								<td scope="col" colspan="3">
									<input type="text" style="width: 700px" id="txtBdNum" name="brd_num" class="input-text" value="${bdNum}" maxlength="100" readonly />
								</td>
							</tr>

							<tr>
								<th scope="col">사용여부</th>
								<td scope="col" colspan="3">
									<input type="hidden" id="presense" value="${presense}"> <input type='radio' name='use_yn' id='id_use_yn_Y' value='Y' checked class='input-text'><label for='id_use_yn_Y'>사용</label> <input type='radio' name='use_yn' id='id_use_yn_N' value='N' class='input-text'><label for='id_use_yn_N'>사용하지 않음</label>
									<script>
										if ($('#presense').val() == "Y") {
											$('#id_use_yn_Y').prop('checked',
													true);
										} else {
											$('#id_use_yn_N').prop('checked',
													true);
										}
									</script>
								</td>
							</tr>

							<tr>
								<th scope="col">리스트 개수</th>
								<td scope="col" colspan="3">
									<input type="text" id="paging_cnt" name="list_cnt" style="width: 50px; IME-MODE: disabled;" onkeyPress="if ((event.keyCode<48) || (event.keyCode>57)) event.returnValue=false;" class="input-text centerText" value="${paging}" maxlength="3" /> ※ [0]을 입력시 사용자 화면에서 페이징이 나오지 않음
								</td>
							</tr>

							<tr>
								<th scope="col">게시글 삭제여부</th>
								<td scope="col" colspan="3">
									<input type="hidden" id="deleteCompl" value="${deleteCompl}"> <input type='radio' name='delflag' id='id_delflag_DB' value='DB' class='input-text'><label for='id_delflag_DB'>DB 삭제 Flag</label> <input type='radio' name='delflag' id='id_delflag_DEL' value='DEL' checked class='input-text'><label for='id_delflag_DEL'>영구 삭제</label>
									<script>
										if ($('#deleteCompl').val() == "DB") {
											$('#id_delflag_DB').prop('checked',
													true);
										} else if ($('#deleteCompl').val() == "DEL") {
											$('#id_delflag_DEL').prop(
													'checked', true);
										}
									</script>
								</td>
							</tr>

							<tr>
								<th scope="col">글쓰기 권한</th>
								<td scope="col" colspan="3">
									<input type="hidden" id="writeAuth" value="${writeAuth}"> <input type='radio' name='write_auth_cd' id='id_write_auth_cd_ALL' value='ALL' checked class='input-text'><label for='id_write_auth_cd_ALL'>전체</label> <input type='radio' name='write_auth_cd' id='id_write_auth_cd_ADMIN' value='ADMIN' class='input-text'><label for='id_write_auth_cd_ADMIN'>관리자</label> <input type='radio' name='write_auth_cd' id='id_write_auth_cd_USER' value='USER' class='input-text'><label
										for='id_write_auth_cd_USER'
									>회원</label> <input type='radio' name='write_auth_cd' id='id_write_auth_cd_NOWRITE' value='NOWRITE' class='input-text'><label for='id_write_auth_cd_NOWRITE'>글쓰기 없음</label>
									<script>
										if ($('#deleteCompl').val() == "ALL") {
											$('#id_write_auth_cd_ALL').prop(
													'checked', true);
										} else if ($('#deleteCompl').val() == "ADMIN") {
											$('#id_write_auth_cd_ADMIN').prop(
													'checked', true);
										} else if ($('#deleteCompl').val() == "USER") {
											$('#id_write_auth_cd_USER').prop(
													'checked', true);
										} else if ($('#deleteCompl').val() == "NOWRITE") {
											$('#id_write_auth_cd_NOWRITE')
													.prop('checked', true);
										}
									</script>
								</td>
							</tr>

							<tr>
								<th scope="col">작성자 사용여부</th>
								<td scope="col" colspan="3">
									<input type="hidden" id="writeCompl" value="${writeCompl}"> <input type='radio' name='writer_use_yn' id='id_writer_use_yn_Y' value='Y' class='input-text'><label for='id_writer_use_yn_Y'>사용</label> <input type='radio' name='writer_use_yn' id='id_writer_use_yn_N' value='N' checked class='input-text'><label for='id_writer_use_yn_N'>사용하지 않음</label>
									<script>
										console.log($('#writeCompl').val());
										if ($('#writeCompl').val() == "Y") {
											$('#id_writer_use_yn_Y')
											.prop('checked', true);
										} else if($('#writeCompl').val() == "N"){
											$('#id_writer_use_yn_N')
											.prop('checked', true);
										}
									</script>
								</td>
							</tr>

							<tr>
								<th scope="col">연락처 사용여부</th>
								<td scope="col" colspan="3">
								<input type="hidden" id="mobileCompl" value="${mobileCompl}">
									<input type='radio' name='phone_use_yn' id='id_phone_use_yn_Y' value='Y' class='input-text'><label for='id_phone_use_yn_Y'>사용</label> <input type='radio' name='phone_use_yn' id='id_phone_use_yn_N' value='N' checked class='input-text'><label for='id_phone_use_yn_N'>사용하지 않음</label>
									<script>
									if($('#mobileCompl').val() == "Y"){
										$('#id_phone_use_yn_Y').prop('checked',true);
									}else{
										$('#id_phone_use_yn_N').prop('checked',true);
									}
									</script>
								</td>
							</tr>

							<tr>
								<th scope="col">이메일 사용여부</th>
								<td scope="col" colspan="3">
									<p style="margin-bottom: 5px;">
										<input type="hidden" id="emailCompl" value="${emailCompl}">
										<input type='radio' name='email_use_yn' id='id_email_use_yn_Y' value='Y' class='input-text'><label for='id_email_use_yn_Y'>사용</label> <input type='radio' name='email_use_yn' id='id_email_use_yn_N' value='N' checked class='input-text'><label for='id_email_use_yn_N'>사용하지 않음</label>
									</p>
									<script>
									if($('#emailCompl').val() == "Y"){
										$('#id_email_use_yn_Y').prop('checked',true);
									}else{
										$('#id_email_use_yn_N').prop('checked',true);
									}
									</script>
									※ 이메일 수신여부 : <input type='radio' name='email_recv_use_yn' id='id_email_recv_use_yn_Y' value='Y' class='input-text'><label for='id_email_recv_use_yn_Y'>사용</label> <input type='radio' name='email_recv_use_yn' id='id_email_recv_use_yn_N' value='N' checked class='input-text' ><label for='id_email_recv_use_yn_N'>사용하지 않음</label>
									<input type="hidden" id="emailReceive" value="${emailReceive}">
									<script>
									if($('#emailReceive').val() == "Y"){
										$('#id_email_recv_use_yn_Y').prop('checked',true);
									}else{
										$('#id_email_recv_use_yn_N').prop('checked',true);
									}
									</script>
								</td>
							</tr>

							<tr>
								<th scope="col">날짜 사용여부</th>
								<td scope="col">
								<input type="hidden" id="dateCompl" value="${dateCompl}">
									<input type='radio' name='date_use_yn' id='id_date_use_yn_Y' value='Y' class='input-text'><label for='id_date_use_yn_Y'>사용</label> <input type='radio' name='date_use_yn' id='id_date_use_yn_N' value='N' checked class='input-text'><label for='id_date_use_yn_N'>사용하지 않음</label>
									<script>
									if($('#dateCompl').val() == "Y"){
										$('#id_date_use_yn_Y').prop('checked',true);
									}else{
										$('#id_date_use_yn_N').prop('checked',true);
									}
									</script>
								</td>
							</tr>

							<tr>
								<th scope="col">답글쓰기 여부</th>
								<td scope="col" colspan="3">
								<input type="hidden" id="replyCompl" value="${replyCompl}">
									<input type='radio' name='reply_use_yn' id='id_reply_use_yn_Y' value='Y' class='input-text'><label for='id_reply_use_yn_Y'>사용</label> <input type='radio' name='reply_use_yn' id='id_reply_use_yn_N' value='N' checked class='input-text'><label for='id_reply_use_yn_N'>사용하지 않음</label>
									<script>
									if($('#replyCompl').val() == "Y"){
										$("#id_reply_use_yn_Y").prop('checked',true);
									}else{
										$("#id_reply_use_yn_N").prop('checked',true);
									}
									</script>
								</td>
							</tr>

							<tr>
								<th scope="col">댓글 사용여부</th>
								<td scope="col">
								<input type="hidden" id="commentCompl" value="${commentCompl}">
									<input type='radio' name='cmt_use_yn' id='id_cmt_use_yn_Y' value='Y' class='input-text'><label for='id_cmt_use_yn_Y'>사용</label> <input type='radio' name='cmt_use_yn' id='id_cmt_use_yn_N' value='N' checked class='input-text'><label for='id_cmt_use_yn_N'>사용하지 않음</label>
									<script>
									if($('#commentCompl').val() == "Y"){
										$("#id_cmt_use_yn_Y").prop('checked',true);
									}else{
										$("#id_cmt_use_yn_N").prop('checked',true);
									}
									</script>
								</td>
								<th scope="col">댓글 권한</th>
								<td scope="col">
									<input type="hidden" id="commentAuth" value="${commentAuth}">
									<input type='radio' name='cmt_auth_cd' id='id_cmt_auth_cd_ALL' value='ALL' checked class='input-text'><label for='id_cmt_auth_cd_ALL'>전체</label> <input type='radio' name='cmt_auth_cd' id='id_cmt_auth_cd_ADMIN' value='ADMIN' class='input-text'><label for='id_cmt_auth_cd_ADMIN'>관리자</label> <input type='radio' name='cmt_auth_cd' id='id_cmt_auth_cd_USER' value='USER' class='input-text'><label for='id_cmt_auth_cd_USER'>회원</label> <input type='radio' name='cmt_auth_cd'
										id='id_cmt_auth_cd_NOWRITE' value='NOWRITE' class='input-text'
									><label for='id_cmt_auth_cd_NOWRITE'>글쓰기 없음</label>
									<script>
									var cA = $('#commentAuth').val();
									if(cA == "ALL"){
										$("#id_cmt_auth_cd_ALL").prop('checked',true);
									}else if(cA == "ADMIN"){
										$("#id_cmt_auth_cd_ADMIN").prop('checked',true);
									}else if(cA == "USER"){
										$("#id_cmt_auth_cd_USER").prop('checked',true);
									}else if(cA == "NOWRITE"){
										$("#id_cmt_auth_cd_NOWRITE").prop('checked',true);
									}
									</script>
								</td>
								</td>
							</tr>


							<tr>
								<th scope="col">비밀글 사용 여부</th>
								<td scope="col" colspan="3">
								<input type="hidden" id="securityCompl" value="${securityCompl}">
									<input type='radio' name='secret_use_yn' id='id_secret_use_yn_Y' value='Y' class='input-text'><label for='id_secret_use_yn_Y'>사용</label> <input type='radio' name='secret_use_yn' id='id_secret_use_yn_N' value='N' checked class='input-text'><label for='id_secret_use_yn_N'>사용하지 않음</label>
									<script>
									if($('#securityCompl').val() == "Y"){
										$("#id_secret_use_yn_Y").prop('checked',true);
									}else{
										$("#id_secret_use_yn_N").prop('checked',true);
									}
									</script>
								</td>
							</tr>
							<tr>
								<td colspan="4" class="buttonTd">
									<button id="submitBtn">완료</button>
									<button id="goListBtn">목록</button>
								</td>
							</tr>
						</table>
					</div>
				</div>
			</section>
		</div>
		<div class="clear"></div>
	</div>
</body>
<script>
$(function() {
	$("#boardManage").addClass("mainOn");
	$("#goListBtn").click(function() {
		window.location.href = "/main/admin/board/list";
	})
})
$(document).on('click','#submitBtn',function() {
	var bdName = $('#txtBdName').val(), bdNum = $(
			'#txtBdNum').val(), presence = $(
			"input:radio[name=use_yn]:checked").val(), pagingCnt = $(
			'#paging_cnt').val(), deleteCompl = $(
			"input:radio[name=delflag]:checked").val(), writeAuth = $(
			"input:radio[name=write_auth_cd]:checked")
			.val(), writerCompl = $(
			"input:radio[name=writer_use_yn]:checked")
			.val(), mobileCompl = $(
			"input:radio[name=phone_use_yn]:checked").val(), emailReceive = $(
			"input:radio[name=email_recv_use_yn]:checked")
			.val(), emailCompl = $(
			"input:radio[name='email_use_yn']:checked")
			.val(), dateCompl = $(
			"input:radio[name='date_use_yn']:checked")
			.val(), replyCompl = $(
			"input:radio[name='reply_use_yn']:checked")
			.val(), commentCompl = $(
			"input:radio[name='cmt_use_yn']:checked").val(), commentAuth = $(
			"input:radio[name='cmt_auth_cd']:checked")
			.val(), securityCompl = $(
			"input:radio[name='secret_use_yn']:checked")
			.val();
	console.log(bdName);

	window.location.href = "/main/admin/board/update?bdName="
			+ bdName
			+ "&bdNum="
			+ bdNum
			+ "&presence="
			+ presence
			+ "&paging="
			+ pagingCnt
			+ "&deleteCompl="
			+ deleteCompl
			+ "&writeAuth="
			+ writeAuth
			+ "&writerCompl="
			+ writerCompl
			+ "&mobileCompl="
			+ mobileCompl
			+ "&emailCompl="
			+ emailCompl
			+ "&emailReceive="
			+ emailReceive
			+ "&dateCompl="
			+ dateCompl
			+ "&replyCompl="
			+ replyCompl
			+ "&commentCompl="
			+ commentCompl
			+ "&commentAuth="
			+ commentAuth
			+ "&securityCompl=" + securityCompl;
});




</script>
</html>