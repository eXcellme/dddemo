package com.redhat.demo.domain;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.Lob;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

import org.apache.commons.lang.builder.EqualsBuilder;
import org.apache.commons.lang.builder.HashCodeBuilder;

import com.dayatang.domain.BaseEntity;
import com.dayatang.domain.InstanceFactory;

/**
 * 功能实体
 * @author Justin
 *
 */
@Entity
@Table(name = "RAMS_FUNCTION_ENTITY")
@NamedQueries( { @NamedQuery(name = "FunctionEntity.findbyParentId", query = "from FunctionEntity o where o.parent.id = ?"),
	             @NamedQuery(name = "FunctionEntity.findDefalutRootNode", query = "from FunctionEntity f where f.parent is NULL")
	          } )
public class FunctionEntity extends BaseEntity {

	private static final long serialVersionUID = -925775882543184230L;
	
	public enum Status{
		DISABLED, ENABLED
	}
	
	// 名称
	@Column(name="NAME", length = 200, nullable = false)
	private String name;
	
	// 别名
	@Column(name="ALIAS", length = 50, nullable = false)
	private String alias;
	
	// 状态
	@Column(name="STATUS")
	private Status status;
	
	// 备注
	@Lob
	@Column(name="DESCRIPTION")
	private String description;
	
	// 父实体
	@ManyToOne
	@JoinColumn(name="FK_PARENT_ID")
	private FunctionEntity parent;
	
	// 类型
	@ManyToOne
	@JoinColumn(name="FK_FUNCTION_ENTITY_TYPE_ID")
	private FunctionEntityType functionEntityType;
	
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getAlias() {
		return alias;
	}

	public void setAlias(String alias) {
		this.alias = alias;
	}

	public Status getStatus() {
		return status;
	}

	public void setStatus(Status status) {
		this.status = status;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public FunctionEntity getParent() {
		return parent;
	}

	public void setParent(FunctionEntity parent) {
		this.parent = parent;
	}

	public FunctionEntityType getFunctionEntityType() {
		return functionEntityType;
	}

	public void setFunctionEntityType(FunctionEntityType functionEntityType) {
		this.functionEntityType = functionEntityType;
	}

	@Override
	public boolean equals(Object obj) {
		boolean flag = false; 
        if (obj != null && FunctionEntity.class.isAssignableFrom(obj.getClass())) { 
        	FunctionEntity f = (FunctionEntity) obj; 
                flag = new EqualsBuilder() 
                                .append(name, f.getName()) 
                                .append(id, f.getId()) 
                                .append(alias, f.getAlias())
                                .isEquals(); 
        } 
        return flag; 
	}

	@Override
	public int hashCode() {
		return HashCodeBuilder.reflectionHashCode(this);
	}

	@Override
	public String toString() {
		return this.name+":"+alias;
	}

	private static FunctionEntityRepository functionEntityRepository;
	
	public static FunctionEntityRepository getFunctionEntityRepository() {
		if(functionEntityRepository == null){
			functionEntityRepository = InstanceFactory.getInstance(FunctionEntityRepository.class);
		}
		return functionEntityRepository;
	}
	
	public void setFunctionEntityRepository(
			FunctionEntityRepository functionEntityRepository) {
		FunctionEntity.functionEntityRepository = functionEntityRepository;
	}
	
	/*
	 * =======================================
	 * =======================================
	 * 
	 * 下面代码放置领域对象的行为
	 * 
	 * =======================================
	 * ========================================
	 */
	
	/**
	 * 创建
	 */
	public FunctionEntity create(){
		
		List<FunctionEntity> exists = getFunctionEntityRepository().find("from FunctionEntity f where f.name=? or f.alias=?", 
				new Object[]{this.getName(),this.getAlias()});
		
		if(exists!=null && exists.isEmpty()==false){
			throw new RuntimeException("当前实体对象名或别名已经存在");
		}
		
		//默认激活状态
		this.setStatus(Status.ENABLED);
		getFunctionEntityRepository().save(this);
		
		return this;
	}
	
	
	/**
	 * 更新
	 */
	public FunctionEntity update(){

		List<FunctionEntity> exists = getFunctionEntityRepository().find("from FunctionEntity f where (f.name=? or f.alias=?) and f.id<>?", 
				new Object[]{this.getName(),this.getAlias(),this.getId()});
		
		if(exists!=null && exists.isEmpty()==false){
			throw new RuntimeException("当前实体对象名或别名已经存在");
		}
		
		//修改 避免id和parentid一致
		if(this.getParent().getId().equals(this.getId())){
			throw new RuntimeException("自身不能作为父实体");
		}
		getFunctionEntityRepository().save(this);
		
		return this;
	}
	
	/**
	 * 删除
	 */
	public void delete(){
		
		StringBuffer errMsg = null;
		
		//查找是否有子实体，有则异常提示：
		List<FunctionEntity> childNode = getChild();
		if(childNode!=null && !childNode.isEmpty()){
			errMsg = new StringBuffer("删除失败！需要先删除其包含的子实体：");
			for (FunctionEntity child : childNode) {
				errMsg.append(child.getAlias()).append(",");
			}
			throw new RuntimeException(errMsg.toString());
		}
	
		//delete
		getFunctionEntityRepository().remove(this);
	}

	/**
	 * 禁用
	 */
	public void disable(){
		this.status = Status.DISABLED;
		getFunctionEntityRepository().save(this);
	}
	
	/**
	 * 启用
	 */
	public void enable(){
		this.status = Status.ENABLED;
		getFunctionEntityRepository().save(this);
	}
	
	/**
	 * 取得关联子实体
	 * @return
	 */
	public List<FunctionEntity> getChild(){
		return getFunctionEntityRepository().findByParentId(id);
	}
}
