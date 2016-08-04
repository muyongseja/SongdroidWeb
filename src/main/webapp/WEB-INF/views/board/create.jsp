<%@page contentType="text/html;charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="/WEB-INF/views/inc/header.jsp"></jsp:include>

<script>
// F5 새로고침 방지
function noEvent() {
	if (event.keyCode == 116) {
		event.keyCode = 2;
		return false;
	} else if (event.ctrlKey
			&& (event.keyCode == 78 || event.keyCode == 82)) {
		return false;
	}
}
document.onkeydown = noEvent;

$("document").ready(
	function() {
		$("#createBoard").click(
			function() {
				if ($("#board_tab_name").val() == "" || $("#board_tab_name").val() == null) {
					alert("게시판 이름을 반드시 입력해주세요.");
					return;
				}

				$.ajax({
					type : "POST",
					url : "/songdroid/board/create",
					data : $('#f1').serialize(), // 폼데이터 직렬화
					contentType : "application/x-www-form-urlencoded; charset=utf-8",
					dataType : "text",
					success : function(data) { // data: 백엔드에서 requestBody 형식으로 보낸 데이터를 받는다.
						//alert(data);
						if (data.trim() == "true") {
							$("#resultDisplay").text("이미 테이블명이 사용중입니다. 다른 이름을 입력해주세요.");
						} 
						else {
							location.reload();
						}
					},
					error : function(jqXHR, textStatus, errorThrown) {
						//에러코드
					}
				});
		});
});
</script>

<div class="container">
	<form method="post" action="board/create" id="f1">
		<div class="row">
			<div class="col-lg-7">
				<div class="input-group">
					<span class="badge">게시판 옵션 설정</span>
						<span class="checkbox-inline"> 
							<label for="board_reply">답변 기능</label>
							<input type="checkbox" class="form-control" name="chkOption" id="board_reply" value="reply"><br />
						</span>
						<span class="checkbox-inline"> 
							<label for="board_comment">댓글 기능</label>
							<input type="checkbox" class="form-control" name="chkOption" id="board_comment" value="comment"/><br />
						</span>
						<span class="checkbox-inline"> 
							<label for="board_upload">업로드 기능</label>
							<input type="checkbox" class="form-control" name="chkOption" id="board_upload" value="upload"><br />
						</span>
				</div>
			</div>
		</div>
		<br />
		<br />
		<div class="row">
			<div class="col-lg-7">
				<div class="input-group">
					<span class="input-group-addon">게시판 타이틀 입력(예:자유토론 게시판, QnA,
						공지사항)</span> <input type="text" class="form-control"
						aria-label="생성할 게시판 타이틀을 입력하시오." name="board_disp_name">
				</div>
				<div class="input-group">
					<span class="input-group-addon">게시판 이름 입력(예:tblFreetalk,
						tblQnA, tblNotice)</span> <input type="text" class="form-control"
						aria-label="생성할 테이블명을 입력하시오." name="board_tab_name" 
						id="board_tab_name" required="required">
				</div>
				입력불가 테이블: tblBoardMaster, tblBoardBasic, tblBoardComment,
				tblBoardUpload, tblBoardReply <br />
				<div class="input-group">
					<span class="input-group-btn">
						<button class="btn btn-default" type="button" id="createBoard">게시판
							생성</button>
					</span>
				</div>
				<span id="resultDisplay" style="color: red;"></span>
			</div>
		</div>
	</form>
	<br />
	<br />
	<div class="row">
		<h2>게시판 목록</h2>
		<table class="table table-striped table-hover table-condensed" style="width:60%">
		<c:forEach var="table" items="${requestScope.tableList}">
			<tr>
				<td>
				<a href='/songdroid/board/list?board_num=${table["board_num"]}'>${table["board_disp_name"]}(${table["board_tab_name"]}
				: ${table["board_create_date"]})</a>
				</td>
				<td>
				<a href='/songdroid/board/drop?board_num=${table["board_num"]}'>삭제</a>
				</td>
			</tr>
		</c:forEach>
		</table>
	</div>
</div>

<jsp:include page="/WEB-INF/views/inc/footer.jsp"></jsp:include>