package com.cloud.web.common.domain;

import java.io.Serializable;

import lombok.Data;

@Data
public class ReturnDataVo implements Serializable {
	
	private static final long serialVersionUID = 1533024539259264563L;
	
	private String resultCode;
	private String resultMsg;
	private Object data = null;
}