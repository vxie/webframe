package com.sunrise.cutshow.business;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.sunrise.cutshow.model.CutStep;
import com.sunrise.cutshow.model.CutTask;
import com.sunrise.cutshow.utils.DateUtils;
import com.sunrise.springext.support.json.JSONException;
import com.sunrise.springext.support.json.JSONUtil;
import com.sunrise.springext.utils.SystemUtils;

@Service
public class CutProgressService extends BaseService {
	@Resource
	private BaseInfoService baseInfoService;
	

	/**
	 * 指定UserID的所有可访问的步骤
	 * @param userId
	 * @param isAdmin
	 * @return
	 */
	public List<CutStep> allVisitSteps(Long userId, boolean isAdmin) {

		if(isAdmin) return allSteps();
		
		String ids = SystemUtils.join(
				dao.getSimpleJdbcTemplate().query(
					"select distinct t.step_id from cut_step_user t where t.user_id=? order by t.step_id", 
					new RowMapper<Long>() {
						public Long mapRow(ResultSet rs, int arg1)
								throws SQLException {
							return rs.getLong(1);
						}
					}, 
					userId
				),
				",",
				"0"
			);
		List<CutStep> list = dao.find(CutStep.class, "from CutStep s where s.stepId in ("+ids+") order by s.stepIndex", new Object[]{});
		
		Map<Long, String> names = baseInfoService.getUsernames();
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

	public Boolean canCheckStep(Long userId) {
		return dao.queryForInt("select count(user_id) from cut_user_role t where t.user_id=? and (t.role_id=12 or t.role_id=1)", 0, userId) > 0; 
	}

	public Boolean canExecStep(Long userId) {
		return dao.queryForInt("select count(user_id) from cut_user_role t where t.user_id=? and (t.role_id=11 or t.role_id=1)", 0, userId) > 0; 
	}
	
	public Boolean canCheckTask(Long userId) {
		return dao.queryForInt("select count(user_id) from cut_user_role t where t.user_id=? and (t.role_id=22 or t.role_id=1)", 0, userId) > 0; 
	}

	public Boolean canExecTask(Long userId) {
		return dao.queryForInt("select count(user_id) from cut_user_role t where t.user_id=? and (t.role_id=21 or t.role_id=1)", 0, userId) > 0; 
	}
	
	/**
	 * 指定UserID的所有的可访问的子任务
	 * @param userId
	 * @param isAdmin
	 * @return
	 */
	public List<CutStep> getVisitTasks(Long userId, boolean isAdmin) {
		List<CutStep> list = null;
		Map<Long, String> names = baseInfoService.getUsernames();
		
		if(isAdmin) {
			list = allSteps();
		}else{
			String ids = SystemUtils.join(
				dao.getSimpleJdbcTemplate().query(
					"select distinct t.step_id from cut_task t where t.task_operater_id=? or t.task_checker_id=?", 
					new RowMapper<Long>() {
						public Long mapRow(ResultSet rs, int arg1)
								throws SQLException {
							return rs.getLong(1);
						}
					}, 
					userId, userId
				),
				",",
				"0"
			);
			list = dao.find(CutStep.class, "from CutStep s where s.stepId in ("+ids+") order by s.stepIndex", new Object[]{});
		}
		for(CutStep cutStep : list){
			List<CutTask> tasks = dao.find(CutTask.class, "from CutTask t where t.stepId=? order by t.taskIndex", cutStep.getStepId());
			for (CutTask cutTask : tasks) {
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
			
			cutStep.getCutTasks().addAll(tasks);
			cutStep.setStepCheckerName(names.get(cutStep.getStepCheckerId()));
			cutStep.setStepOwnerName(names.get(cutStep.getStepOwnerId()));
		}
		
		return list;
	}

	public String getStepProgressVal(Long id) {
		return dao.queryForInt("select step_cur_percent from cut_step where step_id=?", 0, id)+"%";
	}

	@Transactional
	public String updateStepStatus(Long id, Long value) {
		CutStep step = dao.get(CutStep.class, id);
		if(step!=null){
			step.setStepStatus(value);
			if(value == 1L){ //开始
				step.setStartTime(DateUtils.dateToString19(new Date()));
			} else if(value == 2L){ //完成
				step.setFinishTime(DateUtils.dateToString19(new Date()));
			}
			dao.update(step);
		}
		return getStepStatus().get(value);
	}

	public String startStep(Long id) {
		CutStep step = dao.get(CutStep.class, id);
		return step.getStepStatus()+"";
	}

	@Transactional
	public void updateTaskStatus(Long id, Long val) {
		CutTask task = dao.get(CutTask.class, id);
		if(task!=null){
			task.setTaskStatus(val);
			if(val == 1L){
				task.setStartTime(DateUtils.dateToString19(new Date()));
			} else if(val == 2L){
				task.setFinishTime(DateUtils.dateToString19(new Date()));
			} else if(val == 0L){
				task.setStartTime(null);
				task.setFinishTime(null);
			}
			dao.update(task);
			
			//如果是"操作完成", 则更新所在的Step的进度
			/*
			if(val.intValue()==2){
				Long stepId = task.getStepId();
				CutStep step = dao.get(CutStep.class, stepId);
				step.setStepCurPercent(((getFinishedTasksCount(stepId)+1) * 100 / getTasksCount(stepId)) * 1L);
				dao.update(step);
			} else if (val.intValue() == 0){//恢复操作
				Long stepId = task.getStepId();
				CutStep step = dao.get(CutStep.class, stepId);
				System.out.println("getFinishedTasksCount ： " + getFinishedTasksCount(stepId));
				step.setStepCurPercent(((getFinishedTasksCount(stepId)) * 100 / getTasksCount(stepId)) * 1L);
				dao.update(step);
			}
			*/
			
		}
//		return getStepStatus().get(val);
	}

	public String getTaskStatus(Long id) {
		CutTask task = dao.get(CutTask.class, id);
		return task.getTaskStatus()+"";
	}
	
	public String getTaskStatusText(Long id) {
		CutTask task = dao.get(CutTask.class, id);
		return getStepStatus().get(task.getTaskStatus());
	}
	
	private int getTasksCount(Long stepId){
		return dao.queryForInt("select count(task_id) from cut_task where step_id=?", 0, stepId);
	}
	
	private int getFinishedTasksCount(Long stepId){
		return dao.queryForInt("select count(task_id) from cut_task where step_id=? and task_status between 2 and 4", 0, stepId);
	}

	public String getCutTotalTime() {
//		return dao.queryForInt("select sum(step_times) from cut_step ", 0)+"";
		return dao.queryForInt("select sum(step_times) from cut_step where step_weight_value>0 ", 0)+"";
	}
	
	public Map<Long, CutTask> getTasks(){
		Map<Long, CutTask> map = new HashMap<Long, CutTask>();
		List<CutTask> list = dao.find(CutTask.class, "from CutTask ", new Object[]{});
		for (CutTask ct : list) {
			map.put(ct.getTaskId(), ct);
		}
		return map;
	}
	
	@SuppressWarnings("unchecked")
	public String getTaskStatus() throws JSONException{
//		List list = dao.getSimpleJdbcTemplate().queryForList(" select task_id taskId, task_status taskStatus from cut_task t where t.task_status!=4 ");
		List list = dao.getSimpleJdbcTemplate().queryForList(" select task_id taskId, task_status taskStatus from cut_task ");
		return JSONUtil.serialize(list).toString();
	}

	public String updateStepProcess(Long id, Long val) {
		CutTask task = dao.get(CutTask.class, id);
		if(task!=null){
			Long stepId = task.getStepId();
			CutStep step = dao.get(CutStep.class, stepId);
			step.setStepCurPercent(((getFinishedTasksCount(stepId)) * 100 / getTasksCount(stepId)) * 1L);
			dao.update(step);
		}
		return getStepStatus().get(val);
	}

}
