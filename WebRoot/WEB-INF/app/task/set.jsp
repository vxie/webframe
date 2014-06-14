<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
  <head>
	<link href="/resources/css/css.css" type="text/css" rel="stylesheet" />
    <style>
		html {
			height: 100%;
		}
		body {
			margin: 0;
			padding: 0;
			height: 100%;
		}
		.content {
			overflow:scroll;
			background: #EEE;
			width: 100%;
			height:100%;
		}
		.outer {
			position:relative;
			padding:1.7em 0 0em 0;
			width:100%;
			height:100%;
			margin:0 auto 0em auto;
		}
		.weight {
			font-weight:bold;
		}

    </style>
  	<script src="/resources/js/jquery.min.js" type="text/javascript"></script>
	<script src="/resources/js/common.js" type="text/javascript"></script>
  	
  	<script type="text/javascript">
  	  	$(document).ready(function() {
			document.getElementById("content").style.height = document.body.offsetHeight - 20;
			document.body.onresize = function(){
				document.getElementById("content").style.height = document.body.offsetHeight - 20;
			}
		});
		
		function doEdit(id, stepId){
			showModalDlg((id?"编辑":"新建") + "子任务", '/task/edit/'+id+"/"+stepId, 600, 400, function(s){
				window.location.reload();
			});
		}
		function doDel(id){
	  		if(!window.confirm("你确定要删除该子任务吗(删除后不可恢复)?")){
			    return;
			}
			$.post(
				'/task/del/'+id,
				function(s){
					window.location.reload();
				}
			);
		}
		function doImport(){
			showModalDlg("导入任务", '/common/import/task', 600, 120, function(s){doReset();});
		}
  	</script>
  </head>

  <body>

<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr><td></td><td></td></tr>
	<tr>
		<td>&nbsp;[&nbsp;步骤列表&nbsp;]</td>
		<td align="right"><button class="btn_2k3" onclick="doImport()">导入</button></td>
	</tr>
</table>
<div class="outer"><div id="content" class="content">
  <table id="steps" width="100%" border="1" cellpadding="0" cellspacing="0" rules="cols" bordercolor="#9aadce" class="table">
    <tr class="head" style="position:absolute;top:0;left:0;">
      <td width="3%">索引</td>
      <td width="37%">步骤</td>
      <td width="12%" style='display:none'>计划时长</td>
      <td width="13%">负责人</td>
      <td width="8%" style="display: none">检查人</td>
    </tr>
    <c:forEach var="step" varStatus="item" items="${steps}">
    <tr onmouseover="doonmouseover(this)" onmouseout="doonmouseout(this, this.className)" <c:if test="${item.count % 2 == 0}">class="col"</c:if>>
      	<td>${step.stepIndex}</td>
      	<td class="weight"><img src="/resources/images/folder1.gif" border="0" style="cursor: hand;" align="absmiddle"/> ${step.stepName}</td>
      	<td style='display:none'>${step.stepTimes}</td>
      	<td>${step.stepOwnerName}</td>
      	<td style="display: none">${step.stepCheckerName}</td>
    </tr>
    <tr onmouseover="doonmouseover(this)" onmouseout="doonmouseout(this, this.className)">
    	<td>&nbsp;</td>
    	<td colspan="5" style="padding: 0px 2px 2px 22px;">
		<table width="98%" border="1" cellpadding="0" cellspacing="0" rules="cols" bordercolor="#9aadce" class="table">
			<tr class="head2"> 
		      <td width="4%">索引</td>
		      <td>任务名称</td>
		      <td width="15%">任务明细</td>
		      <td width="12%">计划时长(小时)</td>
		      <td width="13%">负责人</td>
		      <td width="8%" style="display: none">检查人</td>
		      <td width="12%">操作</td>
			</tr>
			<c:forEach var="task" varStatus="i" items="${step.cutTasks}">
			<tr onmouseover="doonmouseover(this)" onmouseout="doonmouseout(this, this.className)" <c:if test="${i.count % 2 == 0}">class="col"</c:if>> 
		      <td>${task.taskIndex}</td>
		      <td>${task.taskName}</td>
		      <td>详细...</td>
		      <td><fmt:formatNumber type="number" value="${task.taskTimes/60}" maxFractionDigits="2"/></td>
		      <td>${task.taskOperaterName}</td>
		      <td style="display: none">${task.taskCheckerName}</td>
		      <td><a href="#" onclick="doEdit(${task.taskId}, ${step.stepId})">编辑</a>&nbsp;<a href="#" onclick="doDel(${task.taskId})">删除</a></td>
			</tr>		
			</c:forEach>
			<tr> 
		      <td>&nbsp;</td>
		      <td>&nbsp;</td>
		      <td>&nbsp;</td>
		      <td>&nbsp;</td>
		      <td>&nbsp;</td>
		      <td style="display: none">&nbsp;</td>
		      <td><a href="#" onclick="doEdit(0, ${step.stepId})" style="color:red;">新增</a></td>
			</tr>		
		</table>
    	</td>
    </tr>
    </c:forEach>
  </table>
</div></div>
</body>
</html>
