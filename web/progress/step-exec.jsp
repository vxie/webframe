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
  	<script src="/resources/js/DateUtil.js" type="text/javascript"></script>
  	
  	<script type="text/javascript">
  		$(document).ready(function() {
			document.getElementById("content").style.height = document.body.offsetHeight - 20;
			document.body.onresize = function(){
				document.getElementById("content").style.height = document.body.offsetHeight - 20;
			}
		});
		
		var images = [];
		function preLoadImages(){
			for(i=0;i<2;i++){
				images[i] = new Image();
				images[i].src = "/resources/images/folder"+i+".gif";
			}
		}
		preLoadImages();
		
		function clickFolder(img, id){
			var v = img.src.substr(img.src.lastIndexOf(".gif")-1, 1);
			img.src = v=="0"?images[1].src:images[0].src;
			
			var row = $("#tasks_for_"+id).get(0);
			if(row.cells[1].innerHTML==""){
				
				$.getJSON("/step/tasks", {stepId: id}, function(data){
					var strRow = "";
					$.each(data, function(i){
						var startTime = this.startTime == null ? "" : this.startTime;
						var finishTime = this.finishTime == null ? "" : this.finishTime;
						strRow += 
						"    <tr taskId='"+this.taskId+"' onmouseover='doonmouseover(this)' onmouseout='doonmouseout(this, this.className)' "+(i % 2 == 0?"":"class='col'")+"> " +
						"      <td>"+this.taskIndex+" </td> " +
						"      <td>"+this.taskName+" </td> " +
						"      <td style='display:none'>"+this.taskTimes+"</td> " +
						"      <td>"+startTime+"</td> " +
						"      <td>"+finishTime+"</td> " +
						"      <td>"+this.taskStatusName+"</td> " +
						"      <td>"+this.taskOperaterName+"</td> " +
						"      <td style='display: none'>"+this.taskCheckerName+"</td> " +
						"    </tr> ";
						refreshTaskStatus(this.taskId);
					});
					
					if(strRow == "") return;
					
					strRow = taskDetails + strRow + "</table> ";
					
					row.cells[1].innerHTML = v=="0"?strRow:"&nbsp;";
					row.style.display = v=="0"?"":"none";
				});
			}else{
				row.style.display = v=="0"?"":"none";
			}
			
		}
		
		var taskDetails = 
		"<table width='98%' border='1' cellpadding='0' cellspacing='0' rules='cols' bordercolor='#9aadce' class='table'> " +
      	"	<tr class='head2'> " +
	    "      <td width='5%'>索引</td> " +
	    "      <td>子任务名称</td> " +
	    "      <td width='12%' style='display:none'>计划时长(分钟)</td> " +
	    "      <td width='15%'>开始时间</td> " +
	    "      <td width='15%'>完成时间</td> " +
	    "      <td width='10%'>状态</td> " +
	    "      <td width='20%'>负责人</td> " +
	    "      <td width='18%' style='display: none'>检查人</td> " +
      	"	</tr> ";

		
		function changeStepStatus(btn, id){
			var s = btn.innerText;
			var v = 0;
			if(s == "步骤开始"){
				btn.innerText = "步骤完成";
				$("#step_"+id+"_startTime").text(getSmpFormatNowDate(true));
				v = 1;
			}
			if(s == "步骤完成"){
				btn.disabled = true;
				var finishTime = getSmpFormatNowDate(true);
				$("#step_"+id+"_finishTime").text(finishTime);
				var finishDate = new Date(finishTime.replace(/-/g, '/'));
				var startTime = $("#step_"+id+"_startTime").text();
				var startDate = new Date(startTime.replace(/-/g, '/'));
				var costTime = (finishDate - startDate)/3600000;//小时
				$("#step_"+id+"_costTime").text(Math.round(costTime*100)/100);
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
			$.post('/progress/steps/status/'+id+'/'+v, function(s){
				$("#step_"+id+"_status").text(s);
			});
		}
		
		//每2秒刷新一次Task的状态
		function refreshTaskStatus(id, row){
			$.post("/progress/tasks/get/status/text/"+id, function(s){
				var rowTask = row || $("tr[taskId='"+id+"']").get(0);
				if(rowTask)	rowTask.cells[5].innerText = s;
				setTimeout(function(){refreshTaskStatus(id, rowTask);}, 2000);
			});
		}
		
  	</script>
  </head>

  <body>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr><td></td><td></td></tr>
	<tr><td>[ 步骤列表 ]</td><td>&nbsp;</td></tr>
</table>
<div class="outer"><div id="content" class="content">
  <table id="steps" width="100%" border="1" cellpadding="0" cellspacing="0" rules="cols" bordercolor="#9aadce" class="table">
        <tr class="head" style="position:absolute;top:0;left:0;">
          <td width="3%">索引</td>
          <td>步骤</td>
          <td width="10%">计划时长(小时)</td>
          <td width="10%">实际耗时(小时)</td>
          <td width="15%">开始时间</td>
          <td width="15%">完成时间</td>
          <td width="10%">状态</td>
          <td width="8%">负责人</td>
          <td width="10%">操作</td>
          <td width="15%" style="display: none">检查人</td>
        </tr>
    <c:forEach var="step" varStatus="item" items="${steps}">
    <tr onmouseover="doonmouseover(this)" onmouseout="doonmouseout(this, this.className)" <c:if test="${item.count % 2 == 0}">class="col"</c:if>>
      	<td>${step.stepIndex}</td>
      	<td class="weight"><img src="/resources/images/folder0.gif" border="0" onclick="clickFolder(this, '${step.stepId}')" style="cursor: hand;" align="absmiddle"/> ${step.stepName}</td>
      	<td><fmt:formatNumber type="number" value="${step.stepTimes/60}" maxFractionDigits="2"/></td>
      	<td id="step_${step.stepId}_costTime">${step.costTime}</td>
      	<td id="step_${step.stepId}_startTime">${step.startTime}</td>
		<td id="step_${step.stepId}_finishTime">${step.finishTime}</td>
      	<td id="step_${step.stepId}_status">${status[step.stepStatus]}</td>
	    <td>${step.stepOwnerName}&nbsp;</td>
	    <td>
	      	<c:if test="${isAdmin>0 || (canExecIt && cutUserId==step.stepOwnerId)}">
	      	<button class="btn_2k3" onclick="changeStepStatus(this, ${step.stepId})" 
	      		<c:if test="${step.stepStatus == 0}">>步骤开始</c:if>
	      		<c:if test="${step.stepStatus == 1}">>步骤完成</c:if>
	      		<c:if test="${step.stepStatus > 1}">disabled="true">步骤完成</c:if>
	      	</button>
	      	</c:if>
	    </td>
	    <td style="display: none">${step.stepCheckerName}&nbsp;
	      	<c:if test="${isAdmin>0 || (canCheckIt && cutUserId==step.stepCheckerId)}">
	      	<button class="btn_2k3" onclick="changeStepStatus(this, ${step.stepId})" 
	      		<c:if test="${step.stepStatus < 3}">>检查开始</c:if>
	      		<c:if test="${step.stepStatus == 3}">>检查完成</c:if>
	      		<c:if test="${step.stepStatus == 4}">disabled="true">检查完成</c:if>
	      	</button>
	      	</c:if>
	    </td>
    </tr>
    <tr id="tasks_for_${step.stepId}" style="display:none;"><td>&nbsp;</td><td colspan="6" style="padding: 0px 2px 2px 22px;"></td></tr>
    </c:forEach>
  </table>
</div></div>
</body>
</html>
