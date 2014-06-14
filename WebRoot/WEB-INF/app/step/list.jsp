<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=UTF-8"%>
<html>
	<head>
		<link href="/resources/css/css.css" type="text/css" rel="stylesheet" />
		<script src="/resources/js/ajaxpage-2.0.0.js" type="text/javascript"></script>
		<script src="/resources/js/jquery.min.js" type="text/javascript"></script>
		<script src="/resources/js/common.js" type="text/javascript"></script>
		<script type="text/javascript">
		function doEdit(id){
			showModalDlg((id?"编辑":"新建") + "步骤", '/step/edit/'+id, 600, 400, function(s){
				doReset();
			});
		}
		function doDel(id){
	  		if(!window.confirm("你确定要删除该步骤吗(删除后不可恢复)?")){
			    return;
			}
			if(!window.confirm("删除步骤操作将同时删除该步骤下的所有子任务，你确定仍要继续吗?")){
			    return;
			}
			$.post(
				'/step/del/'+id,
				function(s){
					alert('操作成功!');
					doReset();
				}
			);
		}
		function doImport(){
			showModalDlg("导入步骤", '/common/import/step', 600, 120, function(s){doReset();});
		}
		</script>
	</head>
	<body>
	  <div id="divSearch" class="divSearch">
	  	<form name="form1" id="form1" method="post" action="">
		<table width="100%" border="0" cellpadding="2" cellspacing="1">
			<tr>
			  <td align="left" valign="middle">步骤名称<input id="stepName" name="stepName" type="text"/>
				&nbsp;<button class="btn_2k3" onclick="doSearch()">查询</button>&nbsp;<button class="btn_2k3" onclick="doReset()">重置</button>
		      </td>
		  </tr>
		</table>
		</form>
	  </div>
		<div style="padding-bottom:5px">
		  	<table width="100%" border="0" cellpadding="2" cellspacing="1">
				<tr>
				  <td align="left">&nbsp;[&nbsp;步骤列表&nbsp;]</td>
				  <td align="right"><button class="btn_2k3" onclick="doEdit(0)">新建</button>&nbsp;&nbsp;
				  		<button class="btn_2k3" onclick="doImport()">导入</button></td>
			  </tr>
			</table>
			<table id="pageList" width="100%" border="1" align="center" cellpadding="0" cellspacing="0" rules="cols" bordercolor="#9aadce" class="table">
				<thead>
					<tr class="head">
						<td width="5%">索引</td>
						<td>步骤名称</td>
						<td width="5%">权重(%)</td>
						<td width="10%">计划时长(小时)</td>
						<td width="10%">步骤负责人</td>
						<td width="10%" style="display: none">步骤检查人</td>
						<td width="10%">操作</td>
					</tr>
					<tr style="display: none;cursor='default';" onmouseover="doonmouseover(this)" onmouseout="doonmouseout(this, this.className)">
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td style="display: none"></td>
						<td></td>
					</tr>
				</thead>
		
				<tbody>
				</tbody>
			</table>
		</div>
		<div id="ajaxpage-foot"></div>
		<script type="text/javascript">
			var ajaxPage = new $AjaxPage("pageList", "/ajaxpage/step", 20);
			ajaxPage.afterRow(function(rowIndex, row, datas){
				if("${isAdmin}"=="1" || "${cutUserId}"==datas.get("step_owner_id")){
					var stepId = datas.get("step_id");
					row.cells[row.cells.length-1].innerHTML = "<a href='#' onclick='doEdit("+stepId+")'>编辑</a>&nbsp;&nbsp;<a href='#' onclick='doDel("+stepId+")'>删除</a>";
				}
			});
			
			$(document).ready(function() {
				doSearch();
			});
			
			function doSearch(){
				ajaxPage.reset();
				ajaxPage.addQueryParams("stepName", $("#stepName").val());
				ajaxPage.execute(afterPage);
			}
			
			function doReset(){
				$("#stepName").val("");
				doSearch();
			}
			
			function doRefresh(){
				ajaxPage.refresh(afterPage);
			}
						
		</script>
		<script src="/resources/js/ajaxpage-foot.js" type="text/javascript"></script>
	</body>
</html>