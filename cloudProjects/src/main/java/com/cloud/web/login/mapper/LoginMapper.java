package com.cloud.web.login.mapper;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.cloud.web.common.domain.SessionVo;

//Service interface
@Repository("loginMapper")
//userDao
public interface LoginMapper {

	int getQueryTotalCnt();

	SessionVo checkLoginUser(HashMap<String, Object> hashmapParam);
	int chkUserNm(HashMap<String, Object> hashmapParam);
	
	int createloginHist(HashMap<String, Object> hashmapParam);
}	