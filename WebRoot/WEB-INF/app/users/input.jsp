<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<html>
	<head>
		<link href="/resources/css/css.css" type="text/css" rel="stylesheet" />
  		<script src="/resources/js/jquery.min.js" type="text/javascript"></script>
  		<script src="/resources/js/validate/jquery.validate.js" type="text/javascript"></script>
	</head>
	<body>
	<form id="form1" method="post" action="#">
		<input type="hidden" id="userId" name="userId" value="${oneCutUser.userId}">
		<table width="100%" border="0" cellpadding="2" cellspacing="1">
		    <tr>
				<td class="popTitleMust" width="12%">用户名称:</td>
				<td class="popConent">
					<input type="text" id="userRealName" name="userRealName" value="${oneCutUser.userRealName}" class="required">
				</td>
			</tr>
		    <tr>
				<td class="popTitleMust" width="12%">登录账号:</td>
				<td class="popConent">
					<input type="text" id="userLoginName" name="userLoginName" value="${oneCutUser.userLoginName}" class="required">
				</td>
			</tr>
		    <tr>
				<td class="popTitle" width="12%">用户信息:</td>
				<td class="popConent">
					<textarea rows="10" cols="60" name="userMemo">${oneCutUser.userMemo}</textarea>
				</td>
			</tr>
		    <tr>
				<td class="popTitleMust" width="12%">用户角色:</td>
				<td>
					<table width="100%" height="50%" border="0" cellpadding="2" cellspacing="1">
						<c:forEach var="e" items="${roles}">
						<tr><td>
							<label for="role_${e.key}"><input type="checkbox" name="userRoles" id="role_${e.key}" class="chkInput" value="${e.key}"  <c:if test="${e.value[1] > '0'}">checked='true'</c:if>/>${e.value[0]}</label>
						</td></tr>
						</c:forEach>
					</table>
					<label for="userRoles" class="error" style="display:none;">Please select at least one role.</label>
				</td>
			</tr>
		</table>
    </form>
	</body>
<script type="text/javascript">
	function Ok(){
		if(!$('#form1').validate({
			rules: {
				userRoles: {
					required: true,
					minlength: 1
				}
			}
		}).form()) return;
		
		$.post('/user/edit/check', {userId: $("#userId").val(),userLoginName:$("#userLoginName").val()}, function(s){
			if(s=="0"){
				$.post('/user/edit/save', $("form").serialize(), parent.JQueryXDialog.fnResult);
			}else{
				alert("错误: 该用户登录名称已经存在!");
				$("#userLoginName").focus();
			}
		});
	}

</script>
</html>