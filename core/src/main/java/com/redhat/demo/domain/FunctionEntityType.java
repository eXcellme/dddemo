package com.redhat.demo.domain;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;
import org.hibernate.validator.constraints.Length;

import com.dayatang.domain.BaseEntity;
import com.dayatang.domain.InstanceFactory;

/**
 * 功能实体类型
 * 
 * @author Justin
 * 
 */
@Entity
@Table(name = "RAMS_FUNCTION_ENTITY_TYPE")
public class FunctionEntityType extends BaseEntity {

	private static final long serialVersionUID = 240630512419451465L;

	@NotNull
	@Length(min=3)
	@Column(name = "NAME", length = 50, nullable = false)
	private String name;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Override
	/**
	 * ID相同，便认为是同一对象
	 */
	public boolean equals(Object arg0) {
		if (arg0 == null)
			return false;
		if (arg0 instanceof FunctionEntityType) {
			FunctionEntityType type = (FunctionEntityType) arg0;
			return new EqualsBuilder().append(type.getId(), this.getId()).isEquals();
		}
		return false;
	}

	@Override
	public int hashCode() {
		return new HashCodeBuilder().append(id).append(name).toHashCode();
	}

	@Override
	public String toString() {
		return name;
	}

	/**
	 * lingen.liu 仓储
	 */
	private static FunctionEntityTypeRepository functionEntityTypeRepository;

	public static FunctionEntityTypeRepository getFunctionEntityTypeRepository() {
		if (functionEntityTypeRepository == null) {
			functionEntityTypeRepository = InstanceFactory
					.getInstance(FunctionEntityTypeRepository.class);
		}
		return functionEntityTypeRepository;
	}

	public static void setFunctionEntityTypeRepositoryRepository(
			FunctionEntityTypeRepository functionEntityTypeRepository) {
		FunctionEntityType.functionEntityTypeRepository = functionEntityTypeRepository;
	}

	/**/// ////////////////////领域行为 start/////////////////////////////*/

	/**
	 * 新增一个功能实体类型
	 */
	public void add() {
		if(getFunctionEntityTypeRepository().isExist(this)){
			throw new RuntimeException("当前实体已经存在");
		}
		getFunctionEntityTypeRepository().save(this);
	}

	/**
	 * 移除一个功能实体类型
	 */
	public void remove() {
		
		List<FunctionEntity> list = FunctionEntity.getFunctionEntityRepository().getFunctionEntityByType(this);
		
		if(list!=null && !list.isEmpty())
			throw new RuntimeException("当前实体类型关联了功能实体，请解除关联再进行删除");
		
//		for (FunctionEntity functionEntity : list) {
//			
//		}
		
		getFunctionEntityTypeRepository().remove(this);
	}

	/**
	 * 更新一个功能实体类型
	 */
	public void update() {
		if(getFunctionEntityTypeRepository().isExist(this)){
			throw new RuntimeException("当前实体已经存在");
		}
		getFunctionEntityTypeRepository().save(this);
	}
	
	/**
	 * 以Id返回一个FunctionEntityType
	 * @param id
	 * @return
	 */
	public static FunctionEntityType get(long id){
		return getFunctionEntityTypeRepository().get(id);
	}
}