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
                $("#p_areaid").val("${currMember.areaId}");
            });

            function Ok() {
                if (!$('#form1').validate({
                    rules:{
                        name: {
                            required:true
                        }
                    },
                    messages:{
                        name: "请输入姓名"
                    }
                }).form()) {
                    return;
                }

                doSave();
            }

            function doSave() {
                $.post('/member/edit/save', $("form").serialize(), function (data) {
                    if (data.SUCCESS == "TRUE") {
                        alert("会员信息保存成功");
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
		<input type="hidden" id="p_userid" name="id" value="${currMember.id}">
		<table width="100%" border="0" cellpadding="2" cellspacing="1">
            <tr>
                <td class="popTitleMust filedName" width="12%">会员名:</td>
                <td class="popConent">
                    <input type="text" id="p_name" name="name" value="${currMember.name}" class="required">
                </td>
            </tr>
            <tr>
                <td class="popTitle filedName" width="12%">联系电话:</td>
                <td class="popConent">
                    <input type="text" id="p_phoneNumber" name="phoneNumber" value="${currMember.phoneNumber}">
                </td>
            </tr>
            <tr>
                <td class="popTitle filedName" width="12%">病历ID:</td>
                <td class="popConent">
                    <input type="text" id="p_medicalRecordId" name="medicalRecordId" value="${currMember.phoneNumber}">
                </td>
            </tr>
            <tr>
                <td class="popTitle filedName" width="12%">地址:</td>
                <td class="popConent">
                    <input type="text" id="p_address" name="address" value="${currMember.address}">
                </td>
            </tr>
            <tr>
                <td class="popTitle filedName" width="12%">分组ID:</td>
                <td class="popConent">
                    <input type="text" id="p_groupId" name="groupId" value="${currMember.groupId}">
                </td>
            </tr>
            <tr>
                <td class="popTitle filedName" width="12%">年龄:</td>
                <td class="popConent">
                    <input type="text" id="p_age" name="age" value="${currMember.age}">
                </td>
            </tr>
            <tr>
                <td class="popTitle filedName" width="12%">密码:</td>
                <td class="popConent">
                    <input type="text" id="p_password" name="password" value="${currMember.password}">
                </td>
            </tr>
            <tr>
                <td class="popTitle filedName" width="12%">注册时间:</td>
                <td class="popConent">
                    <input type="text" id="p_time" name="time" value="${currMember.time}">
                </td>
            </tr>
            <tr>
                <td class="popTitle filedName" width="12%">生日:</td>
                <td class="popConent">
                    <input type="text" id="p_brithday" name="brithday" value="${currMember.brithday}">
                </td>
            </tr>
		    <tr>
				<td class="popTitle filedName" width="12%">地区:</td>
				<td class="popConent">
					<select id="p_areaid" name="areaId">
                        <option value="1">测试地区</option>
					</select>
				</td>
			</tr>
            <tr>
                <td class="popTitle filedName" width="12%">病历附件:</td>
                <td class="popConent">
                    <input type="text" id="p_filename" name="filename" value="${currMember.filename}">
                </td>
            </tr>
		</table>
    </form>
	</body>
</html>