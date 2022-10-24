function callAjax(target, form, callback) {
	jQuery.ajax({
		type:'POST',
		url : target,
		data : form,
		dataType : 'json',
		cache: false,
		success : function(data) {
			if(data.resultCode=='S000') {
				callback(data);
			} else {
				alert('작업수행에 실패하였습니다.');
			}
		}
	});
}

function ConfirmAjax(text, target, form, callback) {
	if(text=="create") {
		text = "등록하시겠습니까?";
	}else if(text=="update") {
		text = "수정하시겠습니까?";
	}else if(text=="delete") {
		text = "삭제하시겠습니까?";
	}
	swal({
			title : text,
			type  : "warning",
			showCancelButton: true,
			confirmButtonColor:"#DD6B55",
			confirmButtonText:"예",
			cancelButtonText:"아니오",
			closeOnConfirm:true
		}, function(isConfirm) {
			if(!isConfirm) return;
			jQuery.ajax({
				type : "POST",
				url  : target,
				data : form,
				cache:false,
				dataType:"json",
				success:function(data){
					if(data.resultCode=="S000") {
						callback(data);
					}else {
						swal("실패", data.resultMsg, "error");
					}
				},
				error:function(data){
					swal("실패", "작업수행에 실패하였습니다.", "error");
				},
				timeout:100000
			});
		window.onkeydown=null;
		window.onfocus=null;
	})
}

function ConfirmDialogUpdateToAjax(target, form, callback) {
	swal({
			title : "수정하시겠습니까?",
			type  : "warning",
			showCancelButton: true,
			confirmButtonColor:"#DD6B55",
			confirmButtonText:"예",
			cancelButtonText:"아니오",
			closeOnConfirm:true
		}, function(isConfirm) {
			if(!isConfirm) return;
			jQuery.ajax({
				type : "POST",
				url  : target,
				data : form,
				cache:false,
				dataType:"json",
				success:function(data){
					if(data.resultCode=="S000") {
						callback(data);
					}else {
						swal("실패", data.resultMsg, "error");
					}
				},
				error:function(data){
					swal("실패", "작업수행에 실패하였습니다.", "error");
				},
				timeout:100000
			});
		window.onkeydown=null;
		window.onfocus=null;
	})
}
