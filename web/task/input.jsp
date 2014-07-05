<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<html>
	<head>
		<link href="/resources/css/css.css" type="text/css" rel="stylesheet" />
  		<script src="/resources/js/jquery.min.js" type="text/javascript"></script>
  		<script src="/resources/js/validate/jquery.validate.js" type="text/javascript"></script>
	</head>
	<body>
	<form id="form1" method="post" action="#">
		<input type="hidden" name="taskId" value="${cutTask.taskId}">
		<input type="hidden" name="stepId" value="${cutTask.stepId}">
		<input type="hidden" name="startTime" value="${cutTask.startTime}">
		<input type="hidden" name="finishTime" value="${cutTask.finishTime}">
		<input type="hidden" name="taskStatus" value="${cutTask.taskStatus}">
		<table width="100%" border="0" cellpadding="2" cellspacing="1">
		    <tr>
				<td class="popTitleMust" width="12%">子任务索引:</td>
				<td class="popConent">
					<input type="text" name="taskIndex" value="${cutTask.taskIndex}" class="required">
				</td>
			</tr>
		    <tr>
				<td class="popTitleMust" width="12%">子任务名称:</td>
				<td class="popConent">
					<input type="text" name="taskName" value="${cutTask.taskName}" class="required">
				</td>
			</tr>
		    <tr>
				<td class="popTitle" width="12%">子任务明细:</td>
				<td class="popConent">
					<textarea rows="10" cols="60" name="taskShellCommand">${cutTask.taskShellCommand}</textarea>
				</td>
			</tr>
		    <tr>
				<td class="popTitleMust" width="12%">计划时长(分钟):</td>
				<td class="popConent">
					<input type="text" name="taskTimes" value="${cutTask.taskTimes}" class="required">
				</td>
			</tr>
		    <tr>
				<td class="popTitle" width="12%">子任务负责人:</td>
				<td class="popConent">
					<select name="taskOperaterId" class="required">
		              <c:forEach var="e" items="${taskOperaters}">
		                <option value="${e.key}" <c:if test="${cutTask.taskOperaterId==e.key}">selected</c:if>>${e.value}</option>
		              </c:forEach>
		            </select>
				</td>
			</tr>
		    <tr>
				<td class="popTitle" width="12%">任务检查人:</td>
				<td class="popConent">
					<select name="taskCheckerId" class="required">
		              <c:forEach var="e" items="${taskCheckers}">
		                <option value="${e.key}" <c:if test="${cutTask.taskCheckerId==e.key}">selected</c:if>>${e.value}</option>
		              </c:forEach>
		            </select>
				</td>
			</tr>
		</table>
    </form>
	</body>
<script type="text/javascript">
	function Ok(){
		if(!$('#form1').validate().form()) return;
		$.post('/task/edit/save', $("form").serialize(), parent.JQueryXDialog.fnResult);
	}

</script>
</html>