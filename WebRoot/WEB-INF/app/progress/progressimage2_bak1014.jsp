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
		-->
   		<c:forEach var="posi" varStatus="item" items="${images}">
			<div id="${posi.taskId}" style="position:absolute; left: ${posi.left}px; top:${posi.top}px; width:${posi.width}px; height:${posi.height}px; 
			background-color:${posi.borderColor}; color:${posi.textColor}; border:1px solid; cursor:hand; text-align:center; font-size:16px; margin:5px; padding:5px;" 
			onclick="javascript:viewInfo(${posi.stepid});" title="${posi.taskTitle }">${posi.taskName}</div>
		</c:forEach>
		
		<!--
			<div id="5010" style="position:absolute; left: 225px; top:410px; width:108px; height:33px; 
			background-color:green; color:#FFFFFF; border:1px solid; cursor:hand; text-align:center; font-size:16px; margin:5px; padding:5px;" 
			onclick="javascript:viewInfo(5000);" title="执行已完成">割接环境检查</div>
			<div id="5011" style="position:absolute; left: 225px; top:310px; width:108px; height:33px; 
			background-color:green; color:#FFFFFF; border:1px solid; cursor:hand; text-align:center; font-size:16px; margin:5px; padding:5px;" 
			onclick="javascript:viewInfo(5000);" title="执行已完成">应用部署检查</div>
			<div id="5012" style="position:absolute; left: 225px; top:218px; width:108px; height:33px; 
			background-color:green; color:#FFFFFF; border:1px solid; cursor:hand; text-align:center; font-size:16px; margin:5px; padding:5px;" 
			onclick="javascript:viewInfo(5000);" title="执行已完成">系统与网络环境检查</div>
		
			<div id="5014" style="position:absolute; left: 742px; top:-5px; width:108px; height:34px; 
			background-color:blue; color:#FFFFFF; border:1px solid; cursor:hand; text-align:center; font-size:16px; margin:5px; padding:5px;" 
			onclick="javascript:viewInfo(5001);" title="正在执行中">营业厅停止营业并结算-- new </div>
			<div id="5013" style="position:absolute; left: 758px; top:80px; width:75px; height:40px; 
			background-color:blue; color:#FFFFFF; border:1px solid; cursor:hand; text-align:center; font-size:16px; margin:5px; padding:5px;" 
			onclick="javascript:viewInfo(5001);" title="正在执行中">割接开始</div>
			<div id="5014" style="position:absolute; left: 475px; top:182px; width:108px; height:34px; 
			background-color:blue; color:#FFFFFF; border:1px solid; cursor:hand; text-align:center; font-size:16px; margin:5px; padding:5px;" 
			onclick="javascript:viewInfo(5001);" title="正在执行中">外围渠道系统挂业务通告</div>
			<div id="5015" style="position:absolute; left: 598px; top:182px; width:126px; height:34px; 
			background-color:blue; color:#FFFFFF; border:1px solid; cursor:hand; text-align:center; font-size:16px; margin:5px; padding:5px;" 
			onclick="javascript:viewInfo(5001);" title="正在执行中">省中心离线话单挂起空冲、二卡拦截</div>
			<div id="5016" style="position:absolute; left: 740px; top:182px; width:115px; height:36px; 
			background-color:blue; color:#FFFFFF; border:1px solid; cursor:hand; text-align:center; font-size:16px; margin:5px; padding:5px;" 
			onclick="javascript:viewInfo(5001);" title="正在执行中">融合计费NEGW号段配置</div>
			<div id="5017" style="position:absolute; left: 878px; top:182px; width:100px; height:36px; 
			background-color:blue; color:#FFFFFF; border:1px solid; cursor:hand; text-align:center; font-size:16px; margin:5px; padding:5px;" 
			onclick="javascript:viewInfo(5001);" title="正在执行中">OCE黑名单配置</div>
			<div id="5018" style="position:absolute; left: 862px; top:262px; width:128px; height:36px; 
			background-color:blue; color:#FFFFFF; border:1px solid; cursor:hand; text-align:center; font-size:16px; margin:5px; padding:5px;" 
			onclick="javascript:viewInfo(5001);" title="正在执行中">停OCE应用</div>
			<div id="5019" style="position:absolute; left: 1064px; top:182px; width:105px; height:36px; 
			background-color:blue; color:#FFFFFF; border:1px solid; cursor:hand; text-align:center; font-size:16px; margin:5px; padding:5px;" 
			onclick="javascript:viewInfo(5001);" title="正在执行中">关闭现网数据库应用 -- new</div>
			<div id="5019" style="position:absolute; left: 660px; top:387px; width:105px; height:36px; 
			background-color:blue; color:#FFFFFF; border:1px solid; cursor:hand; text-align:center; font-size:16px; margin:5px; padding:5px;" 
			onclick="javascript:viewInfo(5001);" title="正在执行中">停NGCRM应用停融合计费应用</div>
			<div id="5020" style="position:absolute; left: 830px; top:387px; width:105px; height:36px; 
			background-color:blue; color:#FFFFFF; border:1px solid; cursor:hand; text-align:center; font-size:16px; margin:5px; padding:5px;" 
			onclick="javascript:viewInfo(5001);" title="正在执行中">停旧账务系统应用</div>
			<div id="5021" style="position:absolute; left: 1216px; top:184px; width:102px; height:34px; 
			background-color:blue; color:#FFFFFF; border:1px solid; cursor:hand; text-align:center; font-size:16px; margin:5px; padding:5px;" 
			onclick="javascript:viewInfo(5001);" title="正在执行中">停止现网数据库备份  -- new</div>
			<div id="5021" style="position:absolute; left: 1350px; top:265px; width:100px; height:36px; 
			background-color:blue; color:#FFFFFF; border:1px solid; cursor:hand; text-align:center; font-size:16px; margin:5px; padding:5px;" 
			onclick="javascript:viewInfo(5001);" title="正在执行中">应急系统启动</div>
		 
			<div id="5022" style="position:absolute; left: 750px; top: 513; width:95px; height:40px; 
			background-color:blue; color:#FFFFFF; border:1px solid; cursor:hand; text-align:center; font-size:16px; margin:5px; padding:5px;" 
			onclick="javascript:viewInfo(5002);" title="正在执行中">3.0  -- new</div>
			<div id="5022" style="position:absolute; left: 510px; top:550px; width:146px; height:50px; 
			background-color:blue; color:#FFFFFF; border:1px solid; cursor:hand; text-align:center; font-size:16px; margin:5px; padding:5px;" 
			onclick="javascript:viewInfo(5002);" title="正在执行中">3.1  -- new</div>
			<div id="5022" style="position:absolute; left: 848px; top:561px; width:130px; height:36px; 
			background-color:blue; color:#FFFFFF; border:1px solid; cursor:hand; text-align:center; font-size:16px; margin:5px; padding:5px;" 
			onclick="javascript:viewInfo(5002);" title="正在执行中">融合计费割接相关表数据备份</div>
			<div id="5023" style="position:absolute; left: 732px; top:610px; width:130px; height:36px; 
			background-color:blue; color:#FFFFFF; border:1px solid; cursor:hand; text-align:center; font-size:16px; margin:5px; padding:5px;" 
			onclick="javascript:viewInfo(5002);" title="正在执行中">省中心、OCE、现网帐务数据导出</div>
			<div id="5024" style="position:absolute; left: 732px; top:692px; width:130px; height:36px; 
			background-color:blue; color:#FFFFFF; border:1px solid; cursor:hand; text-align:center; font-size:16px; margin:5px; padding:5px;" 
			onclick="javascript:viewInfo(5002);" title="正在执行中">融合计费数据转换入库</div>
			<div id="5025" style="position:absolute; left: 736px; top:785px; width:125px; height:36px; 
			background-color:blue; color:#FFFFFF; border:1px solid; cursor:hand; text-align:center; font-size:16px; margin:5px; padding:5px;" 
			onclick="javascript:viewInfo(5002);" title="正在执行中">数据库表统计更新</div>
		
			<div id="5026" style="position:absolute; left: 1086px; top:522px; width:125px; height:36px; 
			background-color:blue; color:#FFFFFF; border:1px solid; cursor:hand; text-align:center; font-size:16px; margin:5px; padding:5px;" 
			onclick="javascript:viewInfo(5003);" title="正在执行中">BI文件生成与上传</div>
			<div id="5027" style="position:absolute; left: 1088px; top:614px; width:125px; height:36px; 
			background-color:blue; color:#FFFFFF; border:1px solid; cursor:hand; text-align:center; font-size:16px; margin:5px; padding:5px;" 
			onclick="javascript:viewInfo(5003);" title="正在执行中">旧系统报表取数、报表打印</div>
			<div id="5028" style="position:absolute; left: 1255px; top:614px; width:125px; height:36px; 
			background-color:blue; color:#FFFFFF; border:1px solid; cursor:hand; text-align:center; font-size:16px; margin:5px; padding:5px;" 
			onclick="javascript:viewInfo(5003);" title="正在执行中">旧系统报表核对</div>
			<div id="5029" style="position:absolute; left: 1088px; top:708px; width:130px; height:36px; 
			background-color:blue; color:#FFFFFF; border:1px solid; cursor:hand; text-align:center; font-size:16px; margin:5px; padding:5px;" 
			onclick="javascript:viewInfo(5003);" title="正在执行中">旧系统数据库备份</div>
			<div id="5029" style="position:absolute; left: 1255px; top:746px; width:130px; height:36px; 
			background-color:blue; color:#FFFFFF; border:1px solid; cursor:hand; text-align:center; font-size:16px; margin:5px; padding:5px;" 
			onclick="javascript:viewInfo(5003);" title="正在执行中">4.5 new </div>
			<div id="5029" style="position:absolute; left: 1058px; top:780px; width:130px; height:36px; 
			background-color:blue; color:#FFFFFF; border:1px solid; cursor:hand; text-align:center; font-size:16px; margin:5px; padding:5px;" 
			onclick="javascript:viewInfo(5003);" title="正在执行中">4.6 new </div>
		
			<div id="5031" style="position:absolute; left: 180px; top: 492px; width:125px; height:35px; 
			background-color:blue; color:#FFFFFF; border:1px solid; cursor:hand; text-align:center; font-size:16px; margin:5px; padding:5px;" 
			onclick="javascript:viewInfo(5004);" title="正在执行中">5.1 new </div> 
			<div id="5031" style="position:absolute; left: 180px; top: 572px; width:125px; height:35px; 
			background-color:blue; color:#FFFFFF; border:1px solid; cursor:hand; text-align:center; font-size:16px; margin:5px; padding:5px;" 
			onclick="javascript:viewInfo(5004);" title="正在执行中">5.2 准实时增加HLR签约信息</div>
			<div id="5032" style="position:absolute; left: 180px; top: 662px; width:125px; height:36px; 
			background-color:blue; color:#FFFFFF; border:1px solid; cursor:hand; text-align:center; font-size:16px; margin:5px; padding:5px;" 
			onclick="javascript:viewInfo(5004);" title="正在执行中">动感、神大号码修改OMM指向至融合计费</div>
			<div id="5034" style="position:absolute; left: 182px; top: 751px; width:125px; height:36px; 
			background-color:blue; color:#FFFFFF; border:1px solid; cursor:hand; text-align:center; font-size:16px; margin:5px; padding:5px;" 
			onclick="javascript:viewInfo(5004);" title="正在执行中">1616平台数据修改</div>
			<div id="5035" style="position:absolute; left: 182px; top: 840px; width:125px; height:36px; 
			background-color:blue; color:#FFFFFF; border:1px solid; cursor:hand; text-align:center; font-size:16px; margin:5px; padding:5px;" 
			onclick="javascript:viewInfo(5004);" title="正在执行中">WLAN接入平台数据修改</div>
			<div id="5036" style="position:absolute; left: 179px; top: 922px; width:125px; height:36px; 
			background-color:blue; color:#FFFFFF; border:1px solid; cursor:hand; text-align:center; font-size:16px; margin:5px; padding:5px;" 
			onclick="javascript:viewInfo(5004);" title="正在执行中">短信FEP号段数据配置</div>
			<div id="5036" style="position:absolute; left: 179px; top: 1010px; width:125px; height:40px; 
			background-color:blue; color:#FFFFFF; border:1px solid; cursor:hand; text-align:center; font-size:16px; margin:5px; padding:5px;" 
			onclick="javascript:viewInfo(5004);" title="正在执行中">5.7 new </div>
		
			<div id="5037" style="position:absolute; left: 428px; top: 925px; width:130px; height:36px; 
			background-color:blue; color:#FFFFFF; border:1px solid; cursor:hand; text-align:center; font-size:16px; margin:5px; padding:5px;" 
			onclick="javascript:viewInfo(5005);" title="正在执行中">对帐报告生成</div>
			<div id="5038" style="position:absolute; left: 428px; top: 1028px; width:125px; height:36px; 
			background-color:blue; color:#FFFFFF; border:1px solid; cursor:hand; text-align:center; font-size:16px; margin:5px; padding:5px;" 
			onclick="javascript:viewInfo(5005);" title="正在执行中">数据核对</div>
			<div id="5039" style="position:absolute; left: 620px; top: 925px; width:130px; height:36px; 
			background-color:blue; color:#FFFFFF; border:1px solid; cursor:hand; text-align:center; font-size:16px; margin:5px; padding:5px;" 
			onclick="javascript:viewInfo(5005);" title="正在执行中">融合计费账务前台启动HSC启动</div>
			<div id="5040" style="position:absolute; left: 862px; top: 925px; width:130px; height:36px; 
			background-color:blue; color:#FFFFFF; border:1px solid; cursor:hand; text-align:center; font-size:16px; margin:5px; padding:5px;" 
			onclick="javascript:viewInfo(5005);" title="正在执行中">NGCRM前台启动</div>
			<div id="5041" style="position:absolute; left: 735px; top: 1020px; width:125px; height:36px; 
			background-color:blue; color:#FFFFFF; border:1px solid; cursor:hand; text-align:center; font-size:16px; margin:5px; padding:5px;" 
			onclick="javascript:viewInfo(5005);" title="正在执行中">数据抽查</div>
			<div id="5042" style="position:absolute; left: 473px; top: 1116px; width:125px; height:36px; 
			background-color:blue; color:#FFFFFF; border:1px solid; cursor:hand; text-align:center; font-size:16px; margin:5px; padding:5px;" 
			onclick="javascript:viewInfo(5005);" title="正在执行中">数据纠错</div>
		
			<div id="5043" style="position:absolute; left: 1122px; top: 1020px; width:130px; height:36px; 
			background-color:blue; color:#FFFFFF; border:1px solid; cursor:hand; text-align:center; font-size:16px; margin:5px; padding:5px;" 
			onclick="javascript:viewInfo(5006);" title="正在执行中">新系统数据备份</div>
			<div id="5044" style="position:absolute; left: 1122px; top: 1119px; width:130px; height:36px; 
			background-color:blue; color:#FFFFFF; border:1px solid; cursor:hand; text-align:center; font-size:16px; margin:5px; padding:5px;" 
			onclick="javascript:viewInfo(5006);" title="正在执行中">增量数据备份</div>
		
			<div id="5045" style="position:absolute; left: 1094px; top: 1520px; width:120px; height:30px; 
			background-color:blue; color:#FFFFFF; border:1px solid; cursor:hand; text-align:center; font-size:16px; margin:5px; padding:5px;" 
			onclick="javascript:viewInfo(5007);" title="正在执行中">新系统报表数据加载</div>
			<div id="5046" style="position:absolute; left: 1094px; top: 1650px; width:120px; height:30px; 
			background-color:blue; color:#FFFFFF; border:1px solid; cursor:hand; text-align:center; font-size:16px; margin:5px; padding:5px;" 
			onclick="javascript:viewInfo(5007);" title="正在执行中">新系统报表对数</div>
		
			<div id="5047" style="position:absolute; left: 551px; top:1352px; width:130px; height:36px; 
			background-color:green; color:#FFFFFF; border:1px solid; cursor:hand; text-align:center; font-size:16px; margin:5px; padding:5px;" 
			onclick="javascript:viewInfo(5008);" title="执行已完成">起NGCRM后台应用起融合计费应用</div>
			<div id="5048" style="position:absolute; left: 551px; top:1428px; width:130px; height:36px; 
			background-color:blue; color:#FFFFFF; border:1px solid; cursor:hand; text-align:center; font-size:16px; margin:5px; padding:5px;" 
			onclick="javascript:viewInfo(5008);" title="正在执行中">外围渠道系统下通告</div>
			<div id="5049" style="position:absolute; left: 733px; top:1352px; width:130px; height:36px; 
			background-color:blue; color:#FFFFFF; border:1px solid; cursor:hand; text-align:center; font-size:16px; margin:5px; padding:5px;" 
			onclick="javascript:viewInfo(5008);" title="正在执行中">融合计费CACHEGROP检查</div>
			<div id="5050" style="position:absolute; left: 923px; top:1352px; width:130px; height:36px; 
			background-color:blue; color:#FFFFFF; border:1px solid; cursor:hand; text-align:center; font-size:16px; margin:5px; padding:5px;" 
			onclick="javascript:viewInfo(5008);" title="正在执行中">省中心停话单挂起停二卡、空充拦截</div>
			<div id="5051" style="position:absolute; left: 735px; top:1553px; width:130px; height:36px; 
			background-color:blue; color:#FFFFFF; border:1px solid; cursor:hand; text-align:center; font-size:16px; margin:5px; padding:5px;" 
			onclick="javascript:viewInfo(5008);" title="正在执行中">功能验证</div>
			<div id="5052" style="position:absolute; left: 894px; top:1553px; width:130px; height:36px; 
			background-color:blue; color:#FFFFFF; border:1px solid; cursor:hand; text-align:center; font-size:16px; margin:5px; padding:5px;" 
			onclick="javascript:viewInfo(5008);" title="正在执行中">外围接口功能验证</div>
			<div id="5053" style="position:absolute; left: 435px; top:1716px; width:130px; height:36px; 
			background-color:blue; color:#FFFFFF; border:1px solid; cursor:hand; text-align:center; font-size:16px; margin:5px; padding:5px;" 
			onclick="javascript:viewInfo(5008);" title="正在执行中">软件紧急修改/测试</div>
			<div id="5054" style="position:absolute; left: 449px; top:1553px; width:100px; height:36px; 
			background-color:blue; color:#FFFFFF; border:1px solid; cursor:hand; text-align:center; font-size:16px; margin:5px; padding:5px;" 
			onclick="javascript:viewInfo(5008);" title="正在执行中">软件紧急发布</div>
			<div id="5055" style="position:absolute; left: 590px; top:1553px; width:100px; height:36px; 
			background-color:blue; color:#FFFFFF; border:1px solid; cursor:hand; text-align:center; font-size:16px; margin:5px; padding:5px;" 
			onclick="javascript:viewInfo(5008);" title="正在执行中">软件版本更新</div>
			<div id="5056" style="position:absolute; left: 600px; top:1798px; width:100px; height:30px; 
			background-color:blue; color:#FFFFFF; border:1px solid; cursor:hand; text-align:center; font-size:16px; margin:5px; padding:5px;" 
			onclick="javascript:viewInfo(5008);" title="正在执行中">回退流程</div>
			<div id="5056" style="position:absolute; left: 746px; top:1815px; width:110px; height:30px; 
			background-color:blue; color:#FFFFFF; border:1px solid; cursor:hand; text-align:center; font-size:16px; margin:5px; padding:5px;" 
			onclick="javascript:viewInfo(5008);" title="正在执行中">9.11 new </div>
		
			<div id="5057" style="position:absolute; left: 924px; top:1860px; width:175px; height:20px; 
			background-color:blue; color:#FFFFFF; border:1px solid; cursor:hand; text-align:center; font-size:16px; margin:5px; padding:5px;" 
			onclick="javascript:viewInfo(5009);" title="正在执行中">应急系统停用，工单补录入</div>
			<div id="5058" style="position:absolute; left: 924px; top:1930px; width:175px; height:20px; 
			background-color:blue; color:#FFFFFF; border:1px solid; cursor:hand; text-align:center; font-size:16px; margin:5px; padding:5px;" 
			onclick="javascript:viewInfo(5009);" title="正在执行中">补跑神大、动感月结</div>
			<div id="5059" style="position:absolute; left: 924px; top:1986px; width:175px; height:30px; 
			background-color:blue; color:#FFFFFF; border:1px solid; cursor:hand; text-align:center; font-size:16px; margin:5px; padding:5px;" 
			onclick="javascript:viewInfo(5009);" title="正在执行中">省中心挂起话单处理、融合计费离线话单处理</div>
			<div id="5060" style="position:absolute; left: 744px; top:1921px; width:110px; height:26px; 
			background-color:blue; color:#FFFFFF; border:1px solid; cursor:hand; text-align:center; font-size:16px; margin:5px; padding:5px;" 
			onclick="javascript:viewInfo(5009);" title="正在执行中">营业厅系统登录</div>
			<div id="5061" style="position:absolute; left: 760px; top:1995px; width:80px; height:26px; 
			background-color:blue; color:#FFFFFF; border:1px solid; cursor:hand; text-align:center; font-size:16px; margin:5px; padding:5px;" 
			onclick="javascript:viewInfo(5009);" title="正在执行中">开始营业</div>
			<div id="5060" style="position:absolute; left: 869px; top:2058px; width:100px; height:26px; 
			background-color:blue; color:#FFFFFF; border:1px solid; cursor:hand; text-align:center; font-size:16px; margin:5px; padding:5px;" 
			onclick="javascript:viewInfo(5009);" title="正在执行中">10.6 new </div>
			<div id="5062" style="position:absolute; left: 765px; top:2118px; width:70px; height:42px; 
			background-color:blue; color:#FFFFFF; border:1px solid; cursor:hand; text-align:center; font-size:16px; margin:5px; padding:5px;" 
			onclick="javascript:viewInfo(5009);" title="正在执行中">割接完毕</div>
			<div id="5063" style="position:absolute; left: 697px; top:2257px; width:90px; height:30px; 
			background-color:blue; color:#FFFFFF; border:1px solid; cursor:hand; text-align:center; font-size:16px; margin:5px; padding:5px;" 
			onclick="javascript:viewInfo(5009);" title="正在执行中">割接后业务验证</div>
			<div id="5063" style="position:absolute; left: 812px; top:2257px; width:90px; height:30px; 
			background-color:blue; color:#FFFFFF; border:1px solid; cursor:hand; text-align:center; font-size:16px; margin:5px; padding:5px;" 
			onclick="javascript:viewInfo(5009);" title="正在执行中">10.9 new </div>
		 -->
		 
		<!-- 图例说明 -->
		<div style="position:absolute; left: 1430px; top:10px; border:1px dotted; width:165px; height:135px;"/>
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
