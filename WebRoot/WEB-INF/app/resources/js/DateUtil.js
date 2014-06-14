/*格式化时间
formatStr:
   yyyy:年
   MM:月
   dd:日
   hh:小时
   mm:分钟
   ss:秒
 */
Date.prototype.toString = function(formatStr) {
	var date = this;
	var timeValues = function() {
	};
	timeValues.prototype = {
		year : function() {
			if (formatStr.indexOf("yyyy") >= 0) {
				return date.getYear();
			} else {
				return date.getYear().toString().substr(2);
			}
		},
		elseTime : function(val, formatVal) {
			return formatVal >= 0 ? (val < 10 ? "0" + val : val) : (val);
		},
		month : function() {
			return this.elseTime(date.getMonth() + 1, formatStr.indexOf("MM"));
		},
		day : function() {
			return this.elseTime(date.getDate(), formatStr.indexOf("dd"));
		},
		hour : function() {
			return this.elseTime(date.getHours(), formatStr.indexOf("hh"));
		},
		minute : function() {
			return this.elseTime(date.getMinutes(), formatStr.indexOf("mm"));
		},
		second : function() {
			return this.elseTime(date.getSeconds(), formatStr.indexOf("ss"));
		}
	};
	var tV = new timeValues();
	var replaceStr = {
		year : [ "yyyy", "yy" ],
		month : [ "MM", "M" ],
		day : [ "dd", "d" ],
		hour : [ "hh", "h" ],
		minute : [ "mm", "m" ],
		second : [ "ss", "s" ]
	};
	for ( var key in replaceStr) {
		formatStr = formatStr.replace(replaceStr[key][0], eval("tV." + key
				+ "()"));
		formatStr = formatStr.replace(replaceStr[key][1], eval("tV." + key
				+ "()"));
	}
	return formatStr;
};
//var date = new Date();
//alert(date.toString("yyyy-MM-dd hh:mm:ss"));

Date.prototype.format = function (format) {
    var o = {
        "M+": this.getMonth() + 1,
        "d+": this.getDate(),
        "h+": this.getHours(),
        "m+": this.getMinutes(),
        "s+": this.getSeconds(),
        "q+": Math.floor((this.getMonth() + 3) / 3),
        "S": this.getMilliseconds()
    }
    if (/(y+)/.test(format)) {
        format = format.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
    }
    for (var k in o) {
        if (new RegExp("(" + k + ")").test(format)) {
            format = format.replace(RegExp.$1, RegExp.$1.length == 1 ? o[k] : ("00" + o[k]).substr(("" + o[k]).length));
        }
    }
    return format;
}
/**  
*转换日期对象为日期字符串  
* @param date 日期对象  
* @param isFull 是否为完整的日期数据,  
*               为true时, 格式如"2000-03-05 01:05:04"  
*               为false时, 格式如 "2000-03-05"  
* @return 符合要求的日期字符串  
*/  
function getSmpFormatDate(date, isFull) {
    var pattern = "";
    if (isFull == true || isFull == undefined) {
        pattern = "yyyy-MM-dd hh:mm:ss";
    } else {
        pattern = "yyyy-MM-dd";
    }
    return getFormatDate(date, pattern);
}
/**  
*转换当前日期对象为日期字符串  
* @param date 日期对象  
* @param isFull 是否为完整的日期数据,  
*               为true时, 格式如"2000-03-05 01:05:04"  
*               为false时, 格式如 "2000-03-05"  
* @return 符合要求的日期字符串  
*/  

function getSmpFormatNowDate(isFull) {
    return getSmpFormatDate(new Date(), isFull);
}
/**  
*转换long值为日期字符串  
* @param l long值  
* @param isFull 是否为完整的日期数据,  
*               为true时, 格式如"2000-03-05 01:05:04"  
*               为false时, 格式如 "2000-03-05"  
* @return 符合要求的日期字符串  
*/  

function getSmpFormatDateByLong(l, isFull) {
    return getSmpFormatDate(new Date(l), isFull);
}
/**  
*转换long值为日期字符串  
* @param l long值  
* @param pattern 格式字符串,例如：yyyy-MM-dd hh:mm:ss  
* @return 符合要求的日期字符串  
*/  

function getFormatDateByLong(l, pattern) {
    return getFormatDate(new Date(l), pattern);
}
/**  
*转换日期对象为日期字符串  
* @param l long值  
* @param pattern 格式字符串,例如：yyyy-MM-dd hh:mm:ss  
* @return 符合要求的日期字符串  
*/  
function getFormatDate(date, pattern) {
    if (date == undefined) {
        date = new Date();
    }
    if (pattern == undefined) {
        pattern = "yyyy-MM-dd hh:mm:ss";
    }
    return date.format(pattern);
}

//alert(getSmpFormatDate(new Date(1279849429000), true));
//alert(getSmpFormatDate(new Date(1279849429000),false));    
//alert(getSmpFormatDateByLong(1279829423000, true));
//alert(getSmpFormatDateByLong(1279829423000,false));    
//alert(getFormatDateByLong(1279829423000, "yyyy-MM"));
//alert(getFormatDate(new Date(1279829423000), "yy-MM"));
//alert(getFormatDateByLong(1279849429000, "yyyy-MM hh:mm")); 

/**
 * str : 20121211091430
 */
function formatStr2Date(str){
	str += "";
	if(str=='') return '';
	var year = str.substring(0, 4);
	var month = str.substring(4, 6);
	var day = str.substring(6, 8);
	var hour = str.substring(8, 10);
	var min = str.substring(10, 12);
	var second = str.substring(12, 14);
	if(second == '') return '';//格式不正确
	return year + "-" + month + "-" + day + " " + hour + ":" + min + ":" + second;
}

/**
 * str : 2012-12-11 09:14:30
 */
function str2Date(strDate) { 
	var temp = strDate.toString(); 
	temp = temp.replace(/-/g, "/");
	var date = new Date(Date.parse(temp)); 
	return date; 
} 