<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<c:set var="sessionVo" value="${sessionScope.S_USER}"></c:set>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HOME : MAIN CONTENTS</title>
<style type="text/css">
input:button {
	margin-top:0px;
}
</style>
<script type="text/javascript">
$(function(){
	
	/* Create Board Enter key Event */
	$("#view_b_subject").keypress(function(e){
		if(e.keyCode && e.keyCode == 13) {
			fn_mng_board('add');
		}
	});
	$("#view_b_content").keypress(function(e){
		if(e.keyCode && e.keyCode == 13) {
			fn_mng_board('add');
		}
	});
	/* Search Filter Enter key Event */
	$("#srch_text").keypress(function(e){
		if(e.keyCode && e.keyCode == 13) {
			if($("#srch_text").val()=='') {
				$("#srch_user_board option:eq(0)").prop("selected", true);
			}
			$("#srch_btn").trigger('click'); //click 이벤트 강제 발생
		}
	});
	/* Search Filter Button Event */
	$("#srch_btn").click(function(){
		if($("#srch_text").val()=='') {
			$("#srch_user_board option:eq(0)").prop("selected", true);
		}
		fn_user_board_srch();
	});
	
	/* Board Main Grid */
	$("#mainGrid").jqGrid({
		url:"/board/main/selectAllBoard",
		loadtext:"로딩 중...",
		datatype:"json",
		mtype:"POST",
		height:645,
		width:830,
		pagerpos:'center',
		shrinkToFit: true,
		colNames:['번호', '작성자', '제목', '내용', '', 'b_date', 'b_upd_date', 'user_idx', 'like_tp'],
		colModel:[
					{name:'board_id', index:'board_id', align:"center", width:"28px"},
					{name:'user_nm', index:'user_nm', align:"center", width:"70px"},
					{name:'b_subject', index:'b_subject', align:"center"},
					{name:'b_content', index:'b_content', align:"center"},
					{name:'like_btn', index:'like_btn', align:"center", formatter:formatOpt_like, width:30},
					{name:'b_date', index:'b_date', hidden:true},
					{name:'b_upd_date', index:'b_upd_date', hidden:true},
					{name:'user_idx', index:'user_idx', hidden:true},
					{name:'like_tp', index:'like_tp', hidden:true}
				 ],
		pager : "#pager",
	    rowNum  : 20,
		rowList : [20, 40, 60],
		loadComplete: function(data) {
			$(".ui-state-default.jqgrid-rownum").removeClass('ui-state-default jqgrid-rownum');

			var rows = $("#mainGrid").jqGrid('getGridParam', 'records');        
            if(rows == 0 ){          
            	$("#mainGrid > tbody").append("<tr><td align='center' colspan='7' style=''>조회된 데이터가 없습니다.</td></tr>");
            	//$("#srch_user_board option:eq(0)").prop("selected", true);
           		//$("#srch_text").val('');
            }
		},
 		onSelectRow: function(index, row) {
 			if(index) {
 				var row = $("#mainGrid").jqGrid('getRowData', index);

 				$("#status").val("update");

 				$("#view_board_id").val('');
 				$("#view_user_idx").val('');
 				
 				$("#view_board_id").val(row.board_id);
 				$("#view_user_idx").val(row.user_idx);
 				$("#view_user_nm").val(row.user_nm);
 				$("#view_b_subject").val(row.b_subject);
 				$("#view_b_content").val(row.b_content);
 				$("#view_b_date").val(row.b_date);
 				$("#view_b_upd_date").val(row.b_upd_date);
 			}
	    }
	});
});

function formatOpt_like(cellvalue, options, rowObject) {
	var str = "";
	str += "<div class=\"btn-group\">";
	
	if(rowObject.like_tp == "N") {
	 	str += "<button type='button' id=\"like_" + rowObject.board_id + '"' + "class='btn btn-light sm-1' style='padding:2px 10px 2px; z-index:1;' onclick=\"javascript:fn_like('" + rowObject.board_id + "','" + rowObject.like_tp + "')\">🤍</button>";
	}else if(rowObject.like_tp == "Y"){
		str += "<button type='button' id=\"like_" + rowObject.board_id + '"' + "class='btn btn-light sm-1' style='padding:2px 10px 2px; z-index:1;' onclick=\"javascript:fn_like('" + rowObject.board_id + "','" + rowObject.like_tp + "')\">❤️</button>";
	}
	str += "</div>";
	return str;
}

/* Keep Pageing Function */
function fn_keep_page() {
	var scrollPosition = "";
	var pageing = $("#mainGrid").jqGrid("getGridParam");
	pageing.scrollTopPosition = $("#mainGrid").closest(".ui-jqgrid-bdiv").scrollTop();
	scrollPosition = pageing.scrollPosition;
}

/* Click Like Button */
function fn_like(board_id, like_tp) {
	var user_idx = '${sessionVo.user_idx}';
	callAjax("/like/board/updateLikeTp", {board_id:board_id, like_tp:like_tp, user_idx:user_idx}, fn_update_like);
}

/* Ajax updateLike Callback Function */
function fn_update_like(data) {
	if(data.resultCode=="S000") {
		$("#mainGrid").setGridParam({url:"/board/main/selectAllBoard", page:fn_keep_page(), datatype:"json"}).trigger("reloadGrid");		
	}else {
		alert("좋아요 실패");
	}
}

/* Create Board Button Click */
function fn_board_clear() {
	
	$("#status").val("create");
	
	$("#view_board_id").val("");
	$("#view_user_idx").val("");
	$("#view_user_nm").val("");
	$("#view_b_subject").val("");
	$("#view_b_content").val("");
	$("#view_b_date").val("");
	$("#view_b_upd_date").val("");
}

/* Create/Update/Delete Board */
function fn_mng_board(type) {
	var user_idx  = $("#view_user_idx").val();
	var b_subject = $("#view_b_subject").val().trim();
	var b_content = $("#view_b_content").val().trim();
	if(b_subject == '') {
		alert('제목을 입력해주세요.');
		return;
	}
	if(b_content == '') {
		alert('내용을 입력해주세요.');
		return;
	}
	
	/* Create/Update Board */
	if(type=="add") {
		if($("#status").val()=="create") {
			
			if(!confirm("등록하시겠습니까?")) return;
			callAjax("/board/main/createItem", $("#frm_update_board").serialize(), fn_result);	
		
		}else if($("#status").val()=="update") {
			
			if('${sessionVo.user_idx}' != user_idx) {
				alert('다른 사용자의 게시물은 수정할 수 없습니다.'); 
				fn_board_clear();
				return;
			}
			if(!confirm("수정하시겠습니까?")) return;

			callAjax("/board/main/updateItem", $("#frm_update_board").serialize(), fn_result);
		}
	
	/* Delete Board */
	}else if(type=="delete") {
		
		if('${sessionVo.user_idx}' != user_idx) {
			alert('다른 사용자의 게시물은 삭제할 수 없습니다.'); 
			fn_board_clear();
			return;
		}
		if(!confirm("삭제하시겠습니까?")) return;

		callAjax("/board/main/deleteItem", $("#frm_update_board").serialize(), fn_result);
	}
}

/* Ajax Callback Function */
function fn_result(data) {
	if(data.resultCode=="S000") {
		$("#mainGrid").setGridParam({url:"/board/main/selectAllBoard", page:fn_keep_page(), datatype:"json"}).trigger("reloadGrid");		
		fn_board_clear();
	
	}else {
		alert("작업수행에 실패하였습니다.");
	}
}

/* Board Search Filter */
function fn_user_board_srch() {
	$("#mainGrid").clearGridData();
	$("#mainGrid").setGridParam({
		   url:"/board/main/selectAllBoard"
		 , postData: {
				  srch_user_board: $("#srch_user_board").val()
		   		, srch_text : $("#srch_text").val()	
		   }
		 , datatype:"json"
	}).trigger('reloadGrid');
}
</script>
<style type="text/css">
#gbox_mainGrid {
	margin-right:-50px;
}
</style>
</head>
<body>
<div id="content" style="float:left;">
	<div role="content">
		<div class="widget-body" style="padding:25px; margin-left:30px;">
			<fieldset>
				<div class="form-group" style="flex:center; float:left;">
					<label><span class="widget-icon"><i class="fa fa-list-ul"></i>&nbsp;&nbsp;&nbsp;게시글</span></label>
				</div>
				<!-- 검색 -->
				<div class="input-group rounded" style="width:500px; float: right;">
				  <select id="srch_user_board" name="srch_user_board" style="border-radius: 3px; font-size: 13px; outline:none; border:none; margin-right:3px; width:100px;">
				  	<option value='srch_all'>전 체</option>
				  	<option value='srch_user_nm'>작성자</option>
				  	<option value='srch_b_subject'>제 목</option>
				  	<option value='srch_b_content'>내 용</option>
				  </select>
				  <input type="search" id="srch_text" name="srch_text" class="form-control rounded" placeholder="검색" aria-label="Search" aria-describedby="search-addon"/>
				  <button type="button" class="btn btn-default btn-sm" style="padding:2px 10px 2px; box-shadow: none;" id="srch_btn">
				 	 <span class="input-group-text border-0" id="search-addon"><i class="fas fa-search"></i></span>
				  </button>
				</div>
			</fieldset>
			<fieldset>		
				<div class="row" id="tableWrap" style="margin-top:10px;">
					<table id="mainGrid"></table>
					<div id="pager"></div>
				</div>
			</fieldset>	
		</div>
	</div>
</div>
<form class="form-horizontal" id="frm_update_board" name="frm_update_board" onsubmit="return false">
	<div class="board_info" id="content" style="width:700px; float:right;">
		<div class="widget-body" style="padding:30px;">
			<fieldset>
				<div style="flex:center;">
					<label><span class="widget-icon"><i class="fa fa-list-alt txt-color-white"></i>&nbsp;&nbsp;&nbsp;게시글 상세정보</span></label>
				</div>
			</fieldset>
			<hr style="margin-top:20px;">
			<input type="hidden" id="view_board_id" name="board_id">
			<input type="hidden" id="view_user_idx" name="user_idx">
			<input type="hidden" id="status" value="create">
			<fieldset>	
				<legend style="padding-top:0px; font-size:14px; margin-bottom:5px; margin-top:15px;">작성자</legend>
				<div style="width:200px; text-align: left;">
					<input class="form-control input-sm" id="view_user_nm" disabled="disabled"/>					
				</div>	
				<legend style="padding-top:0px; font-size:14px; margin-bottom:5px; margin-top:15px;">제목</legend>
				<div>
					<input type="text" class="form-control input-sm" id="view_b_subject" name="b_subject"/>					
				</div>
				<legend style="padding-top:0px; font-size:14px; margin-bottom:5px; margin-top:15px;">내용</legend>
				<div>
					<input type="text" class="form-control input-sm" id="view_b_content" name="b_content"/>					
				</div>
				<div style="float:left; width:320px;">
				<legend style="padding-top:0px; font-size:14px; margin-bottom:5px; margin-top:15px;">작성일</legend>
					<input class="form-control input-sm" id="view_b_date" disabled="disabled"/>					
				</div>
				<div style="float:left; width:320px;">
				<legend style="padding-top:0px; font-size:14px; margin-bottom:5px; margin-top:15px;">수정일</legend>
					<input class="form-control input-sm" id="view_b_upd_date" disabled="disabled"/>					
				</div>
			</fieldset>	
			<br>
			<div id="updateCancel_btn" style="text-align: right;">
				<button type='button' class='btn btn-default btn-sm' style="padding:2px 20px 2px; font-size: 15px; font-weight: bold;" onclick="fn_board_clear();">신규</button>		
				<button type='button' class='btn btn-default btn-sm' style="padding:2px 20px 2px; font-size: 15px; font-weight: bold;" onclick="fn_mng_board('add');">저장</button>		
				<button type='button' class='btn btn-default btn-sm' style="padding:2px 20px 2px; font-size: 15px; font-weight: bold;" onclick="fn_mng_board('delete');">삭제</button>		
			</div>
		</div>
	</div>
</form>

</body>
</html>