package com.cloud.web.common.domain;

import java.io.Serializable;

import lombok.Data;

@Data
public class PageingVo implements Serializable {

	private static final long serialVersionUID = 7227522246573477467L;
	
	//현재 페이지
	private int page = 1;
	//페이지 갯수
	private int total = 0;
	//전체 갯수
	private int records = 0;
	//페이지 크기 (한 페이지에 보여질 행 수)
	private int rows = 20;
}