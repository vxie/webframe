package com.vxie.debut.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

@Entity
@Table(name="CUT_TASK")
//@SequenceGenerator(name="SEQ_CUT_SHOW", allocationSize=1, sequenceName = "SEQ_CUT_SHOW")
public class CutTask {
	public CutTask() {
	}
	
	public CutTask(Long stepId) {
		this.stepId = stepId;
	}
	
	@Id
	@Column(name="task_Id")
	//@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "SEQ_CUT_SHOW")
	private Long taskId;
	
	@Column(name="task_Name")
	private String taskName;
	
	@Column(name="task_Operater_Id")
	private Long taskOperaterId;
	
	@Column(name="task_Checker_Id")
	private Long taskCheckerId;
	
	@Column(name="task_Times")
	private Long taskTimes;
	
	@Column(name="step_Id")
	private Long stepId;
	
	@Column(name="task_Shell_Command")
	private String taskShellCommand;
	
	@Column(name="task_Index")
	private Long taskIndex;
	
	@Column(name="task_Status")
	private Long taskStatus = 0L;
	
	@Column(name="start_time")
	private String startTime;
	
	@Column(name="finish_time")
	private String finishTime;
	
	@Transient
	private String taskOperaterName;
	
	@Transient
	private String taskCheckerName;
	
	@Transient
	private String taskStatusName;
	
	public Long getTaskId() {
		return taskId;
	}
	public void setTaskId(Long taskId) {
		this.taskId = taskId;
	}
	public String getTaskName() {
		return taskName;
	}
	public void setTaskName(String taskName) {
		this.taskName = taskName;
	}
	public Long getTaskOperaterId() {
		return taskOperaterId;
	}
	public void setTaskOperaterId(Long taskOperaterId) {
		this.taskOperaterId = taskOperaterId;
	}
	public Long getTaskCheckerId() {
		return taskCheckerId;
	}
	public void setTaskCheckerId(Long taskCheckerId) {
		this.taskCheckerId = taskCheckerId;
	}
	public Long getTaskTimes() {
		return taskTimes;
	}
	public void setTaskTimes(Long taskTimes) {
		this.taskTimes = taskTimes;
	}
	public Long getStepId() {
		return stepId;
	}
	public void setStepId(Long stepId) {
		this.stepId = stepId;
	}
	public String getTaskShellCommand() {
		return taskShellCommand;
	}
	public void setTaskShellCommand(String taskShellCommand) {
		this.taskShellCommand = taskShellCommand;
	}
	public Long getTaskIndex() {
		return taskIndex;
	}
	public void setTaskIndex(Long taskIndex) {
		this.taskIndex = taskIndex;
	}
	public Long getTaskStatus() {
		return taskStatus;
	}
	public void setTaskStatus(Long taskStatus) {
		this.taskStatus = taskStatus;
	}

	public String getTaskOperaterName() {
		return taskOperaterName;
	}

	public void setTaskOperaterName(String taskOperaterName) {
		this.taskOperaterName = taskOperaterName;
	}

	public String getTaskCheckerName() {
		return taskCheckerName;
	}

	public void setTaskCheckerName(String taskCheckerName) {
		this.taskCheckerName = taskCheckerName;
	}

	public String getTaskStatusName() {
		return taskStatusName;
	}

	public void setTaskStatusName(String taskStatusName) {
		this.taskStatusName = taskStatusName;
	}

	public String getStartTime() {
		return startTime;
	}

	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}

	public String getFinishTime() {
		return finishTime;
	}

	public void setFinishTime(String finishTime) {
		this.finishTime = finishTime;
	}
	
	@Transient
	private double costTime;

	public double getCostTime() {
		return costTime;
	}
	public void setCostTime(double costTime) {
		this.costTime = costTime;
	}
	
}
