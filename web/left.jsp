<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/common/head.inc" %>
<html>
 <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
 <meta http-equiv="pragma" content="no-cache" />
 <title></title>
 <head>
	<style type="text/css">
	table {
		font-family: sans-serif; font-size:12px;
	}
	.menuMouseOver{
		color :blue;width:10pt;font-family: webdings;font-size:10pt;
	}
	</style>
 </head>
 <body>
 <table width="140" border="0" bgcolor="#9aadce">
  <tr>
    <td bgcolor="#FFFFFF">
        <table width="100%" border="0" cellpadding="4" cellspacing="1">
           <%--系统管理员菜单--%>
            <tr>
                <td colspan="2" bgcolor="#dbe3f7">系统管理</td>
            </tr>
            <tr onmouseover="this.cells[0].innerText='4'" onmouseout="doonmouseout(this)">
                <td class="menuMouseOver" id="firstRow">4</td>
                <td>
                    <a href="<%= contextPath%>/user/list" onclick="domenu(this.parentNode.parentNode)"
                       target="contentInfo">营养师管理</a>   <%--t_admin--%>
                </td>
            </tr>
            <tr onmouseover="this.cells[0].innerText='4'" onmouseout="doonmouseout(this)">
                <td class="menuMouseOver">&nbsp;</td>
                <td><a href="<%= contextPath%>/member/list" onclick="domenu(this.parentNode.parentNode)"
                       target="contentInfo">会员管理</a></td>  <%--t_user--%>
            </tr>
            <tr onmouseover="this.cells[0].innerText='4'" onmouseout="doonmouseout(this)">
                <td class="menuMouseOver">&nbsp;</td>
                <td><a href="<%= contextPath%>/group/list" onclick="domenu(this.parentNode.parentNode)"
                       target="contentInfo">会员组管理</a></td>  <%--t_group--%>
            </tr>
            <tr onmouseover="this.cells[0].innerText='4'" onmouseout="doonmouseout(this)">
                <td class="menuMouseOver">&nbsp;</td>
                <td><a href="<%= contextPath%>/area/list" onclick="domenu(this.parentNode.parentNode)"
                       target="contentInfo">地区管理</a></td>   <%--t_area--%>
            </tr>
            <tr onmouseover="this.cells[0].innerText='4'" onmouseout="doonmouseout(this)">
                <td class="menuMouseOver">&nbsp;</td>
                <td><a href="<%= contextPath%>/branch/list" onclick="domenu(this.parentNode.parentNode)"
                       target="contentInfo">分店管理</a></td>  <%--t_branch--%>
            </tr>
            <tr onmouseover="this.cells[0].innerText='4'" onmouseout="doonmouseout(this)">
                <td class="menuMouseOver">&nbsp;</td>
                <td><a href="<%= contextPath%>/space/list" onclick="domenu(this.parentNode.parentNode)"
                       target="contentInfo">发布信息管理</a></td>  <%--t_space--%>
            </tr>
            <tr onmouseover="this.cells[0].innerText='4'" onmouseout="doonmouseout(this)">
                <td class="menuMouseOver">&nbsp;</td>
                <td><a href="<%= contextPath%>/pushinfo/list" onclick="domenu(this.parentNode.parentNode)"
                       target="contentInfo">推送信息管理</a></td> <%--t_pushInfo--%>
            </tr>
            <tr onmouseover="this.cells[0].innerText='4'" onmouseout="doonmouseout(this)">
                <td class="menuMouseOver">&nbsp;</td>
                <td><a href="<%= contextPath%>/layout/list" onclick="domenu(this.parentNode.parentNode)"
                       target="contentInfo">主界面管理</a></td>  <%--t_layout--%>
            </tr>

            <%--营养师菜单--%>
            <tr>
                <td colspan="2" bgcolor="#dbe3f7">饮食计划</td>  <%--t_plan--%>
            </tr>
            <tr onmouseover="this.cells[0].innerText='4'" onmouseout="doonmouseout(this)">
                <td class="menuMouseOver">&nbsp;</td>
                <td><a href="javascript:alert('方案管理');" onclick="domenu(this.parentNode.parentNode)"
                       target="contentInfo">方案管理</a></td>
            </tr>
            <tr onmouseover="this.cells[0].innerText='4'" onmouseout="doonmouseout(this)">
                <td class="menuMouseOver">&nbsp;</td>
                <td><a href="javascript:alert('制定计划');" onclick="domenu(this.parentNode.parentNode)"
                       target="contentInfo">制定计划</a></td>
            </tr>


        </table>
        <table width="100%" border="0" cellpadding="4" cellspacing="1">
            <tr>
                <td colspan="2" bgcolor="#dbe3f7">参考菜单</td>
            </tr>

            <tr onmouseover="this.cells[0].innerText='4'" onmouseout="doonmouseout(this)">
                <td class="menuMouseOver">4</td>
                <td>
                    <a href="<%= contextPath%>/role/list" onclick="domenu(this.parentNode.parentNode)"
                       target="contentInfo">角色管理</a>
                </td>
            </tr>

        </table>

    </td>
  </tr>
</table>

<script type="text/javascript">
    var curRow = document.getElementById("firstRow").parentNode;
    function domenu(row) {
        var prevRow = curRow;
        curRow = row;
        prevRow.cells[0].innerHTML = "&nbsp;";
    }
    function doonmouseout(row) {
        row.cells[0].innerHTML = row == curRow ? "4" : "&nbsp;";
    }

</script>
</body>
</html>
