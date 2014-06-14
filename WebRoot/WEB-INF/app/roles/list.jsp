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
				showModalDlg((id?"编辑":"新建") + "角色", '/role/edit/'+id, 600, 400, function(s){
					doReset();
				});
			}
			function doDel(id){
		  		if(!window.confirm("你确定要删除该角色吗(删除后不可恢复)?")){
				    return;
				}
				$.post(
					'/role/del/'+id,
					function(s){
						//alert('操作成功!');
						doReset();
					}
				);
			}
		</script>
	</head>
	<body>
	  <div id="divSearch" class="divSearch">
		<table width="100%" border="0" cellpadding="2" cellspacing="1">
			<tr>
			  <td align="left" valign="middle"> 
	            角色名称
	            <input id="roleName" name="roleName" type="text"/>
				&nbsp;<button class="btn_2k3" onclick="doSearch()">查询</button>&nbsp;<button class="btn_2k3" onclick="doReset()">重置</button>
		      </td>
		  </tr>
		</table>
	  </div>
		<div style="padding-bottom:5px">
		  	<table width="100%" border="0" cellpadding="2" cellspacing="1">
				<tr>
				  	<td align="left">&nbsp;[&nbsp;角色列表&nbsp;]</td>
			  		<td align="right"><button class="btn_2k3" onclick="doEdit(0)" style="display:none;">新建</button>&nbsp;</td>
			  </tr>
			</table>
			<table id="pageList" width="100%" border="1" align="center" cellpadding="0" cellspacing="0" rules="cols" bordercolor="#9aadce" class="table">
				<thead>
					<tr class="head">
						<td width="10%">角色标识</td>
						<td width="30%">角色名称</td>
						<td>角色描述</td>
						<td width="8%">操作</td>
					</tr>
					<tr style="display: none;cursor='default';" onmouseover="doonmouseover(this)" onmouseout="doonmouseout(this, this.className)">
						<td></td>
						<td></td>
						<td></td>
						<td></td>
					</tr>
				</thead>
		
				<tbody>
				</tbody>
			</table>
		</div>
		<div id="ajaxpage-foot"></div>
		<script type="text/javascript">
			var ajaxPage = new $AjaxPage("pageList", "/ajaxpage/role", 20);
			ajaxPage.afterRow(function(rowIndex, row, datas){
				var roleId = datas.get("role_id");
				//row.cells[row.cells.length-1].innerHTML = "&nbsp;";
				//row.cells[row.cells.length-1].innerHTML = "<a href='#' onclick=\"doEdit("+roleId+")\">编辑</a>&nbsp;&nbsp;<a href='#' onclick=\"doDel("+roleId+")\">删除</a>";
				row.cells[row.cells.length-1].innerHTML = "<a href='#' onclick=\"doEdit("+roleId+")\">编辑</a>&nbsp;&nbsp;";
			});
			
			window.onload=function(){
				doSearch();
			}
			
			function doSearch(){
				ajaxPage.reset();
				ajaxPage.addQueryParams("roleName", $("#roleName").val());
				ajaxPage.execute(afterPage);
			}
			
			function doReset(){
				$("#roleName").val("");
				doSearch();
			}
			
			function doRefresh(){
				curSelectedRow = null;
				ajaxPage.refresh(afterPage);
			}
			
		</script>
		<script src="/resources/js/ajaxpage-foot.js" type="text/javascript"></script>
	</body>
</html>