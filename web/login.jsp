<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/common/head.inc" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="pragma" content="no-cache" />
<title>WEBFRAME</title>
<style type="text/css">
<!--
body {
    margin: 0;
    padding: 0;
    width: 100%;
    height: 100%;
    overflow: hidden;
}

td {
    font: Arial, Helvetica, sans-serif;
    font-size: 12px
}

.divlogin {
    width: 100%;
    height: 539px;
    background: url(<%= contextPath%>/resources/images/login.jpg) no-repeat top left;
}

.input {
    border: #7da5c9 solid 1px;
}
-->
</style>
</head>
<body scroll="no">
<!--内容 -->
<div class="divlogin">
<form name="loginForm" id="loginForm" action="<%= contextPath%>/login" method="post">
	<table width="100%" border="0" cellpadding="2" cellspacing="1" class="query01">
		<tr>
		  <td height="170" colspan="3" align="left"  class="query01_td_text">&nbsp;</td>
      </tr>
		<tr >
		  <td width="439" align="left"  class="query01_td_text">&nbsp;</td>
	      <td width="50" align="left"  class="query01_td_text"><div align="right">帐号</div></td>
	      <td align="left"  class="query01_td_text">
              <input name="number" type="text" class="input" style="width:150px;"/>
          </td>
		</tr>
		<tr>
		  <td align="left"  class="query01_td_text"><label></label></td>
	      <td align="left"  class="query01_td_text"><div align="right">密码</div></td>
	      <td align="left"  class="query01_td_text">
              <input name="password" type="password" class="input" style="width:150px;"/>
          </td>
	  </tr>
		<tr >
		  <td colspan="2" align="left">&nbsp;</td>
		  <td align="left"><input type="image" id="loginSubmit" name="loginSubmit" value="提交" src="<%= contextPath%>/resources/images/login_go.gif" /></td>
	  </tr>
		<tr >
		  <td colspan="2" align="left">&nbsp;</td>
		  <td align="left" style="color:red;">${errorInfo}</td>
	  </tr>
		<tr >
		  <td colspan="2" align="left">&nbsp;</td>
		  <td align="left">&nbsp;</td>
	  </tr>
		<tr >
		  <td colspan="2" align="left">&nbsp;</td>
		  <td align="left">&nbsp;</td>
	  </tr>
	</table>
</form>
</div>
<script type="text/javascript">
	document.getElementById("loginSubmit").focus();
</script>
</body>
</html>