package com.vxie.debut.business;

import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.vxie.debut.model.CutBaseInfo;

@Service
public class BaseInfoService extends BaseService {

	@Transactional
	public void save(CutBaseInfo cutBaseInfo){
		dao.update(cutBaseInfo);
	}
	
	public CutBaseInfo find(){
		CutBaseInfo b = dao.find(CutBaseInfo.class, 1L);
		b.setCutManagerName(getUsernames().get(b.getCutManagerId()));
		return b;
	}

	public Map<Long, String> cutOwners() {
		String sql = 
			" select distinct t.user_id, u.user_real_name from cut_user_role t  " +
			" left join cut_user u on u.user_id=t.user_id " +
			" where t.role_id=? " +
			" order by t.user_id ";
		return getMap(sql, 2);
	}

}
