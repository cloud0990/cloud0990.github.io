package com.cloud.web.login.service;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.cloud.web.common.domain.SessionVo;
import com.cloud.web.login.mapper.LoginMapper;
import com.cloud.web.login.mapper.MainMapper;

//Mapper구현 객체 (=ServiceImpl)
@Service("mainService")
public class MainService {
	
	@Resource(name="mainMapper")
	private MainMapper mapper;
	
	public int getQueryTotalCnt() {
		return mapper.getQueryTotalCnt();
	}
	public int signUpUser(HashMap<String, Object> hashmapParam) {
		return mapper.signUpUser(hashmapParam);
	}
	public SessionVo changeUser(HashMap<String, Object> hashmapParam) {
		return mapper.changeUser(hashmapParam);
	}
	public List<HashMap<String, Object>> selectUserList(HashMap<String, Object> hashmapParam) {
		return mapper.selectUserList(hashmapParam);
	}
	public List<HashMap<String, Object>> selectLoginHist(HashMap<String, Object> hashmapParam) {
		return mapper.selectLoginHist(hashmapParam);
	}
	public List<HashMap<String, Object>> srchUserListRetrieve(HashMap<String, Object> hashmapParam) {
		return mapper.srchUserListRetrieve(hashmapParam);
	}
	public int deleteUser(HashMap<String, Object> hashmapParam) {
		return mapper.deleteUser(hashmapParam);
	}
	public int createloginHist(HashMap<String, Object> hashmapParam) {
		return mapper.createloginHist(hashmapParam);
	}
	public int deleteLoginHist(HashMap<String, Object> hashmapParam) {
		return mapper.deleteLoginHist(hashmapParam);
	}
	public int allDeleteLoginHist() {
		return mapper.allDeleteLoginHist();
	}
	public List<HashMap<String, Object>> getLogRetrieve(HashMap<String, Object> hashmapParam) {
		return mapper.getLogRetrieve(hashmapParam);
	}
	public int updateUser(HashMap<String, Object> hashmapParam) {
		return mapper.updateUser(hashmapParam);
	}
	public int chkUserNm(HashMap<String, Object> hashmapParam) {
		return mapper.chkUserNm(hashmapParam);
	}
}