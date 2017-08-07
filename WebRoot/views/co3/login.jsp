<%@page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@include file="/common/header.jsp"%>
<%
	String errors = (String) request.getAttribute("login.errors");
	boolean isError = null != errors && !"".equals(errors.trim());

	//
	Boolean bHaveNews = false;
	String NewsList = "";
	String doMainList = "";
	//验证码
	String pageKeyValue = "login.default_" + System.currentTimeMillis();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>品高协同办公云</title>
<link href="${viewPath}/App_themes/Default/style.css" rel="stylesheet"
	id="skin" title="default" type="text/css" />
<link href="${viewPath}/login-style.css" rel="stylesheet" type="text/css" />
<%@include file="/common/meta.jsp"%>
<script src="${viewPath}/login.js" type="text/javascript"></script>
<script type="text/javascript">
	window.loginowa = false;
	window.owaserver = "";
	window.owa_login_timeout = 3000;
	window.loginReady = false;
</script>
<script type="text/javascript">
function settab(name,num,n){
 for(i=1;i<=n;i++){
  var menu=document.getElementById(name+i);
  var con=document.getElementById(name+"_"+"Desc"+i);
  menu.className=i==num?"active":"";
    con.style.display=i==num?"block":"none";
 }
}
</script>
<script type="text/javascript">
	var baseURL = "http://linktest.bingocc.cc:8088/go";
	var iOSURL = "https://link.bingocc.com/BingoLink_Test/BingoLink.plist";
	var androidURL = baseURL + "/BingoLink/BingoLink.apk";
	function iOS_install(){
		window.location.href = "itms-services://?action=download-manifest&url="+encodeURIComponent(iOSURL);
	}
	function android_install(){
		window.location.href = androidURL;
	}
</script>


<style type="text/css">
        #email_list
        {
            width: 190px;
            list-style: none;
            border: 1px solid #ddd;
            -moz-border-radius: 0 0 2px 2px;
            border-radius: 2px;
            position: absolute;
            top: 29px;
            left: 80px;
            background: #fff;
            display: none;
        }
        #email_list li
        {
            width: 100%;
            height: 30px;
            line-height: 30px;
            text-indent: 10px;
            cursor: pointer;
            overflow: hidden;
        }
        #email_list li.first_li
        {
            cursor: default;
        }
        #email_list .current
        {
            background: #baeafb;
        }
        .email_list_box{ z-index: 999;
left: 107px;
position: absolute;
top: 19px;}
    </style>

</head>
<body class="body_oalogin_page">
<div class="email_list_box">
<ul id="email_list">
	                        <li class="first_li">请选择</li>
	                        <li></li>
	                        <!-- <li>@ytfdc.com.cn</li>
	                        <li>@ytdc.net</li> -->
	                        <%=doMainList %>
</ul>
</div>
<div class="login-wrapper">
   <div class="header-wrapper">
        <div class="header">
          <img src="${viewPath}/images/header.png" />
        </div>
   </div>
   <div class="content-wrapper">
       <div class="content">
           <div class="login-info">
                <div class="link-info pngfix"><img src="${viewPath}/images/link-01.png" /></div>
                <div class="download pngfix"><img src="${viewPath}/images/link-download.png" /></div>
                <div class="link-method">
                     <div class="method1 pngfix">
                         <h3><img src="${viewPath}/images/Method-01.png" /></h3>
                         <span class="qrcode"><img src="${viewPath}/images/erwm.png" /></span>
                     </div>
                     <div class="method2 pngfix">
                         <h3><img src="${viewPath}/images/Method-02.png" /></h3>
                         <ul class="mode">
                             <li class="IOS" onClick="javascript:iOS_install();"><a href="javascript://">Iphone</a></li>
                             <li class="Android" onclick="javascript:android_install();" ><a href="javascript://">Android</a></li>
                         </ul>
                     </div>
                </div>
           </div>
           <div id="login_wrapper" class="dialog login">
               <div id="signin">
                    <div class="tabbable">
						<ul class="nav">
							<li id="Desc1" onclick="settab('Desc',1,2)" class="active"><a href="javascript://">Link账号登录</a></li>
                            <li id="Desc2" onclick="settab('Desc',2,2)"><a href="javascript://">扫二维码登录</a></li>
						</ul>
					<div class="tab-content">
						<div id="Desc_Desc1">
							<div id="logins">
								  <form action="${loginAction}" method="post">
									<input type="hidden" name="LoginForm" value="yes" />
									<input style="display: none" name="pageKey" style="width: 100px;" value="<%=pageKeyValue %>" />
									<p class="error">
										<%
										if (isError) {
										%>
										<%=errors%>
										<%
										}
										%>
									</p>
									<div class="group">
									  <fieldset>
										<div class="item-tip">用户名</div>
										<input id="username" class="form-input" name="username"  type="text" value="">
									  </fieldset>
									  <fieldset>
										<div class="item-tip">密&nbsp;&nbsp;&nbsp;码</div>
										<input id="password" class="form-input" name="password" type="password" >
									  </fieldset>
									  <fieldset id="randomCodeFieldset" class="yzm_box" style="display:none">
										<div class="item-tip">验证码</div>
										<input type="text" id="randomCode" name="randomCode"  class="input_test"  /> &nbsp;&nbsp;
										<img style="height:28px; " id="randomCodeImg" src="${contextPath}/servlet/validatecode?pageKey=<%=pageKeyValue %>"
												onclick="refresh(this)" align="absmiddle" alt="看不清楚，点击获得新图片" title="看不清楚，点击获得新图片" /> &nbsp;&nbsp;
										<a href="#" style="font-size:14px; margin-bottom:-3px;" onclick="refresh(randomCodeImg)">看不清</a>
									  </fieldset>
									</div>
									<div class="check-box">
										<div class="inline"><input type="checkbox">记住账户</div>
										<div class="inline"><input type="checkbox">自动登录</div>
									</div>
									<p class="buttons confirm_btn">
									  <a class="mmbutton" href="javascript://" onclick="doSubmit();">
										<span>登&nbsp;&nbsp;&nbsp;&nbsp;录</span>
									  </a>
									</p>
									<p class="forget" style="display:none"><a href="#">忘记密码?</a></p>
								  </form>
								</div>
							</div>
							<div id="Desc_Desc2" style="display:none;">
								<div class="loginWay">
									请用<a href="#" title="Link客户端">Link客户端</a>扫描二维码登录
									<span class="qrcode-login">
										<img src="${viewPath}/images/erweima.png" />
									<span>
								</div>
							</div>
						 </div>
					</div>
               </div>
			  </div>
           </div>
        </div>
   </div>
   <div class="footer-wrapper">
       <div class="footer">
             <dl>
                <dt><a href="javascript://"><img src="${viewPath}/images/footer-logo.png" /></a></dt>
                <dd>
                    <div class="footer-nav">
                         <ul>
                             <li><a href="#">品高云</a></li>
                             <li>|</li>
                             <li><a href="#">品高云在线</a></li>
                             <li>|</li>
                             <li><a href="#">官方微博</a></li>
                             <li>|</li>
                             <li><a href="#">关于我们</a></li>
                             <li>|</li>
                             <li><a href="#">联系方式</a></li>
                             <li>|</li>
                             <li><a href="#">联合运营</a></li>
                         </ul>
                    </div>
                    <div class="copyright">
                       &copy;Copyright 2002-2013 品高软件
                    </div>
                </dd>
             </dl>
       </div>
   </div>
</div>
</body>
</html>
<script type="text/javascript">
//<![CDATA[
    //function String.prototype.Trim() { return this.replace(/(^\s*)|(\s*$)/g, ""); }
    (function () {

        /* 初始化 */
        var emailInput = document.getElementById('username'),
		list = document.getElementById('email_list'),
		items = list.getElementsByTagName('li'),
		item1 = items[1],
		len = items.length,
		suffix = [],
		newSuffix, indexA, indexB,
		highlight = 'current',
		isIE = navigator.userAgent.toLowerCase().indexOf('msie') != -1,
		clearClassname = function () {
		    for (var i = 1, el; i < len && (el = items[i]); i++) {
		        el.className = '';
		    }
		};
        /* 将邮箱后缀存放到一个新数组中 */
        for (var j = 1, el; j < len && (el = items[j]); j++) {
            suffix[suffix.length++] = el.innerText.replace(/(^\s*)|(\s*$)/g, "");
        }

        /* 邮箱输入框绑定keyup事件 */
        //emailInput.onkeyup = suggest;

        /* suggest核心部分 */
        function suggest(event) {
            var e = event || window.event,
			eCode = e.keyCode,
			val = this.value,
			index = val.indexOf('@'),
			isIndex = index !== -1;

            clearClassname();
            //输入框不为空
            if (val) {
                item1.className = highlight;
                list.style.display = 'block';
                for (var i = 1, el; i < len && (el = items[i]); i++) {
                    el.onmouseover = function () {
                        clearClassname();
                        item1.className = '';
                        this.className = highlight;
                        indexA = 1;
                        indexB = 0;
                    }
                    el.onmouseout = function () {
                        this.className = '';
                        item1.className = highlight;
                    }
                    el.onclick = function () {
                        emailInput.value = this.innerText.replace(/(^\s*)|(\s*$)/g, "");
                    }
                }
            }
            //输入框为空
            else {
                item1.className = '';
                for (var i = 1, el; i < len && (el = items[i]); i++) {
                    el.onmouseout = el.onmouseover = el.onclick = null;
                }
                if (eCode === 38 || eCode === 40 || eCode === 13) return;
            }

            item1.innerText = val;
            newSuffix = [];  //初始化空数组
            for (var i = 1, el; i < len && (el = items[i]); i++) {
                /* 以邮箱后缀和输入框中@标志符后是否
                有相同的字符串来显示或隐藏该元素 */
                el.style.display = isIndex && el.innerHTML.indexOf(val.substring(index)) === -1 ? 'none' : 'block';
                if (i > 1) el.innerText = (isIndex ? val.substring(0, index) : val) + suffix[i - 1];
                /* 出现@标志符时将新的元素的排列顺序
                存放到空数组newSuffix中 */
                if ((!isIE && window.getComputedStyle(el, null).display === 'block') || (isIE && el.currentStyle.display === 'block')) {
                    newSuffix[newSuffix.length++] = i;
                }
            }

            /* 判断按键 */
            switch (eCode) {
                case 38:  //上方向键
                    keyMove(-1);
                    break;
                case 40: //下方向键
                    keyMove(1);
                    break;
                case 13: //回车键
                    getVal();
                    break;
                default:
                    indexA = 1;
                    indexB = 0;
                    return;
            }
        }

        /* 方向键控制元素的高亮效果 */
        function keyMove(n) {
            try {
                var newLen = newSuffix.length;
                if (newLen > 0 && newLen < 8) {
                    items[newSuffix[indexB]].className = item1.className = '';
                    indexB += n;
                    if (indexB === newLen) indexB -= newLen;
                    else if (indexB < 0) indexB += newLen;
                    items[newSuffix[indexB]].className = highlight;
                }
                else {
                    items[indexA].className = item1.className = '';
                    indexA += n;
                    if (indexA === len) indexA -= len - 1;
                    else if (indexA === 0) indexA += len - 1;
                    items[indexA].className = highlight;
                }
            } catch (e) {
            }
        }

        /* 获取当前高亮元素的值 */
        function getVal() {
            var newLen = newSuffix.length;
            emailInput.value = newLen > 0 && newLen < 8 ? items[newSuffix[indexB]].innerText : items[indexA].innerText;
            emailInput.value = emailInput.value.replace(/(^\s*)|(\s*$)/g, "");
            list.style.display = 'none';
        }

        /* 关闭提示层 */
        document.onclick = function (e) {
            var e = e || window.event,
			eNode = e.target ? e.target : e.srcElement;
            if (eNode !== emailInput && eNode !== items[0]) {
                list.style.display = 'none';
            }
        }

        document.onkeyup = tabpress;
        function tabpress(event) {
            var e = event || window.event, eCode = e.keyCode;
            if (eCode == 9)
                list.style.display = 'none';
        }

    })();

    function submitit(event) {
        var e = event || window.event, eCode = e.keyCode;
        if (eCode == 13) {
            checkValue();
        }
    }
//]]>
</script>