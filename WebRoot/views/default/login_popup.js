$(function(){
	//for req :用户在输入认证信息以后，登录页面需要记住用户名、登录类型
	var loginName = getCookie('username');
	if(loginName && loginName != ''){
		document.getElementById('username').value = loginName;
		
		//加载验证码
		displayRandomCode(loginName);
	}
	
	//初始化焦点
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

//记录登录信息
function saveLoginInfo(){
	setCookie('username',document.getElementById('username').value,30);
}

function doSubmit(){
	if(document.getElementById('username').value == ''){
		alert('用户名不能为空，请输入');
		document.getElementById('username').focus();
		return false;
	}
	saveLoginInfo();
	document.forms[0].submit();
	return true;
}

//回车提交事件
function keyFunction(){	
	if( event.keyCode == 13 ){
		doSubmit();
	}
}

function setCookie(objName,objValue,objDays){//添加cookie 
  var str = objName + "=" + objValue; 
  if(objDays> 0){//为0时不设定过期时间，浏览器关闭时cookie自动消失 
    var date = new Date(); 
    var ms = objDays*24*3600*1000; 
    date.setTime(date.getTime() + ms); 
    str += "; expires=" + date.toGMTString(); 
  } 
  document.cookie = str; 
}

function getCookie(cookieName){//自定义函数    	
    var cookieString = document.cookie;    //获取cookie
    var start = cookieString.indexOf(cookieName + '=');//截取cookie的名
    if (start == -1)                         //若不存在该名字的 cookie
    return null;                            //返回空值
    start += cookieName.length + 1;                    
    var end = cookieString.indexOf(';', start);
    if (end == -1)                    //防止最后没有加“;”冒号的情况
    return cookieString.substring(start);//返回cookie值
    return cookieString.substring(start, end);//返回cookie值
}

//重新获取验证码
function refresh(e) {
	e.src = e.src + "&time=" + new Date();
}