<%@page import="bingo.sso.server.web.SecurityContextUtil"%>
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/header.jsp"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>二维码登录测试</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <%@include file="/common/meta.jsp"%>
    <link href="${contextPath}/themes/default/bootstrap.css" rel="stylesheet" type="text/css" />
    <link  href="${contextPath}/themes/default/style.css" rel="stylesheet" type="text/css"/>
</head>
<body>
    <div class="header-blackLine">
    </div>
    <div class="container">
        <div class="row header">
            <div class="span4">
                <!-- logo -->
                <a href="javascript:void(0)">
                    <img class="logo" src="${contextPath}/themes/images/header/logo.png" alt="" />
                </a>
            </div>
            <div class="span8">

            </div>
        </div>
    </div>

	<div class="container">
		<div class="panel">
				<div class="panel-head">
					<div class="row-fluid">
						<div class="span6 first">
							QRCode测试
						</div>
						<div class="span6">
						</div>
					</div>
					<a href="#" class="toggle"></a>
				</div>
				<div class="panel-content">
					<form class="form-horizontal">
						<fieldset>
						  <div class="control-group">
							<label class="control-label" for="input01">用户名</label>
							<div class="controls">
							  <input type="text" class="input-xlarge" value="admin" id="username">
							</div>
						  </div>
						  <div class="control-group">
							<label class="control-label" for="optionsCheckbox">密码</label>
							<div class="controls">
								<input type="text" class="input-xlarge" value="111111" id="password">
							</div>
						  </div>
						  <div class="control-group">
							<label class="control-label" for="optionsCheckbox">二维码Key</label>
							<div class="controls">
								<input type="text" class="input-xlarge" id="qrcode">
							</div>
						  </div>
						  <div class="control-group">
							<label class="control-label" for="optionsCheckbox">二维码nonce</label>
							<div class="controls">
								<input type="text" class="input-xlarge" id="nonce">
							</div>
						  </div>
						  <div class="control-group">
							<label class="control-label" for="optionsCheckbox">TGT_Ticket</label>
							<div class="controls">
								<input type="text" class="input-xlarge" id="tgt">
							</div>
						  </div>
						   <div class="control-group">
							<label class="control-label" for="optionsCheckbox">Login_Ticket</label>
							<div class="controls">
								<input type="text" class="input-xlarge" id="lt">
							</div>
						  </div>
						  <div class="form-actions">
							<button type="button" class="btn btn-primary login">登录</button>
							<button type="button" class="btn btn-primary lticket">loginTicket</button>
							<button type="button" class="btn btn-primary scan">扫描二维码</button>
							<button type="button" class="btn btn-primary confirm">确认</button>
							<button type="button" class="btn btn-primary cancel">取消</button>
						  </div>
						</fieldset>
					  </form>
				</div>
			</div>
	</div>
	<!-- footer -->
    <div class="footer">
        <div class="container">
            <div class="row">
                <div class="span6">
                    <span class="footer-company">&copy;2013 BingoSoft 平台架构部</span>
                </div>
                <div class="span6">
                    <div class="footer-right">
                        <span class="footer-company">yangmc@bingosoft.net</span> +13580318500
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script type="text/javascript">
    var url=Global.contextPath +"/v2";
	$(".login").click(function(){
		$.post(url,{
			"openid.mode":"checkid_setup",
			"openid.ex.client_id":"clientId",
			"credential_type":"password",
			"username":$("#username").val(),
			"password":$("#password").val()
		},function(ret){
			var loginInfo=parseSSOReturn(ret);
			if(loginInfo["mode"]=="ok"){
				$("#tgt").val(loginInfo["ex.token"]);
			}else{
				$("#tgt").val(loginInfo["error"]);
			}
		},"text");
	});
	$(".lticket").click(function(){
		$.post(url,{
			"openid.mode":"login_ticket_setup",
			"openid.ex.client_id":"clientId",
			"openid.ex.token":$("#tgt").val()
		},function(ret){
			var loginInfo=parseSSOReturn(ret);
			if(loginInfo["mode"]=="ok"){
				$("#lt").val(loginInfo["ex.login_ticket"]);
			}else{
				$("#lt").val(loginInfo["error"]);
			}
		},"text");
	});
	$(".scan").click(function(){
		var qrUrl=Global.contextPath+"/qrcode/create";
		var key=$("#qrcode").val();
		if(key==""){
			alert("未设置二维码Key");
			return;
		}
		$.post(qrUrl,{
			"key":key,
			"loginTicket":$("#lt").val()
		},function(ret){
			if(!ret.error){
				alert("扫描成功，请确认,id:"+ret.key+",status:"+ret.status+",nonce:"+ret.nonce);
			}else{
				alert("服务端处理错误:"+ret.error);
			}
			$("#nonce").val(ret.nonce);
		},"json");
	});
	$(".confirm").click(function(){
		var qrUrl=Global.contextPath+"/qrcode/confirm";
		var key=$("#qrcode").val();
		var nonce=$("#nonce").val();
		if(key==""){
			alert("未设置二维码Key");
			return;
		}
		$.post(qrUrl,{
			"key":key,
			"nonce":nonce
		},function(ret){
			if(!ret.error){
				alert("确认成功!");
			}else{
				alert("服务端处理错误:"+ret.error);
			}
		},"json");
	});
	$(".cancel").click(function(){
		var qrUrl=Global.contextPath+"/qrcode/cancel";
		var key=$("#qrcode").val();
		var nonce=$("#nonce").val();
		if(key==""){
			alert("未设置二维码Key");
			return;
		}
		$.post(qrUrl,{
			"key":key,
			"nonce":nonce
		},function(ret){
			alert("确认成功!");
		},"json");
	});

	function parseSSOReturn(ret){
		var loginInfo={};
		var retArr=ret.split("\n");
		$.each(retArr,function(i,item){
			var entry=item.split(":");
			loginInfo[entry[0]]=entry[1];
		});
		return loginInfo;
	}

    </script>
</body>
</html>
