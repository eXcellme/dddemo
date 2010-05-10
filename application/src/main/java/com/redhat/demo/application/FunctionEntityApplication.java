package com.redhat.demo.application;

import java.util.List;

import com.redhat.demo.domain.FunctionEntity;
import com.redhat.demo.domain.FunctionEntity.Status;

/**
 * 功能实体应用层接口
 *<br />
 * @author vakin.Jiang
 *2010-4-19
 */
public interface FunctionEntityApplication{
	
	/**
	 * 查询某节点全部子节点
	 * @param parentId
	 * @return
	 */
	public List<FunctionEntity> queryChildNode(Long parentId,int currentPage, int pageSize);
	
	public FunctionEntity getFunctionEntityById(Long id);
	
	public FunctionEntity createFunctionEntity(FunctionEntity entity);
	
	public FunctionEntity updateFunctionEntity(FunctionEntity entity);
	
	public void deleteFunctionEntityById(Long id);
	
	public Long getCount(FunctionEntity search);
	
	public List<FunctionEntity> queryAllByPage(FunctionEntity search,int currentPage, int pageSize);
	
	/**
	 * 增加/解除功能实体关联关系
	 * @param id
	 * @param ids
	 */
	public void setRelevance(long rscId, long destId);
	
	
	
	/**
	 * 更新功能实体状态
	 * @param FunctionEntity
	 * @param status
	 */
	public void changStatus(Long id , Status status);
	
	/**
	 * 获取默认父实体,不存在则创建
	 * @return
	 */
	public FunctionEntity getDefaultRootFunctionEntity();
}
