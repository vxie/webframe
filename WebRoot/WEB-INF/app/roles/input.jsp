<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<html>
	<head>
		<link href="/resources/css/css.css" type="text/css" rel="stylesheet" />
  		<script src="/resources/js/jquery.min.js" type="text/javascript"></script>
  		<script src="/resources/js/jquery.metadata.js" type="text/javascript"></script>
  		<script src="/resources/js/validate/jquery.validate.js" type="text/javascript"></script>
	</head>
	<body>
	<form id="form1" method="post" action="#">
		<table width="100%" border="0" cellpadding="2" cellspacing="1">
		    <tr>
				<td class="popTitleMust" width="12%">角色标识:</td>
				<td class="popConent">
					<input type="text" name="roleId" value="${cutRole.roleId}" class="{required:true, digits:true}">
				</td>
			</tr>
		    <tr>
				<td class="popTitleMust" width="12%">角色名称:</td>
				<td class="popConent">
					<input type="text" name="roleName" value="${cutRole.roleName}" class="required">
				</td>
			</tr>
		    <tr>
				<td class="popTitle" width="12%">角色描述:</td>
				<td class="popConent">
					<input type="text" name="roleMemo" value="${cutRole.roleMemo}">
				</td>
			</tr>
		    <tr valign="top" width="100%">
				<td class="popTitleMust" width="12%">角色菜单:</td>
				<td>
				 <table width="100%" border="0" bgcolor="#9aadce">
				  <tr>
				    <td bgcolor="#FFFFFF">
				    <table width="100%" border="0" cellpadding="4" cellspacing="1">
				      <tr>
				      	<td colspan="2" bgcolor="#dbe3f7">首页</td>
				      </tr>
				    <c:forEach var="m" varStatus="idx" items="${menus}">
				      <c:if test="${m.menuUrl == null}">
				    	</table>
				    	<table width="100%" border="0" cellpadding="4" cellspacing="1">
				      	<tr>
					        <td colspan="2" bgcolor="#dbe3f7">${m.menuName}</td>
				      	</tr>
				      </c:if>
				      <c:if test="${m.menuUrl != null}">
				      	  <tr>
				      	  	<td>&nbsp;</td>
					        <td>
					        	<label for="menu_${idx.count+1}"><input type="checkbox" name="roleMenus" id="menu_${idx.count+1}" class="chkInput" value="${m.menuId}" <c:if test="${m.menuOthers > '0'}">checked='true'</c:if>/>${m.menuName}</label>
					        </td>
					      </tr>
				      </c:if>
				     </c:forEach>
				    </td>
				  </tr>
				</table>
				<label for="roleMenus" class="error" style="display:none;">Please select at least one menu.</label>
				</td>
			</tr>
		</table>
    </form>
	</body>
<script type="text/javascript">
	function Ok(){
		if(!$('#form1').validate({
			rules: {
				roleMenus: {
					required: true,
					minlength: 1
				}
			}
		}).form()) return;
		$.post('/role/edit/save', $("form").serialize(), parent.JQueryXDialog.fnResult);
	}

</script>
</html>