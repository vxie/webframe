package com.vxie.debut.business;

import com.sunrise.springext.beans.GlobalConfig;
import com.sunrise.springext.dao.IBaseDao;
import com.sunrise.springext.utils.SystemUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.annotation.Resource;
import java.util.Map;

public abstract class BaseService {
	protected static final Logger log = LoggerFactory.getLogger(BaseService.class);
			
	@Resource
	protected IBaseDao dao;
	public IBaseDao getDao() {
		return dao;
	}

	
	@Resource
	protected GlobalConfig globalConfig;
	public void setGlobalConfig(GlobalConfig globalConfig) {
		this.globalConfig = globalConfig;
	}
	
	protected Map<Long, String> getMap(String sql, Object... args){
		return SystemUtils.getLongMap4Dict(dao, sql, args);
	}

	protected Map<String, String> getMap4String(String sql, Object... args){
		return SystemUtils.getStringMap4Dict(dao, sql, args);
	}

}
