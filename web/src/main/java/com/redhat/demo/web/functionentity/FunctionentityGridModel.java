package com.redhat.demo.web.functionentity;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.redhat.demo.application.FunctionEntityApplication;
import com.redhat.demo.domain.FunctionEntity;
import com.redhat.redwork.widget.grid.AbstractGridModel;
import com.redhat.redwork.widget.grid.Order;

@Service(value="functionentityGridModel")
public class FunctionentityGridModel extends
		AbstractGridModel<FunctionEntity, FunctionEntity> {

	@Autowired
	private FunctionEntityApplication functionEntityApplication;
	
	@Override
	public Long count(FunctionEntity search) {
		Long count = functionEntityApplication.getCount(search);
		//忽略默认根节点
		return count > 0 ? count - 1 : count;
	}

	@Override
	public void delete(String id) {
		functionEntityApplication.deleteFunctionEntityById(Long.parseLong(id.toString()));
	}

	@Override
	public FunctionEntity getCriteriaObject() {
		return new FunctionEntity();
	}

	@Override
	public List<FunctionEntity> list(FunctionEntity search, int page,
			int pageSize, Order order) {
		
		List<FunctionEntity> list = null;
		
		if(search!=null && search.getId()!=null)
			list = functionEntityApplication.queryChildNode(search.getId(), page, pageSize);
		else{
			list = functionEntityApplication.queryAllByPage(search, page, pageSize);
			
			//过滤系统默认根节点
			try {
				if(list!=null && list.size()>0){
					for (int i = 0; i < list.size(); i++) {
						if(list.get(i).getParent()==null)
							list.remove(i);
					}
				}
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return list;
	}

	
}
