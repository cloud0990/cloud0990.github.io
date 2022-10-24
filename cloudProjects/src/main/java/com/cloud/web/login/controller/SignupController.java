package com.cloud.web.login.controller;

import java.util.HashMap;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cloud.web.common.domain.ReturnDataVo;
import com.cloud.web.login.service.LoginService;
import com.cloud.web.login.service.SignUpService;

@Controller
@RequestMapping(value="/signUp")
public class SignupController {

	@Resource(name="signUpService")
	private SignUpService service;
	
	@RequestMapping(value="/view")
	public String signUpPage() {
		return "signUp";
	}
	
	/**
	 * 회원가입
	 * @param hashmapParam
	 * @return ReturnDataVo
	 */
	@RequestMapping(value="/insertUser", method=RequestMethod.POST)
	public @ResponseBody ReturnDataVo signUp(@RequestParam HashMap<String, Object> hashmapParam) {
		ReturnDataVo result = new ReturnDataVo();
		try {
			service.signUpUser(hashmapParam);
			result.setResultCode("S000");
		} catch (Exception e) {
			result.setResultCode("S999");
		}
		return result;
	}
	
	/**
	 * 닉네임 중복확인
	 * @param hashmapParam
	 * @return ReturnDataVo
	 */
	@RequestMapping(value="/chkUserNm", method=RequestMethod.POST)
	public @ResponseBody ReturnDataVo chkUserNm(@RequestParam HashMap<String, Object> hashmapParam) {
		ReturnDataVo result = new ReturnDataVo();
		try {
			int chkResult = service.chkUserNm(hashmapParam);
			if(chkResult == 0) {
				result.setResultCode("S000");
			}else {
				result.setResultCode("S999");
			}
		} catch (Exception e) {
			result.setResultCode("V999");
		}
		return result;
	}
}