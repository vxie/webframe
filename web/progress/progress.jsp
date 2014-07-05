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
		
		.progressBarColor1{
			position: relative;
			display: block;
  			overflow: hidden;
			background:blue;
			/* background: #B1D632; */
    		color: #333333;
    		width:0%;
    		height:30px;
		}
		.progressBarColor2{
			background:#778899;
		}
		.progressBarBorderColor{
			width:99.8%;
			height:30px;
			/*font-size:20pt;*/
			background:#EEE; 
			/* border:1px solid #724a10; */
			border:1px solid darkred;
			/* border: 1px solid #B1D632; */
    		padding: 1px;
		}
		.progress-label{
			position:absolute; 
			right: 0; 
			padding-right: 12px; 
			white-space: nowrap; 
			height:30px;
			font-size:20px;
			color:yellow; 
			/*margin:5px;*/ 
			padding:5px;
			/*font-weight:bold;*/
		}
		
		
    </style>
  	<script src="/resources/js/jquery.min.js" type="text/javascript"></script>
  	<script src="/resources/js/common.js" type="text/javascript"></script>
  	<script src="/resources/js/progress.js" type="text/javascript"></script>
  	<script type="text/javascript">
		$(document).ready(function() {	

			//刷新显示系统当前时间
			var clock = new Clock();
			clock.display(document.getElementById("currentTime"));
			//clock.display(document.getElementById("progressbar_currentTime"));

			//alert("progress:"+document.body.offsetHeight);	
				
			document.getElementById("content").style.height = document.body.offsetHeight - 100;
			//document.getElementById("image").style.height = document.body.offsetHeight - 100;
			document.getElementById("image").style.height = parent.height - 41 - 108 + 15;
			document.body.onresize = function(){

				if(parent.barflg == "0"){//收缩
					document.getElementById("image").style.height = parent.height  - 108;
				}
				if(parent.barflg == "1"){//展开
					document.getElementById("image").style.height = parent.height - 41 - 108;
				}
				document.getElementById("content").style.height = document.body.offsetHeight - 200;
				//document.getElementById("image").style.height = document.body.offsetHeight - 200;
			}

			//refreshCutTotalTime(); //每隔2秒种刷新1次总的时间
			doCheckProgressForAllStep();
		});
		
		var images = [];
		function preLoadImages(){
			for(i=0;i<2;i++){
				images[i] = new Image();
				images[i].src = "/resources/images/folder"+i+".gif";
			}
		}
		preLoadImages();

		function clickRow(id){
			var imgObj = $("#img_" + id).get(0);
			clickFolder(imgObj, id);
		}
		
		function clickFolder(img, id){
			var v = img.src.substr(img.src.lastIndexOf(".gif")-1, 1);
			img.src = v=="0"?images[1].src:images[0].src;
			
			var row = $("#tasks_for_"+id).get(0);
			if(row.cells[1].innerHTML==""){
				
				$.getJSON("/step/tasks", {stepId: id}, function(data){
					var strRow = "";
					$.each(data, function(i){
						strRow += 
						"    <tr taskId='"+this.taskId+"' onmouseover='doonmouseover(this)' onmouseout='doonmouseout(this, this.className)' "+(i % 2 == 0?"":"class='col'")+"> " +
						"      <td>"+this.taskIndex+" </td> " +
						"      <td>"+this.taskName+" </td> " +
						"      <td>" + (this.taskTimes/60).toFixed(2) + "</td> " +
						"      <td>"+this.taskStatusName+"</td> " +
						"      <td>"+this.taskOperaterName+"</td> " +
						"      <td style='display:none'>"+this.taskCheckerName+"</td> " +
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
	    "      <td width='10%'>计划时长(小时)</td> " +
	    "      <td width='15%'>状态</td> " +
	    "      <td width='13%'>负责人</td> " +
	    "      <td width='8%' style='display:none'>检查人</td> " +
      	"	</tr> ";

      	
      	//步骤进度
		var stepProgressValues = [];
		function doProgressForTotal(){
			var v = 0;
			for(var x in stepProgressValues){
				var item = stepProgressValues[x];
				v += item.stepWeight * item.value;
			}
	
			if(v == 0) $("#cutStatus").text("割接未开始");
			if(v > 0 && v < 10000) $("#cutStatus").text("割接进行中");
			if(v == 10000) $("#cutStatus").text("割接完毕");
			
			var s = v / 100 + "%";

		
			$("#progressbar_total_text").text(s);
			//$("#progressbar_total_text").css("width", s);
			$("#progressbar_total_value").css("width", s);
			//$('#progressbar_total_value').animateProgress(v/100);
		}
		
		function doCheckProgressForStep(id){
			$.post("/progress/refresh/step/"+id, function(s){

				$("#progressbar_step_"+id+"_text").text(s);
				$("#progressbar_step_"+id+"_value").css("width", s);
				stepProgressValues[id].value = parseInt(s.substr(0, s.length-1));
				//if(s!="100%"){
					setTimeout(function(){doCheckProgressForStep(id);}, 3000);//每3秒检查一次Step进度
				//}
				doProgressForTotal();   //总的进度信息
			});
		}
		
		function doCheckProgressForAllStep(){
			$("tr[stepId]").each(function(){
				stepProgressValues[this.stepId] = {stepWeight: parseInt(this.stepWeight), value:0};
				doCheckProgressForStep(this.stepId);
			});
			
		}
		
		//每2秒刷新一次Task的状态
		function refreshTaskStatus(id, row){
			$.post("/progress/tasks/get/status/text/"+id, function(s){
				var rowTask = row || $("tr[taskId='"+id+"']").get(0);
				if(rowTask)	rowTask.cells[3].innerText = s;
				setTimeout(function(){refreshTaskStatus(id, rowTask);}, 2000);
			});
		}
		
		//每2秒刷新一次Task的状态
		function refreshCutTotalTime(){
			$.post("/progress/refresh/totaltime/", function(s){
				var mins = s;
				var hours = (s/60).toFixed(2);
				var text = hours + " 小时(" + s + " 分钟)";
				$("#cutTotalTime").text(text);
				//setTimeout(function(){refreshCutTotalTime();}, 2000); 不刷新
			});
		}

		function showType(buttonObj){
			var text = buttonObj.innerText;
			if(text == '列表显示'){
				buttonObj.innerText = '图表显示';
				$('#progressImg').hide();
				$('#progressList').show();
			} else {
				buttonObj.innerText = '列表显示';
				$('#progressList').hide();
				$('#progressImg').show();
			}
		}

  	</script>
  </head>

  <body>
<div id="progressHeadText" class="divSearch">
	<table width="100%" cellpadding="0" cellspacing="0">
		<tr>
		  <td height="40" style="background-color:#dae8f8; text-align:center; font-size:30px; font-weight:bold;">${baseInfo.cutTitle}</td>
	    </tr>
		<tr style="font-size:20px; font-weight:bold;" >
		  <td>
		  	<table style="text-align: center;" width="100%" border="0" cellpadding="0" cellspacing="0">
		  		<tr>
		  			<td>总协调人: ${baseInfo.cutManagerName}</td>
		  			<td>计划时长: ${baseInfo.cutDuration}</td>
		  			<td style="display: none">当前状态: <span id="cutStatus"></span></td>
		  			<td>开始时间: ${baseInfo.cutBeginTime}</td>
		  			<td>当前时间: <span id="currentTime"></span></td>
		  			<td style="display: none"><button onclick="showType(this);" >列表显示</button></td>
		  		</tr>
		  	</table>
		  </td>
	    </tr>
		<tr style="font-size:20px; font-weight:bold;">
		  <td>
			  <table width="100%" border="0" cellpadding="0" cellspacing="0">
			    <tr>
			      	<td style="color: green;background-color:#dae8f8;">
						<div style="width:99.8%;text-align:center;">总体进度(<span id="progressbar_total_text" >0%</span>)</div>
					  	<div class="progressBarBorderColor">
							<div id="progressbar_total_value" class="progressBarColor1">
								<span style="display:none;" id="progressbar_currentTime" class="progress-label"></span>
								<span id="progressbar_total_text1" style="display:none;position:absolute; width:99.8%; height:30px; text-align:center; font-weight:bold;">0%</span>
							</div>
						</div>
					</td>
		        </tr>
		      </table>
	      </td>
	  </tr>
	</table>
</div>

   
<div id="progressImg" style="width:100%; height=100%;" >
     <iframe name="contentInfo" id="image" frameBorder="0" scrolling="auto" src="/progress/pimage/2" style="width: 100%;"></iframe>
</div>

<div id="progressList" class="outer" style="display:none"><div id="content" class="content">
  <table id="allSteps" width="100%" border="1" cellpadding="0" cellspacing="0" rules="cols" bordercolor="#9aadce" class="table" >
        <tr class="head" style="position:absolute;top:0;left:0;">
          <td width="3%">索引</td>
          <td width="20%">步骤</td>
          <td width="30%">进度</td>
          <td width="8%">计划时长(小时)</td>
          <td width="12%">状态</td>
          <td width="12%">负责人</td>
          <td width="8%" style="display:none">检查人</td>
        </tr>
    <c:forEach var="step" varStatus="item" items="${steps}">
    <tr stepId="${step.stepId}" stepWeight="${step.stepWeightValue}" onmouseover="doonmouseover(this)" onmouseout="doonmouseout(this, this.className)" onclick="clickRow('${step.stepId}')" <c:if test="${item.count % 2 == 0}">class="col"</c:if>>
      	<td>${step.stepIndex}</td>
      	<td class="weight"><img id="img_${step.stepId}" src="/resources/images/folder0.gif" border="0" onclick="clickFolder(this, '${step.stepId}')" style="cursor: hand;" align="absmiddle"/> ${step.stepName}</td>
      	<td>
      		<div>
				<div style="float:left;width:80%;height:14px;font-size:9pt;background:#EEE;" class="progressBarBorderColor">
					<div id="progressbar_step_${step.stepId}_value" style="width:0%;height:14px;" class="progressBarColor1"></div>
				</div>
				<div id="progressbar_step_${step.stepId}_text" style="float:left;width:16%;text-align:right;">0%</div>
			</div>
		</td>
      	<td><fmt:formatNumber type="number" value="${step.stepTimes/60}" maxFractionDigits="2"/></td>
      	<td>${status[step.stepStatus]}</td>
      	<td>${step.stepOwnerName}</td>
      	<td style="display:none">${step.stepCheckerName}</td>
    </tr>
    <tr id="tasks_for_${step.stepId}" style="display:none;"><td>&nbsp;</td><td colspan="6" style="padding: 0px 2px 2px 22px;"></td></tr>
    </c:forEach>
  </table>
</div></div>
</body>
</html>
