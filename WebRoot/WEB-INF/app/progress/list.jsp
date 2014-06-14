<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
			background:orange;
		}
		.progressBarColor2{
			background:#778899;
		}
		.progressBarBorderColor{
			/* border:1px solid #724a10; */
			border:1px solid darkred;
		}

    </style>
  	<script src="/resources/js/jquery.min.js" type="text/javascript"></script>
  	<script src="/resources/js/common.js" type="text/javascript"></script>
  	
  	<script type="text/javascript">
		$(document).ready(function() {			
			document.getElementById("content").style.height = document.body.offsetHeight - 100;
			document.body.onresize = function(){
				document.getElementById("content").style.height = document.body.offsetHeight - 100;
			}
			refreshCutTotalTime();
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
						"      <td>"+this.taskTimes+"</td> " +
						"      <td>"+this.taskStatusName+"</td> " +
						"      <td>"+this.taskOperaterName+"</td> " +
						"      <td>"+this.taskCheckerName+"</td> " +
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
	    "      <td width='12%'>计划时长(分钟)</td> " +
	    "      <td width='8%'>状态</td> " +
	    "      <td width='8%'>负责人</td> " +
	    "      <td width='8%'>检查人</td> " +
      	"	</tr> ";

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
			$("#progressbar_total_value").css("width", s);
		}
		
		function doCheckProgressForStep(id){
			$.post("/progress/refresh/step/"+id, function(s){
				$("#progressbar_step_"+id+"_text").text(s);
				$("#progressbar_step_"+id+"_value").css("width", s);
				stepProgressValues[id].value = parseInt(s.substr(0, s.length-1));
				if(s!="100%"){
					setTimeout(function(){doCheckProgressForStep(id);}, 2000);//每2秒检查一次Step进度
				}
				doProgressForTotal();
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
				$("#cutTotalTime").text(s);
				setTimeout(function(){refreshCutTotalTime();}, 2000);
			});
		}


		function viewInfo(id){

			
			//showModalDlg("步骤详细信息", '/step/taskinfo/'+id, 1000, 400, function(s){
			//	alert("ok");
			//});

			openwindow("/step/taskinfo/"+id, "步骤明细信息", 1000,400);
		}

    	function openwindow( url, winName, width, height) {
    		xposition=0; yposition=0;
    		if ((parseInt(navigator.appVersion) >= 4 )) {
    			xposition = (screen.width - width) / 2;
    			yposition = (screen.height - height) / 2;
    		}
    		theproperty= "width=" + width + "," 
    		+ "height=" + height + "," 
    		+ "location=0," 
    		+ "menubar=0,"
    		+ "resizable=0,"
    		+ "scrollbars=0,"
    		+ "status=0," 
    		+ "titlebar=0,"
    		+ "toolbar=0,"
    		+ "hotkeys=0,"
    		+ "screenx=" + xposition + "," //仅适用于Netscape
    		+ "screeny=" + yposition + "," //仅适用于Netscape
    		+ "left=" + xposition + "," //IE
    		+ "top=" + yposition; //IE 
    		window.open( url,winName,theproperty );
    	}
  	</script>
  </head>

  <body>
<div id="progressHeadText" class="divSearch">
	<table width="100%" cellpadding="0" cellspacing="0">
		<tr>
		  <td style="background-color:#dae8f8; text-align:center; font-size:20px; font-weight:bold;">${baseInfo.cutTitle}</td>
	    </tr>
		<tr style="font-size:14px; font-weight:bold;" >
		  <td>
		  	<table width="100%" border="0" cellpadding="0" cellspacing="0">
		  		<tr>
		  			<td>开始时间: ${baseInfo.cutBeginTime}</td>
		  			<td>总协调人: ${baseInfo.cutManagerName}</td>
		  			<td>计划时长: <span id="cutTotalTime">0</span> 分钟</td>
		  			<td>当前状态: <span id="cutStatus"></span></td>
		  		</tr>
		  	</table>
		  </td>
	    </tr>
		<tr style="font-size:14px; font-weight:bold;">
		  <td>
			  <table width="100%" border="0" cellpadding="0" cellspacing="0">
			    <tr>
			      	<td style="color: green;background-color:#dae8f8;">
						<div style="width:99.8%;text-align:center;">总体进度(<span id="progressbar_total_text" >0%</span>)</div>
					  	<div style="width:99.8%;height:20px;font-size:12pt;background:#EEE;" class="progressBarBorderColor">
							<div id="progressbar_total_value" style="width:0%;height:20px;" class="progressBarColor1"></div>
						<div>
					</td>
		        </tr>
		      </table>
	      </td>
	  </tr>
	</table>
</div>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr><td></td><td></td></tr>
	<tr><td>[ 步骤列表 ]</td><td align="right"><a href="#">[ 选项 ]</a>&nbsp;  <a href="javascript:viewInfo('1116')">查看</a></td></tr>
</table>
<div class="outer"><div id="content" class="content">
  <table id="allSteps" width="100%" border="1" cellpadding="0" cellspacing="0" rules="cols" bordercolor="#9aadce" class="table">
        <tr class="head" style="position:absolute;top:0;left:0;">
          <td width="3%">索引</td>
          <td width="42%">步骤</td>
          <td>进度</td>
          <td width="12%">计划时长(分钟)</td>
          <td width="8%">状态</td>
          <td width="8%">负责人</td>
          <td width="8%">检查人</td>
        </tr>
    <c:forEach var="step" varStatus="item" items="${steps}">
    <tr stepId="${step.stepId}" stepWeight="${step.stepWeightValue}" onmouseover="doonmouseover(this)" onmouseout="doonmouseout(this, this.className)" <c:if test="${item.count % 2 == 0}">class="col"</c:if>>
      	<td>${step.stepIndex}</td>
      	<td class="weight"><img src="/resources/images/folder0.gif" border="0" onclick="clickFolder(this, '${step.stepId}')" style="cursor: hand;" align="absmiddle"/> ${step.stepName}</td>
      	<td>
      		<div>
				<div style="float:left;width:80%;height:14px;font-size:9pt;background:#EEE;" class="progressBarBorderColor">
					<div id="progressbar_step_${step.stepId}_value" style="width:0%;height:14px;" class="progressBarColor1"></div>
				</div>
				<div id="progressbar_step_${step.stepId}_text" style="float:left;width:16%;text-align:right;">0%</div>
			</div>
		</td>
      	<td>${step.stepTimes}</td>
      	<td>${status[step.stepStatus]}</td>
      	<td>${step.stepOwnerName}</td>
      	<td>${step.stepCheckerName}</td>
    </tr>
    <tr id="tasks_for_${step.stepId}" style="display:none;"><td>&nbsp;</td><td colspan="6" style="padding: 0px 2px 2px 22px;"></td></tr>
    </c:forEach>
  </table>
</div></div>
</body>
</html>
