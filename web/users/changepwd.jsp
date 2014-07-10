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
				<td class="popTitleMust filedName" width="12%">原密码:</td>
				<td class="popConent">
					<input type="password" name="oldpwd" value="" class="required">
				</td>
			</tr>
		    <tr>
				<td class="popTitleMust filedName" width="12%">新密码:</td>
				<td class="popConent">
					<input type="password" id="newpwd" name="newpwd" value="" class="required">
				</td>
			</tr>
		    <tr>
				<td class="popTitleMust filedName" width="12%">重输新密码:</td>
				<td class="popConent">
					<input type="password" id="renewpwd" name="renewpwd" value="" class="required">
				</td>
			</tr>
		</table>
    </form>
	</body>
<script type="text/javascript">
	function Ok(){
        if (!$('#form1').validate({
            rules:{
                oldpwd:{
                    required:true
                },
                newpwd:{
                    required:true
                },
                renewpwd:{
                    required:true
                }
            },
            messages:{
                oldpwd:"请输入旧密码",
                newpwd:"请输入新密码",
                renewpwd:"请重输新密码"
            }

        }).form()) {
            return;
        }


        if($('#newpwd').val() != $('#renewpwd').val()){
			alert("错误: 两次输入的新密码必须相同!");
			return;
		}
		$.post('/user/changepwd/save', $("form").serialize(), function(data){
            if (data.SUCCESS == "TRUE") {
                alert("密码修改成功");
                parent.JQueryXDialog.fnResult();
            } else {
                alert(data.MSG);
            }
		}, "json");
	}

</script>
</html>