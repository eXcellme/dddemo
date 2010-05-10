package com.redhat.demo.domain;

import com.dayatang.domain.BaseEntityRepository;

public interface FunctionEntityTypeRepository extends BaseEntityRepository<FunctionEntityType, Long>{
	
	/**
	 * 判断当前实体是否存在
	 * @param fType
	 * @return
	 */
	public boolean isExist(FunctionEntityType fType);

}
