package com.redhat.demo.application.impl;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dayatang.domain.InstanceFactory;
import com.dayatang.querychannel.service.QueryChannelService;
import com.redhat.demo.application.FunctionEntityTypeApplication;
import com.redhat.demo.core.DemoResourceBundleI18nService;
import com.redhat.demo.domain.FunctionEntityType;

/**
 * FunctionEntityType 的 Application
 * @author lingen.liu
 *
 */
@Transactional
@Service(value="functionEntityTypeAppliaction")
public class FunctionEntityTypeApplicationImpl implements
		FunctionEntityTypeApplication {

	//查询通道
	private static QueryChannelService queryChannel;

	public static QueryChannelService getQueryChannel() {
		if (queryChannel == null) {
			queryChannel = InstanceFactory
					.getInstance(QueryChannelService.class);
		}
		return queryChannel;
	}

	public static void setQueryChannel(QueryChannelService queryChannel) {
		FunctionEntityTypeApplicationImpl.queryChannel = queryChannel;
	}
	
	/**
	 * 根据Id返回一个FunctionEntityType对象
	 */
	@Override
	public FunctionEntityType get(long id) {
		return FunctionEntityType.get(id);
	}


	/**
	 * 保存一个对象
	 */
	@Override
	public void save(FunctionEntityType type) {
		type.add();
	}

	@Override
	public void delete(long id) {
		FunctionEntityType entityType = get(id);
		
		if(entityType==null)
			throw new RuntimeException(DemoResourceBundleI18nService.getMessage("demo.functionentitytype.entityTypeIsNotExist", "当前实体类型不存在"));
		entityType.remove();
	}
	
}
