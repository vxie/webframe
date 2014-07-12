<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/common/head.inc" %>
<html>
	<head>
		<link href="<%= contextPath%>/resources/css/css.css" type="text/css" rel="stylesheet" />
		<script src="<%= contextPath%>/resources/js/ajaxpage-2.0.0.js" type="text/javascript"></script>
		<script src="<%= contextPath%>/resources/js/jquery.min.js" type="text/javascript"></script>
		<script src="<%= contextPath%>/resources/js/common.js" type="text/javascript"></script>
		<script type="text/javascript">
			function doEdit(id){
                showModalDlg((id ? "编辑" : "新建") + "用户", '<%= contextPath%>/user/edit/' + id, 600, 250, function (s) {
                    doReset();
                });
			}
			function doImport(){
				//showModalDlg("导入用户", '/user/import', 600, 400, function(s){doReset();}, null, '返 回');
				showModalDlg("导入用户", '<%= contextPath%>/common/import/user', 600, 120, function(s){doReset();});
			}

            function doDel(id) {
                if (!window.confirm("你确定要删除该用户吗(删除后不可恢复)?")) {
                    return;
                }
                $.post('<%= contextPath%>/user/del/' + id, function (data) {
                            if (data.SUCCESS == "TRUE") {
                                alert("删除用户成功");
                            } else {
                                alert(data.MSG);
                            }
                            doReset();
                        }, "json"
                );
            }
		</script>
	</head>
	<body>
	  <div id="divSearch" class="">
          <table class="paramTable" width="100%" border="1" cellpadding="0" cellspacing="0">
              <tr>
                  <td class="filedName">手机号码:</td>
                  <td><input id="p_number" name="number" type="text"/></td>
                  <td class="filedName">姓名:</td>
                  <td><input id="p_name" name="name" type="text"/></td>
                  <td class="filedName">地区:</td>
                  <td>
                      <select id="p_areaid" name="areaid">
                          <option value=""></option>
                          <option value="1">测试地区</option>
                      </select>
                  </td>
              </tr>
          </table>
          <div class="button_div">
              <button class="btn_2k3" onclick="doSearch()">查 询</button>
              &nbsp;
              <button class="btn_2k3" onclick="doReset()">重 置</button>
              &nbsp;
              <button class="btn_2k3" onclick="doEdit(0)">新 建</button>
              &nbsp;
              <button class="btn_2k3" onclick="doImport()">导入用户</button>
              &nbsp;
          </div>
      </div>
		<div style="padding-bottom:5px">
			<table id="pageList" width="100%" border="1" align="center" cellpadding="0" cellspacing="0" rules="cols" bordercolor="#9aadce" class="table">
				<thead>
					<tr class="head">
						<td>手机号码</td>
						<td>姓名</td>
						<td>地区</td>
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
			var ajaxPage = new $AjaxPage("pageList", "<%= contextPath%>/ajaxpage/user", 20);
            ajaxPage.afterRow(function (rowIndex, row, datas) {
                var userId = datas.get("id");
                row.cells[row.cells.length - 1].innerHTML = "<a href='javascript:void(0);' onclick=\"doEdit(" + userId + ")\">编辑</a>&nbsp;<a href='#' onclick=\"doDel(" + userId + ")\">删除</a>";
            });
			
			$(document).ready(function() {
				doSearch();
			});

			
			function doSearch(){
				ajaxPage.reset();
				ajaxPage.addQueryParams("number", $("#p_number").val());
				ajaxPage.addQueryParams("name", $("#p_name").val());
				ajaxPage.addQueryParams("areaid", $("#p_areaid").val());
				ajaxPage.execute(afterPage);
			}
			
			function doReset(){
				$("#p_number").val("");
				$("#p_name").val("");
				$("#p_areaid").val("");
				doSearch();
			}

			function doRefresh(){
				ajaxPage.refresh(afterPage);
			}

			
		</script>
		<script src="<%= contextPath%>/resources/js/ajaxpage-foot.js" type="text/javascript"></script>
	</body>
</html>