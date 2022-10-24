package com.cloud.web.login.controller;

import java.io.Serializable;
import java.util.HashMap;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.cloud.web.common.domain.ReturnDataVo;
import com.cloud.web.common.domain.SessionVo;
import com.cloud.web.login.service.LoginService;

@Controller
@RequestMapping("/login")
public class LoginController implements Serializable {
	
	private static final long serialVersionUID = 1L;
	
	@Value("${spring.profiles.active}")
	String profiles;
	
	@Resource(name="loginService")
	private LoginService mapper;
	
	@RequestMapping("/view")
	public String loginPage() throws Exception {
		return "login";
	}
	
	/**
	 * 로그인
	 * @param hashmapParam(user_id, user_pwd)
	 * @return ReturnDataVo
	 */
	@RequestMapping(value="/checkLoginUser", method=RequestMethod.POST)
	public @ResponseBody ReturnDataVo checkLoginUser(@RequestParam HashMap<String, Object> hashmapParam, HttpServletRequest request) throws Exception {
		ReturnDataVo  result = new ReturnDataVo();
		HttpSession  session = request.getSession(true);//현재 session이 있으면 반환, 없으면 생성해서 반환 (=request.getSession() )
		//HttpSession session = request.getSession(false); : 현재 session이 있으면 반환, 없으면 null반환
		SessionVo loginUserVo = new SessionVo();
		loginUserVo = mapper.checkLoginUser(hashmapParam);
		HashMap<String, Object> loginHist = new HashMap<>();
		if(loginUserVo != null) {
			result.setResultCode("S000");
			result.setResultMsg("로그인에 성공하셨습니다.");
			session.setAttribute("S_USER", loginUserVo);
			session.setAttribute("S_LOGIN_YN", "Y");
			//로그인 성공 시 로그인 기록
			loginHist.put("log_user_id", hashmapParam.get("user_id"));
			loginHist.put("log_user_nm", loginUserVo.getUser_nm());
			loginHist.put("log_user_ip", request.getRemoteAddr());
			loginHist.put("log_tp_yn", session.getAttribute("S_LOGIN_YN"));
			mapper.createloginHist(loginHist);
		}else {
			result.setResultCode("S999");
			result.setResultMsg("아이디/패스워드가 등록되어있지 않습니다.");
			//로그인 실패 시
			loginHist.put("log_user_id", hashmapParam.get("user_id"));
			loginHist.put("log_user_nm", "미등록 사용자");
			loginHist.put("log_user_ip", "");
			loginHist.put("log_tp_yn", "N");
			mapper.createloginHist(loginHist);
		}
		return result;
	}
	
	/**
	 * 로그아웃
	 * @return 
	 */
	@RequestMapping("/logout")
	public String logout(HttpServletRequest request, HttpServletResponse response , RedirectAttributes redirectAttributes) {
		HttpSession session = request.getSession(true); //=request.getSession();
		if(session == null) {
			return "redirect:/login";
		}
		//session.getAttribute() : 현재 세션에 저장되어있는 값 얻어오기 -> 반환 타입에 맞게 다운 캐스팅 해야함
		String isLogin = (String) session.getAttribute("S_LOGIN_YN");
		SessionVo loginUserVo = (SessionVo) session.getAttribute("S_USER");
		
		//로그인이 되어있는 경우(세션에 로그인 정보가 저장되어있는 경우), session 값 삭제, 쿠키 삭제
		if(isLogin != null && "Y".equals(isLogin) && loginUserVo != null && !"".equals(loginUserVo.getUser_id())) {
			
			//session.setAttribute(key, session값) -> key값은 문자열, session값은 Object
			session.setAttribute("S_USER", null);
			session.setAttribute("S_LOGIN_YN", null);

			session.removeAttribute("S_USER");
			session.removeAttribute("S_LOGIN_YN");
			
			//쿠키 제거
			for(Cookie cookie : request.getCookies()) {
				if(cookie.getName().startsWith("_ga")) {
					//System.out.println(cookie.getName());
					cookie.setValue(null);
					cookie.setMaxAge(0);
					response.addCookie(cookie);
				}
			}
			session.invalidate(); //세션 전체 제거(무효화)
		}
		redirectAttributes.addFlashAttribute("logoutMag", "로그아웃 되었습니다.");
		return "redirect:/login";
	}
}