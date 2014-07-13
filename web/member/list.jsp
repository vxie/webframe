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
                showModalDlg((id ? "编辑" : "新建") + "会员", '<%= contextPath%>/member/edit/' + id, 600, 350, function (s) {
                    doReset();
                });
			}
			function doImport(){
				showModalDlg("导入用户", '<%= contextPath%>/common/import/user', 600, 300, function(s){doReset();});
			}

            function doDel(id) {
                if (!window.confirm("你确定要删除该会员吗(删除后不可恢复)?")) {
                    return;
                }
                $.post('<%= contextPath%>/member/del/' + id, function (data) {
                            if (data.SUCCESS == "TRUE") {
                                alert("删除会员成功");
                            } else {
                                alert(data.MSG);
                            }
                            doReset();
                        }, "json"
                );
            }

            function viewScore(id) {
                alert("查看评分");
            }

            function viewSeedback(id) {
                alert("查看反馈");
            }

            function viewAssessment(id) {
                alert("考核");
            }

		</script>
	</head>
	<body>
	  <div id="divSearch" class="">
          <table class="paramTable" width="100%" border="1" cellpadding="0" cellspacing="0">
              <tr>
                  <td class="filedName">会员名:</td>
                  <td><input id="p_name" class="paramIpt" name="name" type="text"/></td>
                  <td class="filedName">联系电话:</td>
                  <td><input id="p_phoneNumber" class="paramIpt" name="phoneNumber" type="text"/></td>
                  <td class="filedName">病历ID:</td>
                  <td><input id="p_medicalRecordId" class="paramIpt" name="medicalRecordId" type="text"/></td>
              </tr>
              <tr>
                  <td class="filedName">分组ID:</td>
                  <td><input id="p_groupId" class="paramIpt" name="groupId" type="text"/></td>
                  <td class="filedName">地区:</td>
                  <td>
                      <select id="p_areaId" class="paramIpt" name="areaId">
                          <option value=""></option>
                          <option value="1">测试地区</option>
                      </select>
                  </td>
                  <td class="filedName">地址:</td>
                  <td><input id="p_address" class="paramIpt" name="address" type="text"/></td>
              </tr>
          </table>
          <div class="button_div">
              <button class="btn_2k3" onclick="doSearch()">查 询</button>
              &nbsp;
              <button class="btn_2k3" onclick="doReset()">重 置</button>
              &nbsp;
              <button class="btn_2k3" onclick="doEdit(0)">新 建</button>
              &nbsp;
              <button class="btn_2k3" onclick="doImport()">导入会员</button>
              &nbsp;
          </div>
      </div>
		<div style="padding-bottom:5px">
			<table id="pageList" width="100%" border="1" align="center" cellpadding="0" cellspacing="0" rules="cols" bordercolor="#9aadce" class="table">
				<thead>
					<tr class="head">
                        <td>会员名</td>
                        <td>联系电话</td>
						<td>病历ID</td>
						<td>地址</td>
						<td>分组ID</td>
						<td>年龄</td>
						<td>注册时间</td>
						<td>生日</td>
						<td>地区</td>
						<td>病历附件</td>
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
			var ajaxPage = new $AjaxPage("pageList", "<%= contextPath%>/ajaxpage/member", 20);
            ajaxPage.afterRow(function (rowIndex, row, datas) {
                var userId = datas.get("id");
                row.cells[row.cells.length - 1].innerHTML = "<a href='javascript:void(0);' onclick=\"doEdit(" + userId + ");\">编辑</a>&nbsp;"
                       +  "<a href='javascript:void(0);' onclick=\"doDel(" + userId + ");\">删除</a>&nbsp;"
                       +  "<a href='javascript:void(0);' onclick=\"doDel(" + userId + ");\">考核</a>&nbsp;"
                       +  "<a href='javascript:void(0);' onclick=\"viewScore(" + userId + ");\">查看评分</a>&nbsp;"
                       +  "<a href='javascript:void(0);' onclick=\"viewSeedback(" + userId + ");\">查看反馈</a>&nbsp;";
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