/* widget-common */
(function($){
	/**
	 * 控件初始化
	 */
	$.uiwidget = {
		mark:"data-widget",
		options:"data-options",
		map:{},
		/**
		 * eg: $.widget.register("combotree",function(){})
		 */
		register:function(type , func){
			$.uiwidget.map[type] = func ;
		},
		init:function(){
			for(var type in $.uiwidget.map ){
				$.uiwidget.map[type]() ;
			}
		}
	}
	
	/**
	 * 浏览器兼容
	 */
	var browserFix_map = {} ;
	$.browserFix = function(el){
		if ($.browser.msie){
			var bowser = "ie" ;
			var version = parseInt($.browser.version, 10) ;
			for(var type in browserFix_map[bowser+"_"+version]||{} ){
				(browserFix_map[bowser+"_"+version]||{})[type]( el ) ;
			}
		}
	}
	
	/**
	 * eg: $.browserFix.register("ie","6","base",function( target ){} ) ;
	 * 
	 */
	$.browserFix.register = function(bowser, version,type,func ){
		browserFix_map[bowser+"_"+version] = browserFix_map[bowser+"_"+version]||{} ;
		browserFix_map[bowser+"_"+version][type] = func ;
	}
	
	$.fn.browserFix = function(){
		$.browserFix(this) ;
	}
	
	$(function(){
		//控件初始化
		$.uiwidget.init() ;
		//浏览器兼容
		$(document.body).browserFix() ;
		/*$("#loginForm").ajaxForm({
			beforeSubmit: function(arr, $form, options) { 
			    // The array of form data takes the following form: 
			    // [ { name: 'username', value: 'jresig' }, { name: 'password', value: 'secret' } ] 
			    // return false to cancel submit 
			},
			dataType:'json',
			success:function(responseData, statusText, xhr,jqForm){
			if(responseData.returnCode && responseData.returnCode!=200){
				//500错误
				alert(xhr.responseText);
				return;
			}
			if(false===responseData.isValid){
				//逻辑业务验证
				//$.each(responseData.errors,function(index,value){});
				$('.error').show();
				$('.help-inline').text(responseData.errorInfo);
			}else{
				//成功
			}
		}
		});*/
	})
})(jQuery);

//重新获取验证码
function refresh(e) {
	e.src = e.src + "&time=" + new Date();
}