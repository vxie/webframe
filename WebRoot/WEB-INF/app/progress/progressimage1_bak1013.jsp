<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
  <head>
	<script src="/resources/js/jquery.min.js" type="text/javascript"></script>
  	<script src="/resources/js/common.js" type="text/javascript"></script>
    <script>
    	$(document).ready(function(){
    		//refreshImage();
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
								bgColor="green";
								title="执行已完成";
							}
							if("3" == taskStatus){
								bgColor="blue";
								title="正在检查中";
							}
							if("4" == taskStatus){
								bgColor="green";
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
    <div id='image' style='position:relative; background-image:url(/resources/images/step${cutIndex}.jpg); width:${picWidth }px; height:${picHeight }px;'>
    	<!-- width height 和背景图的长宽属性一致
   		<c:forEach var="posi" varStatus="item" items="${images}">
			<div id="${posi.taskId}" style="position:absolute; left: ${posi.left}px; top:${posi.top}px; width:${posi.width}px; height:${posi.height}px; 
			background-color:${posi.borderColor}; color:${posi.textColor}; border:1px solid; cursor:hand; text-align:center; font-size:16px; margin:5px; padding:5px;" 
			onclick="javascript:viewInfo(${posi.stepid});" title="${posi.taskTitle }">${posi.taskName}</div>
		</c:forEach>
		 -->
		
		
		<div id="12911" style="position:absolute; left: 190px; top:480px; width:108px; height:33px;border:1px solid; 
		background-color:#FFF; cursor:hand; text-align:center; display:bolck; font-size:16px; margin:5px; padding:5px;color:black;"  
		onclick="javascript:viewInfo(1116);">
		<span  style="color:black;">割接环境检查</span></div>
		<div style="position:absolute; left: 190px; top: 395px; border:1px solid; width:108px; height:33px;
		background-color:gray; text-align:center; display:bolck; font-size:12px; margin:5px; padding:5px;color:#FFFFFF;"  onclick="javascript:viewInfo(1116);">
		NGCRM数据转换入库</div>
		<div style="position:absolute; left: 192px; top: 313px; border:1px solid; width:108px; height:33px;
		background-color:gray; text-align:center; display:bolck; font-size:12px; margin:5px; padding:5px;color:#FFFFFF;"  onclick="javascript:viewInfo(1116);">
		NGCRM数据转换入 1.3</div>
		<div style="position:absolute; left: 190px; top: 235px; border:1px solid; width:108px; height:33px;
		background-color:green; text-align:center; display:bolck; font-size:12px; margin:5px; padding:5px;color:#FFFFFF;"  onclick="javascript:viewInfo(1116);">
		NGCRM数据转换入库</div>
		<div style="position:absolute; left: 190px; top: 160px; border:1px solid; width:108px; height:33px;
		background-color:gray; text-align:center; display:bolck; font-size:12px; margin:5px; padding:5px;color:#FFFFFF;"  onclick="javascript:viewInfo(1116);">
		NGCRM数据转换入库</div>
		<div style="position:absolute; left: 190px; top: 85px; border:1px solid; width:108px; height:33px;
		background-color:gray; text-align:center; display:bolck; font-size:12px; margin:5px; padding:5px;color:#FFFFFF;"  onclick="javascript:viewInfo(1116);">
		NGCRM数据转换入库</div>
		
		
		<div style="position:absolute; left: 725px; top: 110px; border:1px solid; width:108px; height:33px;
		background-color:gray; text-align:center; display:bolck; font-size:12px; margin:5px; padding:5px;color:#FFFFFF;"  onclick="javascript:viewInfo(1116);" alt="aaa">
		NGCRM</div>
		<div style="position:absolute; left: 742px; top: 195px; border:1px solid; width:80px; height:50px; 
		background-color:gray; text-align:center; display:bolck; font-size:12px; margin:5px; padding:5px;color:#FFFFFF;"  onclick="javascript:viewInfo(1116);" alt="aaa">
		NGCRM</div>
		<div style="position:absolute; left: 443px; top: 325px; border:1px solid; width:102px; height:38px; 
		background-color:gray; text-align:center; display:bolck; font-size:12px; margin:5px; padding:5px;color:#FFFFFF;"  onclick="javascript:viewInfo(1116);" alt="aaa">
		NGCRMNGCRM数据转换入库</div>
		<div style="position:absolute; left: 570px; top: 325px; border:1px solid; width:125px; height:38px; 
		background-color:gray; text-align:center; display:bolck; font-size:12px; margin:5px; padding:5px;color:#FFFFFF;"  onclick="javascript:viewInfo(1116);" alt="aaa">
		NGCRM</div>
		<div style="position:absolute; left: 720px; top: 325px; border:1px solid; width:112px; height:37px; 
		background-color:gray; text-align:center; display:bolck; font-size:12px; margin:5px; padding:5px;color:#FFFFFF;"  onclick="javascript:viewInfo(1116);" alt="aaa">
		NGCRM</div>
		<div style="position:absolute; left: 860px; top: 325px; border:1px solid; width:130px; height:37px; 
		background-color:green; text-align:center; display:bolck; font-size:12px; margin:5px; padding:5px;color:#FFFFFF;"  onclick="javascript:viewInfo(1116);" alt="aaa">
		NGCRM</div>
		<div style="position:absolute; left: 725px; top: 460px; border:1px solid; width:100px; height:37px; 
		background-color:gray; text-align:center; display:bolck; font-size:12px; margin:5px; padding:5px;color:#FFFFFF;"  onclick="javascript:viewInfo(1116);" alt="aaa">
		NGCRM   2.8</div>
		<div style="position:absolute; left: 1020px; top: 325px; border:1px solid; width:130px; height:37px; 
		background-color:gray; text-align:center; display:bolck; font-size:12px; margin:5px; padding:5px;color:#FFFFFF;"  onclick="javascript:viewInfo(1116);" alt="aaa">
		NGCRM</div>
		<div style="position:absolute; left: 1175px; top: 326px; border:1px solid; width:130px; height:37px; 
		background-color:gray; text-align:center; display:bolck; font-size:12px; margin:5px; padding:5px;color:#FFFFFF;"  onclick="javascript:viewInfo(1116);" alt="aaa">
		NGCRM 2.9</div>
		<div style="position:absolute; left: 1330px; top: 326px; border:1px solid; width:130px; height:37px; 
		background-color:gray; text-align:center; display:bolck; font-size:12px; margin:5px; padding:5px;color:#FFFFFF;"  onclick="javascript:viewInfo(1116);" alt="aaa">
		NGCRM 2.10</div>
		
		<div style="position:absolute; left: 460px; top: 591px; border:1px solid; width:130px; height:37px; 
		background-color:gray; text-align:center; display:bolck; font-size:12px; margin:5px; padding:5px;color:#FFFFFF;"  onclick="javascript:viewInfo(1116);" alt="aaa">
		NGCRM 3.0</div>
		<div style="position:absolute; left: 575px; top: 650px; border:1px solid; width:130px; height:37px; 
		background-color:gray; text-align:center; display:bolck; font-size:12px; margin:5px; padding:5px;color:#FFFFFF;"  onclick="javascript:viewInfo(1116);" alt="aaa">
		NGCRM</div>
		<div style="position:absolute; left: 845px; top: 613px; border:1px solid; width:130px; height:37px; 
		background-color:gray; text-align:center; display:bolck; font-size:12px; margin:5px; padding:5px;color:#FFFFFF;"  onclick="javascript:viewInfo(1116);" alt="aaa">
		NGCRM</div>
		<div style="position:absolute; left: 845px; top: 694px; border:1px solid; width:130px; height:37px; 
		background-color:gray; text-align:center; display:bolck; font-size:12px; margin:5px; padding:5px;color:#FFFFFF;"  onclick="javascript:viewInfo(1116);" alt="aaa">
		NGCRM</div>
		<div style="position:absolute; left: 710px; top: 812px; border:1px solid; width:130px; height:37px; 
		background-color:green; text-align:center; display:bolck; font-size:12px; margin:5px; padding:5px;color:#FFFFFF;"  onclick="javascript:viewInfo(1116);" alt="aaa">
		NGCRM</div>
		<div style="position:absolute; left: 710px; top: 885px; border:1px solid; width:130px; height:37px; 
		background-color:gray; text-align:center; display:bolck; font-size:12px; margin:5px; padding:5px;color:#FFFFFF;"  onclick="javascript:viewInfo(1116);" alt="aaa">
		NGCRM</div>
		
		<div style="position:absolute; left: 1188px; top: 590px; border:1px solid; width:130px; height:37px; 
		background-color:gray; text-align:center; display:bolck; font-size:12px; margin:5px; padding:5px;color:#FFFFFF;"  onclick="javascript:viewInfo(1116);" alt="aaa">
		NGCRM</div>
		<div style="position:absolute; left: 1190px; top: 680px; border:1px solid; width:130px; height:37px; 
		background-color:gray; text-align:center; display:bolck; font-size:12px; margin:5px; padding:5px;color:#FFFFFF;"  onclick="javascript:viewInfo(1116);" alt="aaa">
		NGCRM</div>
		<div style="position:absolute; left: 1369px; top: 680px; border:1px solid; width:130px; height:37px; 
		background-color:green; text-align:center; display:bolck; font-size:12px; margin:5px; padding:5px;color:#FFFFFF;"  onclick="javascript:viewInfo(1116);" alt="aaa">
		NGCRM</div>
		<div style="position:absolute; left: 1191px; top: 770px; border:1px solid; width:130px; height:37px; 
		background-color:gray; text-align:center; display:bolck; font-size:12px; margin:5px; padding:5px;color:#FFFFFF;"  onclick="javascript:viewInfo(1116);" alt="aaa">
		NGCRM</div>
		<div style="position:absolute; left: 1196px; top: 862px; border:1px solid; width:130px; height:37px; 
		background-color:gray; text-align:center; display:bolck; font-size:12px; margin:5px; padding:5px;color:#FFFFFF;"  onclick="javascript:viewInfo(1116);" alt="aaa">
		NGCRM 4.5</div>
		
		<div style="position:absolute; left: 385px; top: 1010px; border:1px solid; width:130px; height:37px; 
		background-color:green; text-align:center; display:bolck; font-size:12px; margin:5px; padding:5px;color:#FFFFFF;"  onclick="javascript:viewInfo(1116);" alt="aaa">
		NGCRM</div>
		<div style="position:absolute; left: 387px; top: 1116px; border:1px solid; width:130px; height:37px; 
		background-color:gray; text-align:center; display:bolck; font-size:12px; margin:5px; padding:5px;color:#FFFFFF;"  onclick="javascript:viewInfo(1116);" alt="aaa">
		NGCRM</div>
		<div style="position:absolute; left: 576px; top: 1012px; border:1px solid; width:130px; height:37px; 
		background-color:gray; text-align:center; display:bolck; font-size:12px; margin:5px; padding:5px;color:#FFFFFF;"  onclick="javascript:viewInfo(1116);" alt="aaa">
		NGCRM</div>
		<div style="position:absolute; left: 868px; top: 1012px; border:1px solid; width:130px; height:37px; 
		background-color:gray; text-align:center; display:bolck; font-size:12px; margin:5px; padding:5px;color:#FFFFFF;"  onclick="javascript:viewInfo(1116);" alt="aaa">
		NGCRM</div>
		<div style="position:absolute; left: 713px; top: 1108px; border:1px solid; width:130px; height:37px; 
		background-color:gray; text-align:center; display:bolck; font-size:12px; margin:5px; padding:5px;color:#FFFFFF;"  onclick="javascript:viewInfo(1116);" alt="aaa">
		NGCRM</div>
		<div style="position:absolute; left: 446px; top: 1208px; border:1px solid; width:130px; height:37px; 
		background-color:gray; text-align:center; display:bolck; font-size:12px; margin:5px; padding:5px;color:#FFFFFF;"  onclick="javascript:viewInfo(1116);" alt="aaa">
		NGCRM</div>
		
		<div style="position:absolute; left: 1222px; top: 1098px; border:1px solid; width:130px; height:37px; 
		background-color:green; text-align:center; display:bolck; font-size:12px; margin:5px; padding:5px;color:#FFFFFF;"  onclick="javascript:viewInfo(1116);" alt="aaa">
		NGCRM</div>
		<div style="position:absolute; left: 1222px; top: 1265px; border:1px solid; width:130px; height:37px; 
		background-color:gray; text-align:center; display:bolck; font-size:12px; margin:5px; padding:5px;color:#FFFFFF;"  onclick="javascript:viewInfo(1116);" alt="aaa">
		NGCRM</div>
		
		<div style="position:absolute; left: 345px; top: 1432px; border:1px solid; width:130px; height:37px; 
		background-color:gray; text-align:center; display:bolck; font-size:12px; margin:5px; padding:5px;color:#FFFFFF;"  onclick="javascript:viewInfo(1116);" alt="aaa">
		NGCRM</div>
		<div style="position:absolute; left: 531px; top: 1432px; border:1px solid; width:130px; height:37px; 
		background-color:gray; text-align:center; display:bolck; font-size:12px; margin:5px; padding:5px;color:#FFFFFF;"  onclick="javascript:viewInfo(1116);" alt="aaa">
		NGCRM</div>
		<div style="position:absolute; left: 713px; top: 1432px; border:1px solid; width:130px; height:37px; 
		background-color:gray; text-align:center; display:bolck; font-size:12px; margin:5px; padding:5px;color:#FFFFFF;"  onclick="javascript:viewInfo(1116);" alt="aaa">
		NGCRM</div>
		<div style="position:absolute; left: 900px; top: 1432px; border:1px solid; width:130px; height:37px; 
		background-color:gray; text-align:center; display:bolck; font-size:12px; margin:5px; padding:5px;color:#FFFFFF;"  onclick="javascript:viewInfo(1116);" alt="aaa">
		NGCRM 7.4</div>
		<div style="position:absolute; left: 1090px; top: 1432px; border:1px solid; width:130px; height:37px; 
		background-color:gray; text-align:center; display:bolck; font-size:12px; margin:5px; padding:5px;color:#FFFFFF;"  onclick="javascript:viewInfo(1116);" alt="aaa">
		NGCRM</div>
		<div style="position:absolute; left: 1274px; top: 1432px; border:1px solid; width:140px; height:37px; 
		background-color:gray; text-align:center; display:bolck; font-size:12px; margin:5px; padding:5px;color:#FFFFFF;"  onclick="javascript:viewInfo(1116);" alt="aaa">
		NGCRM</div>
		<div style="position:absolute; left: 712px; top: 1565px; border:1px solid; width:130px; height:30px; 
		background-color:gray; text-align:center; display:bolck; font-size:12px; margin:5px; padding:5px;color:#FFFFFF;"  onclick="javascript:viewInfo(1116);" alt="aaa">
		NGCRM</div>
		<div style="position:absolute; left: 950px; top: 1568px; border:1px solid; width:130px; height:32px; 
		background-color:gray; text-align:center; display:bolck; font-size:12px; margin:5px; padding:5px;color:#FFFFFF;"  onclick="javascript:viewInfo(1116);" alt="aaa">
		NGCRM 7.8</div>
		<div style="position:absolute; left: 411px; top: 1695px; border:1px solid; width:130px; height:31px; 
		background-color:green; text-align:center; display:bolck; font-size:12px; margin:5px; padding:5px;color:#FFFFFF;"  onclick="javascript:viewInfo(1116);" alt="aaa">
		NGCRM</div>
		<div style="position:absolute; left: 429px; top: 1560px; border:1px solid; width:100px; height:37px; 
		background-color:gray; text-align:center; display:bolck; font-size:12px; margin:5px; padding:5px;color:#FFFFFF;"  onclick="javascript:viewInfo(1116);" alt="aaa">
		NGCRM</div>
		<div style="position:absolute; left: 568px; top: 1560px; border:1px solid; width:100px; height:37px; 
		background-color:gray; text-align:center; display:bolck; font-size:12px; margin:5px; padding:5px;color:#FFFFFF;"  onclick="javascript:viewInfo(1116);" alt="aaa">
		NGCRM</div>
		<div style="position:absolute; left: 575px; top: 1783px; border:1px solid; width:108px; height:32px; 
		background-color:gray; text-align:center; display:bolck; font-size:12px; margin:5px; padding:5px;color:#FFFFFF;"  onclick="javascript:viewInfo(1116);" alt="aaa">
		NGCRM</div>
		<div style="position:absolute; left: 720px; top: 1800px; border:1px solid; width:108px; height:32px; 
		background-color:gray; text-align:center; display:bolck; font-size:12px; margin:5px; padding:5px;color:#FFFFFF;"  onclick="javascript:viewInfo(1116);" alt="aaa">
		NGCRM 7.13</div>
		
		<div style="position:absolute; left: 142px; top: 1519px; border:1px solid; width:115px; height:30px; 
		background-color:green; text-align:center; display:bolck; font-size:12px; margin:5px; padding:5px;color:#FFFFFF;"  onclick="javascript:viewInfo(1116);" alt="aaa">
		NGCRM</div>
		<div style="position:absolute; left: 142px; top: 1650px; border:1px solid; width:115px; height:25px; 
		background-color:gray; text-align:center; display:bolck; font-size:12px; margin:5px; padding:5px;color:#FFFFFF;"  onclick="javascript:viewInfo(1116);" alt="aaa">
		NGCRM</div>
		
		<div style="position:absolute; left: 902px; top: 1860px; border:1px solid; width:175px; height:30px; 
		background-color:gray; text-align:center; display:bolck; font-size:12px; margin:5px; padding:5px;color:#FFFFFF;"  onclick="javascript:viewInfo(1116);" alt="aaa">
		NGCRM</div>
		<div style="position:absolute; left: 902px; top: 1935px; border:1px solid; width:175px; height:23px; 
		background-color:gray; text-align:center; display:bolck; font-size:12px; margin:5px; padding:5px;color:#FFFFFF;"  onclick="javascript:viewInfo(1116);" alt="aaa">
		NGCRM</div>
		<div style="position:absolute; left: 902px; top: 1991px; border:1px solid; width:175px; height:35px; 
		background-color:gray; text-align:center; display:bolck; font-size:12px; margin:5px; padding:5px;color:#FFFFFF;"  onclick="javascript:viewInfo(1116);" alt="aaa">
		NGCRM</div> 
		<div style="position:absolute; left: 725px; top: 1925px; border:1px solid; width:100px; height:30px; 
		background-color:green; text-align:center; display:bolck; font-size:12px; margin:5px; padding:5px;color:#FFFFFF;"  onclick="javascript:viewInfo(1116);" alt="aaa">
		NGCRM</div> 
		<div style="position:absolute; left: 740px; top: 2000px; border:1px solid; width:74px; height:30px; 
		background-color:gray; text-align:center; display:bolck; font-size:12px; margin:5px; padding:5px;color:#FFFFFF;"  onclick="javascript:viewInfo(1116);" alt="aaa">
		NGCRM</div> 
		<div style="position:absolute; left: 856px; top: 2075px; border:1px solid; width:100px; height:30px; 
		background-color:gray; text-align:center; display:bolck; font-size:12px; margin:5px; padding:5px;color:#FFFFFF;"  onclick="javascript:viewInfo(1116);" alt="aaa">
		NGCRM 9.6</div>
		<div style="position:absolute; left: 740px; top: 2151px; border:1px solid; width:75px; height:45px; 
		background-color:gray; text-align:center; display:bolck; font-size:12px; margin:5px; padding:5px;color:#FFFFFF;"  onclick="javascript:viewInfo(1116);" alt="aaa">
		NGCRM 9.7</div> 
		<div style="position:absolute; left: 687px; top: 2274px; border:1px solid; width:75px; height:30px; 
		background-color:gray; text-align:center; display:bolck; font-size:12px; margin:5px; padding:5px;color:#FFFFFF;"  onclick="javascript:viewInfo(1116);" alt="aaa">
		NGCRM</div>
		<div style="position:absolute; left: 787px; top: 2274px; border:1px solid; width:75px; height:30px; 
		background-color:gray; text-align:center; display:bolck; font-size:12px; margin:5px; padding:5px;color:#FFFFFF;"  onclick="javascript:viewInfo(1116);" alt="aaa">
		NGCRM</div>
		<!-- -->
		 
		<!-- 图例说明 -->
		<div style="position:absolute; left: 1010px; top:10px; border:1px dotted; width:200px; height:135px;"/>
		<div style="position:absolute; left: 10px; top:10px; border:1px solid; width:20px; height:20px; 
			background-color:write; display:bolck;"/>
		<div style="position:absolute; left: 30px; top:2px; width:150px; height:20px; font-size:16px;">操作未开始</div>
		<div style="position:absolute; left: -1px; top:30px; border:1px solid; width:20px; height:20px; 
			background-color:blue; display:bolck;"/>
		<div style="position:absolute; left: 30px; top:2px; width:150px; height:20px; font-size:16px;">正在执行(检查)中</div>
		<div style="position:absolute; left: -1px; top:30px; border:1px solid; width:20px; height:20px; 
			background-color:green; display:bolck;"/>
		<div style="position:absolute; left: 30px; top:2px; width:150px; height:20px; font-size:16px;">执行(检查)已完成</div>
		<div style="position:absolute; left: -1px; top:30px; border:1px solid; width:20px; height:20px; 
			background-color:red; display:bolck;"/>
		<div style="position:absolute; left: 30px; top:2px; width:150px; height:20px; font-size:16px;">执行异常</div>
		
    </div>
</body>
</html>
