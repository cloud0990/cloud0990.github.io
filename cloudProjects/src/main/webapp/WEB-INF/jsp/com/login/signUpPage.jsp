<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name ="google-signin-client_id" content="697342832307-9o74r3mkkp8buqlbnagvus5ksr4b555q.apps.googleusercontent.com">
<title>SIGN UP</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet"/>
<link href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap" rel="stylesheet"/>
<link href="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/4.3.0/mdb.min.css" rel="stylesheet"/>
<style type="text/css">
.gradient-custom-2 {
/* fallback for old browsers */
background: #fccb90;

/* Chrome 10-25, Safari 5.1-6 */
background: -webkit-linear-gradient(to right, #ee7724, #d8363a, #dd3675, #b44593);

/* W3C, IE 10+/ Edge, Firefox 16+, Chrome 26+, Opera 12+, Safari 7+ */
background: linear-gradient(to right, #ee7724, #d8363a, #dd3675, #b44593);
}

@media (min-width: 768px) {
.gradient-form {
height: 100vh !important;
}
}
@media (min-width: 769px) {
	.gradient-custom-2 {
	border-top-right-radius: .3rem;
	border-bottom-right-radius: .3rem;
	}
}
</style>
<script type="text/javascript">
$(function(){
	/* 회원가입 엔터 처리 */
	$("#user_nm").keypress(function(e){
		if(e.keyCode && e.keyCode == 13) {
			if(!confirm('회원가입 하시겠습니까?')) return;			
			$("#signUp").trigger('click'); //trigger() : 이벤트 강제 발생
		}
	});
	
	$("#signUp").click(function(){
		if(!confirm('회원가입 하시겠습니까?')) return;

		var user_id  = $("#user_id").val();
		var user_pwd = $("#user_pwd").val();
		var confirm_user_pwd = $("#confirm_user_pwd").val();
		var user_nm  = $("#user_nm").val();
	
		if(user_id == '') {
			$("#user_id").css("border", "2px solid red");
			$("#user_id").css("box-shadow", "0 0 3px red");
			alert('아이디를 입력해주세요.');
			return;
		}
		if(user_pwd == '') {
			$("#user_pwd").css("border", "2px solid red");
			$("#user_pwd").css("box-shadow", "0 0 3px red");
			alert('비밀번호를 입력해주세요.');
			return;
		}
		if(confirm_user_pwd == '') {
			$("#confirm_user_pwd").css("border", "2px solid red");
			$("#confirm_user_pwd").css("box-shadow", "0 0 3px red");
			alert('비밀번호 확인이 필요합니다.');
			return;
		}
		if(user_nm == '') {
			$("#user_nm").css("border", "2px solid red");
			$("#user_nm").css("box-shadow", "0 0 3px red");
			alert('닉네임을 입력해주세요.');
			return;
		}
		if(user_pwd != confirm_user_pwd) {
			$("#user_pwd").css("border", "2px solid red");
			$("#user_pwd").css("box-shadow", "0 0 3px red");
			$("#confirm_user_pwd").css("border", "2px solid red");
			$("#confirm_user_pwd").css("box-shadow", "0 0 3px red");
			alert('비밀번호가 일치하지 않습니다.');
			return;
		}
		
		$.post("/signUp/insertUser"
				, {user_id:user_id, user_pwd:user_pwd, user_nm:user_nm}
				, function(data){
					var resultCode = data.resultCode;
					if(resultCode=='S000'){
						location.href='/login';
						alert("회원가입이 완료되었습니다.\n로그인 화면으로 이동합니다.");
					}else if(resultCode=='S999'){
						//$("#user_id").focus();
						//$("#user_pwd").focus();
						//$("#user_nm").focus();
						$("#user_id").attr("style", "border: 2px solid red;");
						$("#user_pwd").attr("style", "border: 2px solid red;");					
						$("#user_nm").attr("style", "border: 2px solid red;");
						alert("작업수행에 실패하였습니다.\n다시 시도해주세요.");
						return false;
				   }
		});
	});
	
	/* 닉네임 중복체크 */
	$("#duplChk").click(function(){
		var user_nm  = $("#user_nm").val();
		
		$.post("/signUp/chkUserNm"
				, {user_nm:user_nm}
				, function(data){
					var resultCode = data.resultCode;
					if(resultCode=='S000'){
						alert("사용할 수 있는 닉네임입니다.");
					}else if(resultCode=='S999'){
						alert("중복된 닉네임입니다.");
						return false;
				   }else if(resultCode=='V999') {
						alert("작업수행에 실패하였습니다.");
						return false;
				   }
		});
	});
}); //end : function
</script>
<!-- 구글 API -->
<script>
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
}
</script>
<script src="https://apis.google.com/js/platform.js?onload=init" async defer></script>
</head>
<body>

<section class="vh-100" style="background-color: #508bfc;">
  <div class="container py-5 h-100">
    <div class="row d-flex justify-content-center align-items-center h-100">
      <div class="col-12 col-md-8 col-lg-6 col-xl-5">
        <div class="card shadow-2-strong" style="border-radius: 1rem;">
          <div class="card-body p-5 text-center">
            <h5 class="mb-5" style="font-weight: 700">회원가입</h5>
            <div class="form-outline mb-4" style="text-align: left;">
              <label class="form-label" for="user_id" style="font-size: 14px; font-weight: 700;">아이디</label>
              <input type="text" id="user_id" class="form-control form-control-lg" style="border:1px solid gray;"/>
            </div>
            <div class="form-outline mb-4" style="text-align: left; width:213px; float:left;">
              <label class="form-label" for="user_pwd" style="font-size: 14px; font-weight: 700;">비밀번호</label>
              <input type="password" id="user_pwd" class="form-control form-control-lg" style="border:1px solid gray;"/>
            </div>
            <div class="form-outline mb-4" style="text-align: left; width:213px; float:right;">
              <label class="form-label" for="confirm_user_pwd" style="font-size: 14px; font-weight: 700;">비밀번호 확인</label>
              <input type="password" id="confirm_user_pwd" class="form-control form-control-lg" style="border:1px solid gray;"/>
            </div>
             
            <div class="form-outline mb-4" style="text-align: left; clear:both;">
            <label class="form-label" for="user_nm" style="font-size: 14px; font-weight: 700;">닉네임</label><br>
              <input type="text" id="user_nm" class="form-control form-control-lg" style="border:1px solid gray; width:345px; display: inline-block;" />
              <div style="display: inline-block;">
	              <button type="button" class='btn btn-default btn-sm' id="duplChk" style="font-weight: bold; font-size: 12px;">중복확인</button>
              </div>
            </div>
            <div class="text-center text-lg-start mt-4 pt-2">
	            <button type="button" class="btn btn-primary btn-block mb-4" id="signUp" style="font-size: 15px;">회원가입</button>
	            <p class="small fw-bold mt-2 pt-1 mb-0">이미 가입하셨습니까? <a href="/login" class="link-danger">로그인</a></p>
            </div>
            <hr class="my-4">
            <button class="btn btn-lg btn-block btn-primary" id="google_login_btn" style="background-color: #dd4b39;" type="submit"><i class="fab fa-google me-2"></i> 구글 회원가입</button>
           <!--  <button class="btn btn-lg btn-block btn-primary mb-2" id="facebook_login_btn" style="background-color: #3b5998;" type="submit"><i class="fab fa-facebook-f me-2"></i> 페이스북 회원가입</button> -->
          </div>
        </div>
      </div>
    </div>
  </div>
</section>
	
</body>
</html>