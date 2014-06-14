<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<html>
	<head>
		<link href="/resources/css/css.css" type="text/css" rel="stylesheet" />
  		<script src="/resources/js/jquery.min.js" type="text/javascript"></script>
  		<script src="/resources/js/jquery.metadata.js" type="text/javascript"></script>
  		<script src="/resources/js/validate/jquery.validate.js" type="text/javascript"></script>
  		<script src="/resources/js/cal/jquery.cal.js" type="text/javascript"></script>
	</head>
	<body>
		<form name="form1" id="form1" method="post" action="" class="inputTable">
			<input type="hidden" name="cutInfoId" value="${baseInfo.cutInfoId}">
			<table width="100%" border="0" cellpadding="2" cellspacing="1">
			    <tr>
					<td class="popTitleMust" width="12%">割接主标题:</td>
					<td class="popConent">
						<input type="text" id="cutTitle" name="cutTitle" value="${baseInfo.cutTitle}" class="required">
					</td>
				</tr>
			    <tr>
					<td class="popTitleMust" width="12%">割接总协调人:</td>
					<td class="popConent">
					<select id="cutManagerId" name="cutManagerId" class="required" disabled="true">
		              <c:forEach var="e" items="${cutOwners}">
		                <option value="${e.key}" <c:if test="${baseInfo.cutManagerId==e.key}">selected</c:if>>${e.value}</option>
		              </c:forEach>
		            </select>
					</td>
				</tr>
			    <tr>
					<td class="popTitleMust" width="12%">割接开始时间:</td>
					<td class="popConent">
						<input type="text" id="cutBeginTime" name="cutBeginTime" value="${baseInfo.cutBeginTime}" class="required">
					</td>
				</tr>
                <tr>
					<td class="popTitleMust" width="12%">计划时长:</td>
					<td class="popConent">
						<input type="text" id="cutDuration" name="cutDuration" value="${baseInfo.cutDuration}" class="required">
					</td>
				</tr>
			</table>
		</form>
		<div class="popBtnTools">
			<button class="btn_2k3" onclick="doEdit()">编辑</button>
			&nbsp;
			<button class="btn_2k3" onclick="doSave()">保存</button>
		</div>
	</body>
<script type="text/javascript">
	$(document).ready(function () {
		$('#cutBeginTime').simpleDatepicker();
		disabledAll(true);
		$('#cutTitle').focus();
	});
	
	function disabledAll(b){
		$("input").each(function(i){
			if(this.type!="hidden"){
				this.disabled = b;
			}
		});
		$('#cutManagerId').get(0).disabled = b;
	}
	
	function doEdit(){
		disabledAll(false);
	}

	function doSave(){
		if(!$('#form1').validate().form()) return;
		$.post('/baseinfo/save', $("form").serialize(), function(s){
			alert("操作成功!");
			disabledAll(true);
		});
	}

</script>
</html>