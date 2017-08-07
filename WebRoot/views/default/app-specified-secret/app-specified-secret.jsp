<%@page pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@include file="/common/header.jsp"%>
<%
	String appSpecifiedSecret = (String) request
			.getAttribute("appSpecifiedSecret");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title></title>
<link href="${viewPath}/app-specified-secret/images/style.css"
	rel="stylesheet" />
</head>
<body>
	<div class="maincontent">
		<div class="getpass">
			<h1>获取专用密码</h1>
			<div class="getpass-content">
				<div class="getpass-info">
					<dl>
						<dt>什么是应用专用密码？</dt>
						<dd>
							某些使用您帐号信息的一些应用程序（例如电脑或 者移动终端上的网盘）需要其他类型的验证码，这 些就被称为“<span>应用专用密码</span>”。
						</dd>
						<dt>为什么要用应用专用密码呢？</dt>
						<dd>
							您不需要在应用程序上直接输入自己的帐号信息， 而是在您受信任的站点上获取“<span>应用专用密码</span>”，
							这样可以有效保障您的帐号信息不被泄漏。
						</dd>
						<dt>如何使用应用专用密码呢？</dt>
						<dd>
							当您打开非浏览器的应用程序或者设备时，如果系 统提示您输入用户名、应用专用密码，请执行如下操作：<br /> 1.输入您的用户名
							<br />2.获取应用专用密码 <br />3.在应用程序中输入您的“<span>应用专用密码</span>”
						</dd>
					</dl>
				</div>
				<div class="getpass-word">
					<p>
						<span id="oSecret"><%=appSpecifiedSecret%></span>
						<button class="btn-copy" id="copyBtn"
							onclick="copyToClipboard('<%=appSpecifiedSecret%>')">复制</button>
					</p>
				</div>
				<div style="clear: both;"></div>
			</div>
		</div>
	</div>
</body>
</html>


<script>  
function copyToClipboard(txt) {    
    if(window.clipboardData) {    
        window.clipboardData.clearData();    
        window.clipboardData.setData("Text", txt);    
        document.getElementById("copyBtn").innerHTML = "完成"; 
    } else if(navigator.userAgent.indexOf("Opera") != -1) {    
        window.location = txt;    
        document.getElementById("copyBtn").innerHTML = "完成"; 
    } else if (window.netscape) {    
        try {    
            netscape.security.PrivilegeManager.enablePrivilege("UniversalXPConnect");    
        } catch (e) {    
            alert("被浏览器拒绝！/n请在浏览器地址栏输入'about:config'并回车/n然后将'signed.applets.codebase_principal_support'设置为'true'");    
        }    
	    var clip = Components.classes['@mozilla.org/widget/clipboard;1'].createInstance(Components.interfaces.nsIClipboard);   
	    if (!clip)    
	        return;    
	    var trans = Components.classes['@mozilla.org/widget/transferable;1'].createInstance(Components.interfaces.nsITransferable);   
	    if (!trans)    
	        return;    
	    trans.addDataFlavor('text/unicode');    
	    var str = new Object();    
	    var len = new Object();    
	    var str = Components.classes["@mozilla.org/supports-string;1"].createInstance(Components.interfaces.nsISupportsString);    
	    var copytext = txt;    
	    str.data = copytext;    
	    trans.setTransferData("text/unicode",str,copytext.length*2);    
	    var clipid = Components.interfaces.nsIClipboard;    
	    if (!clip)    
	        return false;    
	    clip.setData(trans,null,clipid.kGlobalClipboard);    
	    document.getElementById("copyBtn").innerHTML = "完成";  
    } else {
    	alert("还未能支持该浏览器的自动复制，请手工选中并复制！");
    }
}
</script>
