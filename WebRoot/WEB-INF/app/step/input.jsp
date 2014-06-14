<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<html>
	<head>
		<link href="/resources/css/css.css" type="text/css" rel="stylesheet" />
  		<script src="/resources/js/jquery.min.js" type="text/javascript"></script>
  		<script src="/resources/js/jquery.metadata.js" type="text/javascript"></script>
  		<script src="/resources/js/validate/jquery.validate.js" type="text/javascript"></script>
	</head>
	<body>
	<form id="form1" method="post" action="#">
		<input type="hidden" name="stepId" value="${cutStep.stepId}" />
		<input type="hidden" name="startTime" value="${cutStep.startTime}" />
		<input type="hidden" name="finishTime" value="${cutStep.finishTime}" />
		<input type="hidden" name="stepStatus" value="${cutStep.stepStatus}" />
		<input type="hidden" name="stepCurPercent" value="${cutStep.stepCurPercent}" />
		<table width="100%" border="0" cellpadding="2" cellspacing="1">
		    <tr>
				<td class="popTitleMust" width="12%">步骤索引:</td>
				<td class="popConent">
					<input type="text" name="stepIndex" value="${cutStep.stepIndex}" class="{required:true, digits:true}">
				</td>
			</tr>
		    <tr>
				<td class="popTitleMust" width="12%">步骤名称:</td>
				<td class="popConent">
					<input type="text" name="stepName" value="${cutStep.stepName}" class="required">
				</td>
			</tr>
		    <tr>
				<td class="popTitleMust" width="12%">权重(占总割接进度百分比):</td>
				<td class="popConent">
					<input type="text" name="stepWeightValue" value="${cutStep.stepWeightValue}" class="{required:true, digits:true, min:0, max:100}">
				</td>
			</tr>
		    <tr>
				<td class="popTitleMust" width="12%">计划时长(分钟):</td>
				<td class="popConent">
					<input type="text" name="stepTimes" value="${cutStep.stepTimes}" class="{required:true, digits:true}">
				</td>
			</tr>
		    <tr>
				<td class="popTitleMust" width="12%">步骤负责人:</td>
				<td class="popConent">
					<select name="stepOwnerId" class="required">
		              <c:forEach var="e" items="${stepOwners}">
		                <option value="${e.key}" <c:if test="${cutStep.stepOwnerId==e.key}">selected</c:if>>${e.value}</option>
		              </c:forEach>
		            </select>
				</td>
			</tr>
		    <tr>
				<td class="popTitleMust" width="12%">步骤检查人:</td>
				<td class="popConent">
					<select name="stepCheckerId" class="required">
		              <c:forEach var="e" items="${stepCheckers}">
		                <option value="${e.key}" <c:if test="${cutStep.stepCheckerId==e.key}">selected</c:if>>${e.value}</option>
		              </c:forEach>
		            </select>
				</td>
			</tr>
		    <tr valign="top" width="100%">
				<td class="popTitle" width="12%">步骤子任务用户列表:</td>
				<td>
					<div style="overflow:auto;height:260px;border:1px solid #D3D3D3;">
					<table border="0" cellpadding="2" cellspacing="1">
					<c:forEach var="e" items="${taskUsers}">
						<tr><td><label for="taskUser_${e.key}"><input type="checkbox" name="stepVisitUsers" id="taskUser_${e.key}" class="chkInput" value="${e.key}"  <c:if test="${e.value[1] > '0'}">checked='true'</c:if>/>${e.value[0]}</label></td></tr>
					</c:forEach>
					</table>
					</div>
				</td>
			</tr>
		</table>
    </form>
	</body>
<script type="text/javascript">

	function Ok(){
		if(!$('#form1').validate().form()) return;
		$.post('/step/edit/save', $("form").serialize(), parent.JQueryXDialog.fnResult);
	}

</script>
</html>