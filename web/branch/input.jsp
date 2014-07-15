<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/common/head.inc" %>
<html>
<head>
    <link href="<%= contextPath%>/resources/css/css.css" type="text/css" rel="stylesheet"/>
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
                    }
                },
                messages:{
                    name:"请输入分店名称"
                }
            }).form()) {
                return;
            }

            doSave();
        }

        function doSave() {
            $.post('<%= contextPath%>/branch/edit/save', $("form").serialize(), function (data) {
                if (data.SUCCESS == "TRUE") {
                    alert("分店信息保存成功");
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
    <input type="hidden" id="p_branchid" name="id" value="${currBranch.id}">
    <table width="100%" border="0" cellpadding="2" cellspacing="1">
        <tr>
            <td class="popTitleMust filedName" width="12%">分店名称:</td>
            <td class="popConent">
                <input type="text" id="p_name" name="name" value="${currBranch.name}" class="required"/>
            </td>
        </tr>
        <tr>
            <td class="popTitle filedName" width="12%">分店地址:</td>
            <td class="popConent">
                <input type="text" id="p_address" name="address" value="${currBranch.address}"/>
            </td>
        </tr>
        <tr>
            <td class="popTitle filedName" width="12%">地理经度:</td>
            <td class="popConent">
                <input type="text" id="p_longitude" name="longitude" value="${currBranch.longitude}"/>
            </td>
        </tr>
        <tr>
            <td class="popTitle filedName" width="12%">地理纬度:</td>
            <td class="popConent">
                <input type="text" id="p_latitude" name="latitude" value="${currBranch.latitude}"/>
            </td>
        </tr>
    </table>
</form>
</body>
</html>