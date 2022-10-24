package com.cloud.web.login.mapper;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Repository;

import com.cloud.web.common.domain.SessionVo;

//Service interface
@Repository("signUpMapper")
//userDao
public interface SignUpMapper {

	int getQueryTotalCnt();

	int signUpUser(HashMap<String, Object> hashmapParam);
	int chkUserNm(HashMap<String, Object> hashmapParam);
}	