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
            function doDel(id) {
                if (!window.confirm("你确定要删除该考核记录吗(删除后不可恢复)?")) {
                    return;
                }
                $.post('<%= contextPath%>/assessment/del/' + id, function (data) {
                            if (data.SUCCESS == "TRUE") {
                                alert("删除成功");
                            } else {
                                alert(data.MSG);
                            }
                            doSearch();
                        }, "json"
                );
            }

            function doAssessment() {
                var serialize = "level=" + $("#p_level").val() + "&adminId=${adminId}";
                $.post('<%= contextPath%>/assessment/edit/save', serialize, function (data) {
                    if (data.SUCCESS == "TRUE") {
                        alert("考核成功");
                        doSearch();
                    } else {
                        alert(data.MSG);
                    }
                }, "json");
            }


		</script>
	</head>
	<body>
	  <div id="divSearch" class="">
          <table class="paramTable" width="100%" border="1" cellpadding="0" cellspacing="0">
              <tr>
                  <td class="filedName">评分级别</td>
                  <td>
                      <select id="p_level" name="level">
                          <option value="0">优</option>
                          <option value="1">良</option>
                          <option value="2">差</option>
                      </select>
                  </td>
                  <td>
                      <button class="btn_2k3" style="text-align:left;" onclick="doAssessment()">新增考核</button>
                  </td>
              </tr>
          </table>
          <div class="button_div"></div>
      </div>
		<div style="padding-bottom:5px">
			<table id="pageList" width="100%" border="1" align="center" cellpadding="0" cellspacing="0" rules="cols" bordercolor="#9aadce" class="table">
				<thead>
					<tr class="head">
                        <td>考核时间</td>
                        <td>评分级别</td>
						<td width="5%">操作</td>
					</tr>
					<tr style="display: none;cursor='default';" onmouseover="doonmouseover(this)" onmouseout="doonmouseout(this, this.className)">
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
			var ajaxPage = new $AjaxPage("pageList", "<%= contextPath%>/ajaxpage/assessment/${adminId}", 20);
            ajaxPage.afterRow(function (rowIndex, row, datas) {
                var assid = datas.get("id");
                row.cells[row.cells.length - 1].innerHTML =  "<a href='javascript:void(0);' onclick=\"doDel(" + assid + ");\">删除</a>&nbsp;";
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


			function doRefresh(){
				ajaxPage.refresh(afterPage);
			}

			
		</script>
		<script src="<%= contextPath%>/resources/js/ajaxpage-foot.js" type="text/javascript"></script>
	</body>
</html>