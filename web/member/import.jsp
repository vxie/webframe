<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ include file="/common/head.inc" %>
<html>
	<head>
		<link href="<%= contextPath%>/resources/css/css.css" type="text/css" rel="stylesheet" />
  		<script src="<%= contextPath%>/resources/js/jquery.min.js" type="text/javascript"></script>
  		<script src="<%= contextPath%>/resources/js/validate/jquery.validate.js" type="text/javascript"></script>
  		<script src="<%= contextPath%>/resources/js/jquery.form.js" type="text/javascript"></script>
	</head>
	<body>
	<form name="fileUploadForm" id="fileUploadForm" action="<%= contextPath%>/member/import/save" method="post" enctype="multipart/form-data">
		<table width="100%" border="0" cellpadding="2" cellspacing="1">
			<tr>
              <td class="popTitle filedName">
                  Excel文件:
              </td>
			  <td align="left" style="width:80%;overflow:hidden;white-space:normal;">
	            <input type="file" name="xfile" id="xfile" value="" style="width:350px;"/>
			    &nbsp;
			    <button type="button" id="submitBtn" class="btn_2k3" onclick="doUpLoad()">上传并处理</button>
			    <br/>
			    <a href="<%= contextPath%>/member/download/xls">下载Excel模板</a>
		      </td>
		  </tr>
		</table>
	</form>
	<table width="100%" border="0" cellpadding="2" cellspacing="1">
	    <tr>
			<td class="popTitle filedName" width="12%">待处理数:</td>
			<td class="popConent"><input type="text" id="CountItems" value="0" disabled></td>
		</tr>
	    <tr>
			<td class="popTitle filedName" width="12%">已处理数:</td>
			<td class="popConent"><input type="text" id="HandledItems" value="0" disabled></td>
		</tr>
	    <tr>
			<td class="popTitle filedName" width="12%">成功数:</td>
			<td class="popConent"><input type="text" id="Success" value="0" disabled></td>
		</tr>
	    <tr>
			<td class="popTitleMust filedName" width="12%">失败数:</td>
			<td class="popConent"><input type="text" id="Fail" value="0" disabled></td>
		</tr>
	</table>
	<div id="outMsg" style="display:none;"></div>
	</body>
<script type="text/javascript">
    $(document).ready(function () {
        $('#fileUploadForm').submit(function (e) {
            e.preventDefault();//阻止默认的提交

            try {
                $(this).ajaxSubmit({
                    success:function (s) {
                        var data = eval("(" + s.replace(/<PRE>/ig, "").replace(/<\/PRE>/ig, "") + ")");
                        if (data.SUCCESS == "TRUE") {
                            alert("操作成功");
                            $("#xfile").val("");
                            $("#submitBtn").attr("disabled", true);
                            var objs = data.RES;
                            if (objs) {
                                for (var x in objs) {
                                    $('#' + x).val(objs[x]);
                                }
                            }
                        } else {
                            alert(data.MSG);
                        }
                    },
                    timeout:3000
                });
            } catch (e) {
                alert(e);
            }

            return false;
        });
    });


    function Ok() {
        parent.JQueryXDialog.fnResult(1);
    }


    function doUpLoad() {
        if (!isXlsFile($("#xfile").get(0))) {
            alert("请选择一个Excel文件(*.xls)");
            return;
        }
        $("#fileUploadForm").submit();
    }

    function isXlsFile(o) {
        if (o.value) {
            var suffx = o.value.replace(/.+\./, '');
            if ("xls" == suffx.toLowerCase()) {
                return true;
            }
        }
        return false;
    }

</script>
</html>