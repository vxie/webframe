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
//            if (!$('#form1').validate({
//                rules:{
//                    name:{
//                        required:true
//                    }
//                },
//                messages:{
//                    name:"请输入分店名称"
//                }
//            }).form()) {
//                return;
//            }

            doSave();
        }

        function doSave() {
            $.post('<%= contextPath%>/layout/edit/save', $("form").serialize(), function (data) {
                if (data.SUCCESS == "TRUE") {
                    alert("主界面保存成功");
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
    <input type="hidden" id="p_layoutid" name="id" value="${currLayout.id}"/>
    <table width="100%" border="0" cellpadding="2" cellspacing="1">
        <tr>
            <td class="popTitleMust filedName" width="12%">文字内容:</td>
            <td class="popConent">
                <input type="text" id="p_textContent" name="textContent" value="${currLayout.textContent}"/>
            </td>
        </tr>
        <tr>
            <td class="popTitle filedName" width="12%">图片名称:</td>
            <td class="popConent">
                <input type="text" id="p_picName" name="picName" value="${currLayout.picName}"/>
            </td>
        </tr>
        <tr>
            <td class="popTitle filedName" width="12%">是否显示:</td>
            <td class="popConent">
                <select id="p_useing" name="useing">
                    <option value="0">显示</option>
                    <option value="1" ${currLayout.useing == 1 ? 'checked' : ''}>不显示</option>
                </select>
            </td>
        </tr>
        <tr>
            <td class="popTitle filedName" width="12%">显示的序号:</td>
            <td class="popConent">
                <input type="text" id="p_disorder" name="disorder" value="${currLayout.disorder}"/>
            </td>
        </tr>
        <tr>
            <td class="popTitle filedName" width="12%">图片上传时间:<br/>(格式如:2014-07-19 17:31:38)</td>
            <td class="popConent">
                <input type="text" id="p_updatetime" name="updatetime" value="<fmt:formatDate value="${currLayout.updatetime}" pattern="yyyy-MM-dd HH:mm:ss"/>"/>
            </td>
        </tr>
    </table>
</form>
</body>
</html>