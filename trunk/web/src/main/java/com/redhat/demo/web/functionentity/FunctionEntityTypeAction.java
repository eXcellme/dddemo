package com.redhat.demo.web.functionentity;

import javax.validation.Valid;

import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;

import com.opensymphony.xwork2.ActionSupport;
import com.redhat.demo.application.FunctionEntityTypeApplication;
import com.redhat.demo.domain.FunctionEntityType;
import com.redhat.redwork.coc.RedworkAction;
/**
 * 此action处理FunctionEntityType的相关操作
 * @author lingen.liu
 *
 */
public class FunctionEntityTypeAction extends ActionSupport implements RedworkAction{

	@Valid
	private FunctionEntityType type;
	
	@Autowired
	private FunctionEntityTypeApplication functionEntityTypeAppliaction;
	
	/**
	 * 新增一个functionEntityType实体
	 * @return 返回列表页面
	 */
	public String addFunctionEntityType(){
		functionEntityTypeAppliaction.save(type);
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
		functionEntityTypeAppliaction.save(type);
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
