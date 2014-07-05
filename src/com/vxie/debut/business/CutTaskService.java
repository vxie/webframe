package com.vxie.debut.business;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

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
import com.sunrise.springext.utils.SystemUtils;

@Service
public class CutTaskService extends BaseService {
	
	private static final String addTaskSql = "insert into cut_task(task_id, task_name, task_operater_id, task_checker_id, " +
			" task_times, step_id, task_index, task_status) values(?, ?,?, ?, ?, ?, ?, ?)";
	
	@Resource
	private BaseInfoService baseInfoService;
	@Resource
	private DictService dictService;
	
	
	public List<CutStep> getVisitSteps(Long userId, boolean isAdmin) {
		List<CutStep> list = null;
		Map<Long, String> names = baseInfoService.getUsernames();
		
		if(isAdmin) {
			list = allSteps();
		}else{
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
			list = dao.find(CutStep.class, "from CutStep s where s.stepId in ("+ids+") order by s.stepIndex", new Object[]{});
		}
		for(CutStep cutStep : list){
			List<CutTask> tasks = dao.find(CutTask.class, "from CutTask t where t.stepId=? order by t.taskIndex", cutStep.getStepId());
			for (CutTask cutTask : tasks) {
				cutTask.setTaskCheckerName(names.get(cutTask.getTaskCheckerId()));
				cutTask.setTaskOperaterName(names.get(cutTask.getTaskOperaterId()));
			}
			
			cutStep.getCutTasks().addAll(tasks);
			cutStep.setStepCheckerName(names.get(cutStep.getStepCheckerId()));
			cutStep.setStepOwnerName(names.get(cutStep.getStepOwnerId()));
		}
		
		return list;
	}

	@Transactional
	public void save(CutTask cutTask) {
//		CutStep step = dao.get(CutStep.class, cutTask.getStepId());
//		if(step!=null){
//			//现在的step_times != sum(task_times)
//			//step.setStepTimes(step.getStepTimes()+cutTask.getTaskTimes());
//			dao.update(step);
//		}
		dao.saveOrUpdate(cutTask);
	}

	@Transactional
	public void del(long id) {
		CutTask task = dao.get(CutTask.class, id);
//		CutStep step = dao.get(CutStep.class, task.getStepId());
//		if(step!=null){
//			//step.setStepTimes(step.getStepTimes() - task.getTaskTimes());
//			dao.update(step);
//		}
		dao.delete(task);
	}

	public Map<Long, String> getTaskOperaters(long id) {
		String sql = 
			" select distinct t.user_id, u.user_real_name from cut_user_role t  " +
			" left join cut_user u on u.user_id=t.user_id " +
			" where t.role_id=? " +
			" order by t.user_id ";
		return getMap(sql, 21);
	}

	public Map<Long, String> getTaskCheckers(long id) {
		String sql = 
			" select distinct t.user_id, u.user_real_name from cut_user_role t  " +
			" left join cut_user u on u.user_id=t.user_id " +
			" where t.role_id=? " +
			" order by t.user_id ";
		return getMap(sql, 22);
	}

	/**
	 * <p>Description: <p>
	 * @param book
	 * @return
	 */
	public String importTask(Workbook book) throws Exception {
		List<Object[]> taskParams = new ArrayList<Object[]>();
//		Map<String, String> taskNameMap = dictService.id2Name("task_name", "task_id", "cut_task");
		Map<String, String> taskIdMap = dictService.id2Name("task_id", "task_name", "cut_task");
		Map<String, String> userNameMap = dictService.id2Name("user_real_name", "user_id", "cut_user");
		Map<String, String> stepNameMap = dictService.id2Name("step_name", "step_id", "cut_step");
		int curRow = 2;
		String taskId;
		String taskName;
		String userName;
		String taskTime;
		String stepName;
		String taskIndex;
		String errorMsg = "";
		Object[] taskParam;
		Sheet sheet = book.getSheet(0);//第一个工作表
		while(true){
			Cell[] c = sheet.getRow(curRow);//第三行开始
			if(c != null && c.length > 0){
				if(StringUtils.isEmpty(c[0].getContents())){
					taskId = getSequence().toString();
				} else {
					taskId = c[0].getContents().trim();
					if(Constants.XLS_END_FLAG.equals(taskId)){
						log.info("已载入全部数据！");
						break;
					}
					if(StringUtils.isNotEmpty(taskIdMap.get(taskId))){
						errorMsg = "任务ID已存在！行号：" + (++curRow);
						log.error(errorMsg);
						throw new Exception(errorMsg);
					}
				}
				taskName = c[1].getContents();
				if(StringUtils.isEmpty(taskName)){
					errorMsg = "任务名不能为空！行号：" + (++curRow);
					log.error(errorMsg);
					throw new Exception(errorMsg);
				} else {
					taskName = taskName.trim();
					taskIdMap.put(taskId, taskName);
//					if(StringUtils.isNotEmpty(taskNameMap.get(taskName))){
//						errorMsg = "任务名已存在！行号：" + (++curRow);
//						log.error(errorMsg);
//						throw new Exception(errorMsg);
//					} else {
//						taskNameMap.put(taskName, taskId);
//					}
					userName = c[2].getContents().trim();//userName
					if(StringUtils.isEmpty(userName)){
						errorMsg = "负责人不能为空！行号：" + (++curRow);
						log.error(errorMsg);
						throw new Exception(errorMsg);
					}
					taskTime = c[3].getContents().trim();//taskTime
					if(StringUtils.isEmpty(taskTime)){
						taskTime = "0";
					}
					stepName = c[4].getContents().trim();//stepName
					if(StringUtils.isEmpty(stepNameMap.get(stepName))){
						errorMsg = "所属步骤不能为空！行号：" + (++curRow);
						log.error(errorMsg);
						throw new Exception(errorMsg);
					}
					taskIndex = c[5].getContents().trim();//stepName
					if(StringUtils.isEmpty(taskIndex)){
						taskTime = "0";
					}
					
					taskParam = new Object[8];
					taskParam[0] = taskId;
					taskParam[1] = taskName;
					taskParam[2] = userNameMap.get(userName);
					taskParam[3] = userNameMap.get(userName);
					taskParam[4] = taskTime;
					taskParam[5] = stepNameMap.get(stepName);
					taskParam[6] = taskIndex;
					taskParam[7] = "0";
					taskParams.add(taskParam);
					curRow ++;
				}
			} else {
				throw new Exception("行数据不能为空！行号：" + (++curRow));
			}
		}
		if(!taskParams.isEmpty()){
			insertTasks(taskParams);
			return (taskParams.size()) + "";
		}
		return "0";
	}

	/**
	 * <p>Description: <p>
	 * @param taskParams
	 */
	@Transactional
	private void insertTasks(List<Object[]> taskParams) {
		dao.getSimpleJdbcTemplate().batchUpdate(addTaskSql, taskParams);
	}
	
}
