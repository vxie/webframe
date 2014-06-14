<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
  <head>
	<script src="/resources/js/jquery.min.js" type="text/javascript"></script>
  	<script src="/resources/js/common.js" type="text/javascript"></script>
    <script>
    	$(document).ready(function(){
    		refreshImage();
		});
    
		function viewInfo(id){
			openwindow("/step/taskinfo/"+id, "步骤明细信息", 1100,400);
			event.cancelBubble=true; 
			return false;
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

		//每2秒刷新一次任务框
		function refreshImage(){
			jQuery.ajax({url: "/progress/taskStatus",
				cache: false,
				dataType: "json",
				complete:function(data){
					var statusText = data.statusText;
					if("success" == statusText){
						var taskList = eval('{' + data.responseText + '}');
						$.each(taskList, function(n, row){
							var taskId = "#" + row.TASKID;
							var taskStatus = row.TASKSTATUS;
							var bgColor = "#FFF";//write
							var textColor = "#FFF";
							var title="操作未开始";
							if("0" == taskStatus){
								bgColor="#FFF";
								textColor = "black";
								title="操作未开始";
							}
							if("1" == taskStatus){
								bgColor="blue";
								title="正在执行中";
							}
							if("2" == taskStatus){
								bgColor="#7CFC00";//"green";
								title="执行已完成";
							}
							if("3" == taskStatus){
								bgColor="blue";
								title="正在检查中";
							}
							if("4" == taskStatus){
								bgColor="#7CFC00";//"green";
								title="检查已完成";
							}
							if("5" == taskStatus){
								bgColor="red";
								title="异常执行";
							}
							$(taskId).css({'background-color':bgColor, 'color':textColor});
							$(taskId).attr("title", title);
						});
					}
					setTimeout(function(){refreshImage();}, 2000);
				}
			});
		}
	</script>
  </head>
  <body>
    <!-- 第 cutIndex 个割接流程 -->
    <div id='image' style='position:relative; background-image:url(/resources/images/${imageName}); width:${picWidth }px; height:${picHeight }px;'>
    	<!-- width height 和背景图的长宽属性一致
		-->
   		<c:forEach var="posi" varStatus="item" items="${images}">
			<div id="${posi.taskId}" style="position:absolute; left: ${posi.left}px; top:${posi.top}px; width:${posi.width}px; 
				height:${posi.height}px; background-color:${posi.borderColor}; color:${posi.textColor}; 
				border:1px solid; cursor:hand; text-align:center; font-size:10pt; margin:5px; padding:5px;" 
				onclick="javascript:viewInfo(${posi.stepid});" title="${posi.taskTitle }">${posi.taskName}</div>
		</c:forEach>

		<!-- 图例说明 -->
		<div style="position: fixed; left: 2250px; top:30px; border:1px dotted; width:165px; height:135px;"/>
		<div style="position:absolute; left: 10px; top:10px; border:1px solid; width:20px; height:20px; 
			background-color:write; display:bolck;"/>
		<div style="position:absolute; left: 30px; top:2px; width:150px; height:20px; font-size:16px;">操作未开始</div>
		<div style="position:absolute; left: -1px; top:30px; border:1px solid; width:20px; height:20px; 
			background-color:blue; display:bolck;"/>
		<div style="position:absolute; left: 30px; top:2px; width:150px; height:20px; font-size:16px;">正在执行中</div>
		<div style="position:absolute; left: -1px; top:30px; border:1px solid; width:20px; height:20px; 
			background-color:#7CFC00; display:bolck;"/>
		<div style="position:absolute; left: 30px; top:2px; width:150px; height:20px; font-size:16px;">执行已完成</div>
		<div style="position:absolute; left: -1px; top:30px; border:1px solid; width:20px; height:20px; 
			background-color:red; display:bolck;"/>
		<div style="position:absolute; left: 30px; top:2px; width:150px; height:20px; font-size:16px;">执行异常</div>
		
    </div>
</body>
</html>
