package com.cloud.web.login.service;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.cloud.web.common.domain.SessionVo;
import com.cloud.web.login.mapper.LoginMapper;

//Mapper구현 객체 (=ServiceImpl)
@Service("loginService")
public class LoginService {
	
	@Resource(name="loginMapper")
	private LoginMapper mapper;
	
	public int getQueryTotalCnt() {
		return mapper.getQueryTotalCnt();
	}
	public SessionVo checkLoginUser(HashMap<String, Object> hashmapParam) {
		return mapper.checkLoginUser(hashmapParam);
	}
	public int chkUserNm(HashMap<String, Object> hashmapParam) {
		return mapper.chkUserNm(hashmapParam);
	}
	public int createloginHist(HashMap<String, Object> hashmapParam) {
		return mapper.createloginHist(hashmapParam);
	}
}