<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<html>
	<head>
		<link href="/resources/css/css.css" type="text/css" rel="stylesheet" />
  		<script src="/resources/js/jquery.min.js" type="text/javascript"></script>
  		<script src="/resources/js/validate/jquery.validate.js" type="text/javascript"></script>
        <script type="text/javascript">
            $(document).ready(function () {
               $("#p_areaid").val("${currUser.areaId}");
            });

            function Ok() {
                if (!$('#form1').validate({
                    rules:{
                        userRoles:{
                            required:true,
                            minlength:1
                        }
                    }
                }).form()) return;
                $.post('/user/edit/check', {userid:$("#p_userid").val(), number:$("#p_number").val()}, function (s) {
                    if (s == "0") {
                        $.post('/user/edit/save', $("form").serialize(), parent.JQueryXDialog.fnResult);
                    } else {
                        alert("错误:该手机号码已经存在!");
                        $("#p_number").focus();
                    }
                });
            }

        </script>
	</head>
	<body>
	<form id="form1" method="post" action="#">
		<input type="hidden" id="p_userid" name="id" value="${currUser.id}">
		<table width="100%" border="0" cellpadding="2" cellspacing="1">
            <tr>
                <td class="popTitleMust" width="12%">手机号码:</td>
                <td class="popConent">
                    <input type="text" id="p_number" name="number" value="${currUser.number}" class="required">
                </td>
            </tr>
		    <tr>
				<td class="popTitleMust" width="12%">姓名:</td>
				<td class="popConent">
					<input type="text" id="p_name" name="name" value="${currUser.name}" class="required">
				</td>
			</tr>
		    <tr>
				<td class="popTitleMust" width="12%">地区:</td>
				<td class="popConent">
					<select id="p_areaid" name="areaid">
                        <option value="1">测试地区</option>
					</select>
				</td>
			</tr>

		</table>
    </form>
	</body>
</html>