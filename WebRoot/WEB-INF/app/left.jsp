<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
 <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
 <meta http-equiv="pragma" content="no-cache" />
 <title></title>
 <head>
	<style type="text/css">
	table {
		font-family: sans-serif; font-size:12px;
	}
	.menuMouseOver{
		color :blue;width:10pt;font-family: webdings;font-size:10pt;
	}
	</style>
 </head>
 <body>
 <table width="140" border="0" bgcolor="#9aadce">
  <tr>
    <td bgcolor="#FFFFFF">
    <table width="100%" border="0" cellpadding="4" cellspacing="1">
      <tr>
        <td colspan="2" bgcolor="#dbe3f7">首页(${cutUser.userRealName})</td>
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
      	  <tr onmouseover="this.cells[0].innerText='4'" onmouseout="doonmouseout(this)">
      	  <c:if test="${idx.count == 1}">
      	  	<td class="menuMouseOver" id="firstRow">4</td>
      	  </c:if>
      	  <c:if test="${idx.count != 1}">
      	  	<td class="menuMouseOver">&nbsp;</td>
      	  </c:if>
	        <td><a href="${m.menuUrl}" onclick="domenu(this.parentNode.parentNode)" target="contentInfo">${m.menuName}</a></td>
	      </tr>
      </c:if>
     </c:forEach>
    </td>
  </tr>
</table>

<script type="text/javascript">
	var curRow = document.getElementById("firstRow").parentNode;
	function domenu(row){
		var prevRow = curRow;
		curRow = row;
		prevRow.cells[0].innerHTML = "&nbsp;";
	}
	function doonmouseout(row){
		row.cells[0].innerHTML= row==curRow?"4":"&nbsp;";
	}

</script>
</body>
</html>
