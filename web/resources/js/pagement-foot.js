
document.getElementById("ajaxpage-foot").innerHTML = 
	"<table  width='99%' border='0' cellspacing='0' cellpadding='0'> "+
	"	<tr> "+
	"		<td width='25%' align='left'>每页记录数  <select id='page.pageSize' onchange='doChangePageSize(this.value)'> "+
	"		    <option value='10'>10</option> "+
	"		    <option value='20' selected>20</option> "+
	"		    <option value='50'>50</option> "+
	"		    <option value='100'>100</option> "+
//	"		    <option value='0'>all</option> "+
	"		  </select> "+
	"		</td> "+
	"		<td width='25%' align='center'> "+
	"			<span id='firstPage'><a href='#' onclick='ajaxPage.firstPage(afterPage)'>首页</a></span>　<span id='prevPage'><a href='#' onclick='ajaxPage.prevPage(afterPage)'><上页</a></span>　<span id='nextPage'><a href='#' onclick='ajaxPage.nextPage(afterPage)'>下页></a></span>　<span id='lastPage'><a href='#' onclick='ajaxPage.lastPage(afterPage)'>尾页</a></span> "+
	"		</td> "+
	"		<td width='25%' align='center'>第<span id='currentPage' class='blue'></span>页 　|　共<span id='totalPages'></span>页　共<span id='totalRecords'></span>条记录</td> "+
	"		<td width='25%' align='right'>转到第<input id='page.pageNo' type='text' size='4' value='1'>页　<a href='#' onclick='ajaxPage.gotoPage(document.getElementById(\"page.pageNo\").value, afterPage)'>GO</a></td> "+
	"	</tr> "+
	"</table> ";

ajaxPage.setOddRowClass("");
ajaxPage.setEvenRowClass("col");
document.getElementById("currentPage").innerText = "1";
document.getElementById("totalRecords").innerText = "0";
document.getElementById("totalPages").innerText = "0";
setAjaxPage("firstPage", false);
setAjaxPage("prevPage", false);
setAjaxPage("nextPage", false);
setAjaxPage("lastPage", false);

//doSearch();

function setPageInformix(){
	document.getElementById("currentPage").innerText = ajaxPage.getCurrentPage();
	var n = ajaxPage.getTotalRows();	
	document.getElementById("totalRecords").innerText = n > 0?n:0;
	document.getElementById("totalPages").innerText = ajaxPage.getTotalPages();
	if(ajaxPage.getTotalPages()==0 || ajaxPage.getTotalPages()==1){
		setAjaxPage("firstPage", false);
		setAjaxPage("prevPage", false);
		setAjaxPage("nextPage", false);
		setAjaxPage("lastPage", false);
		return;
	}

	if(ajaxPage.getCurrentPage()==ajaxPage.getTotalPages()){
		setAjaxPage("firstPage", true);
		setAjaxPage("prevPage", true);
		setAjaxPage("nextPage", false);
		setAjaxPage("lastPage", false);
	}else {	
		if(ajaxPage.getCurrentPage()==1){
			setAjaxPage("firstPage", false);
			setAjaxPage("prevPage", false);
			setAjaxPage("nextPage", true);
			setAjaxPage("lastPage", true);
		}else{
			setAjaxPage("firstPage", true);
			setAjaxPage("prevPage", true);
			setAjaxPage("nextPage", true);
			setAjaxPage("lastPage", true);
		}
	}

}

function afterPage(){
	setPageInformix();
}

function setAjaxPage(name, bEnabled){
	var oSpan = document.getElementById(name);
	if(!oSpan) return;
	if(!oSpan.href){
		oSpan.href = oSpan.innerHTML;
	}
	if(!bEnabled){
		if(oSpan.className=="disabled") return;
		oSpan.className="disabled";
		oSpan.innerHTML = oSpan.getElementsByTagName("A")[0].innerHTML;
	}else{
		if(oSpan.className=="") return;
		oSpan.className="";
		oSpan.innerHTML = oSpan.href;
	}
	
}

function doChangePageSize(n){
	ajaxPage.setPageSize(n);
	doSearch();
}

