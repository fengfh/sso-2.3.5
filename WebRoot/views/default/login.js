
$(function(){


	// for req :用户在输入认证信息以后，登录页面需要记住用户名、登录类型
	var loginName = getCookie('username');
	if (loginName && loginName != '') {
		document.getElementById('username').value = loginName;
		var $tip = $("#username").prev();
		$tip.addClass("item-tip-focus");
		//加载验证码
		displayRandomCode(loginName);
	}

	// 初始化焦点
	if($('#username').val() == ''){
		$('#username').focus();
	}else{
		$('#password').focus();
	}

	$('#username').enterkeydown(function(){
		doSubmit();
	});
	$('#password').enterkeydown(function(){
		doSubmit();
	});
	$('#random_code').enterkeydown(function(){
		doSubmit();
	});

	// 为username增加blur事件
	$("#username").blur(function(){
		displayRandomCode(this.value);
	}) ;
});

var localServiceLoginBase = {"https:":"https://127.0.0.1:8089/","http:":"http://127.0.0.1:8089/"} ;


function local_login(user , password , domain) {
	var localServiceLoginUrl  = localServiceLoginBase[window.location.protocol]+"RemoteAppLogin" ;

	// Create object for post field
	var postData = new HttpLcAgentFieldSet();

	// Add field name and it's value
	postData.addField("user", user);
	postData.addField("password", password);
	postData.addField("domain", domain);

	// Post data to the local http agent
	sendHttpLcAgentData(localServiceLoginUrl, postData);
}

//加载验证码
function displayRandomCode(username){
	jQuery.ajax(
			{url: Global.contextPath + "/servlet/validatecodeneedcheck" + "?username=" + username,
		    type: 'GET',
		    timeout: 1000,
		    error: function(){
		    	$("#randomCodeFieldset").hide();
		    },
		    success: function(ret){
		    	var retJson = $.parseJSON(ret);
		        if(retJson.needcode){
		        	$("#randomCodeFieldset").show();
		        }else{
		        	$("#randomCodeFieldset").hide();
		        }
		    }
			});
}

// 记录登录信息
function saveLoginInfo() {
	setCookie('username', document.getElementById('username').value, 30);
}

// function doSubmit() {
// if (document.getElementById('username').value == '') {
// alert('用户名不能为空，请输入');
// document.getElementById('username').focus();
// return false;
// }
// saveLoginInfo();
// document.forms[0].submit();
// return true;
// }

function doSubmit() {

	var uname = document.getElementById('username').value;
	var upwd = document.getElementById('password').value;

	if (uname.length == 0) {
		alert('请输入用户名!');
		document.getElementById('username').focus();
		return false;
	}

	if (upwd.length == 0) {
		alert('请输入密码!');
		document.getElementById('password').focus();
		return false;
	}

	//远程应用本地登录
	/*local_login(document.getElementById('username').value,
				document.getElementById('password').value,
				document.getElementById('domain').value) ;*/

	setTimeout(function(){
        saveLoginInfo();
        document.forms[0].submit();
	},500) ;
	return true;
}

// 回车提交事件
function keyFunction() {
	if (event.keyCode == 13) {
		doSubmit();
	}
}

function setCookie(objName, objValue, objDays) {// 添加cookie
	var str = objName + "=" + objValue;
	if (objDays > 0) {// 为0时不设定过期时间，浏览器关闭时cookie自动消失
		var date = new Date();
		var ms = objDays * 24 * 3600 * 1000;
		date.setTime(date.getTime() + ms);
		str += "; expires=" + date.toGMTString();
	}
	document.cookie = str;
}

function getCookie(cookieName) {// 自定义函数
	var cookieString = document.cookie; // 获取cookie
	var start = cookieString.indexOf(cookieName + '=');// 截取cookie的名
	if (start == -1) // 若不存在该名字的 cookie
		return null; // 返回空值
	start += cookieName.length + 1;
	var end = cookieString.indexOf(';', start);
	if (end == -1) // 防止最后没有加“;”冒号的情况
		return cookieString.substring(start);// 返回cookie值
	return cookieString.substring(start, end);// 返回cookie值
}

// 重新获取验证码
function refresh(e) {
	e.src = e.src + "&time=" + new Date();
}

function FillForm(param, actionurl, iframe) {
	var mydoc = null;
	if (iframe.contentWindow)
		mydoc = iframe.contentWindow.document;
	else
		mydoc = iframe.contentDocument;
	var myForm = mydoc.createElement("form");
	myForm.method = "post";
	myForm.action = actionurl;

	for (var k in param) {

		var myInput = mydoc.createElement("input");
		myInput.setAttribute("name", k);
		myInput.setAttribute("value", param[k]);
		myForm.appendChild(myInput);
	}
	mydoc.body.appendChild(myForm);
	return myForm;
}

function setformCallback(ifm, callback, param) {
	if (ifm.attachEvent) {
		ifm.attachEvent("onload", function() {
					callback(param);
					ifm.src = "about:blank";
					ifm.detachEvent("onload", arguments.callee);
				});
	} else {
		ifm.onload = function() {
			callback(param);
			ifm.src = "about:blank";
			ifm.onload = null;
		}
	}
}

function iframeCallback(param) {
	loginReady = true;
	document.forms[0].submit();
}

function loginToOWA(server, domain, username, password) {
	var url = server + "auth/owaauth.dll";
	var p = {
		destination : server,
		flags : '0',
		forcedownlevel : '0',
		trusted : '0',
		isutf8 : '1',
		username : username,
		password : password
	};

	var owaFrame = document.getElementById('owaframe');
	try {
		var form = FillForm(p, url, owaFrame);
		setformCallback(owaFrame, iframeCallback, 'owa');
		form.submit();
	} catch (e) {
	}
}

/**
 * 两个sso单点登录服务器互联，
 * 1、trustSSOChecker值为第二个sso服务器地址
 * 2、在page开始中调用JS中调用loginFromTrustSSO(trustSSOUrl)方法
 * trustSSOUrl地址格式：/sso
 */
function loginFromTrustSSO(trustSSOUrl){
	var hideLoading=function(){
		$("#loading").hide();
	};

	if(window.location.href.indexOf("_userager")>0){
		hideLoading();
	}

	//var trustSSOUrl=$("#trustSSOChecker").val() || "";
	if(trustSSOUrl==""){
		return;
	}
	trustSSOUrl+="/v2?openid.mode=checkid_immediate&openid.ex.client_id=clientId&direct=y&$format=jsonp&openid.ex.get.jwt=y";

	window.setTimeout(function(){
		hideLoading();
	},2000);
		$.ajax({
			async:false,
			url: trustSSOUrl,
			type: "GET",
			dataType: 'jsonp',
			success: function (json) {
				if(json==null || json.mode!='ok'){
					return;
				}
				var form = $('<form style="display:none"></form>');
				// 设置属性
				form.attr('action', $("form").attr("action"));
				form.attr('method', 'post');
				form.attr('target', '_self');
				// 创建jwt_input
				var jwt_input = $('<input type="jwt" name="jwt" />');
				jwt_input.attr('value', json.jwt);
				form.append(jwt_input);
				// 创建type_input
				var type_input = $('<input type="jwt" name="credential_type" value="jwt" />');
				form.append(type_input);

				// 提交表单
				$("body").append(form);
				form.submit();
			},
			complete:function(){
				hideLoading();
			}
		});
}