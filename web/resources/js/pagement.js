/* 
 * 基于Ajax的翻页组件SQLPage
 *   - 支持可定制的客户端页面数据缓存(缺省缓存最近10页), 翻页几乎没有延迟.
 *   - 支持三页预装载(上一页,当前页,下一页).
 *   - 支持用户自定义页面内容输出
 *   - 支持刷新当前页
 *   - 支持goto指定页
 *   - 同时支持IE6以上和FF2以上
 *
 */

/* 
 * 结构体函数
 * params:
 *   tab 				-- 必须的, 以string类型指定的表id, 也可以是object类型的表对象	
 *   url 				-- 必须的, ajax访问的url
 *   pageSize 			-- 必须的, 每页的行数
 */
function $AjaxPage(tab, url, pageSize){
	this.version = "2.0.0";				//服务端需要sqlpage.jar 1.2.2以上版本
    this.oTab = (typeof(tab) == "string")?document.getElementById(tab):tab;
    this.url = url;
    this.pageSize = pageSize;			//页面行数
    this.retry = 3; 					//如果ajax request失败, 重试3次数
    this.oddRowClass = null;			//奇数行的className
    this.evenRowClass = null;			//偶数行的className
    this._afterFillRowFun = null;
    this._beforeFillRowFun = null;
    this.cachesSize = 3;				//caches中保留多少页

   this.reset = function(){
    	this.isFirstQuery = true;			//是否第一次查询
    	this.bShowLoading = false;			//当前页面是否正在显示
        this.requestPage = 1;				//当前请求的页面号
        this.totalRows = -1;				//总行数
        this.totalPages = 0;				//总页数
        this.currentPage = 0;				//当前显示的页面号
        this.caches = new $Ajax$Hash();		//页面缓存
        this.urlParams = new $Ajax$Hash();	//Query Params参数数组
        this.fieldnames = [];				//字段名数组
        this.redire = 1;
        this.lastContext = "";
        this.tableColumns = 0;
    };
    this.reset();
    
    this._getQueryParams = function(){
    	var params = "";
		params += (this.urlParams.size()==0?"":"&" + this.urlParams.toQueryString()) + "&pageSize=" + this.pageSize + "&requestPage=" + this.requestPage + "&totalRows=" + this.totalRows + "&totalPages=" + this.totalPages;
    	//if(params.length > 2083){
    	//	throw new Error("The URL of Ajax request is too long(the maximum length of a URL is 2083)...");
    	//	return;
    	//}
    	//alert(params);
    	return params;
    };
    this._loading = function(f){
    	var row = this._colSpan();
    	row.style.color = "green";
		row.cells[0].innerText = "Loading...";
		if(typeof(f)=="function"){
			f();
		} 
    };
    this._notFound = function(f){
    	var row = this._colSpan();
		row.style.color = "green";
		row.cells[0].innerText = "查询结果为空";
		if(typeof(f)=="function"){
			f();
		}
    };
    //合并当前行的所有列合并为一个列
    this._colSpan = function(){
    	this._clearTable();
    	var row = this._newTableRow();
    	var x = row.cells.length;
    	var n = x;
    	while (n > 1){  
           row.removeChild(row.cells[n - 1]);
           n--;
        }
    	row.align = "center";
		row.cells[0].colSpan = x;
		return row;
    };
    this._showFailureInfo = function(s){
    	var row = this._colSpan();
		row.style.color = "red";
		row.align = "left";
		row.cells[0].innerHTML = s ||"Error for load data....";
    };
    this.generateCache = function(content){
    	var cache = [];
    	if(content.length == 0) return cache;
    	
    	var rows = content.split(";");
    	for(var i = 0; i < rows.length - 1; i++){
    		var values = rows[i].split(",");
    		var rowCache = new $Ajax$Hash();
	   		for(var j = 0; j < this.fieldnames.length - 1; j++){
	   			rowCache.set(this.fieldnames[j], unescape(values[j]));
	   		}
	   		cache.push(rowCache);
		}

   		return cache;
    };
    this.isFirstExecute = function(){
    	return this.isFirstQuery;
    };
    this._showContext = function(cache){
    	this._clearTable();
    	for(var i = 0; i < cache.length; i++){
    		
    		var row = this._newTableRow(i);
    		
    		//使用奇偶行
			if((i % 2) == 0){
				if(this.evenRowClass){
					row.className = this.evenRowClass;
				}
			}else{
				if(this.oddRowClass){
					row.className = this.oddRowClass;
				}
			}
			
	   		if(this._beforeFillRowFun){
	   			this._beforeFillRowFun(i, row, cache[i]);
	   		}
	   		
    		this._fillRowValues(row, cache[i]);
    		
	   		if(this._afterFillRowFun){
	   			this._afterFillRowFun(i, row, cache[i]);
	   		}
    		
    	}
    };
    this._newTableRow = function(rowIndex){
		var row = this.oTab.rows[1].cloneNode(true);
		row.style.display = "";
		this.oTab.tBodies[0].appendChild(row);
		return row;
    };
    this._fillRowValues = function(row, datas){
    	var n = row.cells.length;
    	this.tableColumns = n;
    	datas.each(function(data, index){
			if(index < n){
				row.cells[index].innerHTML = data.value;
			}
    	});
    };
    this._clearTable = function(){
    	//IE 兼容
    	if(typeof(this.oTab.tBodies[0].removeNode) == "object"){
	    	this.oTab.tBodies[0].removeNode(true);
	  		this.oTab.appendChild(document.createElement("tbody"));
	  		return; 		
    	}
    	//FF 兼容
	  	this.oTab.tBodies[0].innerHTML = "";
    };
    this.setUrl = function(url){
    	this.url = url;
    };
    this.getUrl = function(){
    	return this.url;
    };
    this.getUrlWithQueryString = function(){
    	return this._getQueryParams();
    };
    this.setPageSize = function(size){
    	this.pageSize = size
    };
    this.getPageSize = function(){
    	return this.pageSize;
    };
    this.getTotalRows  = function(){
    	return this.totalRows;
    };
    this.getTotalPages = function(){
    	return this.totalPages;
    };
    this.getCurrentPage = function(){
    	return this.currentPage;
    };
    this.getCurrentPageCache = function(){
    	return this._getCache(this.currentPage);
    };
    this.getLastContext = function(){
    	return this.lastContext;
    };
    this.getTableColNums = function(){
    	return this.tableColumns;
    };
    this.setLastContext = function(s){
    	this.lastContext = s;
    };
    this.setAfterFillRowFun = function(f){
    	this.afterRow(f);
    };
    this.afterRow = function(f){
    	this._afterFillRowFun = f;
    };
    
    this.setBeforeFillRowFun = function(f){
    	this.beforeRow(f);
    };
    
    this.beforeRow = function(f){
    	this._beforeFillRowFun = f;
    };
    
    //设置奇数行的className
    this.setOddRowClass = function(s){
    	this.oddRowClass = s;
    };
    //设置偶数行的className
    this.setEvenRowClass = function(s){
        this.evenRowClass = s;
    };
    this.addQueryParams = function(name, value){
    	if(typeof(value)=='undefined'){
    		var x = $(name);
    		if(x && x.value){
    			value = x.value;
    		}
    	}
    	if(!value || value.replace(/(^\s*)|(\s*$)/g, "")==""){
    		return;
    	}
    	this.urlParams.set(name, escape(value));
    };
    this.execute = function(f){
    	this.firstPage(f);
    };
    //通过页面号获取cache
    this._getCache = function(pageno){
    	return this.caches.get(pageno);
    };
    this._hasCache = function(pageno){
    	return this.caches.has(pageno);
    };
    this._cacheNextPage  = function(self, afterFun){
    	if(!self){
    		self = this;
    	}
    	self.requestPage = self.currentPage + 1;
    	if(self.requestPage > self.totalPages){
    		self.requestPage = self.totalPages;
    		if(typeof(afterFun)=="function"){
    			afterFun(self);
    		} 
    		return;
    	}
    	if(!self._hasCache(self.requestPage)){
    		self.doRequestCache(self._getQueryParams(), self.currentPage, self.requestPage, afterFun);
    	}else{
    		if(typeof(afterFun)=="function"){
    			afterFun(self);
    		} 
    	}
    	
    };
    this._cachePrevPage  = function(self, afterFun){
    	if(!self){
    		self = this;
    	}
    	self.requestPage = self.currentPage - 1;
    	if(self.requestPage < 1){
    		self.requestPage = 1;
    		if(typeof(afterFun)=="function"){
    			afterFun(self);
    		} 
    		return;
    	}
    	if(!self._hasCache(self.requestPage)){
    		self.doRequestCache(self._getQueryParams(), self.currentPage, self.requestPage, afterFun);
    	}else{
    		if(typeof(afterFun)=="function"){
    			afterFun(self);
    		} 
    	}
    };
    this._cachePrevAndNextPage  = function(self){
		self._cacheNextPage(self, self._cachePrevPage);
    };
    this.doRequestCache = function(params, currentPage, requestPage, afterComplete, f){
    	if(this.bShowLoading){
    		this.bShowLoading = false;
    		this._loading(f);
    	}
    	this.isFirstQuery = this.totalRows == -1;
    	var self = this;
		this.postAjaxRequest(
			this.url, 
			params,
			function(request){
				var s = request.responseText;
				
				if(s.indexOf("@")!=0){
					self._showFailureInfo(s);
				}
				
				s = s.substring(1, s.length);
				var strs = s.split("#");
				self.lastContext = unescape(strs[strs.length - 1]); //获取额外的返回内容
				if(self.isFirstExecute()){
					self.totalRows = parseInt(strs[0]);
					self.totalPages = parseInt(strs[1]);
					self.fieldnames = strs[2].length > 0?strs[2].split(","):[];
					if(typeof(f)=="function"){
			    		f();
			    	}
					if(strs[3].length==0) {
						self._clearTable();
						self._notFound();
						return;
					}
				}
				//alert(strs[3]);
				var cache = self.generateCache(strs[3]);
				if(cache.length > 0){
					if(self.caches.size() >= self.cachesSize){
						self.caches.unset(self.caches.keys()[0]);
					}
					self.caches.set(requestPage, cache);
					if(currentPage==requestPage){
						self._showContext(cache);
					}
					
					if(typeof(afterComplete)=="function"){
			    		afterComplete(self);
			    	}
					
					
				}else{
					//如果返回的cache为空, 则尝试重连trytimes次, 每隔5秒重连一次
					if(requestPage<self.totalPages && self.trytimes > 0){
						self.trytimes--;
						setTimeout(function(){self.doRequestCache(params, currentPage, requestPage, afterComplete, f);}, 5000);
					}
				}
			},
			function(request){
				if(currentPage==requestPage){
					self._showFailureInfo(request.responseText);						
				}
			}
		);
    	
    };
    this.firstPage  = function(f){
    	if(this.currentPage==1){
    		return;
    	}
    	this.requestPage = 1;
    	this.currentPage = 1;
    	if(this._hasCache(this.currentPage)){
    		this.bShowLoading = false;
    		this._showContext(this._getCache(this.currentPage));
    		this._cacheNextPage();
	     	if(typeof(f)=="function"){
	    		f();
	    	}
    	}else{
    		this.bShowLoading = true;
    		this.trytimes = this.retry;
    		this.doRequestCache(this._getQueryParams(), this.currentPage, this.requestPage, this._cacheNextPage, f);
    	}
    };
    this.prevPage  = function(f){
    	if(this.currentPage==1){
    		return;
    	}
    	this.currentPage--;
    	if(this._hasCache(this.currentPage)){
    		this.bShowLoading = false;
    		this._showContext(this._getCache(this.currentPage));
    		this._cachePrevPage();
	     	if(typeof(f)=="function"){
	    		f();
	    	}
    	}else{
    		this.bShowLoading = true;
    		this.trytimes = this.retry;
    		this.doRequestCache(this._getQueryParams(), this.currentPage, this.currentPage, this._cachePrevPage, f);
    	}
    };
    this.nextPage  = function(f){
    	if(this.currentPage==this.totalPages){
    		return;
    	}
    	this.redire = 1;
    	this.currentPage++;
    	if(this._hasCache(this.currentPage)){
    		this.bShowLoading = false;
    		this._showContext(this._getCache(this.currentPage));
    		this._cacheNextPage();
	    	if(typeof(f)=="function"){
	    		f();
	    	}
    	}else{
    		this.bShowLoading = true;
    		this.trytimes = this.retry;
    		this.doRequestCache(this._getQueryParams(), this.currentPage, this.currentPage, this._cacheNextPage, f);
    	}
    	
    };
    this.lastPage  = function(f){
    	if(this.currentPage==this.totalPages){
    		return;
    	}
    	this.redire = 0;
    	this.requestPage = this.totalPages;
    	this.currentPage = this.totalPages;
    	if(this._hasCache(this.currentPage)){
    		this.bShowLoading = false;
    		this._showContext(this._getCache(this.currentPage));
    		this._cachePrevPage();
	    	if(typeof(f)=="function"){
	    		f();
	    	}
    	}else{
    		this.bShowLoading = true;
    		this.trytimes = this.retry;
    		this.doRequestCache(this._getQueryParams(), this.currentPage, this.requestPage, this._cachePrevPage, f);
    	}
    };
    this.gotoPage = function(x, f){
    	if(this.totalPages==0) return;
    	
    	var n = parseInt(x);
    	if(n == this.currentPage) return;

    	if(n >= this.totalPages){
    		this.lastPage(f);
    		return;
    	}else if(n <= 1){
    		this.firstPage(f);
    		return;
    	}

    	this.requestPage = n;
    	this.currentPage = n;
    	if(this._hasCache(this.currentPage)){
    		this.bShowLoading = false;
    		this._showContext(this._getCache(this.currentPage));
    		this._cacheNextPage(this, this._cachePrevPage);
	    	if(typeof(f)=="function"){
	    		f();
	    	}
    	}else{
    		this.bShowLoading = true;
    		this.trytimes = this.retry;
    		this.doRequestCache(this._getQueryParams(), this.currentPage, this.requestPage, this._cachePrevAndNextPage, f);
    	}
    };
    
    //刷新(重新装载)当前页
    this.refresh = function(f, bRecount){
    	if(typeof(bRecount)=="undefined"){
    		bRecount = true;
    	}
		//当前页即请求页
    	this.requestPage = this.currentPage;
    	this.totalRows = -1;
    	
    	var curpage = this.currentPage;
    	var caches = this.caches;
    	//所有大于等于当前页的页面缓存都将被清除掉
    	var keys = this.caches.keys();
    	for(var i=0;i<keys.length;i++){
    		var key = keys[i];
    		var pageno = parseInt(key);
    		if(pageno >= curpage){
    			caches.unset(key);
    		}
    	}
		this.bShowLoading = true;
		this.trytimes = this.retry;
		this.doRequestCache(this._getQueryParams()+(bRecount?"&recount=1":""), this.currentPage, this.requestPage, this._cacheNextPage, f);
    	if(typeof(f)=="function"){
    		f();
    	}

    };
    
    this.createXMLHttpRequest = function(){    
	    if (window.ActiveXObject) {  
	        var versions = ['Microsoft.XMLHTTP', 'MSXML.XMLHTTP', 'Microsoft.XMLHTTP', 'Msxml2.XMLHTTP.7.0', 'Msxml2.XMLHTTP.6.0', 'Msxml2.XMLHTTP.5.0', 'Msxml2.XMLHTTP.4.0', 'MSXML2.XMLHTTP.3.0', 'MSXML2.XMLHTTP'];  
	        for(var i = 0; i < versions.length; i++) {  
	            try {  
	                return new ActiveXObject(versions[i]);  
	            } catch(e) {}
	        }  
	    } else if (window.XMLHttpRequest) {  
	        return new XMLHttpRequest();  
	    }
		return null;
	};
	
    this.postAjaxRequest = function(url, params, fSuccess, fFailure) {
    	var xmlHttp = this.createXMLHttpRequest();
	    if(xmlHttp){
	    	xmlHttp.onreadystatechange = function() {
		        if (xmlHttp.readyState == 4) {
		            if (xmlHttp.status == 200) {
		                fSuccess(xmlHttp);  
		            } else {
		            	fFailure(xmlHttp);
		            }
		        }
		    }
	        xmlHttp.open("POST", url, true);  
	        xmlHttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");  
	        xmlHttp.send(params);
	    }
	};
    

}
function $Ajax$Hash(){
  	this._KEY_PREFIX = "$Ajax_Hash#";
  	this._startIndex = this._KEY_PREFIX.length;
  	this._length = 0;
  	
  	this._getkey = function(key){
  		return this._KEY_PREFIX+key;
  	};
	this.set = function(key, value){
		if(!this.has(key)){ 
	    	this._length++;
	    }
	    this[this._getkey(key)] = value;
	    return value;
	};
	this.unset = function(key){
		if(this._length>0 && this.has(key)){ 
	      	delete this[this.getkey(key)];
	      	this._length--;
	      	return true;
	    }
	    return false;
	};
	this.get = function(key){
		return this[this._getkey(key)];
	};
	this.has = function(key){
		return this[this._getkey(key)]?true:false;
	};	
	this.size = function(){
		return this._length;
	};
	this.keys = function(){
		var keys=[]; this.each(function(pair){keys.push(pair.key);}); return keys;
	};
	this.values = function(){
		var values=[]; this.each(function(pair){values.push(pair.value);}); return values;
	};
	this.each = function(f){
		if(typeof f == "function"){
			var i = 0;
			for(var key in this){
				if(key.length>this._startIndex && key.indexOf(this._KEY_PREFIX)==0){
					var pair = new Object();
					pair.key = key.substr(this._startIndex);
					pair.value = this[key];
					f(pair, i++);
				}
			}
		}
	};
	this.toQueryString = function(){
		var ary = [];
		this.each(function(pair){
			ary.push(pair.key + "=" + encodeURIComponent(pair.value==null ? '' : pair.value.toString()));
		});
		return ary.join("&");
	};
}
