<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ page import="com.sunrise.cutshow.model.CutStepPosition,java.util.*"  contentType="text/html; charset=UTF-8"%>
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
		var info = window.open( url,winName,theproperty );

	}

			
	</script>

  </head>

  <body>
     <!-- 第二个流程 -->

    <div id='image' style='position:relative; background-image:url(/resources/images/step2.jpg); width: 1407px; height: 2210px;'>
       <!--
   
       <div style="position:absolute; left: 325px; top:399px; border:red 5px groove; width:108px; height:33px"  onclick="javascript:viewInfo(1116);" alt="aaa"/>
       <div style="position:absolute; left: -3px; top: -102px; border:red 5px groove; width:108px; height:33px"  onclick="javascript:viewInfo(1116);"/>
       <div style="position:absolute; left: -5px; top: -98px; border:red 5px groove; width:108px; height:33px"  onclick="javascript:viewInfo(1116);"/>
       
      <div style="position:absolute; left: 410px; top: -151px; border:red 5px groove; width:85px; height:50px"  onclick="javascript:viewInfo(1116);"/>
      <div style="position:absolute; left: -178px; top: 98px; border:red 5px groove; width:108px; height:40px"  onclick="javascript:viewInfo(1116);"/>
      <div style="position:absolute; left: 150px; top: -5px; border:red 5px groove; width:126px; height:40px"  onclick="javascript:viewInfo(1116);"/>
      <div style="position:absolute; left: 170px; top: -2px; border:red 5px groove; width:115px; height:36px"  onclick="javascript:viewInfo(1116);"/>
      <div style="position:absolute; left: 184px; top: -8px; border:red 5px groove; width:128px; height:36px"  onclick="javascript:viewInfo(1116);"/>
      <div style="position:absolute; left: -5px; top: 77px; border:red 5px groove; width:128px; height:36px"  onclick="javascript:viewInfo(1116);"/>
      <div style="position:absolute; left: -440px; top: 120px; border:red 5px groove; width:105px; height:36px"  onclick="javascript:viewInfo(1116);"/>
      <div style="position:absolute; left: 157px; top: -3px; border:red 5px groove; width:105px; height:36px"  onclick="javascript:viewInfo(1116);"/>
     <div style="position:absolute; left: 450px; top: -130px; border:red 5px groove; width:130px; height:36px"  onclick="javascript:viewInfo(1116);"/>
     

       <div style="position:absolute; left: -780px; top: 287px; border:red 5px groove; width:130px; height:36px"  onclick="javascript:viewInfo(1116);"/>
       <div style="position:absolute; left: 223px; top: 50px; border:red 5px groove; width:130px; height:36px"  onclick="javascript:viewInfo(1116);"/>	
       <div style="position:absolute; left: -10px; top: 80px; border:red 5px groove; width:130px; height:36px"  onclick="javascript:viewInfo(1116);"/>	
       <div style="position:absolute; left: -225px; top: 75px; border:red 5px groove; width:125px; height:36px"  onclick="javascript:viewInfo(1116);"/>	

       <div style="position:absolute; left: 550px; top: -217px; border:red 5px groove; width:125px; height:36px"  onclick="javascript:viewInfo(1116);"/>	
       <div style="position:absolute; left: -10px; top: 100px; border:red 5px groove; width:135px; height:36px"  onclick="javascript:viewInfo(1116);"/>	
       <div style="position:absolute; left: 165px; top: 0px; border:red 5px groove; width:135px; height:36px"  onclick="javascript:viewInfo(1116);"/>	
       <div style="position:absolute; left: -170px; top: 95px; border:red 5px groove; width:135px; height:36px"  onclick="javascript:viewInfo(1116);"/>	

       <div style="position:absolute; left: -895px; top: -210px; border:red 5px groove; width:135px; height:36px"  onclick="javascript:viewInfo(1116);"/>	
       <div style="position:absolute; left: 0px; top: 90px; border:red 5px groove; width:130px; height:36px"  onclick="javascript:viewInfo(1116);"/>	
        <div style="position:absolute; left: -8px; top: 85px; border:red 5px groove; width:130px; height:36px"  onclick="javascript:viewInfo(1116);"/>
        <div style="position:absolute; left: -5px; top: 75px; border:red 5px groove; width:130px; height:36px"  onclick="javascript:viewInfo(1116);"/>
        <div style="position:absolute; left: -5px; top: 75px; border:red 5px groove; width:135px; height:36px"  onclick="javascript:viewInfo(1116);"/>
        <div style="position:absolute; left: -8px; top: 78px; border:red 5px groove; width:135px; height:36px"  onclick="javascript:viewInfo(1116);"/>

         <div style="position:absolute; left: 250px; top: -78px; border:red 5px groove; width:135px; height:36px"  onclick="javascript:viewInfo(1116);"/>
         <div style="position:absolute; left: -5px; top: 98px; border:red 5px groove; width:125px; height:36px"  onclick="javascript:viewInfo(1116);"/>
         <div style="position:absolute; left: 180px; top: -110px; border:red 5px groove; width:145px; height:36px"  onclick="javascript:viewInfo(1116);"/>
         <div style="position:absolute; left: 240px; top: 0px; border:red 5px groove; width:130px; height:36px"  onclick="javascript:viewInfo(1116);"/>
         <div style="position:absolute; left: -130px; top: 90px; border:red 5px groove; width:120px; height:36px"  onclick="javascript:viewInfo(1116);"/>
         <div style="position:absolute; left: -260px; top: 90px; border:red 5px groove; width:120px; height:36px"  onclick="javascript:viewInfo(1116);"/>

         <div style="position:absolute; left: 650px; top: -105px; border:red 5px groove; width:120px; height:36px"  onclick="javascript:viewInfo(1116);"/>
         <div style="position:absolute; left: -5px; top: 95px; border:red 5px groove; width:120px; height:36px"  onclick="javascript:viewInfo(1116);"/>

         <div style="position:absolute; left: -50px; top: 390px; border:red 5px groove; width:120px; height:36px"  onclick="javascript:viewInfo(1116);"/>
         <div style="position:absolute; left: -5px; top: 130px; border:red 5px groove; width:120px; height:36px"  onclick="javascript:viewInfo(1116);"/>

 <div style="position:absolute; left: -545px; top: -300px; border:red 5px groove; width:125px; height:36px"  onclick="javascript:viewInfo(1116);"/>
 <div style="position:absolute; left: 0px; top: 70px; border:red 5px groove; width:125px; height:36px"  onclick="javascript:viewInfo(1116);"/>
<div style="position:absolute; left: 170px; top: -85px; border:red 5px groove; width:135px; height:36px"  onclick="javascript:viewInfo(1116);"/>
<div style="position:absolute; left: 190px; top: 0px; border:red 5px groove; width:135px; height:36px"  onclick="javascript:viewInfo(1116);"/>
<div style="position:absolute; left: -190px; top: 195px; border:red 5px groove; width:135px; height:36px"  onclick="javascript:viewInfo(1116);"/>
<div style="position:absolute; left: 150px; top: -5px; border:red 5px groove; width:135px; height:36px"  onclick="javascript:viewInfo(1116);"/>
<div style="position:absolute; left: -465px; top: 160px; border:red 5px groove; width:125px; height:36px"  onclick="javascript:viewInfo(1116);"/>
<div style="position:absolute; left: 10px; top: -170px; border:red 5px groove; width:100px; height:36px"  onclick="javascript:viewInfo(1116);"/>
<div style="position:absolute; left: 135px; top: -3px; border:red 5px groove; width:100px; height:36px"  onclick="javascript:viewInfo(1116);"/>
<div style="position:absolute; left: 10px; top: 240px; border:red 5px groove; width:100px; height:36px"  onclick="javascript:viewInfo(1116);"/>

<div style="position:absolute; left: 315px; top: 55px; border:red 5px groove; width:180px; height:36px"  onclick="javascript:viewInfo(1116);"/>
<div style="position:absolute; left: 0px; top: 65px; border:red 5px groove; width:180px; height:26px"  onclick="javascript:viewInfo(1116);"/>
<div style="position:absolute; left: -15px; top: 45px; border:red 5px groove; width:180px; height:46px"  onclick="javascript:viewInfo(1116);"/>
<div style="position:absolute; left: -185px; top: -65px; border:red 5px groove; width:130px; height:26px"  onclick="javascript:viewInfo(1116);"/>
<div style="position:absolute; left: 3px; top: 70px; border:red 5px groove; width:130px; height:26px"  onclick="javascript:viewInfo(1116);"/>
<div style="position:absolute; left: -5px; top: 60px; border:red 5px groove; width:120px; height:49px"  onclick="javascript:viewInfo(1116);"/>
<div style="position:absolute; left: -5px; top: 80px; border:red 5px groove; width:120px; height:36px"  onclick="javascript:viewInfo(1116);"/>
<div style="position:absolute; left: -578px; top: -1660px; border:red 5px groove; width:135px; height:36px"  onclick="javascript:viewInfo(1116);"/>
-->

   
         <c:forEach var="posi" varStatus="item" items="${images}">
            <c:if test="${posi.status == 0}">  <!-- 未开始 -->
                <div style="position:absolute; left: ${posi.left}px; top:${posi.top}px; border:black 5px groove; width:${posi.width}px; height:${posi.height}px;cursor:hand"  onclick="javascript:viewInfo(${posi.stepid});"  title="操作未开始"/>
            </c:if>
            <c:if test="${posi.status == 1}"><!-- 正在执行 -->
                <div style="position:absolute; left: ${posi.left}px; top:${posi.top}px; border:red 5px groove; width:${posi.width}px; height:${posi.height}px;cursor:hand"  onclick="javascript:viewInfo(${posi.stepid});" title="正在执行中"/>
            </c:if>
            <c:if test="${posi.status == 2}"><!-- 执行已完成 -->
               <div style="position:absolute; left: ${posi.left}px; top:${posi.top}px; border:green 5px groove; width:${posi.width}px; height:${posi.height}px;cursor:hand"  onclick="javascript:viewInfo(${posi.stepid});" title="执行已完成"/>
            </c:if>
            <c:if test="${posi.status == 3}"><!-- 正在检查 -->
              <div style="position:absolute; left: ${posi.left}px; top:${posi.top}px; border:red 5px groove; width:${posi.width}px; height:${posi.height}px;cursor:hand"  onclick="javascript:viewInfo(${posi.stepid});" title="正在检查中"/>
            </c:if>
            <c:if test="${posi.status == 4}"><!-- 检查已完成 -->
              <div style="position:absolute; left: ${posi.left}px; top:${posi.top}px; border:green 5px groove; width:${posi.width}px; height:${posi.height}px;cursor:hand"  onclick="javascript:viewInfo(${posi.stepid});" title="检查已完成"/>
            </c:if>
       </c:forEach>
    
    </div>
</body>
</html>
