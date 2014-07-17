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
                    groupId:{
                        required:true
                    },
                    userId:{
                        required:true
                    }
                },
                messages:{
                    groupId:"请输入会员组ID",
                    userId:"请输入会员ID"

                }
            }).form()) {
                return;
            }

            doSave();
        }

        function doSave() {
            $.post('<%= contextPath%>/plan/edit/save', $("form").serialize(), function (data) {
                if (data.SUCCESS == "TRUE") {
                    alert("饮食方案保存成功");
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
    <input type="hidden" id="p_infoid" name="id" value="${currPlan.id}">
    <table width="100%" border="0" cellpadding="2" cellspacing="1">
        <tr>
            <td class="popTitleMust filedName" width="12%">会员组ID:</td>
            <td class="popConent">
                <input type="text" id="p_groupId" name="groupId" value="${currPlan.groupId}" class="required"/>
            </td>
        </tr>
        <tr>
            <td class="popTitleMust filedName" width="12%">会员ID:</td>
            <td class="popConent">
                <input type="text" id="p_userId" name="userId" value="${currPlan.userId}" class="required"/>
            </td>
        </tr>
        <tr>
            <td class="popTitle filedName" width="12%">早餐搭配方案:</td>
            <td class="popConent">
                <input type="text" id="p_breakfast" name="breakfast" value="${currPlan.breakfast}"/>
            </td>
        </tr>
        <tr>
            <td class="popTitle filedName" width="12%">午餐搭配方案:</td>
            <td class="popConent">
                <input type="text" id="p_lunch" name="lunch" value="${currPlan.lunch}"/>
            </td>
        </tr>
        <tr>
            <td class="popTitle filedName" width="12%">晚餐搭配方案:</td>
            <td class="popConent">
                <input type="text" id="p_dinner" name="dinner" value="${currPlan.dinner}"/>
            </td>
        </tr>
        <tr>
            <td class="popTitle filedName" width="12%">预定发送时间:</td>
            <td class="popConent">
                <input type="text" id="p_sendTime" name="sendTime" value="<fmt:formatDate value="${currPlan.sendTime}" pattern="yyyy-MM-dd HH:mm:ss"/>"/>
            </td>
        </tr>
        <tr>
            <td class="popTitle filedName" width="12%">备注:</td>
            <td class="popConent">
                <input type="text" id="p_remarks" name="remarks" value="${currPlan.remarks}"/>
            </td>
        </tr>
    </table>
</form>
</body>
</html>