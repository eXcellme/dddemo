package com.redhat.demo.domain.infra.hibernate;

import java.util.List;

import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

import com.dayatang.spring.repository.BaseEntityRepositoryHibernateSpring;
import com.redhat.demo.domain.FunctionEntity;
import com.redhat.demo.domain.FunctionEntityRepository;
import com.redhat.demo.domain.FunctionEntityType;

/**
 * 功能实体管理仓储实现
 *<br />
 * @author vakin.Jiang
 *2010-4-19
 */

@Repository
public class FunctionEntityRepositoryImpl extends BaseEntityRepositoryHibernateSpring<FunctionEntity, Long> implements FunctionEntityRepository {

	public FunctionEntityRepositoryImpl() {
		super(FunctionEntity.class);
	}

	@Override
	public List<FunctionEntity> findByParentId(Long parentId) {
		return findByNamedQuery("FunctionEntity.findbyParentId", new Object[] { parentId });
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<FunctionEntity> getFunctionEntityByType(FunctionEntityType type) {
		return getSession().createCriteria(FunctionEntity.class)
        .createAlias("functionEntityType", "type")
        .add(Restrictions.eq("type.id", type.getId()))
        .list();
	}
}
