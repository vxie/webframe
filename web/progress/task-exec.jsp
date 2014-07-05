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
	<script src="/resources/js/DateUtil.js" type="text/javascript"></script>
	<script src="/resources/js/common.js" type="text/javascript"></script>
  	
  	<script type="text/javascript">
		var images = [];
		function preLoadImages(){
			for(i=0;i<2;i++){
				images[i] = new Image();
				images[i].src = "/resources/images/folder"+i+".gif";
			}
		}
		preLoadImages();
		
  		$(document).ready(function() {
			document.getElementById("content").style.height = document.body.offsetHeight - 20;
			document.body.onresize = function(){
				document.getElementById("content").style.height = document.body.offsetHeight - 20;
			}
			
			$("tr[stepId]").each(function(){
				doCheckDisabledForTask(this.stepId);
			});
			
			$("button:contains('检查')").each(function(){
				var id = this.id.substr(this.id.indexOf("_")+1, this.id.length);
				doCheckButtonForTask(id);
			});
			
		});

		
		function clickFolder(img, id){
			var v = img.src.substr(img.src.lastIndexOf(".gif")-1, 1);
			img.src = v=="0"?images[1].src:images[0].src;
			
			var row = $("#tasks_for_"+id).get(0);
			row.style.display = v=="0"?"":"none";
		}
		
		function doCheckDisabledForTask(id){
			$.post("/progress/steps/start/"+id, function(s){
				$("tr[id='tasks_for_"+id+"'] button:contains('任务开始')").each(function(){
					this.disabled = s=="0";
				});
				if(s=="0"){
					setTimeout(function(){doCheckDisabledForTask(id);}, 2000);//每2秒检查一次
				}
			});
		}
		
		function doCheckButtonForTask(id){
			$.post("/progress/tasks/get/status/"+id, function(s){
				var o = $("#taskCheck_"+id).get(0);
				o.disabled = parseInt(s) < 2 || parseInt(s)==4;
				if(s=="3"){
					o.innerText = "检查完成";
				}
				setTimeout(function(){doCheckButtonForTask(id);}, 1000);//每1秒检查一次
			});
		}
		
		function changeTaskStatus(btn, id){
			var s = btn.innerText;
			var v = 0;
			if(s == "任务开始"){
				btn.innerText = "任务完成";
				$("#task_"+id+"_startTime").text(getSmpFormatNowDate(true));
				$("#taskError_"+id).get(0).disabled = false;
				$("#taskRecover_"+id).get(0).disabled = false;
				v = 1;
			}
			if(s == "任务完成"){
				btn.disabled = true;
				$("#taskError_"+id).get(0).disabled = true;

				var finishTime = getSmpFormatNowDate(true);
				$("#task_"+id+"_finishTime").text(finishTime);
				var finishDate = new Date(finishTime.replace(/-/g, '/'));
				var startTime = $("#task_"+id+"_startTime").text();
				var startDate = new Date(startTime.replace(/-/g, '/'));
				var costTime = (finishDate - startDate)/3600000;//小时
				$("#task_"+id+"_costTime").text(Math.round(costTime*100)/100);

				v = 2;
			}
			if(s == "检查开始"){
				btn.innerText = "检查完成";
				v = 3;
			}
			if(s == "检查完成"){
				btn.disabled = true;
				v = 4;
			}
			if(s == "设置异常"){
				$("#taskAction_"+id).get(0).disabled = true;
				btn.innerText = "结束异常";
				v = 5;
			}
			if(s == "结束异常"){
				btn.innerText = "设置异常";
				btn.disabled = true;
				$("#taskAction_"+id).get(0).innerText = "任务完成";
				$("#taskAction_"+id).get(0).disabled = true;

				var finishTime = getSmpFormatNowDate(true);
				$("#task_"+id+"_finishTime").text(finishTime);
				var finishDate = new Date(finishTime.replace(/-/g, '/'));
				var startTime = $("#task_"+id+"_startTime").text();
				var startDate = new Date(startTime.replace(/-/g, '/'));
				var costTime = (finishDate - startDate)/3600000;//小时
				$("#task_"+id+"_costTime").text(Math.round(costTime*100)/100);
				
				v = 2;
			}
			if(s == "恢复"){
				$("#taskAction_"+id).get(0).innerText = "任务开始";
				$("#taskAction_"+id).get(0).disabled = false;
				$("#taskError_"+id).get(0).innerText = "设置异常";
				$("#taskError_"+id).get(0).disabled = true;
				$("#task_"+id+"_startTime").text("");
				$("#task_"+id+"_finishTime").text("");
				$("#task_"+id+"_costTime").text("0.0");
				btn.disabled = true;
				v = 0;
			}
			$.post('/progress/tasks/update/status/'+id+'/'+v, function(s){
				$("#task_"+id+"_status").text(s);
			});
		}

  	</script>
  </head>

  <body>

<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr><td></td><td></td></tr>
	<tr><td>&nbsp;[&nbsp;步骤列表&nbsp;]</td></tr>
</table>
<div class="outer"><div id="content" class="content">
  <table id="steps" width="100%" border="1" cellpadding="0" cellspacing="0" rules="cols" bordercolor="#9aadce" class="table">
    <tr class="head" style="position:absolute;top:0;left:0;">
	  <td width="3%">索引</td>
	  <td >步骤</td>
      <td width="15%" style='display:none'>计划时长</td>
      <td width="20%">负责人</td>
      <td width="8%" style='display:none'>检查人</td>
    </tr>
    <c:forEach var="step" varStatus="item" items="${steps}">
    <tr stepId="${step.stepId}" onmouseover="doonmouseover(this)" onmouseout="doonmouseout(this, this.className)" <c:if test="${item.count % 2 == 0}">class="col"</c:if>>
      	<td>${step.stepIndex}</td>
      	<td class="weight"><img src="/resources/images/folder1.gif" border="0" onclick="clickFolder(this, '${step.stepId}')" style="cursor: hand;" align="absmiddle"/> ${step.stepName}</td>
      	<td style='display:none'>${step.stepTimes}</td>
      	<td>${step.stepOwnerName}</td>
      	<td style='display:none'>${step.stepCheckerName}</td>
    </tr>
    <tr id="tasks_for_${step.stepId}" onmouseover="doonmouseover(this)" onmouseout="doonmouseout(this, this.className)">
    	<td>&nbsp;</td>
    	<td colspan="4" style="padding: 0px 2px 2px 22px;">
		<table width="98%" border="1" cellpadding="0" cellspacing="0" rules="cols" bordercolor="#9aadce" class="table">
			<tr class="head2"> 
		      <td width="30pt">索引</td>
		      <td>任务名称</td>
		      <td width="10%" style="display: none">任务明细</td>
		      <td width="10%">计划时长(小时)</td>
		      <td width="10%">实际耗时(小时)</td>
		      <td width="12%">开始时间</td>
		      <td width="12%">完成时间</td>
		      <td width="8%">状态</td>
		      <td width="5%">负责人</td>
		      <td width="14%" style="display: none">检查人</td>
		      <td width="17%">操作</td>
		      <c:if test="${isAdmin>0}">
		      <td width="5%"></td>
		      </c:if>
			</tr>
			<c:forEach var="task" varStatus="i" items="${step.cutTasks}">
			<tr onmouseover="doonmouseover(this)" onmouseout="doonmouseout(this, this.className)" <c:if test="${i.count % 2 == 0}">class="col"</c:if>> 
		      <td>${task.taskIndex}</td>
		      <td><span style='display:block;width:180px;white-space:nowrap;overflow:hidden;text-overflow:ellipsis;'>${task.taskName}</span></td>
		      <td style="display: none">详细...</td>
		      <td><fmt:formatNumber type="number" value="${task.taskTimes/60}" maxFractionDigits="2"/></td>
		      <td id="task_${task.taskId}_costTime">${task.costTime}</td>
		      <td id="task_${task.taskId}_startTime">${task.startTime}</td>
		      <td id="task_${task.taskId}_finishTime">${task.finishTime}</td>
		      <td id="task_${task.taskId}_status">${status[task.taskStatus]}</td>
		      <td>${task.taskOperaterName}&nbsp;</td>
		      <td style="display: none">${task.taskCheckerName}&nbsp;
		      	<c:if test="${isAdmin>0 || (canCheckIt && cutUserId==task.taskCheckerId)}">
		      	<button id="taskCheck_${task.taskId}" class="btn_2k3" onclick="changeTaskStatus(this, ${task.taskId})"
		      		<c:if test="${task.taskStatus < 2 }">disabled="true">检查开始</c:if>
		      		<c:if test="${task.taskStatus == 2}">>检查开始</c:if>
		      		<c:if test="${task.taskStatus == 3}">>检查完成</c:if>
		      		<c:if test="${task.taskStatus > 3}">disabled="true">检查完成</c:if>
		      	</button>
		      	</c:if>
		      </td>
		      <td align="center">
		      	<c:if test="${isAdmin>0 || (canExecIt && cutUserId==task.taskOperaterId)}"><!-- 等待步骤开始 -->
		      	<button id="taskAction_${task.taskId}" class="btn_2k3" onclick="changeTaskStatus(this, ${task.taskId})" 
		      		<c:if test="${task.taskStatus == 0}">disabled="true">任务开始</c:if>
		      		<c:if test="${task.taskStatus == 1}">>任务完成</c:if>
		      		<c:if test="${task.taskStatus > 1 && task.taskStatus < 5}">disabled="true">任务完成</c:if>
		      		<c:if test="${task.taskStatus == 5}">disabled="true">任务完成</c:if>
		      	</button>
		      	</c:if>
		      	&nbsp;
		      	<c:if test="${isAdmin>0 || (canExecIt && cutUserId==task.taskOperaterId) || (canCheckIt && cutUserId==task.taskCheckerId)}">
		      	<button id="taskError_${task.taskId}" class="btn_2k3" onclick="changeTaskStatus(this, ${task.taskId})"
		      		<c:if test="${task.taskStatus == 0}">disabled="true">设置异常</c:if>
		      		<c:if test="${task.taskStatus > 0 && task.taskStatus < 2 }">>设置异常</c:if>
		      		<c:if test="${task.taskStatus == 2}">disabled="true">设置异常</c:if>
		      		<c:if test="${task.taskStatus > 2 && task.taskStatus < 5 }">>设置异常</c:if>
		      		<c:if test="${task.taskStatus == 5}">>结束异常</c:if>
		      	</button>
		      	</c:if>
		      </td>
		      <c:if test="${isAdmin>0}">
		      <td>&nbsp;
		      	<button id="taskRecover_${task.taskId}" class="btn_2k3" onclick="changeTaskStatus(this, ${task.taskId})"
		      		<c:if test="${task.taskStatus == 0}">disabled="true">恢复</c:if>
		      		<c:if test="${task.taskStatus > 0}">>恢复</c:if>
		      	</button>
		      </td>
		      </c:if>
			</tr>		
			</c:forEach>
		</table>
    	</td>
    </tr>
    </c:forEach>
  </table>
</div></div>
</body>
</html>
