<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<c:set var="sessionVo" value="${sessionScope.S_USER}"></c:set>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>HOME : LOGIN HISTORY</title>
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
	
	/* Search Filter Enter key Event */
	$("#srch_text").keypress(function(e){
		if(e.keyCode && e.keyCode == 13) {
			if($("#srch_text").val()=='') {
				$("#srch_log option:eq(0)").prop("selected", true);
			}
			$("#srch_btn").trigger('click'); //trigger() : 이벤트 강제 발생
		}
	});
	/* Delete LoginHistory Enter key Event */
	$("input:radio[name='delData']").keypress(function(e){
		if(e.keyCode && e.keyCode == 13) {
			$("#log_del_btn").trigger('click');
		}
	});
	/* Search Filter Click Event */
	$("#srch_btn").click(function(){
		if($("#srch_text").val()=='') {
			$("#srch_log option:eq(0)").prop("selected", true);
		}
		fn_log_srch();
	});
	
	$("#mainGrid").jqGrid({
		url:"/main/selectLoginHist",
	    loadtext:"로딩 중..",
		datatype:"json", //데이터 타입(그리드를 채우는 데이터의 형식)
		mtype:"POST",    //데이터 전송방식(요청메소드 정의)
		height : 650,    //'auto' : 자동 높이 설정
		width : 820,
		shrinkToFit: true,
		colNames:['번호', '닉네임', '접속 아이디', '접속여부', '접속시도일', 'log_user_ip'],
		colModel: [
					{name:'log_id',  index:'log_id',  align:"center", width:"10px"},
					{name:'log_user_nm',  index:'log_user_nm',  align:"center", width:"30px"},
					{name:'log_user_id',  index:'log_user_id',  align:"center", width:"30px"},
					{name:'log_tp_yn',  index:'log_tp_yn',  align:"center", width:"15px"},
					{name:'log_date', index:'log_date', align:"center", width:"30px"},
					{name:'log_user_ip',  index:'log_user_ip',  hidden:true}
	              ],
        pager: "#pager",
        rowNum: 25,            //한 화면에 보여줄 행 수
	    rowList: [25, 50, 75], //5개보기, 10개보기, 15개보기 선택해서 보기 가능
		viewrecords: true,
		loadComplete: function() {
			$(".ui-state-default.jqgrid-rownum").removeClass('ui-state-default jqgrid-rownum');
            var rows = $("#mainGrid").jqGrid('getGridParam', 'records');        
            if(rows == 0 ){          
            	$("#mainGrid > tbody").append("<tr><td align='center' colspan='6' style=''>조회된 데이터가 없습니다.</td></tr>");       
           	}
		},
 		onSelectRow: function(index, row) { //index = 선택된 row의 index
 			if(index) {
 				var row = $("#mainGrid").jqGrid('getRowData', index);
 				$("#view_user_nm").val(row.log_user_nm);
 				$("#view_user_id").val(row.log_user_id);
 				$("#view_log_tp_yn").val(row.log_tp_yn);
 				$("#view_log_date").val(row.log_date);
 				$("#view_log_user_ip").val(row.log_user_ip);
 			}
	    },
	    gridComplete: function() {
	    	$("#mainGrid td").css("vertical-align", "middel");
	    } 
	});
});

/* Delete Login History Function */
function fn_log_hist_del() {
	
	var delData = $("input:radio[name='delData']:checked").val();
	
	if(!confirm('삭제하시겠습니까?')) return;
	callAjax("/main/deleteLoginHist", {delData:delData}, fn_result);
}

/* Ajax Callback Function */
function fn_result(data) {
	
	if(data.resultCode=="S000") {
		$("#mainGrid").setGridParam({url:"/main/selectLoginHist", page:1, datatype:"json"}).trigger("reloadGrid");
	}else {
		alert("작업수행에 실패하였습니다.");
	}
}

/* Login User Search Filter */
function fn_log_srch() {
	$("#mainGrid").clearGridData();
	$("#mainGrid").setGridParam({
		   url:"/main/selectLoginHist"
		 , postData: {
				  srch_log: $("#srch_log").val()
		   		, srch_text : $("#srch_text").val()	
		   }
		 , datatype:"json"
	}).trigger('reloadGrid');
}
</script>
<style type="text/css">
#pager_left {
	width:185px;
}
#gbox_mainGrid {
	margin-right:-50px;
}
</style>
</head>
<body>

<div id="content" style="float:left;">
	<div role="content">
		<div class="widget-body" style="padding:25px; margin-left:20px;">
			<fieldset>
				<div class="form-group" style="flex:center; float:left;">
					<label><span class="widget-icon"><i class="fa fa-list-ul"></i>&nbsp;&nbsp;&nbsp;로그인 기록</span></label>
				</div>
			<!-- 검색 -->
			<div class="input-group rounded" style="width:400px; float: right;">
			  <select id="srch_log" name="srch_log" style="border-radius: 3px; font-size: 13px; outline:none; border:none; margin-right:3px; width:120px;">
			  	<option value='srch_all'>전 체</option>
			  	<option value='srch_user_nm'>닉네임</option>
			  	<option value='srch_user_id'>접속 아이디</option>
			  	<option value='srch_log_tp_yn'>접속여부 [Y/N]</option>
			  </select>
			  <input type="search" id="srch_text" name="srch_text" class="form-control rounded" placeholder="검색" aria-label="Search" aria-describedby="search-addon"/>
			  <button type="button" class="btn btn-default btn-sm" style="padding:2px 10px 2px; box-shadow: none;" id="srch_btn">
			 	 <span class="input-group-text border-0" id="search-addon"><i class="fas fa-search"></i></span>
			  </button>
			</div>
			</fieldset>
			<!-- <hr style="margin-top:0px;"> -->
			<fieldset>		
				<div class="row" id="tableWrap" style="margin-top : 10px;">
					<table id="mainGrid"></table>
					<div id="pager"></div>
				</div>
			</fieldset>	
		</div>
	</div>
</div>
<div class="user_info" id="content" style="float:right; width:710px;">
	<div class="widget-body" style="padding:30px;">
		<fieldset>
			<div style="flex:center;">
				<label><span class="widget-icon"><i class="fa fa-list-alt txt-color-white"></i>&nbsp;&nbsp;&nbsp;로그인 상세정보</span></label>
			</div>
		</fieldset>
		<hr style="margin-top:10px;">
		<fieldset>		
			<legend style="padding-top:0px; font-size:14px; margin-bottom:5px; margin-top:15px;">닉네임</legend>
			<div>
				<input class="form-control input-sm" id="view_user_nm" disabled="disabled"/>					
			</div>
			<legend style="padding-top:0px; font-size:14px; margin-bottom:5px; margin-top:15px;">아이디</legend>
			<div>
				<input class="form-control input-sm" id="view_user_id" disabled="disabled"/>					
			</div>
			<legend style="padding-top:0px; font-size:14px; margin-bottom:5px; margin-top:15px;">접속 IP</legend>
			<div>
				<input class="form-control input-sm" id="view_log_user_ip" disabled="disabled"/>					
			</div>
			
			<div style="float:left; width:130px;">
			<legend style="padding-top:0px; font-size:14px; margin-bottom:5px; margin-top:15px;">접속 성공 여부</legend>
				<input class="form-control input-sm" id="view_log_tp_yn" disabled="disabled"/>					
			</div>
			<div style="float:right; width:517px;">
			<legend style="padding-top:0px; font-size:14px; margin-bottom:5px; margin-top:15px;">접속시도일</legend>
				<input class="form-control input-sm" id="view_log_date" disabled="disabled"/>					
			</div>
		</fieldset>
	</div>
	
	<div class="widget-body" style="padding:30px;">
		<fieldset>
			<div style="flex:center;">
				<label><span class="widget-icon"><i class="fa fa-list-alt txt-color-white"></i>&nbsp;&nbsp;&nbsp;로그인 데이터 관리</span></label>
			</div>
		</fieldset>
		<hr style="margin-top:10px;">
		<div style="margin-top:30px;">
			<div style="margin-right:30px; display: inline-block;">
				<input type="radio" class="form-check-input" name="delData" id="day" value="DAY" checked/>
				<label for="day" class="radio radio-inline">
					<span>일일</span>
				</label>
			</div>
			<div style="margin-right:30px; display: inline-block;">
				<input type="radio" class="form-check-input" name="delData" id="week" value="WEEK"/>	
				<label for="week" class="radio radio-inline">
					<span>주간</span>
				</label>
			</div>
			<div style="margin-right:30px; display: inline-block;">
				<input type="radio" class="form-check-input" name="delData" id="month" value="MONTH"/>
				<label for="month" class="radio radio-inline">
					<span>월간</span>
				</label>
			</div>
			<div style="margin-right:30px; display: inline-block;">
				<input type="radio" class="form-check-input" name="delData" id="all" value="ALL"/>	
				<label for="all" class="radio radio-inline">
					<span>일괄</span>
				</label>
			</div>
			<div style="margin-right:30px; display: inline-block;">
				<input type="radio" class="form-check-input" name="delData" id="failed" value="failed"/>	
				<label for="failed" class="radio radio-inline">
					<span>로그인 실패</span>
				</label>
			</div>
		</div>
		<div id="del_btn" style="text-align: right; font-weight: bold; padding:10px;">
			<button type='button' class='btn btn-default btn-sm' style="padding:2px 20px 2px; font-weight: bold; font-size: 15px;" id="log_del_btn" onclick="fn_log_hist_del();">삭제</button>		
		</div>
	</div>
</div>

</body>
</html>