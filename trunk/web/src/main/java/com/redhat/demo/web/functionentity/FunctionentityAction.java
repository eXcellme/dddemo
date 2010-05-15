package com.redhat.demo.web.functionentity;

import org.apache.struts2.ServletActionContext;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import com.redhat.demo.application.FunctionEntityApplication;
import com.redhat.demo.domain.FunctionEntity;
import com.redhat.demo.web.util.WebActionExceptionUtil;
import com.redhat.redwork.coc.RedworkAction;
import com.redhat.redwork.coc.RedworkActionSupport;

public class FunctionentityAction extends RedworkActionSupport implements RedworkAction  {

	private static final long serialVersionUID = -3286665774475807231L;
	
	private static final Logger	logger  = LoggerFactory.getLogger(FunctionentityAction.class);
	
	@Autowired
	private FunctionEntityApplication functionEntityApplication;
	
	private String id;
	private FunctionEntity entity;
	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public FunctionEntity getEntity() {
		return entity;
	}

	public void setEntity(FunctionEntity entity) {
		this.entity = entity;
	}


	public void setFunctionEntityApplication(FunctionEntityApplication FunctionEntityApplication) {
		this.functionEntityApplication = FunctionEntityApplication;
	}
	

	public String save() {
		try {
			if(entity.isNew())
				functionEntityApplication.createFunctionEntity(entity);
			else
				functionEntityApplication.updateFunctionEntity(entity);
		} catch (Exception e) {
			logger.error(e.getMessage(),e);
			return WebActionExceptionUtil.buildExceptionToResponse(this, WebActionExceptionUtil.ALERT_WARN ,null ,e);
		}
		
		return JSON;
	}


	public String edit() {
		try {
			entity = functionEntityApplication.getFunctionEntityById(entity.getId());
		} catch (Exception e) {
			logger.error(e.getMessage(),e);
			return WebActionExceptionUtil.buildExceptionToResponse(this, WebActionExceptionUtil.ALERT_WARN ,null ,e);
		}
		return "edit";
	}
	
	
	/**
	 * 关联
	 * @return
	 */
	public String associate(){
		String[] ids = ServletActionContext.getRequest().getParameterValues("ids");
		for (String s : ids) {
			functionEntityApplication.setRelevance(entity.getId(), Long.parseLong(s));
		}
		return "";
	}
	
	
	/**
	 * 设置状态
	 */
	public String setStatus(){
		
		try {
			if(entity==null || entity.getStatus()==null){
				throw new RuntimeException("无法识别实体对象");
			}
			functionEntityApplication.changStatus(entity.getId(),entity.getStatus());
		} catch (Exception e) {
			logger.error(e.getMessage(),e);
			return WebActionExceptionUtil.buildExceptionToResponse(this, WebActionExceptionUtil.ALERT_WARN ,null ,e);
		}
		return JSON;
	}

}
