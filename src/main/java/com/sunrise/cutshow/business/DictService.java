package com.sunrise.cutshow.business;

import java.util.Map;

import org.springframework.stereotype.Service;

import com.sunrise.springext.utils.SystemUtils;



/**
 * <p>Description: </p>
 * <p>Company: sunrise Tech Ltd.</p>
 * @author tanggensheng
 * @date 2011-11-30下午06:02:24
 */
@Service
public class DictService extends BaseService {

	/**
	 * 返回ID->NAME的字典项映射
	 */
//	public Map<String, String> getDict(String groupKey) {
//		if(!dictCaches.containsKey(groupKey)){
//			dictCaches.put(groupKey, SystemUtils.getStringMap4Dict(dao, "select dict_id, dict_name from oam_dict where group_key=? order by sort_order", groupKey));
//		}
//		return dictCaches.get(groupKey);
//	}
	
	/**
	 * <p>Description: 返回ID->NAME的映射<p>
	 * @param id
	 * @param name
	 * @param table
	 * @param condition 查询条件
	 * @return
	 */
	public Map<String, String> id2Name(String id, String name, String table, String condition){
		return SystemUtils.getStringMap4Dict(dao, "select " + id + ", " + name +" from " + table  + condition + " order by " + id);
	}
	
	public Map<String, String> id2Name(String id, String name, String table){
		return id2Name(id, name, table, " where 1=1 ");
	}
	
}
