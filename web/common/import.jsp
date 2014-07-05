<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<html>
	<head>
  		<link href="/resources/css/css.css" type="text/css" rel="stylesheet" />
  		<script src="/resources/js/jquery.min.js" type="text/javascript"></script>
  		<script src="/resources/js/validate/jquery.validate.js" type="text/javascript"></script>
  		<script src="/resources/js/jquery.form.js" type="text/javascript"></script>
	</head>
	<body>
	<form name="fileUploadForm" id="fileUploadForm" action="/common/import/save/${subject}" method="post" enctype="multipart/form-data">
		<table width="100%" border="0" cellpadding="2" cellspacing="1">
			<tr><td height="10px;"></td></tr>
			<tr>
				<td align="left" style="width:80%;overflow:hidden;white-space：normal;nowrap;">&nbsp;&nbsp;请选择数据文件:
					<input type="file" name="xfile" id="xfile" value="浏览..." accept="application/vnd.ms-excel" style="width:60%;"/>&nbsp;&nbsp;
				  	<a href="/common/import/download/${subject}"><font color="blue">下载Excel模板</font></a>
				</td>
			</tr>
			<tr><td height="10px;"></td></tr>
			<tr>
				<td>
					<div>
						<span id="waiting" style="display:none;padding-left:5px;color:#FF0000;font-size:110%;">请您稍等，正在进行数据导入</span>
					</div>
				</td>
			</tr>
			<tr align="center" style="display:none;">
				<td><input type="button" value="开始导入" id="uploadButton" class="bgBtn" onclick="doUpLoad();" /></td>
			</tr>
		</table>
	</form>
	<script type="text/javascript">
		$(document).ready(function() {
			$('#fileUploadForm').submit(function(){
		        $(this).ajaxSubmit({
		        	success: function(s){
		        		var objs = eval("("+s.replace(/<PRE>/ig, "").replace(/<\/PRE>/ig, "")+")");
		        		/*
		        		jQuery.each(objs, function(key, value){
		        			$('#'+key).val(value);
		        		});
		        		for(var x in objs) {
			        		alert(x + '==' + objs[x]);
			        		$('#'+x).val(objs[x]) ;
		        		}*/
		        		if(objs.total == '0'){
			        		$('#waiting').text("ERROR：\n" + objs.error);
		        			//alert("导入失败!");
		        		} else {
		        			$('#waiting').text("导入成功！");
		        			alert("成功导入" + objs.total + "条记录!");
		        		}
		        		killTimerCount();
		        	},
		        	error: function(data, status, e) {
		        		alert("导入超时!建议导入数据不超过1000条。");
		        		killTimerCount();
		        	},
		        	timeout:30000
		        });
		        return false;
		    }); 
		});
		
		function doUpLoad(){
			if(!isXlsFile($("#xfile").get(0))){
				alert("请选择一个Excel文件(*.xls)!");
				getBtnOK().disabled = false;
				return;
			}
			//$('#uploadButton').attr('disabled', 'disabled');
			$('#waiting').show();
			timerCount();
			$("#fileUploadForm").submit();
		}
		
		function isXlsFile(o){
		 	if(""!=o.value){
				var suffx = o.value.replace(/.+\./,'');
				if("xls"==suffx.toLowerCase()){
					return true;
				}
			}
			return false;
		}
		
		function Ok(){
			doUpLoad();
		}

		var text = "请您稍等,正在进行数据导入";
		var i = 0;
		var timerSecond = 0;
		var refreshTimer;
		function timerCount(){
			if(i < 6){
				text += ".";
				i ++;
			} else {
				text = "请您稍等,正在进行数据导入";
				i = 0;
			}
			$('#waiting').text(text);
			//getBtnOK().value = timerSecond++;
			refreshTimer = setTimeout(function(){timerCount();}, 1000);
		}

		function killTimerCount(){
			timerSecond = 0;
			clearTimeout(refreshTimer);
			//getBtnOK().disabled = false;
			//getBtnOK().value = "导入";
		}

	</script>
</body>
</html>