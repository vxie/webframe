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
                showModalDlg((id ? "编辑" : "新建") + "推送信息", '<%= contextPath%>/pushinfo/edit/' + id, 600, 250, function (s) {
                    doReset();
                });
			}

            function doDel(id) {
                if (!window.confirm("你确定要删除该信息吗(删除后不可恢复)?")) {
                    return;
                }
                $.post('<%= contextPath%>/pushinfo/del/' + id, function (data) {
                            if (data.SUCCESS == "TRUE") {
                                alert("删除推送信息成功");
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
                  <td class="filedName">信息ID:</td>
                  <td><input id="p_id" class="paramIpt" name="id" type="text"/></td>
                  <td class="filedName">发布者ID:</td>
                  <td><input id="p_adminId" class="paramIpt" name="adminId" type="text"/></td>
                  <td class="filedName">信息内容:</td>
                  <td><input id="p_content" class="paramIpt" name="content" type="text"/></td>
              </tr>
          </table>
          <div class="button_div">
              <button class="btn_2k3" onclick="doSearch()">查 询</button>
              &nbsp;
              <button class="btn_2k3" onclick="doReset()">重 置</button>
              &nbsp;
              <button class="btn_2k3" onclick="doEdit(0)">新 建</button>
              &nbsp;
          </div>
      </div>
		<div style="padding-bottom:5px">
			<table id="pageList" width="100%" border="1" align="center" cellpadding="0" cellspacing="0" rules="cols" bordercolor="#9aadce" class="table">
				<thead>
					<tr class="head">
                        <td>信息ID</td>
                        <td>发布者ID</td>
                        <td>发布者名称</td>
                        <td>发布时间</td>
                        <td>信息内容</td>
						<td width="8%">操作</td>
					</tr>
					<tr style="display: none;cursor='default';" onmouseover="doonmouseover(this)" onmouseout="doonmouseout(this, this.className)">
						<td></td>
						<td></td>
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
			var ajaxPage = new $AjaxPage("pageList", "<%= contextPath%>/ajaxpage/pushinfo", 20);
            ajaxPage.afterRow(function (rowIndex, row, datas) {
                var pushinfoid = datas.get("id");
                row.cells[row.cells.length - 1].innerHTML = "<a href='javascript:void(0);' onclick=\"doEdit(" + pushinfoid + ");\">编辑</a>&nbsp;"
                       +  "<a href='javascript:void(0);' onclick=\"doDel(" + pushinfoid + ");\">删除</a>&nbsp;";
            });
			
			$(document).ready(function() {
				doSearch();
			});


            function doSearch() {
                ajaxPage.reset();
                $(".paramIpt").each(function () {
                    ajaxPage.addQueryParams($(this).attr("name"), $(this).val());
                });
                ajaxPage.execute(afterPage);
            }
			
			function doReset(){
				$(".paramIpt").val("");
				doSearch();
			}

			function doRefresh(){
				ajaxPage.refresh(afterPage);
			}

			
		</script>
		<script src="<%= contextPath%>/resources/js/ajaxpage-foot.js" type="text/javascript"></script>
	</body>
</html>