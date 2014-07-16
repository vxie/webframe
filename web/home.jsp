<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/common/head.inc" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta http-equiv="pragma" content="no-cache" />
		<title>割接进度管理系统</title>
		<script src="<%= contextPath%>/resources/js/jquery.min.js" type="text/javascript"></script>
		<script src="<%= contextPath%>/resources/js/dlg/jquery.xdialog.js" type="text/javascript"></script>
		<script>
		var images = [];
		function preLoadImages(){
			for(i=0;i<4;i++){
				images[i] = new Image();
				images[i].src = "<%= contextPath%>/resources/images/nav"+i+".png";
			}
		}
		preLoadImages();

		
		function switchBar(type){
			
			var o = document.getElementById("switch_"+type+"_point");
			var f = document.getElementById(type+"Info");
			var v = o.src.substr(o.src.lastIndexOf(".png")-1, 1);
			if(type=="top"){
				o.src = v=="0"?images[1].src:images[0].src;
				f.style.display= v=="0"?"none":"";

				if(v == "0"){
                   //收缩
                    barflg ="0";
			    }else{
                   //展开
			    	barflg = "1";   
				}
			}else{
				o.src = v=="2"?images[3].src:images[2].src;
				f.style.display= v=="2"?"none":"";
				
			}
		}
		
		//function showModalDlg(title, url, w, h, callback){
		//	JQueryXDialog.Open(title, url, w, h, callback);
		//}
		
		function showModalDlg(title, url, w, h, callback, txtSubmit, txtCancel){
			JQueryXDialog.Open(title, url, w, h, callback, txtSubmit, txtCancel);
		}
		
		function closeModalDlg(){
			JQueryXDialog.Close();
		}

		
		function logout(){
			$.post('<%= contextPath%>/logout', function(s){
				window.top.location.href = "<%= contextPath%>/login";
			});
		}
		
		function changePwdDlg(){
			showModalDlg("修改密码", '<%= contextPath%>/user/changepwd', 600, 180);
		}

		var barflg = "";
		var height = 0;
		$(document).ready(function(){
//			switchBar('left');
//			switchBar('top');
			height = document.body.offsetHeight;
            $("#mainContent").css("height", document.body.offsetHeight - 50);
		});
		</script>
        <style type="text/css">
            html,body {
                height: 100%
            }
        </style>
	</head>
<body scroll="no" style="margin: 0;">
	<table border="0" cellspacing="0" cellpadding="0" width="100%" height="100%">
 		<tr id="topInfo">
  			<td width="100%" height="28px" bgcolor="#2596ee">
  				<table style="width:100%; font-family: Arial;font-size: 12px;">
  					<tr valign="bottom">
  						<td><img src="<%= contextPath%>/resources/images/top_bg.jpg" border="0"/></td>
                        <td align="left" style="color:#fff;">${adminUser.number}，您好！</td>
  						<td align="right"><a href="#" style="color:#fff;" onclick="changePwdDlg()">修改密码</a></td>
  						<td align="right"><a href="#" onclick="logout()" style="color:#fff;">退出</a>&nbsp;</td>
  					</tr>
  				</table>
             </td>
 		</tr>
 		<tr>
  			<td bgColor="#dbe3f7" style="height: 2pt" width="100%" align="middle">
                  <%--<img id="switch_top_point" onclick="switchBar('top')" style="cursor: hand;" src="/resources/images/nav0.png" border="0">--%>
              </td>
 		</tr>
 		<tr>
	  		<td width="100%" height="100%" id="mainContent">
	  		<table border="0" cellPadding="0" cellSpacing="0" height="100%" width="100%">
				<tr>
			  		<td align="left" id="frmTitle" noWrap style="vertical-align:top;">
						<iframe name="menuInfo" id="leftInfo" frameborder="0" framespacing="0" marginwidth="0" marginheight="0" src="<%= contextPath%>/left" style="height: 100%; visibility: inherit; width: 140px; z-index: 2"></iframe>
			  		</td>
			  		<td bgColor="#dbe3f7" style="width: 10pt;">
              			<img id="switch_left_point" onclick="switchBar('left')" style="cursor: hand;" src="<%= contextPath%>/resources/images/nav2.png" border="0">
			   		</td>
					<td style="width: 100%; height: 100%; padding: 5px; vertical-align:top;">
						<iframe name="contentInfo" id="contentInfo" frameBorder="0" scrolling="" src="<%= contextPath%>/user/list" style="height: 100%; visibility: inherit; width: 100%; z-index: 1"></iframe>
					</td>
				</tr>
			</table>
	  		</td>
 		</tr>

 	</table>
</body>

</html>