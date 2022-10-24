<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<c:set var="sessionVo" value="${sessionScope.S_USER}"></c:set>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HOME : TODO LIST</title>
<style type="text/css">
input[type=radio]:checked+label {
	font-weight: 700;
}
input[type=radio]+label {
	font-size: 15px;
}
input[type=radio]+label:hover {
	cursor: pointer;
}
</style>
<script type="text/javascript">
$(function(){
	/* Update Todo Enter key Evenet */
	$("#view_td_nm").keypress(function(e){
		if(e.keyCode && e.keyCode == 13) {
			fn_mng('add');
		}
	});	
 	$("input:radio[name='td_tp']").keypress(function(e){
		if(e.keyCode && e.keyCode == 13) {
			fn_mng('add');
		}
	});
 	
	/* Set Current Time */
	$("#view_td_last_date").val(getToday());	
	$("#view_td_date").val(getToday());	
	
	/* Check input radio */
	$("#view_tp_pre").prop("checked", true);
	
	/* Pre Grid */
	$("#pre_todo").jqGrid({
		url:"/todo/main/getTodoPreListRetrieve",
		loadtext:"로딩 중...",
		datatype:"json",
		mtype:"POST",
		height:250,
		width:360,
		//multiselect:true,
		//autowidth:true,
		shrinkToFit: true,
		colNames:['내용', '마감일','user_nm', 'td_id', 'user_idx', 'td_date', 'td_upd_date', 'td_tp'],
		colModel:[
					{name:'td_nm', index:'td_nm', align:"left"},		
					{name:'td_last_date', index:'td_last_date', align:"center", width:"55px;"},
					{name:'user_nm', index:'user_nm', hidden:true},
					{name:'td_id', index:'td_id', hidden:true},
					{name:'user_idx', index:'user_idx', hidden:true},
					{name:'td_date', index:'td_date', hidden:true},
					{name:'td_upd_date', index:'td_upd_date', hidden:true},
					{name:'td_tp', index:'td_tp', hidden:true}
				 ],
		pager : "#pager_pre_list",
		pagerpos:'left',
	    rowNum  : 10,
	    loadComplete: function() {
			$(".ui-state-default.jqgrid-rownum").removeClass('ui-state-default jqgrid-rownum');
		},
 		onSelectRow: function(index, row) {
 			
 			if(index) {
	 			var row = $("#pre_todo").jqGrid('getRowData', index);
	 			
				$("#status").val("update");

				$("#view_td_id").val('');
				$("#view_td_id").val(row.td_id);
				$("#view_td_nm").val(row.td_nm);
				
				$("#view_td_date").val(row.td_date);
				$("#view_td_upd_date").val(row.td_upd_date);
				$("#view_td_last_date").val(row.td_last_date);
				
				$("#view_tp_pre").prop("checked", true);
 			}
	    }
	});	
	
	/* Now Grid */
	$("#now_todo").jqGrid({
		url:"/todo/main/getTodoNowListRetrieve",
		loadtext:"로딩 중...",
		datatype:"json",
		mtype:"POST",
		height:250,
		width:350,
		//multiselect:true,
		shrinkToFit: true,
		colNames:['내용', '마감일','user_nm', 'td_id', 'user_idx', 'td_date', 'td_upd_date', 'td_tp'],
		colModel:[
					{name:'td_nm', index:'td_nm', align:"left"},
					{name:'td_last_date', index:'td_last_date', align:"center", width:"55px;"},
					{name:'user_nm', index:'user_nm', hidden:true},
					{name:'td_id', index:'td_id', hidden:true},
					{name:'user_idx', index:'user_idx', hidden:true},
					{name:'td_date', index:'td_date', hidden:true},
					{name:'td_upd_date', index:'td_upd_date', hidden:true},
					{name:'td_tp', index:'td_tp', hidden:true}
				 ],
		pager : "#pager_now_list",
	    rowNum  : 25,
		pagerpos:'left',
	    loadComplete: function() {
			$(".ui-state-default.jqgrid-rownum").removeClass('ui-state-default jqgrid-rownum');
		},
 		onSelectRow: function(index, row) {
			
 			if(index) {
				var row = $("#now_todo").jqGrid('getRowData', index);

				$("#status").val("update");
				
				$("#view_td_id").val('');
				$("#view_td_id").val(row.td_id);
				
				$("#view_td_nm").val(row.td_nm);
				$("#view_td_date").val(row.td_date);
				$("#view_td_upd_date").val(row.td_upd_date);
				$("#view_td_last_date").val(row.td_last_date);
				
				$("#view_tp_now").prop("checked", true);
			}
	    }
	});	
	
	/* Success Grid */
	$("#success_todo").jqGrid({
		url:"/todo/main/getTodoSuccessListRetrieve",
		loadtext:"로딩 중...",
		datatype:"json",
		mtype:"POST",
		height:250,
		width:350,
		shrinkToFit: true,
		//multiselect:true,
		colNames:['내용', '마감일', 'user_nm', 'td_id', 'user_idx', 'td_date', 'td_upd_date', 'td_tp'],
		colModel:[
					{name:'td_nm', index:'td_nm', align:"left"},
					{name:'td_last_date', index:'td_last_date', align:"center", width:"55px;"},
					{name:'user_nm', index:'user_nm',hidden:true},
					{name:'td_id', index:'td_id', hidden:true},
					{name:'user_idx', index:'user_idx', hidden:true},
					{name:'td_date', index:'td_date', hidden:true},
					{name:'td_upd_date', index:'td_upd_date', hidden:true},
					{name:'td_tp', index:'td_tp', hidden:true}
				 ],
		pager : "#pager_success_list",
	    rowNum  : 25,
		pagerpos:'left',
	    loadComplete: function() {
			$(".ui-state-default.jqgrid-rownum").removeClass('ui-state-default jqgrid-rownum');
		},
 		onSelectRow: function(index, row) {
			
 			if(index) {
				var row = $("#success_todo").jqGrid('getRowData', index);

				$("#status").val("update");
				
				$("#view_td_id").val('');
				$("#view_td_id").val(row.td_id);
				
				$("#view_td_nm").val(row.td_nm);
				$("#view_td_date").val(row.td_date);
				$("#view_td_upd_date").val(row.td_upd_date);
				$("#view_td_last_date").val(row.td_last_date);
				
				$("#view_tp_success").prop("checked", true);
			}
	    }
	});	
	
	/* Rest Grid */
	$("#re_todo").jqGrid({
		url:"/todo/main/getTodoRestListRetrieve",
		loadtext:"로딩 중...",
		datatype:"json",
		mtype:"POST",
		height:250,
		width:350,
		//multiselect:true,
		shrinkToFit: true,
		colNames:['내용', '마감일', 'user_nm', 'td_id', 'user_idx', 'td_date', 'td_upd_date', 'td_tp'],
		colModel:[
					{name:'td_nm', index:'td_nm', align:"left"},
					{name:'td_last_date', index:'td_last_date', align:"center", width:"55px;"},
					{name:'user_nm', index:'user_nm', hidden:true},
					{name:'td_id', index:'td_id', hidden:true},
					{name:'user_idx', index:'user_idx', hidden:true},
					{name:'td_date', index:'td_date', hidden:true},
					{name:'td_upd_date', index:'td_upd_date', hidden:true},
					{name:'td_tp', index:'td_tp', hidden:true}
				 ],
		pager : "#pager_re_list",
	    rowNum  : 25,
		pagerpos:'left',
	    loadComplete: function() {
			$(".ui-state-default.jqgrid-rownum").removeClass('ui-state-default jqgrid-rownum');
		},
 		onSelectRow: function(index, row) {
			
 			if(index) {
				var row = $("#re_todo").jqGrid('getRowData', index);

				$("#status").val("update");
				
				$("#view_td_id").val("");
				$("#view_td_id").val(row.td_id);

				$("#view_td_nm").val(row.td_nm);
				$("#view_td_tp").val(row.td_tp);
				$("#view_td_date").val(row.td_date);
				$("#view_td_upd_date").val(row.td_upd_date);
				$("#view_td_last_date").val(row.td_last_date);
				
				$("#view_tp_re").prop("checked", true);
			}
	    }
	});	
});

function fn_mng(type) {

	/* Create/Update Todo */
	if(type=="add") {
		
		var td_nm = $("#view_td_nm").val();
		if(td_nm == '') {
			alert("내용을 입력하세요."); return;
		}
		
		var td_tp = $("input:radio[name='td_tp']:checked").val();
		$("#view_td_tp").val(td_tp);
	
		if($("#status").val()=="create") {
			if(!confirm('등록하시겠습니까?')) return;
			callAjax("/todo/main/createTodo", $("#frm_todo").serialize(), fn_result);
	
		}else if($("#status").val()=="update") {
			if(!confirm("수정하시겠습니까?")) return;
			callAjax("/todo/main/updateTodo", $("#frm_todo").serialize(), fn_result);
		}
	
	/* Delete Todo */	
	}else if(type=="delete") {
		if($("#status").val()=="create") {
			alert("삭제할 일정을 선택하세요."); return;
		}
		
		if(!confirm("삭제하시겠습니까?")) return;
		callAjax("/todo/main/deleteTodo",  $("#frm_todo").serialize(), fn_result);
	}
}

/* Ajax Callback Function */
function fn_result(data) {
	if(data.resultCode=="S000"){
		$("#pre_todo").setGridParam({url:"/todo/main/getTodoPreListRetrieve", page:1, datatype:"json"}).trigger("reloadGrid");
		$("#now_todo").setGridParam({url:"/todo/main/getTodoNowListRetrieve", page:1, datatype:"json"}).trigger("reloadGrid");
		$("#success_todo").setGridParam({url:"/todo/main/getTodoSuccessListRetrieve", page:1, datatype:"json"}).trigger("reloadGrid");
		$("#re_todo").setGridParam({url:"/todo/main/getTodoRestListRetrieve", page:1, datatype:"json"}).trigger("reloadGrid");
		
		fn_clear();
	}else {
		alert("작업수행에 실패하였습니다.");
	}
}

/* Clear Button Click Function */
function fn_clear() {
	$("#status").val("create");
	
	$("#view_td_nm").val('');
	$("#view_td_tp").val('');
	$("#view_td_upd_date").val('');
	
	$("#view_td_last_date").val('');
	$("#view_td_last_date").val(getToday());
	
	$("#view_td_date").val('');
	$("#view_td_date").val(getToday());	

	$("#view_tp_pre").prop("checked", true);
}

/* Current Time Set Function */
function getToday(){
    var date = new Date();
    var year = date.getFullYear();
    var month = ("0" + (1 + date.getMonth())).slice(-2);
    var day = ("0" + date.getDate()).slice(-2);

    return year + "-" + month + "-" + day;
}
/* My Current Time Set Function */
function myGetToday() {
	var year = new Date().getFullYear();
	var m = new Date().getMonth()+1;
	var d = new Date().getDate();
	var month = '';
	var day = '';
	if(m<10) month = "0" + m;
	if(d<10) day = "0" + d;
	
	return year + "-" + month + "-" + day;
}
</script>
</head>
<body>
<div id="container">
	<div role="content">
		<div class="widget-body" style="padding:30px;">
			<fieldset>
				<div class="form-group" style="flex:center; display: inline-block; width:380px;">
					<label><span class="widget-icon"><i class="fa fa-list-ul"></i>&nbsp;&nbsp;&nbsp;할 일</span></label>
				</div>
				<div class="form-group" style="flex:center; display: inline-block; width:373px;">
					<label><span class="widget-icon"><i class="fa fa-list-ul"></i>&nbsp;&nbsp;&nbsp;진행 중</span></label>
				</div>				
				<div class="form-group" style="flex:center; display: inline-block; width:373px;">
					<label><span class="widget-icon"><i class="fa fa-list-ul"></i>&nbsp;&nbsp;&nbsp;완료</span></label>
				</div>	
				<div class="form-group" style="flex:center; display: inline-block;">
					<label><span class="widget-icon"><i class="fa fa-list-ul"></i>&nbsp;&nbsp;&nbsp;보류</span></label>
				</div>				
			</fieldset>
			<fieldset>
				<div class="row" id="table_pre" style="display: inline-block; padding:10px;">
					<table id="pre_todo" style="width:100%;"></table>
					<div id="pager_pre_list"></div>
				</div>
				<div class="row" id="table_now" style="display: inline-block; padding:10px;">
					<table id="now_todo"></table>
					<div id="pager_now_list"></div>
				</div>
				<div class="row" id="table_success" style="display: inline-block; padding:10px;">
					<table id="success_todo"></table>
					<div id="pager_success_list"></div>
				</div>
				<div class="row" id="table_re" style="display: inline-block; padding:10px;">
					<table id="re_todo"></table>
					<div id="pager_re_list"></div>
				</div>
			</fieldset>	
		</div>
	</div>
</div>

<form class="form-horizontal" id="frm_todo" name="frm_todo" onsubmit="return false">
	<div class="board_info" id="content">
	<hr style="margin-top:0px; margin-bottom:0px;">
		<div class="widget-body" style="width:800px; padding:30px; margin: auto;">
			<fieldset>
				<div style="flex:center;">
					<label>
						<span class="widget-icon"><i class="fa fa-list-alt txt-color-white"></i>&nbsp;&nbsp;&nbsp;일정 관리</span>
					</label>
				</div>
			</fieldset>
			<input type="hidden" id="user_nm" name="user_nm" value="${sessionVo.user_nm}"/>
			<input type="hidden" id="user_idx" name="user_idx" value="${sessionVo.user_idx}"/>
			<input type="hidden" id="view_td_id" name="td_id"/>
			<input type="hidden" id="view_td_tp" name="td_tp"/>
			<input type="hidden" id="status" value="create"/>
			
			<fieldset>	
					<legend style="padding-top:0px; font-size:14px; margin-bottom:5px; margin-top:15px;">내용</legend>
					<div>
						<input class="form-control input-sm" id="view_td_nm" name="td_nm"/>					
					</div>
					<div style="float:left;">
					<legend style="padding-top:0px; font-size:14px; margin-bottom:5px; margin-top:15px;">상태</legend>
						<div style="margin-right:30px; display: inline-block;">
							<input type="radio" class="form-check-input" name="td_tp" id="view_tp_pre" value="00"/>
							<label for="view_tp_pre" class="radio radio-inline">
								<span>할 일</span>
							</label>
						</div>
						<div style="margin-right:30px; display: inline-block;">
							<input type="radio" class="form-check-input" name="td_tp" id="view_tp_now" value="01"/>	
							<label for="view_tp_now" class="radio radio-inline">
								<span>진행 중</span>
							</label>
						</div>
						<div style="margin-right:30px; display: inline-block;">
							<input type="radio" class="form-check-input" name="td_tp" id="view_tp_success" value="02"/>
							<label for="view_tp_success" class="radio radio-inline">
								<span>완료</span>
							</label>
						</div>
						<div style="margin-right:30px; display: inline-block;">
							<input type="radio" class="form-check-input" name="td_tp" id="view_tp_re" value="99"/>	
							<label for="view_tp_re" class="radio radio-inline">
								<span>보류</span>
							</label>
						</div>
					</div>
					
					<div style="clear:both;">
					<label style="padding-top:0px; font-size:14px; margin-bottom:5px; margin-top:30px;">
						<span>작성일 / 마감일</span>
						<input class="form-control input-sm" id="view_td_date" disabled="disabled" style="display:inline-block; width:310px; margin-left:15px;"/>					
						<input type="date" class="form-control input-sm" id="view_td_last_date" name="td_last_date" style="display:inline-block; width:310px;"/>
					</label>					
					</div>
			</fieldset>	
			
			<div id="todo_mng" style="text-align: right; margin-top: 30px; float:right;">
				<button type='button' class='btn btn-default btn-sm' style="padding:2px 20px 2px; font-size: 15px; font-weight: bold;" onclick="fn_clear();">신규</button>		
				<button type='button' class='btn btn-default btn-sm' style="padding:2px 20px 2px; font-size: 15px; font-weight: bold;" onclick="fn_mng('add');">저장</button>		
				<button type='button' class='btn btn-default btn-sm' style="padding:2px 20px 2px; font-size: 15px; font-weight: bold;" onclick="fn_mng('delete');">삭제</button>		
			</div>
		</div>
	</div>
</form>

</body>
</html>