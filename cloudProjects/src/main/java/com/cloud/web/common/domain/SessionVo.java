package com.cloud.web.common.domain;

import java.io.Serializable;

import org.apache.ibatis.type.Alias;

@Alias("sessionVo")
//@Data
public class SessionVo implements Serializable {
	
	private static final long serialVersionUID = 1L;
	
	private int    user_idx;
	private String user_id;
	private String user_pwd;
	private String user_nm;
	private String user_date;
	private String upd_date; 
	//로그인 기록
	private String log_user_ip;
	private String log_user_nm;
	private String log_date;
	private String log_tp_yn; //로그인 성공 여부
	
	public int getUser_idx() {
		return user_idx;
	}
	public String getUser_id() {
		return user_id;
	}
	public String getUser_pwd() {
		return user_pwd;
	}
	public String getUser_nm() {
		return user_nm;
	}
	public String getUser_date() {
		return user_date;
	}
	public String getUpd_date() {
		return upd_date;
	}
	public String getLog_user_ip() {
		return log_user_ip;
	}
	public String getLog_user_nm() {
		return log_user_nm;
	}
	public String getLog_date() {
		return log_date;
	}
	public String getLog_tp_yn() {
		return log_tp_yn;
	}
	public void setUser_idx(int user_idx) {
		this.user_idx = user_idx;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public void setUser_pwd(String user_pwd) {
		this.user_pwd = user_pwd;
	}
	public void setUser_nm(String user_nm) {
		this.user_nm = user_nm;
	}
	public void setUser_date(String user_date) {
		this.user_date = user_date;
	}
	public void setUpd_date(String upd_date) {
		this.upd_date = upd_date;
	}
	public void setLog_user_ip(String log_user_ip) {
		this.log_user_ip = log_user_ip;
	}
	public void setLog_user_nm(String log_user_nm) {
		this.log_user_nm = log_user_nm;
	}
	public void setLog_date(String log_date) {
		this.log_date = log_date;
	}
	public void setLog_tp_yn(String log_tp_yn) {
		this.log_tp_yn = log_tp_yn;
	}
}