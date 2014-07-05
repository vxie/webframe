<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ page import="com.vxie.debut.model.CutStepPosition,java.util.*"  contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
  <head>
  
  	<script src="/resources/js/jquery.min.js" type="text/javascript"></script>
  	<script src="/resources/js/common.js" type="text/javascript"></script>
	
    <script>
    $(document).ready(function(){

          // $('#image').html("<div style='position:absolute;left:200px; top:800px; border:red 4px groove; width:120px; height:42px' onClick='aaa(11,22)' />");
        }

     );


	function viewInfo(id){

		//alert(id);
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

			
	</script>

  </head>

  <body>

    <!-- 第一个流程 -->
    <div id='image' style='position:relative; background-image:url(/resources/images/step1.jpg); width: 1588px; height: 2195px;'>
    	<!-- width height 和背景图的长宽属性一致 -->
        <!-- 
       <div style="position:absolute; left: 158px; top:440px; border:red 4px groove; width:108px; height:33px"  onclick="javascript:viewInfo(1116);" alt="aaa"/>
       <div style="position:absolute; left: -5px; top: -90px; border:red 4px groove; width:108px; height:33px"  onclick="javascript:viewInfo(1116);"/>
       <div style="position:absolute; left: -5px; top: -85px; border:red 4px groove; width:108px; height:33px"  onclick="javascript:viewInfo(1116);"/>
       <div style="position:absolute; left: -5px; top: -85px; border:red 4px groove; width:108px; height:33px"  onclick="javascript:viewInfo(1116);"/>
       <div style="position:absolute; left: -3px; top: -82px; border:red 4px groove; width:108px; height:33px"  onclick="javascript:viewInfo(1116);"/>

       <div style="position:absolute; left: 530px; top: -50px; border:red 4px groove; width:108px; height:33px"  onclick="javascript:viewInfo(1116);"/>
       <div style="position:absolute; left: 12px; top: 78px; border:red 4px groove; width:80px; height:50px"  onclick="javascript:viewInfo(1116);"/>
       <div style="position:absolute; left: -300px; top: 127px; border:red 4px groove; width:102px; height:38px"  onclick="javascript:viewInfo(1116);"/>
       <div style="position:absolute; left: 150px; top: -2px; border:red 4px groove; width:125px; height:38px"  onclick="javascript:viewInfo(1116);"/>
       <div style="position:absolute; left: 180px; top: -1px; border:red 4px groove; width:110px; height:37px"  onclick="javascript:viewInfo(1116);"/>
       <div style="position:absolute; left: 150px; top: -6px; border:red 4px groove; width:130px; height:37px"  onclick="javascript:viewInfo(1116);"/>
       <div style="position:absolute; left: 170px; top: -6px; border:red 4px groove; width:130px; height:37px"  onclick="javascript:viewInfo(1116);"/>
       <div style="position:absolute; left: -385px; top: 120px; border:red 4px groove; width:100px; height:37px"  onclick="javascript:viewInfo(1116);"/>

      <div style="position:absolute; left: -254px; top: 250px; border:red 4px groove; width:130px; height:37px"  onclick="javascript:viewInfo(1116);"/>
      <div style="position:absolute; left: 497px; top: -115px; border:red 4px groove; width:130px; height:37px"  onclick="javascript:viewInfo(1116);"/>
      <div style="position:absolute; left: -5px; top: 170px; border:red 4px groove; width:130px; height:37px"  onclick="javascript:viewInfo(1116);"/>
      <div style="position:absolute; left: -465px; top: 125px; border:red 4px groove; width:130px; height:37px"  onclick="javascript:viewInfo(1116);"/>
      <div style="position:absolute; left: 340px; top: -30px; border:red 4px groove; width:130px; height:37px"  onclick="javascript:viewInfo(1116);"/>

      <div style="position:absolute; left: 410px; top: -265px; border:red 4px groove; width:130px; height:37px"  onclick="javascript:viewInfo(1116);"/>
      <div style="position:absolute; left: 0px; top: 100px; border:red 4px groove; width:130px; height:37px"  onclick="javascript:viewInfo(1116);"/>
      <div style="position:absolute; left: 190px; top: 0px; border:red 4px groove; width:130px; height:37px"  onclick="javascript:viewInfo(1116);"/>
      <div style="position:absolute; left: -200px; top: 95px; border:red 4px groove; width:130px; height:37px"  onclick="javascript:viewInfo(1116);"/>

     <div style="position:absolute; left: -895px; top: 190px; border:red 4px groove; width:130px; height:37px"  onclick="javascript:viewInfo(1116);"/>
     <div style="position:absolute; left: -1px; top: 100px; border:red 4px groove; width:130px; height:37px"  onclick="javascript:viewInfo(1116);"/>
     <div style="position:absolute; left: 182px; top: -105px; border:red 4px groove; width:130px; height:37px"  onclick="javascript:viewInfo(1116);"/>
     <div style="position:absolute; left: 293px; top: -5px; border:red 4px groove; width:130px; height:37px"  onclick="javascript:viewInfo(1116);"/>
     <div style="position:absolute; left: -160px; top: 95px; border:red 4px groove; width:130px; height:37px"  onclick="javascript:viewInfo(1116);"/>
     <div style="position:absolute; left: -270px; top: 95px; border:red 4px groove; width:130px; height:37px"  onclick="javascript:viewInfo(1116);"/>


     <div style="position:absolute; left: 820px; top: -118px; border:red 4px groove; width:130px; height:37px"  onclick="javascript:viewInfo(1116);"/>
     <div style="position:absolute; left: -2px; top: 163px; border:red 4px groove; width:130px; height:37px"  onclick="javascript:viewInfo(1116);"/>

     <div style="position:absolute; left: -933px; top: 163px; border:red 4px groove; width:130px; height:37px"  onclick="javascript:viewInfo(1116);"/>
     <div style="position:absolute; left: 185px; top: 0px; border:red 4px groove; width:130px; height:37px"  onclick="javascript:viewInfo(1116);"/>
     <div style="position:absolute; left: 175px; top: -4px; border:red 4px groove; width:130px; height:37px"  onclick="javascript:viewInfo(1116);"/>
     <div style="position:absolute; left: 180px; top: -4px; border:red 4px groove; width:130px; height:37px"  onclick="javascript:viewInfo(1116);"/>
     <div style="position:absolute; left: 188px; top: -4px; border:red 4px groove; width:130px; height:37px"  onclick="javascript:viewInfo(1116);"/>
     <div style="position:absolute; left: 180px; top: -4px; border:red 4px groove; width:130px; height:37px"  onclick="javascript:viewInfo(1116);"/>
     <div style="position:absolute; left: -567px; top: 126px; border:red 4px groove; width:130px; height:37px"  onclick="javascript:viewInfo(1116);"/>
     <div style="position:absolute; left: 235px; top: 1px; border:red 4px groove; width:130px; height:37px"  onclick="javascript:viewInfo(1116);"/>
     <div style="position:absolute; left: -544px; top: 123px; border:red 4px groove; width:130px; height:37px"  onclick="javascript:viewInfo(1116);"/>
     <div style="position:absolute; left: 13px; top: -135px; border:red 4px groove; width:100px; height:37px"  onclick="javascript:viewInfo(1116);"/>
     <div style="position:absolute; left: 135px; top: -5px; border:red 4px groove; width:100px; height:37px"  onclick="javascript:viewInfo(1116);"/>
     <div style="position:absolute; left: 5px; top: 210px; border:red 4px groove; width:110px; height:37px"  onclick="javascript:viewInfo(1116);"/>

     <div style="position:absolute; left: -435px; top: -265px; border:red 4px groove; width:115px; height:30px"  onclick="javascript:viewInfo(1116);"/>
     <div style="position:absolute; left: -5px; top: 130px; border:red 4px groove; width:115px; height:25px"  onclick="javascript:viewInfo(1116);"/>

     <div style="position:absolute; left: 755px; top: 214px; border:red 4px groove; width:175px; height:23px"  onclick="javascript:viewInfo(1116);"/>
     <div style="position:absolute; left: -3px; top: 60px; border:red 4px groove; width:175px; height:23px"  onclick="javascript:viewInfo(1116);"/>
     <div style="position:absolute; left: -3px; top: 55px; border:red 4px groove; width:175px; height:35px"  onclick="javascript:viewInfo(1116);"/> 
     <div style="position:absolute; left: -180px; top: -70px; border:red 4px groove; width:100px; height:30px"  onclick="javascript:viewInfo(1116);"/> 
     <div style="position:absolute; left: 10px; top: 70px; border:red 4px groove; width:70px; height:30px"  onclick="javascript:viewInfo(1116);"/> 
     <div style="position:absolute; left: -3px; top: 66px; border:red 4px groove; width:75px; height:45px"  onclick="javascript:viewInfo(1116);"/> 
     <div style="position:absolute; left: -5px; top: 90px; border:red 4px groove; width:75px; height:30px"  onclick="javascript:viewInfo(1116);"/> 
     -->
  

     <c:forEach var="posi" varStatus="item" items="${images}">
     	<div id="${posi.taskId}" style="position:absolute; left: ${posi.left}px; top:${posi.top}px; border:${posi.colors[posi.status] } 4px groove; width:${posi.width}px; height:${posi.height}px;cursor:hand"  onclick="javascript:viewInfo(${posi.stepid});"  title="${posi.titles[posi.status] }"/>
     </c:forEach>
    </div>
</body>
</html>
