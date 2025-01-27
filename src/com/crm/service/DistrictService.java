/**
 * 
 */
package com.crm.service;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.crm.dao.DistrictMapper;
import com.crm.model.District;
import com.crm.model.User;
import com.crm.model.easyui.PageHelper;
import com.crm.model.easyui.Tree;

/**
 * @author zh
 * 2014-8-2
 */
@Service
public class DistrictService {

	@Resource
	private DistrictMapper districtMapper;
	
	//分页
	public List<District> datagridDistrict(PageHelper page) {
		page.setStart((page.getPage()-1)*page.getRows());
		page.setEnd(page.getRows());		
		return districtMapper.datagridDistrict(page);  
	}
	//分页
	public long datagridTotal() {	
		return districtMapper.getDatagridTotal();  
	}
    public void deleteDistrict(long id){
    	districtMapper.deleteDistrict(id);
    }
    public void addDistrict(District district){
    	districtMapper.addDistrict(district);
    }
    public void upDateDistrict(District district){
    	districtMapper.updateDistrict(district);
    }
	public List<Tree> nodesDistrict(){
		List<District> list=districtMapper.getDatagrid();
		List<Tree> treeList=null;
		if(list!=null){
			treeList = new ArrayList<Tree>();
			for(District dis:list){
				Tree node = new Tree();				
				node.setId((int)dis.getId());
				node.setPid(0);
				node.setText(dis.getDictName());
				node.setIconCls(null);				
				treeList.add(node);
			}
			Tree node = new Tree();				
			node.setId(0);
			node.setPid(0);
			node.setText("全部");
			node.setIconCls(null);				
			treeList.add(node);
		}
		return treeList;
	}
	/**
	 * 获取所有县分
	 * @return
	 */
	public List<District> getDatagrid(){
		return districtMapper.getDatagrid();
	}
	public District getDistrictByUserid(User user){
		return districtMapper.getDistrictByUserId(user);
	}
}
