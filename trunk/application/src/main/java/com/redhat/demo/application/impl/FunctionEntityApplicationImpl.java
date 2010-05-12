package com.redhat.demo.application.impl;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.hibernate.HibernateException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dayatang.domain.InstanceFactory;
import com.dayatang.querychannel.service.QueryChannelService;
import com.redhat.demo.application.FunctionEntityApplication;
import com.redhat.demo.core.DemoResourceBundleI18nService;
import com.redhat.demo.domain.FunctionEntity;
import com.redhat.demo.domain.FunctionEntity.Status;

/**
 * 功能实体应用（业务逻辑）层
 *<br />
 * @author vakin.Jiang
 *2010-4-26
 */
@Service
public class FunctionEntityApplicationImpl implements FunctionEntityApplication {

	private static final Logger	logger  = LoggerFactory.getLogger(FunctionEntityApplicationImpl.class);
	
	//查询通道
	protected static QueryChannelService queryChannel;
	
	protected static QueryChannelService queryChannel() {
		if (queryChannel == null) {
			queryChannel = InstanceFactory.getInstance(QueryChannelService.class);
		}
		return queryChannel;
	}

	@Override
	public List<FunctionEntity> queryChildNode(Long id, int currentPage,
			int pageSize) {
		FunctionEntity entity = new FunctionEntity();
		entity.setId(id);
		return entity.getChild();
	}
	
	@Override
	@Transactional
	public FunctionEntity createFunctionEntity(FunctionEntity entity) {
		
		// 如果未指定父实体则设置默认父实体为root节点ID
		if(entity.getParent()==null || entity.getParent().getId()==null){
			FunctionEntity parent = getDefaultRootFunctionEntity();
			entity.setParent(parent);
		}
		
		return entity.create();
	}

	@Override
	@Transactional
	public void deleteFunctionEntityById(Long id) {
		
		//查找关联子实体
		FunctionEntity entity = getFunctionEntityById(id);
		if(entity==null)
			return;
		entity.delete();
	}

	@Override
	public Long getCount(FunctionEntity search) {
		StringBuffer hql = new StringBuffer();
		Object[] obj = createQueryParams(search, hql);
		return queryChannel().queryResultSize(hql.toString(), obj);
	}

	@Override
	public FunctionEntity getFunctionEntityById(Long id) {
		FunctionEntity entity = FunctionEntity.getFunctionEntityRepository().get(id);
		if(entity == null)
			throw new RuntimeException(DemoResourceBundleI18nService.getMessage("demo.functionentity.entityIsNotExist", "当前功能实体不存在"));
		return entity;
	}

	@Override
	public List<FunctionEntity> queryAllByPage(FunctionEntity search,
			int currentPage, int pageSize) {
		StringBuffer hql = new StringBuffer();
		Object[] obj = createQueryParams(search, hql);
		List<FunctionEntity> list = queryChannel().queryResult(hql.toString(), obj);
		return list;
	}

	@Override
	@Transactional
	public FunctionEntity updateFunctionEntity(FunctionEntity entity) {
		return entity.update();
	}


	@Override
	public void setRelevance(long rscId, long destId) {
		
	}

	@Override
	@Transactional
	public void changStatus(Long id, Status status) {
		FunctionEntity funEntity = getFunctionEntityById(id);
		if(funEntity==null){
			throw new HibernateException("当前实体对象不存在");
		}
		if(Status.ENABLED.equals(status)){
			funEntity.enable();
		}else if(Status.DISABLED.equals(status)){
			funEntity.disable();
		}
	}
	
	@Override
	public FunctionEntity getDefaultRootFunctionEntity() {
		
		FunctionEntity dafaultNode = null;
		
		List<FunctionEntity> rootNodes = queryChannel().queryResult("from FunctionEntity f where f.parent is NULL", new Object[0]);
		
		if(rootNodes==null || rootNodes.isEmpty()){
			dafaultNode = new FunctionEntity();
			dafaultNode.setParent(null);
			dafaultNode.setAlias(" ");
			dafaultNode.setName("root");
			dafaultNode.create();
		
		}else{
			dafaultNode = rootNodes.get(0);
		}
		
		return dafaultNode;
	}
	
	/**
	 * 构造查询条件
	 * @param search
	 * @param hql
	 * @return
	 */
	private Object[] createQueryParams(FunctionEntity search, StringBuffer hql) {
		hql.append("select f from FunctionEntity f");
		List<Object> params = new ArrayList<Object>();
		if(search!=null){
			
			if(search.getFunctionEntityType()!=null){
				hql.append(" join f.functionEntityType type where type.id=?");
			    params.add(search.getFunctionEntityType().getId());
			}else{
				hql.append(" where 1=1");
			}
			
			if(StringUtils.isNotBlank(search.getName())){
				hql.append(" and f.name like ?");
			    params.add("%"+search.getName()+"%");
			}
			
			if(StringUtils.isNotBlank(search.getAlias())){
				hql.append(" and f.name like ?");
			    params.add("%"+search.getAlias()+"%");
			}
			
			if(search.getStatus()!=null){
				hql.append(" and f.status=?");
			    params.add(search.getStatus());
			}
		}
		
		Object[] obj = params.isEmpty()? new Object[]{ }:params.toArray();
		return obj;
	}
}
