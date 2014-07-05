package com.vxie.debut.business;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.Resource;

import jxl.Cell;
import jxl.Sheet;
import jxl.Workbook;

import org.apache.commons.lang.StringUtils;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.vxie.debut.model.CutStep;
import com.vxie.debut.model.CutTask;
import com.vxie.debut.utils.Constants;
import com.vxie.debut.utils.DateUtils;
import com.sunrise.springext.support.json.JSONUtil;

@Service
public class CutStepService extends BaseService {
	
	private static final String addStepSql = "insert into cut_step(step_id, step_name, step_weight_value, step_cur_percent, " +
			" step_times, step_owner_id, step_checker_id, step_index, step_status) values(?,?,?,?,?,?,?,?,?)";
	private static final String addStepUserSql = "insert into cut_step_user(step_id, user_id) values(?, ?)";
	private static final String isStepOwnerSql = "select count(*) from cut_user a left join cut_user_role b " +
			" on a.user_id = b.user_id where a.user_real_name=? and b.role_id in (11, 12)";
	
	@Resource
	private BaseInfoService baseInfoService;
	@Resource
	private DictService dictService;
	
	public String getTasksByStepId(Long stepId) throws Exception {
		List<CutTask> list = dao.find(CutTask.class, "from CutTask t where t.stepId=? order by t.taskIndex", stepId);
		
		Map<Long, String> names = baseInfoService.getUsernames();
		Map<Long, String> status = getStepStatus();
		for (CutTask cutTask : list) {
			cutTask.setTaskStatusName(status.get(cutTask.getTaskStatus()));
			cutTask.setTaskCheckerName(names.get(cutTask.getTaskCheckerId()));
			cutTask.setTaskOperaterName(names.get(cutTask.getTaskOperaterId()));
		}
		
		return JSONUtil.serialize(list);
	}
	
	//lw 2011-08-30
	public List<CutTask> getTasksByStepId2(Long stepId) throws Exception {
		List<CutTask> list = dao.find(CutTask.class, "from CutTask t where t.stepId=? order by t.taskIndex", stepId);
		
		Map<Long, String> names = baseInfoService.getUsernames();
		Map<Long, String> status = getStepStatus();
		for (CutTask cutTask : list) {
			cutTask.setTaskStatusName(status.get(cutTask.getTaskStatus()));
			cutTask.setTaskCheckerName(names.get(cutTask.getTaskCheckerId()));
			cutTask.setTaskOperaterName(names.get(cutTask.getTaskOperaterId()));
			
			String finishTime = cutTask.getFinishTime();
			if(StringUtils.isNotEmpty(finishTime)){
				String startTime = cutTask.getStartTime();
				Long finishDate = DateUtils.stringToLong(finishTime);
				Long startDate = DateUtils.stringToLong(startTime);
				double costTime = (finishDate - startDate)/(double)3600000;
				costTime = (Math.round(costTime*100)/100.0);
				cutTask.setCostTime(costTime);
			}
		}
		
		return list;
	}
	
	//lw 2011-08-30
	public CutStep getStepById(Long stepId){
		
		//List<CutStep> list = dao.find(CutStep.class, "from CutStep s where s.stepId=? ", stepId);
		CutStep  cutStep = dao.get(CutStep.class, stepId);
		Map<Long, String> names = getUsernames();

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
		return cutStep;
	}

	@Transactional
	public void save(CutStep cutStep) {
        if(cutStep.getStepId() == null) {
            cutStep.setStepId(cutStep.getStepIndex());
        }

		dao.saveOrUpdate(cutStep);
		
		Long id = cutStep.getStepId();
		
		dao.getSimpleJdbcTemplate().update("delete from cut_step_user where step_id=?", id);
		
		List<Object[]> args = new ArrayList<Object[]>();
		Set<Long> set = new HashSet<Long>();
		
		String s = cutStep.getStepVisitUsers() +(cutStep.getStepVisitUsers().length()>0?",":"")+ cutStep.getStepOwnerId() + "," + cutStep.getStepCheckerId();
		for(String strId: s.split(",")){
			Long roleId = Long.parseLong(strId);
			if(!set.contains(roleId)) {
				set.add(roleId);
				args.add(new Object[]{id, roleId});
			}
		}
		
		if(args.size()>0)
			dao.getSimpleJdbcTemplate().batchUpdate("insert into cut_step_user(step_id, user_id) values(?, ?)", args);

	}

	@Transactional
	public void del(long id) {
		dao.delete(CutStep.class, id);
		dao.getSimpleJdbcTemplate().update("delete from cut_step_user where step_id=?", id);
		dao.getSimpleJdbcTemplate().update("delete from cut_task where step_id=?", id);
	}

	public Map<Long, String> getAllStepOwnerRoleUsers() {
		String sql = 
			" select distinct t.user_id, u.user_real_name from cut_user_role t  " +
			" left join cut_user u on u.user_id=t.user_id " +
			" where t.role_id=? " +
			" order by t.user_id ";
		return getMap(sql, 11);
	}

	public Map<Long, String> getAllStepCheckerRoleUsers() {
		String sql = 
			" select distinct t.user_id, u.user_real_name from cut_user_role t  " +
			" left join cut_user u on u.user_id=t.user_id " +
			" where t.role_id=? " +
			" order by t.user_id ";
		return getMap(sql, 12);
	}

	public Map<Long, String[]> getAllTaskUsers(Long id) {
		final Map<Long, String[]> map = new LinkedHashMap<Long, String[]>();
		dao.getSimpleJdbcTemplate().query(
				" select distinct t.user_id, u.user_real_name, s.step_id from cut_user_role t  " +
				" left join cut_user u on u.user_id=t.user_id " +
				" left join cut_step_user s on s.user_id=t.user_id and s.step_id=? " +
				" where t.role_id in (1, 21)  " +
				" order by t.user_id",
				new RowMapper<Object>() {
					public Map<String, Long> mapRow(ResultSet rs, int arg1)
							throws SQLException {
						map.put(rs.getLong(1), new String[]{rs.getString(2), rs.getString(3)});
						return null;
					}
				},
				id
		);
		return map;

	}

	/**
	 * <p>Description: <p>
	 * @param book
	 * @return
	 */
	public String importStep(Workbook book) throws Exception {
		List<Object[]> stepParams = new ArrayList<Object[]>();
		List<Object[]> stepUserParams = new ArrayList<Object[]>();
		Map<String, String> stepIdMap = dictService.id2Name("step_id", "step_name", "cut_step");
		Map<String, String> userNameMap = dictService.id2Name("user_real_name", "user_id", "cut_user");
		Map<String, String> stepNameMap = dictService.id2Name("step_name", "step_id", "cut_step");
		int curRow = 2;
		String stepId;
		String stepName;
		String userName;
		String stepTime;
		String stepWeight;
		String stepIndex;
		String stepUsers;
		String errorMsg = "";
		Object[] stepParam;
		Object[] stepUserParam;
		Sheet sheet = book.getSheet(0);//第一个工作表
		while(true){
			Cell[] c = sheet.getRow(curRow);//第三行开始
			if(c != null && c.length > 0){
				if(StringUtils.isEmpty(c[0].getContents())){
					stepId = getSequence().toString();
				} else {
					stepId = c[0].getContents().trim();
					if(Constants.XLS_END_FLAG.equals(stepId)){
						log.info("已载入全部数据！");
						break;
					}
					if(StringUtils.isNotEmpty(stepIdMap.get(stepId))){
						errorMsg = "步骤ID已存在！行号：" + (++curRow);
						log.error(errorMsg);
						throw new Exception(errorMsg);
					}
				}
				stepIndex = c[1].getContents();
				if(StringUtils.isEmpty(stepIndex)){
					stepIndex = "0";
				}
				stepName = c[2].getContents();
				if(StringUtils.isEmpty(stepName)){
					errorMsg = "步骤名不能为空！行号：" + (++curRow);
					log.error(errorMsg);
					throw new Exception(errorMsg);
				} else {
					stepName = stepName.trim();
					if(StringUtils.isNotEmpty(stepNameMap.get(stepName))){
						errorMsg = "登录名已存在！行号：" + (++curRow);
						log.error(errorMsg);
						throw new Exception(errorMsg);
					} else {
						stepNameMap.put(stepName, stepId);
						stepIdMap.put(stepId, stepName);
					}
					stepWeight = c[3].getContents().trim();//weight
					if(StringUtils.isEmpty(stepWeight)){
						stepWeight = "0";
					}
					stepTime = c[4].getContents().trim();//stepTime
					if(StringUtils.isEmpty(stepTime)){
						stepTime = "0";
					}
					userName = c[5].getContents().trim();//userName
					if(StringUtils.isEmpty(userNameMap.get(userName))){
						errorMsg = "负责人不存在！行号：" + (++curRow);
						log.error(errorMsg);
						throw new Exception(errorMsg);
					}
					stepParam = new Object[9];
					stepParam[0] = stepId;
					stepParam[1] = stepName;
					stepParam[2] = stepWeight;
					stepParam[3] = 0;//当前百分比
					stepParam[4] = stepTime;
					stepParam[5] = userNameMap.get(userName);
					stepParam[6] = userNameMap.get(userName);
					stepParam[7] = stepIndex;
					stepParam[8] = 0;
					stepParams.add(stepParam);
					
					//步骤-用户
					stepUsers = c[6].getContents().trim();//userName
					if(StringUtils.isNotEmpty(stepUsers)){
						for(String uName: stepUsers.split(",")){
							stepUserParam = new Object[2];
							stepUserParam[0] = stepId;
							if(StringUtils.isEmpty(userNameMap.get(uName))){
								errorMsg = "步骤子任务用户" + uName + "不存在！行号：" + (++curRow);
								log.error(errorMsg);
								throw new Exception(errorMsg);
							}
							if(!isStepOwner(uName)){
								errorMsg = "步骤子任务用户" + uName + "不是负责人角色！行号：" + (++curRow);
								log.error(errorMsg);
								throw new Exception(errorMsg);
							}
							stepUserParam[1] = userNameMap.get(uName);
							stepUserParams.add(stepUserParam);
						}
					}
					curRow ++;
				}
			} else {
				throw new Exception("行数据不能为空！行号：" + (++curRow));
			}
		}
		if(!stepParams.isEmpty()){
			insertTasks(stepParams, stepUserParams);
			return (stepParams.size()) + "";
		}
		return "0";
	}

	/**
	 * <p>Description: <p>
	 * @param stepParams
	 * @param stepUserParams
	 */
	@Transactional
	private void insertTasks(List<Object[]> stepParams, List<Object[]> stepUserParams) {
		dao.getSimpleJdbcTemplate().batchUpdate(addStepSql, stepParams);
		dao.getSimpleJdbcTemplate().batchUpdate(addStepUserSql, stepUserParams);
	}
	
	private boolean isStepOwner(String userName){
		return dao.getSimpleJdbcTemplate().queryForInt(isStepOwnerSql, userName) > 0 ? true : false;
	}
	
}
