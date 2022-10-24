package com.cloud.web.login.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cloud.web.common.domain.PageingVo;
import com.cloud.web.common.domain.ReturnDataVo;
import com.cloud.web.common.domain.SessionVo;
import com.cloud.web.common.util.DateUtil;
import com.cloud.web.login.service.LoginService;
import com.cloud.web.login.service.MainService;

@Controller
@RequestMapping("/main")
public class MainController {
	
	@Resource(name="mainService")
	private MainService mapper;
	
	@RequestMapping("/view")
	public String mainPage() {
		return "mainPage";
	}
	@RequestMapping("/loginhist")
	public String loginhistPage() throws Exception {
		return "login/loginHist";
	}
	
	/**
	 * 사용자 조회
	 * @param hashmapParam
	 * @param PageingVo
	 * @return HashMap
	 */
	@RequestMapping(value="/selectUserList", method=RequestMethod.POST)
	public @ResponseBody HashMap<String, Object> selectUserList(@ModelAttribute("pageing") PageingVo pageing, @RequestParam HashMap<String, Object> hashmapParam) throws Exception {
		List<HashMap<String, Object>> resultList = new ArrayList<HashMap<String, Object>>();
		HashMap<String, Object>  hashmapResult = new HashMap<String, Object>();
		
		//페이징 처리 시, 반드시 try~catch로 예외처리 할 것
		try {
			Integer page = pageing.getPage();
			if(page == 0) page = (Integer) 1;
			Integer rows  = pageing.getRows();
			Integer start = (page - 1) * rows;
			Integer end   = rows;
			
			hashmapParam.put("start", start);
			hashmapParam.put("end", end);
			
			resultList = mapper.selectUserList(hashmapParam);
			int records = mapper.getQueryTotalCnt();
			
			/* Day Setting */
			for(int i=0; i<resultList.size(); i++) {
				String user_date = (String)resultList.get(i).get("user_date"); // = String.valueOf
				String upd_date = (String)resultList.get(i).get("upd_date");
				String userDay = DateUtil.getDateDay(user_date, "yyyy-MM-dd");
				String updDay;
				String resultUpdDay;
				
				if(upd_date != null) {
					updDay = DateUtil.getDateDay(upd_date, "yyyy-MM-dd");
					resultUpdDay = (String)user_date.format("%s (%s)", upd_date, updDay);
				}else {
					updDay = "";
					resultUpdDay = "";
				}
				
				String resultUserDay = (String)user_date.format("%s (%s)", user_date, userDay);
				
				resultList.get(i).remove("user_date");
				resultList.get(i).remove("upd_date");
				resultList.get(i).put("user_date", resultUserDay);
				resultList.get(i).put("upd_date", resultUpdDay);
			}

			pageing.setRecords(records);
			pageing.setTotal( (int) Math.ceil((double)records / (double)pageing.getRows()));
			
			hashmapResult.put("page", pageing.getPage());
			hashmapResult.put("total", pageing.getTotal());
			hashmapResult.put("records", pageing.getRecords());
			hashmapResult.put("rows", resultList);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return hashmapResult;
	}
	
	/**
	 * 로그인기록 조회
	 * @param hashmapParam
	 * @param PageingVo
	 * @return HashMap
	 */
	@RequestMapping(value="/selectLoginHist", method=RequestMethod.POST)
	public @ResponseBody HashMap<String, Object> getLoginHist(@ModelAttribute("pageing") PageingVo pageing, @RequestParam HashMap<String, Object> hashmapParam) throws Exception {
		List<HashMap<String, Object>> resultList = new ArrayList<HashMap<String, Object>>();
		HashMap<String, Object> hashmapResult = new HashMap<String, Object>();
		
		try {
			Integer page = pageing.getPage();
			if(page == 0) page = (Integer) 1;
			
			Integer rows  = pageing.getRows();
			Integer start = (page - 1) * rows;
			Integer end   = rows;
			
			hashmapParam.put("start", start);
			hashmapParam.put("end", end);
			
			resultList = mapper.selectLoginHist(hashmapParam);
			int records = mapper.getQueryTotalCnt();

			/* Day Setting */
			for(int i=0; i<resultList.size(); i++) {
				
				String date = (String)resultList.get(i).get("log_date");
				String day = DateUtil.getDateDay(date, "yyyy-MM-dd");
				
				String resultDay = date.format("%s (%s)", date, day);
				
				resultList.get(i).remove("log_date");
				resultList.get(i).put("log_date", resultDay);
			}
			
			pageing.setRecords(records);
			pageing.setTotal( (int) Math.ceil((double)records / (double)pageing.getRows()));
			
			hashmapResult.put("page", pageing.getPage());
			hashmapResult.put("total", pageing.getTotal());
			hashmapResult.put("records", pageing.getRecords());
			hashmapResult.put("rows", resultList);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return hashmapResult;
	}
	
	/**
	 * 로그인기록 삭제
	 * @param hashmapParam
	 * @return ReturnDataVo
	 */
	@Transactional
	@RequestMapping(value="/deleteLoginHist", method=RequestMethod.POST)
	public @ResponseBody ReturnDataVo deleteLoginHist(@RequestParam HashMap<String, Object> hashmapParam) {
		ReturnDataVo result = new ReturnDataVo();
		List<HashMap<String, Object>> resultList = new ArrayList<HashMap<String,Object>>();
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			
			if("ALL".equals(hashmapParam.get("delData"))) {
				mapper.allDeleteLoginHist();
			
			}else {
				
				resultList = mapper.getLogRetrieve(hashmapParam);
				
				if(resultList != null) {
				
					for(int i=0; i<resultList.size(); i++) {
						Object log_id = resultList.get(i).get("log_id");
						resultMap.put("log_id", log_id);
						
						mapper.deleteLoginHist(resultMap);
					}
					
				}else {
					result.setResultCode("S999");
				}
			}
			
			result.setResultCode("S000");
			
		} catch (Exception e) {
			result.setResultCode("S999");
			e.printStackTrace();
		}
		return result;
	}
	/**
	 * 사용자 삭제
	 * @param hashmapParam
	 * @return ReturnDataVo
	 */
	@Transactional
	@RequestMapping(value="/deleteUser", method=RequestMethod.POST)
	public @ResponseBody ReturnDataVo deleteUser(@RequestParam HashMap<String, Object> hashmapParam) {
		ReturnDataVo result = new ReturnDataVo();
		
		try {
			mapper.deleteUser(hashmapParam);
			result.setResultCode("S000");
			
		} catch (Exception e) {
			result.setResultCode("S999");
			e.printStackTrace();
		}
		return result;
	}
	
	/**
	 * 사용자 수정
	 * @param hashmapParam
	 * @return ReturnDataVo
	 */
	@Transactional
	@RequestMapping(value="/updateUser", method=RequestMethod.POST)
	public @ResponseBody ReturnDataVo updateUser(@RequestParam HashMap<String, Object> hashmapParam, HttpSession session, HttpServletRequest request) {
		ReturnDataVo result = new ReturnDataVo();
		
		SessionVo member = (SessionVo)session.getAttribute("S_USER");

		String user_idx = (String)hashmapParam.get("user_idx");
		String curr_user_idx = (String)hashmapParam.get("curr_user_idx");
		
		try {
			
			mapper.updateUser(hashmapParam);
			
			if(user_idx.equals(curr_user_idx)) {
				member = mapper.changeUser(hashmapParam);
				session.removeAttribute("S_USER");
				session.setAttribute("S_USER", member);
			}
			
			result.setResultCode("S000");
			
		} catch (Exception e) {
			result.setResultCode("S999");
			e.printStackTrace();
		}
		return result;
	}
	
	/**
	 * 로그인 전환
	 * @param hashmapParam
	 * @return ReturnDataVo
	 */
	@Transactional
	@RequestMapping(value="/changeUser", method=RequestMethod.POST)
	public @ResponseBody ReturnDataVo changeUser(@RequestParam HashMap<String, Object> hashmapParam, HttpSession session, HttpServletRequest request) throws Exception{
		ReturnDataVo result = new ReturnDataVo();
		session = request.getSession(true);
		
		SessionVo member = new SessionVo();
		member = mapper.changeUser(hashmapParam);
		
		HashMap<String, Object> loginHist = new HashMap<>();
		
		if(member != null) {
			
			session.removeAttribute("S_USER");
			session.setAttribute("S_USER", member);
			
			//로그인 성공 시 로그인 기록
			loginHist.put("log_user_id", member.getUser_id());
			loginHist.put("log_user_nm", member.getUser_nm());
			loginHist.put("log_user_ip", request.getRemoteAddr());
			loginHist.put("log_tp_yn", session.getAttribute("S_LOGIN_YN"));
			mapper.createloginHist(loginHist);
		
			result.setResultCode("S000");
			result.setResultMsg("CHG");

		}else {
			//로그인 실패 시
			loginHist.put("log_user_id", hashmapParam.get("user_id"));
			loginHist.put("log_user_nm", "사용자 전환 실패");
			loginHist.put("log_user_ip", "");
			loginHist.put("log_tp_yn", "N");
			mapper.createloginHist(loginHist);

			result.setResultCode("S999");
		}
		
		return result;
	}
	
}