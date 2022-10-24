package com.cloud.web.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.Ordered;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;

import com.cloud.web.common.interceptor.InterceptorConfig;

@SuppressWarnings("deprecation") //경고 무시
@Configuration	
@ComponentScan("com.cloud.web")
//@EnableWebMvc : 스프링부트의 기본적인 웹 MVC기능들을 제외하고 처음부터 생성한다.
public class WebConfig extends WebMvcConfigurerAdapter implements WebMvcConfigurer {
	
	@Override
	public void addViewControllers(ViewControllerRegistry registry) {
		// "/"에 해당하는 url mapping을 setViewName으로 forward
		registry.addViewController("/").setViewName("forward:/main");
		// 우선순위를 가장 높게 잡는다.
		registry.setOrder( Ordered.HIGHEST_PRECEDENCE );
		super.addViewControllers(registry);
	}

	@Autowired
	private InterceptorConfig testInterceptor;
	
	// addPathPatterns     : 해당 경로에 접근하기 전, 인터셉터가 가로챈다.
	// excludePathPatterns : 해당 경로는 인터셉터가 가로채지 않는다.
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		registry.addInterceptor(testInterceptor)
		.addPathPatterns("/**")
		.excludePathPatterns("*.css")
		.excludePathPatterns("*.js")
		.excludePathPatterns("/assets/plugin/js/jqgird/**")
		.excludePathPatterns("/assets/css/**")
		.excludePathPatterns("/assets/common/**")
		.excludePathPatterns("/assets/dev/**")
		.excludePathPatterns("/login/view")
		.excludePathPatterns("/logout")
		.excludePathPatterns("/checkLoginUser") //회원체크
		.excludePathPatterns("/signUp/view")    //회원가입 페이지 forword
		.excludePathPatterns("/signUp/**");     //insertUser
	}
}