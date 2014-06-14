package com.sunrise.cutshow.business;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.sunrise.cutshow.model.CutStep;
import com.sunrise.cutshow.utils.DateUtils;
import com.sunrise.springext.beans.GlobalConfig;
import com.sunrise.springext.dao.IBaseDao;
import com.sunrise.springext.utils.SystemUtils;

public abstract class BaseService {
	protected static final Logger log = LoggerFactory.getLogger(BaseService.class);
			
	private static final String SEQ_NAME = "SEQ_CUT_SHOW";
	@Resource
	protected IBaseDao dao;
	public IBaseDao getDao() {
		return dao;
	}
	
	private Map<Long, String> stepStatus;
	public Map<Long, String> getStepStatus() {
		return stepStatus;
	}
	
	@Resource
	protected GlobalConfig globalConfig;
	public void setGlobalConfig(GlobalConfig globalConfig) {
		this.globalConfig = globalConfig;
		
		this.stepStatus = this.globalConfig.getLongItemsByArea("Step_Status");
	}
	
	protected Map<Long, String> getMap(String sql, Object... args){
		return SystemUtils.getLongMap4Dict(dao, sql, args);
	}
	protected Map<String, String> getMap4String(String sql, Object... args){
		return SystemUtils.getStringMap4Dict(dao, sql, args);
	}
	protected Long getSequence() {
		return dao.getSimpleJdbcTemplate().queryForLong("select " + SEQ_NAME + ".nextval from dual");
	}
	
	public List<CutStep> allSteps(){
		List<CutStep> list = dao.find(CutStep.class, "from CutStep s order by s.stepIndex", new Object[]{});
		Map<Long, String> names = getUsernames();
		for (CutStep cutStep : list) {
			cutStep.setStepCheckerName(names.get(cutStep.getStepCheckerId()));
			cutStep.setStepOwnerName(names.get(cutStep.getStepOwnerId()));
			
			String finishTime = cutStep.getFinishTime();
			if(StringUtils.isNotEmpty(finishTime)){
				String startTime = cutStep.getStartTime();
				Long finishDate = DateUtils.stringToLong(finishTime);// - DateUtils.stringToLong(startTime);
				Long startDate = DateUtils.stringToLong(startTime);
				double costTime = (finishDate - startDate)/(double)3600000;
				costTime = (Math.round(costTime*100)/100.0);
				cutStep.setCostTime(costTime);
			}
		}
		return list;
	}
	
	
	public Map<Long, String> getUsernames(){
		return getMap("select user_id, user_real_name from cut_user");
	}

}
