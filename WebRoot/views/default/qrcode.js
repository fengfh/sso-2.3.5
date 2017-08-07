/**
 * 二维码登录
 */
(function (window, document, $, undefined) {
	"use strict";
	var H = $("html"),
		W = $(window),
		D = $(document);
	var errorMapping={
		"no_key":"二维码生成失败。",
		"lt_expired":"登录已过期，请重新刷新网页。",
		"created_error":"二维码已被使用，请刷新网页重新生成。",
		"qrcode_not_exist":"二维码已被使用，请刷新网页重新生成。"
	};

	function randomString(len) {
		len = len || 32;
		var $chars = 'ABCDEFGHJKMNPQRSTWXYZabcdefhijkmnprstwxyz2345678';
		var maxPos = $chars.length;
		var pwd = '';
		for (var i = 0; i < len; i++) {
			pwd += $chars.charAt(Math.floor(Math.random() * maxPos));
		}
		return pwd;
	}

	var QRCodeLoginClass={
		version: '1.0.0',
		defaults:{
			baseUrl:(Global.contextPath||"")+"/qrcode",
			key:"",
			width:150,
			height:150,
			status:0,		//运行状态，0：等待扫描，1：等待确认，2：已确认，10：取消
			// css selector
			wrapper:"",
			qrcodeScanContainer:".qrcode_scan_container",
			qrcodeImg:".qrcode_img",
			qrcodeConfirmContainer:".qrcode_confirm_container",
			qrcodeUserImg:".qrcode_user_img",
			qrcodeError:".qrcode_error",
			qrcodeCancel:".qrcode_cancel",
			//event
			afterInit:$.noop,
			afterScan:$.noop,
			afterConfirm:$.noop,
			beforLogin:$.noop,
			onCancel:$.noop,
			onError:$.noop,
			//token
			token:{
				status:0,
				key:"",
				loginTicket:"",
				loginId:""
			}
		},
		createNew:function(what,opts){
			if (!$.isPlainObject(opts)) {
				opts = {};
			}
			opts.wrapper=what;
			var Q= $.extend(true, {}, QRCodeLoginClass.defaults, opts);
			var errorTimes=0;
			var maxErrorTimes=5;
			var currentAjax=null;

			function init(){
				//生成二维码随机Key
				restKey();

				//抛出已初始化事件
				Q.afterInit();

				//更新状态为待扫描
				updateStatus(0);
			}

			/**
			 * 根据状态值，启动下一步任务
			 * @returns
			 */
			function nextTask(){
				switch(Q.status){
					case 0:
						chkScan();
						break;
					case 1:
						chkConfirm();
						break;
					case 2:
						loginToSSO();
						break;
					case 10:
						cancel();
						break;
				}
			}

			function updateStatus(status){
				Q.status=status;
				errorTimes=0;
				nextTask();
			}

			function restKey(){
				Q.key=randomString(5)+new Date().getTime();
				var qrcodeImg=$(Q.qrcodeImg);
				var qrcodeUrl=Q.baseUrl+"/img?key="+Q.key+"&width="+parseInt(qrcodeImg.attr("width")||Q.width)+"&height="+parseInt(qrcodeImg.attr("height")||Q.height);
				qrcodeImg.attr("src",qrcodeUrl);
				if(currentAjax!=null){
					try{
						currentAjax.abort();
					}catch(ex){	}
				}
				cleanError();
			}

			function chkScan(callback){
				var url=Q.baseUrl+"/check?key="+Q.key+"&_date="+new Date().getTime();
				sendRequest({
					url:url,
					type: "GET",
					success:function(reVal){
						if(reVal.key){
							Q.token=reVal;
							updateStatus(1);
							showConfirmInfo();
							Q.afterScan();
						}else{
							updateStatus(0);
						}
					}
				});
			}

			function showConfirmInfo(){
				$(Q.qrcodeScanContainer).hide();
				$(Q.qrcodeConfirmContainer).show();
				$(Q.qrcodeCancel).click(function(){
					cancel();
				});
			}

			function chkConfirm(){
				var url=Q.baseUrl+"/await?key="+Q.key+"&_date="+new Date().getTime();
				sendRequest({
					url:url,
					type: "GET",
					success:function(reVal){
						if(reVal.errorCode){
							showError(reVal.errorCode,reVal[error]);
							return
						}
						if(reVal.status==1){
							Q.token=reVal;
							Q.afterConfirm();
							updateStatus(2);
						}else if(reVal.status==10){
							cancel();
						}else{
							updateStatus(1);
						}
					}
				});
			}

			function loginToSSO(){
				var postForm = document.createElement("form");
		        postForm.method = "POST";
		        postForm.action = window.location.href;
		        postForm.target ="_self";

		       var inputItem1 = document.createElement("input");
		       inputItem1.setAttribute("name", "credential_type");
		       inputItem1.setAttribute("value", "login_ticket");
		       postForm.appendChild(inputItem1);

		       var inputItem2 = document.createElement("input");
		       inputItem2.setAttribute("name", "login_ticket");
		       inputItem2.setAttribute("value", Q.token.loginTicket);
		       postForm.appendChild(inputItem2);

		       Q.beforLogin(postForm);

		       document.body.appendChild(postForm);
		       postForm.submit();
			}

			function cancel(){
				restKey();
				$(Q.qrcodeScanContainer).show();
				$(Q.qrcodeConfirmContainer).hide();
				updateStatus(0);
			}

			function showError(errorCode,errorMsg){
				var msg=errorMsg || errorMapping[errorCode];
				$(Q.qrcodeError).show().html(msg);
				Q.onError(errorCode,errorMsg);
			}

			function cleanError(){
				$(Q.qrcodeError).hide().html("");
			}

			function sendRequest(opts){
				var params=$.extend(true,{
					dataType:"json",
					error:function(xhr,status,thrown){
						showError("请求出错，请检查网络是否连接！");
						errorTimes++;
						var sleepTime=1000;
						if(errorTimes>maxErrorTimes){
							sleepTime=3000;
						}
						window.setTimeout(function(){
							nextTask();
						},sleepTime);
					}
				},opts);
				currentAjax=$.ajax(params);
			}

			init();

			Q.rest=restKey;
			Q.cancel=cancel;
			Q.updateStatus=updateStatus;
			return Q;
		}
	};

	// jQuery plugin initialization
	$.fn.qrcodeLogin = function (options) {
		options = options || {};
		return this.each(function(){
			var what = $(this).blur();
			var qrcode=null;
			if(typeof(what.data("qr"))=="undefined"){
				qrcode=QRCodeLoginClass.createNew(what,options);
				what.data("qr",qrcode);
			}else{
				qrcode=what.data("qr");
			}
			return qrcode;
		});
	};
}(window, document, jQuery));