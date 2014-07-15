<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/common/head.inc" %>
<html>
	<head>
		<link href="<%= contextPath%>/resources/css/css.css" type="text/css" rel="stylesheet" />
  		<script src="<%= contextPath%>/resources/js/jquery.min.js" type="text/javascript"></script>
  		<script src="<%= contextPath%>/resources/js/validate/jquery.validate.js" type="text/javascript"></script>
        <%--<script src="<%= contextPath%>/resources/js/DatePicker/WdatePicker.js" type="text/javascript"></script>--%>
        <script type="text/javascript">
            $(document).ready(function () {

            });

            function Ok() {
                if (!$('#form1').validate({
                    rules:{
                        name:{
                            required:true
                        },
                        headId: {
                            required:true
                        }
                    },
                    messages:{
                        name:"请输入分组名称",
                        headId:"请输入饮食搭配负责人ID"
                    }
                }).form()) {
                    return;
                }

                doSave();
            }

            function doSave() {
                $.post('<%= contextPath%>/group/edit/save', $("form").serialize(), function (data) {
                    if (data.SUCCESS == "TRUE") {
                        alert("分组信息保存成功");
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
		<input type="hidden" id="p_groupid" name="id" value="${currGroup.id}">
		<table width="100%" border="0" cellpadding="2" cellspacing="1">
            <tr>
                <td class="popTitleMust filedName" width="12%">分组名称:</td>
                <td class="popConent">
                    <input type="text" id="p_name" name="name" value="${currGroup.name}" class="required"/>
                </td>
            </tr>
            <tr>
                <td class="popTitleMust filedName" width="12%">饮食搭配负责人:</td>
                <td class="popConent">
                    <input type="text" id="p_headId" name="headId" value="${currGroup.headId}" class="required"/>
                </td>
            </tr>
		</table>
    </form>
	</body>
</html>