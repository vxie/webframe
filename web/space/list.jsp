<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/common/head.inc" %>
<html>
	<head>
		<link href="<%= contextPath%>/resources/css/css.css" type="text/css" rel="stylesheet" />
		<script src="<%= contextPath%>/resources/js/pagement.js" type="text/javascript"></script>
		<script src="<%= contextPath%>/resources/js/jquery.min.js" type="text/javascript"></script>
		<script src="<%= contextPath%>/resources/js/common.js" type="text/javascript"></script>
		<script type="text/javascript">

            function doDel(id) {
                if (!window.confirm("你确定要删除该信息吗(删除后不可恢复)?")) {
                    return;
                }
                $.post('<%= contextPath%>/space/del/' + id, function (data) {
                            if (data.SUCCESS == "TRUE") {
                                alert("删除信息成功");
                            } else {
                                alert(data.MSG);
                            }
                            doReset();
                        }, "json"
                );
            }

            function doPass(id) {
                $.post('<%= contextPath%>/space/pass/' + id, function (data) {
                            if (data.SUCCESS == "TRUE") {
//                                alert("审核成功");
                            } else {
                                alert(data.MSG);
                            }
                            doReset();
                        }, "json"
                );
            }

            function doReject(id) {
                $.post('<%= contextPath%>/space/reject/' + id, function (data) {
                            if (data.SUCCESS == "TRUE") {
//                                alert("审核成功");
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
                  <td class="filedName">作者ID:</td>
                  <td><input id="p_userId" class="paramIpt" name="userId" type="text"/></td>
                  <td class="filedName">文字内容:</td>
                  <td><input id="p_content" class="paramIpt" name="content" type="text"/></td>
              </tr>
          </table>
          <div class="button_div">
              <button class="btn_2k3" onclick="doSearch()">查 询</button>
              &nbsp;
              <button class="btn_2k3" onclick="doReset()">重 置</button>
              &nbsp;
          </div>
      </div>
		<div style="padding-bottom:5px">
			<table id="pageList" width="100%" border="1" align="center" cellpadding="0" cellspacing="0" rules="cols" bordercolor="#9aadce" class="table">
				<thead>
					<tr class="head">
                        <td>信息ID</td>
                        <td>作者ID</td>
                        <td>作者名称</td>
                        <td>图片名称</td>
                        <td>发布时间</td>
                        <td>文字内容</td>
                        <td>审核状态</td>
						<td width="8%">操作</td>
					</tr>
					<tr style="display: none;cursor='default';" onmouseover="doonmouseover(this)" onmouseout="doonmouseout(this, this.className)">
						<td></td>
						<td></td>
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
			var ajaxPage = new $AjaxPage("pageList", "<%= contextPath%>/ajaxpage/space", 20);
            ajaxPage.afterRow(function (rowIndex, row, datas) {
                var spaceid = datas.get("id");
                var state = datas.get("state");
                var opcontent = "通过&nbsp;驳回&nbsp;";
                if (state == "未审核") {
                    opcontent = "<a href='javascript:void(0);' onclick=\"doPass(" + spaceid + ");\">通过</a>&nbsp;"
                            +  "<a href='javascript:void(0);' onclick=\"doReject(" + spaceid + ");\">驳回</a>&nbsp;";
                }
                row.cells[row.cells.length - 1].innerHTML = opcontent +  "<a href='javascript:void(0);' onclick=\"doDel(" + spaceid + ");\">删除</a>&nbsp;";
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
		<script src="<%= contextPath%>/resources/js/pagement-foot.js" type="text/javascript"></script>
	</body>
</html>