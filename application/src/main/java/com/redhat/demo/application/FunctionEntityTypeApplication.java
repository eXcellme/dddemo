package com.redhat.demo.application;

import java.util.List;

import com.redhat.demo.domain.FunctionEntityType;

/**
 * 功能实体类型的application
 * 
 * @author lingen.liu
 * 
 */
public interface FunctionEntityTypeApplication {
	
	public void save(FunctionEntityType type);

	public FunctionEntityType get(long id);
	
	public void delete(long id);

}
