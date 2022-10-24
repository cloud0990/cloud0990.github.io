<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- <meta name ="google-signin-client_id" content="697342832307-9o74r3mkkp8buqlbnagvus5ksr4b555q.apps.googleusercontent.com"> -->
<!-- <meta name="description" content=""> -->
<title>LOGIN</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap" rel="stylesheet"/>
<link href="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/4.3.0/mdb.min.css" rel="stylesheet"/>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>
<style type="text/css">
.divider:after,
.divider:before {
content: "";
flex: 1;
height: 1px;
background: #eee;
}
.h-custom {
height: calc(100% - 73px);
}
@media (max-width: 450px) {
	.h-custom {
		height: 100%;
	}
}
</style>
<script type="text/javascript">
$(function(){
	/* Login Enter key Event */
	$("#user_id").keypress(function(e){
		if(e.keyCode && e.keyCode == 13) {
			$("#login").trigger('click');
		}
	});
	$("#user_pwd").keypress(function(e){
		if(e.keyCode && e.keyCode == 13) {
			$("#login").trigger('click');
		}
	});
	/* Remember Id Enter key Event */
	$("#rememberId").keypress(function(e){
		if(e.keyCode && e.keyCode == 13) {
			$("#rememberId").trigger('click');
		}
	});
	
	/* Login Button Click Event */
	$("#login").click(function(){
		user_id  = $("#user_id").val();
		user_pwd = $("#user_pwd").val();
		
		if(user_id == '') {
			$("#user_id").css("border", "2px solid red");
			$("#user_id").css("box-shadow", "0 0 3px red");
			alert('아이디를 입력해주세요');	
			return;
		}
		if(user_pwd == '') {
			$("#user_pwd").css("border", "2px solid red");
			$("#user_pwd").css("box-shadow", "0 0 3px red");
			alert('비밀번호를 입력해주세요');	
			return;
		}
		
		$.post("/checkLoginUser"
			  , {user_id:user_id, user_pwd:user_pwd}
			  , function(data){
				  var resultCode = data.resultCode;
				  var resultMsg  = data.resultMsg;
				  if(resultCode=='S000') {
				   	  location.href='/main/view';
					  alert(resultMsg);
				  } else if(resultCode=='S999') {
					  $("#user_id").attr("style", "border: 2px solid red;");
					  $("#user_pwd").attr("style", "border: 2px solid red;");
					  alert(resultMsg);
					  return false;
				  }
		});
	});
});	
</script>
<script type="text/javascript">
$(function(){
	/* Remember Id related to Function */
	
	//저장된 쿠키값을 가져온다. 없으면 공백
	var key = getCookie("key");
	$("#user_id").val(key);
	//처음 페이지 로딩 시, ID 입력칸에 ID가 표시된 상태인 경우
	if($("#user_id").val() != "") {
		$("#rememberId").attr("checked", true); //chekced 상태로 둔다. 
	}
	//체크박스에 변화가 있는 경우
	$("#rememberId").change(function(){
		if($("#rememberId").is(":checked")) {
			setCookie("key", $("#user_id").val(), 7); //7일 동안 쿠키 보관
		}else { //체크 해제 시, 쿠키 삭제
			deleteCookie("key");			
		}	
	});
	//rememberId가 체크된 상태에서 ID를 입력하는 경우
	$("#user_id").keyup(function(){
		if($("#rememberId").is(":checked")) {
			setCookie("key", $("#user_id").val(), 7);
		}
	});
});
//Insert Cookie : Cookie is stored to window.document.cookie
function setCookie(cookieName, value, exdays) {
	var exdate = new Date();
	exdate.setDate(exdate.getDate() + exdays);
	var cookieValue = escape(value) + ((exdays==null) ? "" : "; expires=" + exdate.toGMTString()); //escape() : 한글깨짐 막기
	document.cookie = cookieName + "=" + cookieValue;
}
//Delete Cookie
function deleteCookie(cookieName) {
	var expire = new Date(); //현재시간 불러오기
	expire.setDate(expire.getDate() - 1);
	document.cookie = cookieName + "=" + "; expires=" + expire.toGMTString();
}
//Get Cookie
function getCookie(cookieName) {
	cookieName = cookieName + "=";
	var cookieData = document.cookie; //Get Current Cookie Value 
	var start = cookieData.indexOf(cookieName);
	var cookieValue = '';
	if(start != -1) {
		start += cookieName.length;
		var end = cookieData.indexOf(';', start);
		if(end == -1) end = cookieData.length;
		cookieValue = cookieData.substring(start, end);
	}
	return unescape(cookieValue);	
}
</script>
<!-- Google Login API -->
<script>
/* Init Function
function init() {
	gapi.load('auth2', function() {
		gapi.auth2.init();
		options = new gapi.auth2.SigninOptionsBuilder();
		options.setPrompt('select_account');
        // 추가는 Oauth 승인 권한 추가 후 띄어쓰기 기준으로 추가
		options.setScope('email profile openid https://www.googleapis.com/auth/user.birthday.read');
        // 인스턴스의 함수 호출 - element에 로그인 기능 추가
        // GgCustomLogin은 li태그안에 있는 ID, 위에 설정한 options와 아래 성공,실패시 실행하는 함수들
		gapi.auth2.getAuthInstance().attachClickHandler('google_login_btn', options, onSignIn, onSignInFailure);
	})
}
function onSignIn(googleUser) {
	var access_token = googleUser.getAuthResponse().access_token
	$.ajax({
		  url: 'https://people.googleapis.com/v1/people/me' 
		, data: {personFields:'birthdays', key:'AIzaSyBbDk2F66S-MUF8Y3bbVFMzDf990_SJoc8', 'access_token': access_token}
		, method:'GET'
	})
	.done(function(e){
		var profile = googleUser.getBasicProfile();
	})
	.fail(function(e){
		console.log(e);
	})
}
function onSignInFailure(t){		
	console.log(t);
} */
</script>
<!-- Using for Google API
<script src="https://apis.google.com/js/platform.js?onload=init" async defer></script>-->
</head>
<body>

<section class="vh-100">
  <div class="container-fluid h-custom">
    <div class="row d-flex justify-content-center align-items-center h-100">
      <div class="col-md-9 col-lg-6 col-xl-5">
        <img src="https://mdbcdn.b-cdn.net/img/Photos/new-templates/bootstrap-login-form/draw2.webp" class="img-fluid" alt="Sample image">
      </div>
      <div class="col-md-8 col-lg-6 col-xl-4 offset-xl-1">
        <form class="form-horizontal" id="frm_login_info">
		  <!-- Google Login API -->        
          <div class="d-flex flex-row align-items-center justify-content-center justify-content-lg-start">
            <button type="button" class="btn btn-lg btn-block btn-primary" id="google_login_btn" style="background-color: #dd4b39;">
            	<i class="fab fa-google me-2"></i> 구글 로그인</button>
           <!--  <button type="button" class="btn btn-lg btn-block btn-primary mb-2" id="facebook_login_btn" style="background-color: #3b5998;">
            	<i class="fab fa-facebook-f me-2"></i> 페이스북 로그인</button> -->
          </div> 
          <div class="divider d-flex align-items-center my-4">
            <p class="text-center fw-bold mx-3 mb-0">Or</p>
          </div>

          <div class="form-outline mb-4">
            <label class="form-label" for="user_id">아이디</label>
            <input type="text" id="user_id" class="form-control form-control-lg" style="border:1px solid gray;"/>
          </div>
          <div class="form-check mb-0">
            <label class="form-check-label" for="rememberId">아이디 저장</label>
            <input class="form-check-input me-2" type="checkbox" value="" id="rememberId" />
          </div>
          <br>
          <div class="form-outline mb-3">
            <label class="form-label" for="user_pwd">비밀번호</label>
            <input type="password" id="user_pwd" class="form-control form-control-lg" style="border:1px solid gray;"/>
          </div>
          <div class="text-center text-lg-start mt-4 pt-2">
            <button type="button" class="btn btn-primary btn-lg" style="padding-left: 2.5rem; padding-right: 2.5rem;" id="login">LOGIN</button>
            <p class="small fw-bold mt-2 pt-1 mb-0">회원이 아니십니까? <a href="/signUp/view" class="link-danger">Sign in</a></p>
          </div><br>
          <div class="d-flex justify-content-between align-items-center">
            <a href="#exampleModal" class="text-body">비밀번호 찾기</a> 
          </div>
        </form>
      </div>
    </div>
  </div>
  <div class="d-flex flex-column flex-md-row text-center text-md-start justify-content-between py-4 px-4 px-xl-5 bg-primary">
    <div class="text-white mb-3 mb-md-0">Copyright © 2020. All rights reserved.</div>
  </div>
</section>

</body>
</html>