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
							var mycolor="black";
							var title="操作未开始";
							if("1" == taskStatus){
								mycolor="red";
								title="正在执行中";
							}
							if("2" == taskStatus){
								mycolor="green";
								title="执行已完成";
							}
							if("3" == taskStatus){
								mycolor="red";
								title="正在检查中";
							}
							if("4" == taskStatus){
								mycolor="green";
								title="检查已完成";
							}
							$(taskId).css({ 'border-color':mycolor});
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
    <div id='image' style='position:relative; background-image:url(/resources/images/step${cutIndex}.jpg); width:${picWidth }px; height:${picHeight }px;'>
    	<!-- width height 和背景图的长宽属性一致
		 -->
		<c:forEach var="posi" varStatus="item" items="${images}">
			<div id="${posi.taskId}" style="position:absolute; left: ${posi.left}px; top:${posi.top}px; width:${posi.width}px; height:${posi.height}px; 
				border:1px solid; cursor:hand; background-color:${posi.borderColor}; text-align:center; font-size:16px; margin:5px; padding:5px;
				color:#FFFFFF;" onclick="javascript:viewInfo(${posi.stepid});"  title="${posi.taskTitle }">
			${posi.taskName}
			</div>
		</c:forEach>
		 
		<!-- 
		<div style="position:absolute; left: 150px; top:480px; border:1px solid; width:108px; height:33px; 
		background-color:gray; text-align:center; display:bolck; font-size:12px; margin:5px; padding:5px;color:#FFFFFF;"  onclick="javascript:viewInfo(1116);" alt="aaa">
		NGCRM</div>
		<div style="position:absolute; left: 150px; top: 395px; border:1px solid; width:108px; height:33px;
		background-color:gray; text-align:center; display:bolck; font-size:12px; margin:5px; padding:5px;color:#FFFFFF;"  onclick="javascript:viewInfo(1116);">
		NGCRM数据转换入库</div>
		<div style="position:absolute; left: 152px; top: 310px; border:1px solid; width:108px; height:33px;
		background-color:gray; text-align:center; display:bolck; font-size:12px; margin:5px; padding:5px;color:#FFFFFF;"  onclick="javascript:viewInfo(1116);">
		NGCRM数据转换入</div>
		<div style="position:absolute; left: 150px; top: 235px; border:1px solid; width:108px; height:33px;
		background-color:green; text-align:center; display:bolck; font-size:12px; margin:5px; padding:5px;color:#FFFFFF;"  onclick="javascript:viewInfo(1116);">
		NGCRM数据转换入库</div>
		<div style="position:absolute; left: 150px; top: 160px; border:1px solid; width:108px; height:33px;
		background-color:gray; text-align:center; display:bolck; font-size:12px; margin:5px; padding:5px;color:#FFFFFF;"  onclick="javascript:viewInfo(1116);">
		NGCRM数据转换入库</div>
		<div style="position:absolute; left: 150px; top: 85px; border:1px solid; width:108px; height:33px;
		background-color:gray; text-align:center; display:bolck; font-size:12px; margin:5px; padding:5px;color:#FFFFFF;"  onclick="javascript:viewInfo(1116);">
		NGCRM数据转换入库</div>
		
		
		<div style="position:absolute; left: 685px; top: 110px; border:1px solid; width:108px; height:33px;
		background-color:gray; text-align:center; display:bolck; font-size:12px; margin:5px; padding:5px;color:#FFFFFF;"  onclick="javascript:viewInfo(1116);" alt="aaa">
		NGCRM</div>
		<div style="position:absolute; left: 705px; top: 195px; border:1px solid; width:80px; height:50px; 
		background-color:gray; text-align:center; display:bolck; font-size:12px; margin:5px; padding:5px;color:#FFFFFF;"  onclick="javascript:viewInfo(1116);" alt="aaa">
		NGCRM</div>
		<div style="position:absolute; left: 403px; top: 325px; border:1px solid; width:102px; height:38px; 
		background-color:gray; text-align:center; display:bolck; font-size:12px; margin:5px; padding:5px;color:#FFFFFF;"  onclick="javascript:viewInfo(1116);" alt="aaa">
		NGCRMNGCRM数据转换入库</div>
		<div style="position:absolute; left: 555px; top: 325px; border:1px solid; width:125px; height:38px; 
		background-color:gray; text-align:center; display:bolck; font-size:12px; margin:5px; padding:5px;color:#FFFFFF;"  onclick="javascript:viewInfo(1116);" alt="aaa">
		NGCRM</div>
		<div style="position:absolute; left: 740px; top: 325px; border:1px solid; width:112px; height:37px; 
		background-color:gray; text-align:center; display:bolck; font-size:12px; margin:5px; padding:5px;color:#FFFFFF;"  onclick="javascript:viewInfo(1116);" alt="aaa">
		NGCRM</div>
		<div style="position:absolute; left: 895px; top: 325px; border:1px solid; width:130px; height:37px; 
		background-color:gray; text-align:center; display:bolck; font-size:12px; margin:5px; padding:5px;color:#FFFFFF;"  onclick="javascript:viewInfo(1116);" alt="aaa">
		NGCRM</div>
		<div style="position:absolute; left: 689px; top: 450px; border:1px solid; width:100px; height:37px; 
		background-color:gray; text-align:center; display:bolck; font-size:12px; margin:5px; padding:5px;color:#FFFFFF;"  onclick="javascript:viewInfo(1116);" alt="aaa">
		NGCRM</div>
		<div style="position:absolute; left: 1070px; top: 325px; border:1px solid; width:130px; height:37px; 
		background-color:gray; text-align:center; display:bolck; font-size:12px; margin:5px; padding:5px;color:#FFFFFF;"  onclick="javascript:viewInfo(1116);" alt="aaa">
		NGCRM</div>
		
		<div style="position:absolute; left: 440px; top: 650px; border:1px solid; width:130px; height:37px; 
		background-color:gray; text-align:center; display:bolck; font-size:12px; margin:5px; padding:5px;color:#FFFFFF;"  onclick="javascript:viewInfo(1116);" alt="aaa">
		NGCRM</div>
		<div style="position:absolute; left: 935px; top: 594px; border:1px solid; width:130px; height:37px; 
		background-color:gray; text-align:center; display:bolck; font-size:12px; margin:5px; padding:5px;color:#FFFFFF;"  onclick="javascript:viewInfo(1116);" alt="aaa">
		NGCRM</div>
		<div style="position:absolute; left: 938px; top: 690px; border:1px solid; width:130px; height:37px; 
		background-color:gray; text-align:center; display:bolck; font-size:12px; margin:5px; padding:5px;color:#FFFFFF;"  onclick="javascript:viewInfo(1116);" alt="aaa">
		NGCRM</div>
		<div style="position:absolute; left: 670px; top: 812px; border:1px solid; width:130px; height:37px; 
		background-color:green; text-align:center; display:bolck; font-size:12px; margin:5px; padding:5px;color:#FFFFFF;"  onclick="javascript:viewInfo(1116);" alt="aaa">
		NGCRM</div>
		<div style="position:absolute; left: 670px; top: 885px; border:1px solid; width:130px; height:37px; 
		background-color:gray; text-align:center; display:bolck; font-size:12px; margin:5px; padding:5px;color:#FFFFFF;"  onclick="javascript:viewInfo(1116);" alt="aaa">
		NGCRM</div>
		
		<div style="position:absolute; left: 1238px; top: 590px; border:1px solid; width:130px; height:37px; 
		background-color:gray; text-align:center; display:bolck; font-size:12px; margin:5px; padding:5px;color:#FFFFFF;"  onclick="javascript:viewInfo(1116);" alt="aaa">
		NGCRM</div>
		<div style="position:absolute; left: 1242px; top: 680px; border:1px solid; width:130px; height:37px; 
		background-color:gray; text-align:center; display:bolck; font-size:12px; margin:5px; padding:5px;color:#FFFFFF;"  onclick="javascript:viewInfo(1116);" alt="aaa">
		NGCRM</div>
		<div style="position:absolute; left: 1433px; top: 680px; border:1px solid; width:130px; height:37px; 
		background-color:green; text-align:center; display:bolck; font-size:12px; margin:5px; padding:5px;color:#FFFFFF;"  onclick="javascript:viewInfo(1116);" alt="aaa">
		NGCRM</div>
		<div style="position:absolute; left: 1242px; top: 770px; border:1px solid; width:130px; height:37px; 
		background-color:gray; text-align:center; display:bolck; font-size:12px; margin:5px; padding:5px;color:#FFFFFF;"  onclick="javascript:viewInfo(1116);" alt="aaa">
		NGCRM</div>
		
		<div style="position:absolute; left: 345px; top: 1010px; border:1px solid; width:130px; height:37px; 
		background-color:green; text-align:center; display:bolck; font-size:12px; margin:5px; padding:5px;color:#FFFFFF;"  onclick="javascript:viewInfo(1116);" alt="aaa">
		NGCRM</div>
		<div style="position:absolute; left: 349px; top: 1116px; border:1px solid; width:130px; height:37px; 
		background-color:gray; text-align:center; display:bolck; font-size:12px; margin:5px; padding:5px;color:#FFFFFF;"  onclick="javascript:viewInfo(1116);" alt="aaa">
		NGCRM</div>
		<div style="position:absolute; left: 538px; top: 1012px; border:1px solid; width:130px; height:37px; 
		background-color:gray; text-align:center; display:bolck; font-size:12px; margin:5px; padding:5px;color:#FFFFFF;"  onclick="javascript:viewInfo(1116);" alt="aaa">
		NGCRM</div>
		<div style="position:absolute; left: 828px; top: 1012px; border:1px solid; width:130px; height:37px; 
		background-color:gray; text-align:center; display:bolck; font-size:12px; margin:5px; padding:5px;color:#FFFFFF;"  onclick="javascript:viewInfo(1116);" alt="aaa">
		NGCRM</div>
		<div style="position:absolute; left: 675px; top: 1108px; border:1px solid; width:130px; height:37px; 
		background-color:gray; text-align:center; display:bolck; font-size:12px; margin:5px; padding:5px;color:#FFFFFF;"  onclick="javascript:viewInfo(1116);" alt="aaa">
		NGCRM</div>
		<div style="position:absolute; left: 407px; top: 1206px; border:1px solid; width:130px; height:37px; 
		background-color:gray; text-align:center; display:bolck; font-size:12px; margin:5px; padding:5px;color:#FFFFFF;"  onclick="javascript:viewInfo(1116);" alt="aaa">
		NGCRM</div>
		
		<div style="position:absolute; left: 1235px; top: 1098px; border:1px solid; width:130px; height:37px; 
		background-color:green; text-align:center; display:bolck; font-size:12px; margin:5px; padding:5px;color:#FFFFFF;"  onclick="javascript:viewInfo(1116);" alt="aaa">
		NGCRM</div>
		<div style="position:absolute; left: 1235px; top: 1266px; border:1px solid; width:130px; height:37px; 
		background-color:gray; text-align:center; display:bolck; font-size:12px; margin:5px; padding:5px;color:#FFFFFF;"  onclick="javascript:viewInfo(1116);" alt="aaa">
		NGCRM</div>
		
		<div style="position:absolute; left: 304px; top: 1432px; border:1px solid; width:130px; height:37px; 
		background-color:gray; text-align:center; display:bolck; font-size:12px; margin:5px; padding:5px;color:#FFFFFF;"  onclick="javascript:viewInfo(1116);" alt="aaa">
		NGCRM</div>
		<div style="position:absolute; left: 494px; top: 1432px; border:1px solid; width:130px; height:37px; 
		background-color:gray; text-align:center; display:bolck; font-size:12px; margin:5px; padding:5px;color:#FFFFFF;"  onclick="javascript:viewInfo(1116);" alt="aaa">
		NGCRM</div>
		<div style="position:absolute; left: 675px; top: 1432px; border:1px solid; width:130px; height:37px; 
		background-color:gray; text-align:center; display:bolck; font-size:12px; margin:5px; padding:5px;color:#FFFFFF;"  onclick="javascript:viewInfo(1116);" alt="aaa">
		NGCRM</div>
		<div style="position:absolute; left: 860px; top: 1434px; border:1px solid; width:130px; height:37px; 
		background-color:gray; text-align:center; display:bolck; font-size:12px; margin:5px; padding:5px;color:#FFFFFF;"  onclick="javascript:viewInfo(1116);" alt="aaa">
		NGCRM</div>
		<div style="position:absolute; left: 1050px; top: 1434px; border:1px solid; width:130px; height:37px; 
		background-color:gray; text-align:center; display:bolck; font-size:12px; margin:5px; padding:5px;color:#FFFFFF;"  onclick="javascript:viewInfo(1116);" alt="aaa">
		NGCRM</div>
		<div style="position:absolute; left: 1234px; top: 1434px; border:1px solid; width:140px; height:37px; 
		background-color:gray; text-align:center; display:bolck; font-size:12px; margin:5px; padding:5px;color:#FFFFFF;"  onclick="javascript:viewInfo(1116);" alt="aaa">
		NGCRM</div>
		<div style="position:absolute; left: 675px; top: 1565px; border:1px solid; width:130px; height:30px; 
		background-color:gray; text-align:center; display:bolck; font-size:12px; margin:5px; padding:5px;color:#FFFFFF;"  onclick="javascript:viewInfo(1116);" alt="aaa">
		NGCRM</div>
		<div style="position:absolute; left: 910px; top: 1568px; border:1px solid; width:130px; height:30px; 
		background-color:gray; text-align:center; display:bolck; font-size:12px; margin:5px; padding:5px;color:#FFFFFF;"  onclick="javascript:viewInfo(1116);" alt="aaa">
		NGCRM</div>
		<div style="position:absolute; left: 371px; top: 1696px; border:1px solid; width:130px; height:30px; 
		background-color:green; text-align:center; display:bolck; font-size:12px; margin:5px; padding:5px;color:#FFFFFF;"  onclick="javascript:viewInfo(1116);" alt="aaa">
		NGCRM</div>
		<div style="position:absolute; left: 387px; top: 1560px; border:1px solid; width:100px; height:37px; 
		background-color:gray; text-align:center; display:bolck; font-size:12px; margin:5px; padding:5px;color:#FFFFFF;"  onclick="javascript:viewInfo(1116);" alt="aaa">
		NGCRM</div>
		<div style="position:absolute; left: 530px; top: 1560px; border:1px solid; width:100px; height:37px; 
		background-color:gray; text-align:center; display:bolck; font-size:12px; margin:5px; padding:5px;color:#FFFFFF;"  onclick="javascript:viewInfo(1116);" alt="aaa">
		NGCRM</div>
		<div style="position:absolute; left: 535px; top: 1783px; border:1px solid; width:108px; height:32px; 
		background-color:gray; text-align:center; display:bolck; font-size:12px; margin:5px; padding:5px;color:#FFFFFF;"  onclick="javascript:viewInfo(1116);" alt="aaa">
		NGCRM</div>
		
		<div style="position:absolute; left: 105px; top: 1519px; border:1px solid; width:115px; height:30px; 
		background-color:green; text-align:center; display:bolck; font-size:12px; margin:5px; padding:5px;color:#FFFFFF;"  onclick="javascript:viewInfo(1116);" alt="aaa">
		NGCRM</div>
		<div style="position:absolute; left: 105px; top: 1652px; border:1px solid; width:115px; height:25px; 
		background-color:gray; text-align:center; display:bolck; font-size:12px; margin:5px; padding:5px;color:#FFFFFF;"  onclick="javascript:viewInfo(1116);" alt="aaa">
		NGCRM</div>
		
		<div style="position:absolute; left: 865px; top: 1860px; border:1px solid; width:175px; height:30px; 
		background-color:gray; text-align:center; display:bolck; font-size:12px; margin:5px; padding:5px;color:#FFFFFF;"  onclick="javascript:viewInfo(1116);" alt="aaa">
		NGCRM</div>
		<div style="position:absolute; left: 865px; top: 1935px; border:1px solid; width:175px; height:23px; 
		background-color:gray; text-align:center; display:bolck; font-size:12px; margin:5px; padding:5px;color:#FFFFFF;"  onclick="javascript:viewInfo(1116);" alt="aaa">
		NGCRM</div>
		<div style="position:absolute; left: 865px; top: 1992px; border:1px solid; width:175px; height:35px; 
		background-color:gray; text-align:center; display:bolck; font-size:12px; margin:5px; padding:5px;color:#FFFFFF;"  onclick="javascript:viewInfo(1116);" alt="aaa">
		NGCRM</div> 
		<div style="position:absolute; left: 688px; top: 1925px; border:1px solid; width:100px; height:30px; 
		background-color:green; text-align:center; display:bolck; font-size:12px; margin:5px; padding:5px;color:#FFFFFF;"  onclick="javascript:viewInfo(1116);" alt="aaa">
		NGCRM</div> 
		<div style="position:absolute; left: 702px; top: 2000px; border:1px solid; width:74px; height:30px; 
		background-color:gray; text-align:center; display:bolck; font-size:12px; margin:5px; padding:5px;color:#FFFFFF;"  onclick="javascript:viewInfo(1116);" alt="aaa">
		NGCRM</div> 
		<div style="position:absolute; left: 702px; top: 2068px; border:1px solid; width:75px; height:45px; 
		background-color:gray; text-align:center; display:bolck; font-size:12px; margin:5px; padding:5px;color:#FFFFFF;"  onclick="javascript:viewInfo(1116);" alt="aaa">
		NGCRM</div> 
		<div style="position:absolute; left: 702px; top: 2164px; border:1px solid; width:75px; height:30px; 
		background-color:gray; text-align:center; display:bolck; font-size:12px; margin:5px; padding:5px;color:#FFFFFF;"  onclick="javascript:viewInfo(1116);" alt="aaa">
		NGCRM</div>
		 -->
    </div>
</body>
</html>
