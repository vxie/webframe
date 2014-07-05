<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=UTF-8"%>
<html>
	<head>
		<link href="/resources/css/css.css" type="text/css" rel="stylesheet" />
  		<script src="/resources/js/jquery.min.js" type="text/javascript"></script>
  		<script src="/resources/js/validate/jquery.validate.js" type="text/javascript"></script>
	</head>
	<body>
	<form id="form1" method="post" action="#">
		<table width="100%" border="0" cellpadding="2" cellspacing="1">
		    <tr>
				<td class="popTitleMust" width="12%">原密码:</td>
				<td class="popConent">
					<input type="password" name="oldUserPwd" value="" class="required">
				</td>
			</tr>
		    <tr>
				<td class="popTitleMust" width="12%">新密码:</td>
				<td class="popConent">
					<input type="password" id="newUserPwd" name="newUserPwd" value="" class="required">
				</td>
			</tr>
		    <tr>
				<td class="popTitleMust" width="12%">重输新密码:</td>
				<td class="popConent">
					<input type="password" id="againNewUserPwd" name="againNewUserPwd" value="" class="required">
				</td>
			</tr>
		</table>
    </form>
	</body>
<script type="text/javascript">
	function Ok(){
		if(!$('#form1').validate().form()) return;
		if($('#newUserPwd').val() != $('#againNewUserPwd').val()){
			alert("错误: 两次输入的新密码必须相同!");
			return;
		}
		$.post('/user/changepwd/save', $("form").serialize(), function(s){
			if(s=="0"){
				alert("操作成功!");
			}else{
				alert("操作失败, 用户不存在!");
			}
			parent.JQueryXDialog.fnResult(s);
		});
	}

</script>
</html>