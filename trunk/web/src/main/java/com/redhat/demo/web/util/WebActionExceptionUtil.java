package com.redhat.demo.web.util;

import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;

/**
 * web层异常处理工具类
 * @author vakin.jiang
 *
 */
public class WebActionExceptionUtil {

	public static String PAGE = "page";
	public static String ALERT_ERROR = "error";
	public static String ALERT_WARN = "warn";
	
	
	/**
	 * 直接输出JSON.
	 * 
	 * @param response
	 * @param text
	 */
	public static  void writeJSON(HttpServletResponse response, String text) {
		writeObject(response, text == null ? "" : text, "text/x-json;charset=UTF-8");
	}
	
	
	/**
	 * 直接输出HTML.
	 * 
	 * @param response
	 * @param text
	 */
	public static  void writeHTML(HttpServletResponse response, String text) {
		writeObject(response, text == null ? "" : text, "text/html;charset=UTF-8");
	}
	
	/**
	 * 输出.
	 * 
	 * @param contentType
	 *            内容的类型.html,text,xml的值见后，json为"text/x-json;charset=UTF-8"
	 */
	public static  void writeObject(HttpServletResponse response, String text,
			String contentType) {
		try {
			response.setContentType(contentType);
			response.getWriter().write(text);
		} catch (Exception e) {
			
		}
	}
	
	/**
	 * 输出异常提示信息到页面前端
	 * @param response
	 * @param errorType
	 * @param message
	 */
	public static String buildExceptionToResponse(ActionSupport as,String errorType,String page, Exception ex){
		
		HttpServletResponse response = ServletActionContext.getResponse();
		
		String message = "系统繁忙，请稍后再试！";
		if(ex instanceof RuntimeException)
			message = ex.getMessage();
		
		if(PAGE.equals(errorType)){
//			writeHTML(response, message);
			as.addActionError(message);
		}else{
			String json = "{\"type\":\"{errorType}\",\"msg\":\"{message}\"}";
			writeJSON(response, json.replace("{errorType}", errorType).replace("{message}", message));
		}
		return page;
	}
}
