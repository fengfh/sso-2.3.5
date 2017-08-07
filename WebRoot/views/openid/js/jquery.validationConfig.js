(function($) {
	$.fn.validationConfig = function() {
	};
	$.validationConfig = {
		newLang : function() {
			$.validationConfig.allRules = {
				"required" : { // Add your regex rules here, you can take telephone as an example
					"executor" : "_required"
				},
				"pattern" : {
					"executor" : "_customRegex"
				},
                "func" : {
                    "executor" : "_funcCall"
                },
				"length" : {
					"executor" : "_length"
				},
				"range" : {
					"executor" : "_range"
				},
				"equalToField" : {
					"executor" : "_confirm",
					"alertText" : "输入值与相关信息不相符"
				},
				"url" : {
					"regex" : /^(http|https|ftp):\/\/(([A-Z0-9][A-Z0-9_-]*)(\.[A-Z0-9][A-Z0-9_-]*)+)(:(\d+))?\/?/i,
					"executor" : "_customRegex",
					"alertText" : "网址输入不正确"
				},
				"qq" : {
					"regex" : /^[1-9][0-9]{4,}$/,
					"executor" : "_customRegex",
					"alertText" : "QQ号码输入不正确（非零开头的四位以上的数字）"
				},
				"telephone" : {
					"regex" : /^(\(0\d{2,3}\)|0\d{2,3}-)?[1-9]\d{6,7}(\-\d{1,4})?$/,
					"executor" : "_customRegex",
					"alertText" : "电话号码输入不正确"
				},
				"mobile" : {
					"regex" : /^1[3|5|8]\d{9}$/,
					"executor" : "_customRegex",
					"alertText" : "手机号码输入不正确"
				},
                "zip":{
                  "regex":/^[1-9]\d{5}$/,
                  "executor" : "_customRegex",
                  "alertText":"邮政编码输入不正确"
                },
				"email" : {
					"regex" : /^[a-zA-Z0-9_\.\-]+\@([a-zA-Z0-9\-]+\.)+[a-zA-Z0-9]{2,4}$/,
					"executor" : "_customRegex",
					"alertText" : "邮箱地址输入不正确"
				},
				"date" : {
					"regex" : /^[0-9]{4}\-[0-9]{1,2}\-[0-9]{1,2}$/,
					"executor" : "_customRegex",
					"alertText" : "日期输入格式不正确（YYYY-MM-DD）"
				},
				"identity" : {
					"regex" : /\d{15}|\d{18}/,
					"executor" : "_customRegex",
					"alertText" : "身份证输入不正确"
				},
				"money" : {
					"regex" : /^[0-9]+(.[0-9]{2})?$/,
					"executor" : "_customRegex",
					"alertText" : "金额格式输入不正确"
				},
				"integer" : {
					"regex" : /^\d+$/,
					"executor" : "_customRegex",
					"alertText" : "输入值必须是正整数"
				},
				"double" : {
					"regex" : /^[0-9]+(.[0-9]{1})?$/,
					"executor" : "_customRegex",
					"alertText" : "输入值必须是数值"
				},
				"digit" : {
					"regex" : /^[0-9]+$/,
					"executor" : "_customRegex",
					"alertText" : "只能输入数字"
				},
				"noSpecialCaracters" : {
					"regex" : /^[0-9a-zA-Z]+$/,
					"executor" : "_customRegex",
					"alertText" : "不允许输入字母和数字之外的特殊字符"
				},
				"letter" : {
					"regex" : /^[a-zA-Z]+$/,
					"executor" : "_customRegex",
					"alertText" : "只允许输入英文"
				},
				"chinese" : {
					"regex" : /^[\u0391-\uFFE5]+$/,
					"executor" : "_customRegex",
					"alertText" : "只允许输入中文"
				}
			}
		}
	}
	
	$.validationConfig.newLang() ;
})(jQuery);