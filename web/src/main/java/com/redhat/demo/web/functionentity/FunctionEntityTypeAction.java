package com.redhat.demo.web.functionentity;

import javax.validation.Valid;

import org.apache.struts2.ServletActionContext;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import com.opensymphony.xwork2.ActionSupport;
import com.redhat.demo.application.FunctionEntityTypeApplication;
import com.redhat.demo.domain.FunctionEntityType;
import com.redhat.demo.web.util.WebActionExceptionUtil;
import com.redhat.redwork.coc.RedworkAction;
/**
 * 此action处理FunctionEntityType的相关操作
 * @author lingen.liu
 *
 */
public class FunctionEntityTypeAction extends ActionSupport implements RedworkAction{

	private static final Logger	logger  = LoggerFactory.getLogger(FunctionEntityTypeAction.class);
	
	@Valid
	private FunctionEntityType type;
	
	@Autowired
	private FunctionEntityTypeApplication functionEntityTypeAppliaction;
	
	/**
	 * 新增一个functionEntityType实体
	 * @return 返回列表页面
	 */
	public String addFunctionEntityType(){
		try {
			functionEntityTypeAppliaction.save(type);
		} catch (Exception e) {
			logger.error(e.getMessage(),e);
			return WebActionExceptionUtil.buildExceptionToResponse(this, WebActionExceptionUtil.ALERT_WARN ,null ,e);
		}
		return "functionEntityType_list";
	}
    
	/**
	 * 返回一个functionEntityType实体
	 * @return 返回修改页面
	 */
	public String getFunctionEntityType(){
		long id = new Long(ServletActionContext.getRequest().getParameter("id"));
		type = functionEntityTypeAppliaction.get(id);
		return "functionEntityType_modify";
	}
	
	/**
	 * 修改一个functionEntityType实体
	 * @return
	 */
	public String modifyFunctionType(){
		try {
			functionEntityTypeAppliaction.save(type);
		} catch (Exception e) {
			logger.error(e.getMessage(),e);
			return WebActionExceptionUtil.buildExceptionToResponse(this, WebActionExceptionUtil.PAGE ,"/errorpages/error" ,e);
		}
		return "functionEntityType_list";
	}

	
	public FunctionEntityType getType() {
		return type;
	}

	public void setType(FunctionEntityType type) {
		this.type = type;
	}

	public FunctionEntityTypeApplication getFunctionEntityTypeAppliaction() {
		return functionEntityTypeAppliaction;
	}

	public void setFunctionEntityTypeAppliaction(
			FunctionEntityTypeApplication functionEntityTypeAppliaction) {
		this.functionEntityTypeAppliaction = functionEntityTypeAppliaction;
	}
}
