<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="mm" uri="http://tags.vxie.com" %>
<%@ include file="/common/head.inc" %>
<html>
	<head>
		<link href="<%= contextPath%>/resources/css/css.css" type="text/css" rel="stylesheet" />
  		<script src="<%= contextPath%>/resources/js/jquery.min.js" type="text/javascript"></script>
  		<script src="<%= contextPath%>/resources/js/validate/jquery.validate.js" type="text/javascript"></script>
        <script type="text/javascript">
            $(document).ready(function () {
               <%--$("#p_areaid").val("${currUser.areaId}");--%>
            });

            function Ok() {
                if (!$('#form1').validate({
                    rules:{
                        number:{
                            required:true
                        },
                        name: {
                            required:true
                        }
                    },
                    messages:{
                        number: "请输入手机号码",
                        name: "请输入姓名"
                    }

                }).form()) {
                    return;
                }
//                $.post('/user/edit/check', {userid:$("#p_userid").val(), number:$("#p_number").val()}, function (data) {
//                    if (data.SUCCESS == "TRUE") {
//                        doSave();
//                    } else {
//                        alert(data.MSG);
//                        $("#p_number").focus();
//                    }
//                }, "json");

                doSave();
            }

            function doSave() {
                $.post('<%= contextPath%>/user/edit/save', $("form").serialize(), function (data) {
                    if (data.SUCCESS == "TRUE") {
                        alert("用户信息保存成功");
                        parent.JQueryXDialog.fnResult(1);
                    } else {
                        alert(data.MSG);
                    }
                }, "json");
            }

        </script>
	</head>
	<body>
	<form id="form1" method="post" action="#">
		<input type="hidden" id="p_userid" name="id" value="${currUser.id}">
		<table width="100%" border="0" cellpadding="2" cellspacing="1">
            <tr>
                <td class="popTitleMust filedName" width="12%">手机号码:</td>
                <td class="popConent">
                    <input type="text" id="p_number" name="number" value="${currUser.number}" class="required"/>
                </td>
            </tr>
		    <tr>
				<td class="popTitleMust filedName" width="12%">姓名:</td>
				<td class="popConent">
					<input type="text" id="p_name" name="name" value="${currUser.name}" class="required"/>
				</td>
			</tr>
		    <tr>
				<td class="popTitleMust filedName" width="12%">地区:</td>
				<td class="popConent">
                    <mm:select id="p_areaid" name="areaid" cssClass="paramIpt" items="${areaList}"
                               valueProperty="id" displayProperty="name" currentValue="${currUser.areaId}"/>
				</td>
			</tr>

		</table>
    </form>
	</body>
</html>