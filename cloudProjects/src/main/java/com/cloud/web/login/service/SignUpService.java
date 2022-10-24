package com.cloud.web.login.service;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.cloud.web.common.domain.SessionVo;
import com.cloud.web.login.mapper.LoginMapper;
import com.cloud.web.login.mapper.SignUpMapper;

//Mapper구현 객체 (=ServiceImpl)
@Service("signUpService")
public class SignUpService {
	
	@Resource(name="signUpMapper")
	private SignUpMapper mapper;
	
	public int getQueryTotalCnt() {
		return mapper.getQueryTotalCnt();
	}
	public int signUpUser(HashMap<String, Object> hashmapParam) {
		return mapper.signUpUser(hashmapParam);
	}
	public int chkUserNm(HashMap<String, Object> hashmapParam) {
		return mapper.chkUserNm(hashmapParam);
	}
}