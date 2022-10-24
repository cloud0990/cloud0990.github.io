package com.cloud.web.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.LoggerFactory;
import org.slf4j.Logger;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.cloud.web.common.domain.SessionVo;

@Component
public class InterceptorConfig extends HandlerInterceptorAdapter implements HandlerInterceptor {
	
	//로그를 남기려는 클래스에 Logger객체를 필드로 선언한다.
	static final Logger logger = (Logger) LoggerFactory.getLogger(InterceptorConfig.class);
	
	//Alt + Shift + S -> V implement Methods 원하는 메소드 자동 생성
	//컨트롤러에 접근하기 전 실행 / false를 리턴하면 다음 내용(Controller)을 실행하지 않는다. (true : Controller 실행)
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		HttpSession session = request.getSession(false);
		String requestURI = request.getRequestURI();
		
		//getSession(false) : 현재 세션이 존재하면 현재 세션 반환 / 존재하지않으면 null 반환
		if(session == null) {
			logger.debug( (String) request.getAttribute("S_LOGIN_YN"));
			logger.debug("isLogon : X");
			
			response.sendRedirect("/login/view");
			return false;
		}else {
			String isLogon = (String) session.getAttribute("S_LOGIN_YN");
			logger.debug("isLogon : " + isLogon);
			SessionVo member = (SessionVo) session.getAttribute("S_USER");
			if(isLogon==null || !"Y".equals(isLogon) || member==null) {
				response.sendRedirect("/login/view");
				return false;
			}
			//HashMap<String, Object> testMap = new HashMap<String, Object>();
			//testMap.put("url", request.getRequestURI());
			//request.getRequestURI : 프로젝트 + 파일경로까지 가져옴 (getRequestURL : 전체경로 가져옴 -> http://...)
			//response.sendRedirect("/main");
			return true;
//			if("/login".equals(requestURI)) {
//				return true;
//			}else {
//				response.sendRedirect("/login");
//				return false;
//			}
		}
		//return HandlerInterceptor.super.preHandle(request, response, handler);
	}

	//컨트롤러 경유 후, View 랜더링 전 실행 / Controller에서 예외가 발생되면 실행하지 않는다.
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
		super.postHandle(request, response, handler, modelAndView);
	}
	
	// Controller 진입 후, View가 랜더링 된 후에 실행
	// 클라이언트 요청을 마치고, 클라이언트에서 뷰를 통해 응답을 전송한 뒤 실행된다.
	// 뷰를 생성할 때 예외가 발생할 경우에도 실행이 된다.
	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
		super.afterCompletion(request, response, handler, ex);
	}
}