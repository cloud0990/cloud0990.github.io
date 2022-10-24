<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles" %>
<%
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);
%> 
<!DOCTYPE html>
<html lang="ko-kr">
<head>
<meta charset="UTF-8">
<meta name="description" content="">

<!-- BootStrap css -->
<link rel="stylesheet" media="screen" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />
<link rel="stylesheet" media="screen" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap" />
<link rel="stylesheet" media="screen" href="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/4.3.0/mdb.min.css" />

<!-- jqGrid css --> 
<link rel="stylesheet" media="screen" href="https://cdnjs.cloudflare.com/ajax/libs/jqgrid/5.7.0/css/ui.jqgrid.min.css"/>
<link rel="stylesheet" media="screen" href="https://cdnjs.cloudflare.com/ajax/libs/jqgrid/5.7.0/css/ui.jqgrid-bootstrap-ui.min.css"/>
<link rel="stylesheet" media="screen" href="https://cdnjs.cloudflare.com/ajax/libs/jqgrid/5.7.0/css/ui.jqgrid-bootstrap5.min.css"/>

<!-- sweetAlert css -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-sweetalert/1.0.1/sweetalert.css"/> 

<!-- select2 -->
<link rel="stylesheet" media="screen" href="https://cdn.jsdelivr.net/npm/select2@4.1.0-beta.1/dist/css/select2.min.css" />

<!-- jQuery Ajax -->
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript" src="/assets/common/ajaxCommon.js"></script>
<script type="text/javascript" src="/assets/common/jquery.form.js"></script>

<script src="//cdnjs.cloudflare.com/ajax/libs/validate.js/0.12.0/validate.min.js"></script>

<!-- sweetAlert2 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-sweetalert/1.0.1/sweetalert.min.js"></script> 

<!-- jgGrid -->
<script type="text/javascript" src="/assets/plugin/js/jqgrid/jquery.jqGrid.min.js"></script>
<script type="text/javascript" src="/assets/plugin/js/jqgrid/grid.locale-en.min.js"></script>


<style type="text/css">
* {
margin:0px;
padding:0px;
}
.ui-jqgrid {
font-size:15px;
} 
.ui-jqgrid .ui-jqgrid-htable th div {
    height:30px;
    font-weight: bold;
    background-color: #F8F8F8;
    overflow:hidden;
    padding-right:2px;
    padding-left:2px;
    padding-top:4px;
    padding-bottom:4px;
    position:relative;
    vertical-align:text-top;
    white-space:normal !important;
}
#jqgh_mainGrid_rn {
	background-color:white;
}
#pager {
	height:40px;
}
.ui-jqgrid-btable tr:hover {
	background-color: #EAEAEA;
}
.ui-jqgrid .ui-jqgrid-titlebar {
	background-image: -webkit-linear-gradient(top, #FFFFFF, #CCCCCC);
}
.ui-jqgrid tr .ui-row-ltr td {
	padding: 3px 4px;
}
</style>
</head>
<body>
<tiles:insertAttribute name="header"/>
<tiles:insertAttribute name="body"/>

<script type="text/javascript">
$(function(){
	//remove classes
	$(".ui-jqgrid").removeClass("ui-widget ui-widget-content");	
	$(".ui-jqgrid-view").children().removeClass("ui-widget-header ui-state-default");	
	$(".ui-jqgrid-pager").removeClass("ui-state-default");	
	$(".ui-jqgrid").removeClass("ui-widget-content");	
	//add calsses
	$(".ui-jqgrid-htable").addClass("table table-bordered table-hover");	
	$(".ui-jqgrid-btable").addClass("table table-bordered table-striped");	
	
	$(".ui-pg-div").removeClass().addClass("btn btn-sm btn-primary");	
	$(".ui-icon.ui-icon-plus").removeClass().addClass("fa fa-plus");	
	$(".ui-icon.ui-icon-pencil").removeClass().addClass("fa fa-pencil");	
	$(".ui-icon.ui-icon-trash").removeClass().addClass("fa fa-trash-o");	
	$(".ui-icon.ui-icon-search").removeClass().addClass("fa fa-search");	
	$(".ui-icon.ui-icon-refresh").removeClass().addClass("fa fa-refresh");	
	$(".ui-icon.ui-icon-disk").removeClass().addClass("fa fa-save").parent(".btn-primary").removeClass("btn-primary").addClass("btn-success");	
	$(".ui-icon.ui-icon-cancel").removeClass().addClass("fa fa-times").parent(".btn-primary").removeClass("btn-primary").addClass("btn-danger");	

	$(".ui-icon.ui-icon-seek-prev").wrap("<div class='btn btn-sm btn-default'></div>");	
	$(".ui-icon.ui-icon-seek-prev").removeClass().addClass("fas fa-angle-left");
	
	$(".ui-icon.ui-icon-seek-first").wrap("<div class='btn btn-sm btn-default'></div>");
	$(".ui-icon.ui-icon-seek-first").removeClass().addClass("fas fa-angle-double-left");
	
	$(".ui-icon.ui-icon-seek-next").wrap("<div class='btn btn-sm btn-default'></div>");
	$(".ui-icon.ui-icon-seek-next").removeClass().addClass("fas fa-angle-right");
	
	$(".ui-icon.ui-icon-seek-end").wrap("<div class='btn btn-sm btn-default'></div>");
	$(".ui-icon.ui-icon-seek-end").removeClass().addClass("fas fa-angle-double-right");
	
/* 
	$(".ui-jqgrid-htable").each(function(){
		$(this).css("width", "" + eval($(this).width()+3.5)+"px");		
	}); 
*/
});	
</script>

</body>
</html>