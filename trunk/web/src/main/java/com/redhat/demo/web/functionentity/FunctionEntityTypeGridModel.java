package com.redhat.demo.web.functionentity;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.redhat.demo.application.FunctionEntityTypeApplication;
import com.redhat.demo.domain.FunctionEntityType;
import com.redhat.redwork.widget.grid.AbstractGridModel;
/**
 * 功能类型实体的Gird模型
 * @author lingen.liu
 *
 */
@Transactional
@Service
public class FunctionEntityTypeGridModel extends
		AbstractGridModel<FunctionEntityType, FunctionEntityType> {	
	
	@Autowired
	private FunctionEntityTypeApplication functionEntityTypeAppliaction;
	
	@Override
	public void delete(String sid) {
		functionEntityTypeAppliaction.delete(Long.parseLong(sid));
	}	
	
	
}
