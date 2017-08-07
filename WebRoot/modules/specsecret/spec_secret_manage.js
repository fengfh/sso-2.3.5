/*业务操作*/
$(function () {
    /*注销*/
    $("#btnSignOut").click(function () {
         if (confirm("注销将同时关闭浏览器，是否确定？")) {
                //window.location.href = "Logout.aspx";
                window.close();
            }

    });
    /*使用指定密码*/
    $("#cbPwd").click(function () {
        $("tr[name='tr_pwd']").toggle();
        $(".tip").hide();
        $("#txtPwd").val("");
        $("#txtSurePwd").val("");
    });
    /*生成密码*/
    $("#btnCreate").click(function () {
        if (validate()) {
            var myPassword = "";
            var name = $("#txtName").val();
            var password = $("#txtPwd").val();
            var state = 0;
            if ($("#cbPwd").attr("checked") == "checked") {
                state = 1;
            }
            myPassword = generatePassword(state, name, password);  
            alert("应用专用密码生成成功！");
            $("#txtName").val("");
            $("#txtPwd").val("");
            $("#txtSurePwd").val("");
            if(state == 0){
            	$("#password").html("您指定的密码已生成");
            }else{
            	$("#password").html(myPassword);
            }
            
        }
        pwdList();
    });
    pwdList();
});

/*生成密码*/
function generatePassword(state, name, password) {
    var str = "";
    //state: 0表示指定密码 1表示随机生成
    //name: 名称
    //password: 密码
    var data = {};
    data.name = name;
    if (state == 0){
    	data.secret = password;
    }
    $.ajax({
        url: Global.serverPath + "/specsecret/gen",
        data: data,
        type: "get",
        async: false,
        success: function(response){
        	str = response;
        }
    });
    
    return str;
}
/*撤销密码*/
function cancelPassword(id) {
    $.ajax({
        url: Global.serverPath + "/specsecret/cancel/" + id,
        type: "post",
        async: false
    });
}
/*密码列表*/
function pwdList() {
    /*密码列表*/
    //发请求到后台拿数据
    var data = [];
    
    $.ajax({
        url: Global.serverPath + "/specsecret/list",
        type: "post",
        async: false,
        success: function(response){
        	data = response;
        }
    });
    
    renderTemplate(data);
}

/*渲染列表*/
function renderTemplate(data) {
    var result = "";
    var bt = baidu.template;
    $("#result").html("");
    var pwdlistTemplate='<tr><td><%=name %></td><td name="secret">******</td><td><%=createTime %></td><td><%=lastUsedTime %></td><td><a href="#" name="cancel" id="<%=id %>">[撤销]</a></td></tr>';
    	
    for (var i = 0; i < data.length; i++) {
    	var createTime = new Date();
    	createTime.setTime(data[i].createTime);
    	data[i].createTime = (createTime).toLocaleDateString() + " " + (createTime).toLocaleTimeString();
    	if(data[i].lastUsedTime == null || data[i].lastUsedTime == "" || data[i].lastUsedTime == "null"){
    		data[i].lastUsedTime = "无";
    	}else{
    		var lastUsedTime = new Date();
    		lastUsedTime.setTime(data[i].lastUsedTime);
    		data[i].lastUsedTime = (lastUsedTime).toLocaleDateString() + " " + (lastUsedTime).toLocaleTimeString();
    	}
    	
        result = bt(pwdlistTemplate, data[i]);
        $("#result").append(result);
    }
    /*撤销密码*/
    $("a[name='cancel']").each(function () {
        $(this).click(function () {
            var id = $(this).attr("id");
            if (confirm("确定要撤销密码吗?")) {
                cancelPassword(id);
                pwdList();
            }
        });
    });
}


/*表单校验*/
function validate() {
    var name = $("#txtName").val();
    var pwd = $("#txtPwd").val();
    var surepwd = $("#txtSurePwd").val();
    /*指定密码*/
    if ($("#cbPwd").attr("checked") != "checked") {
        if (name == "") {
            $("#txtName").focus();
            return false;
        }
        if (pwd == "") {
            $("#txtPwd").focus();
            return false;
        }
        if (surepwd == "") {
            $("#txtSurePwd").focus();
            return false;
        }
        if (surepwd != pwd) {
            /*$(".tip").show();
            $("#txtSurePwd").focus();*/
        	alert("两次输入的密码不一致！");
            return false;
        }
        
        if(surepwd.length < 6){
        	alert("密码至少6位！")
        	return false;
        }

    } else {
        if (name == "") {
            $("#txtName").focus();
            return false;
        }
    }
    return true;
}


/*渲染页面效果*/
$().ready(function () {
    jquery_dropdown();
    fancy_box();
    content_tab();
});
function fancy_box() {
    $(".image-wrap a").fancybox({
        'overlayShow': true,
        'transitionIn': 'elastic',
        'transitionOut': 'elastic',
        'hideOnContentClick': true,
        'padding': '5px',
        'overlayColor': 'white',
        'centerOnScroll': true,
        'speedIn': 200,
        'speedOut': 200
    });
}
function jquery_dropdown() {
    $("ul.js-jquery-dropdown li.sub_menu").hover(function () {
        var dropMenu = $('ul:first', this);
        dropMenu.fadeIn(100);
        var dropMenuOffset = dropMenu.offset();
        if ((dropMenuOffset.left + dropMenu.width()) > $(window).width() - 10) {
            // the menu is out of screen, reposition it
            dropMenu.addClass("dropdown-menu-moved");
        }
        $(this).delay(50).queue(function () {
            $(this).addClass("hover");
            $(this).dequeue();
        });
    }, function () {
        $('ul:first', this).removeClass("dropdown-menu-moved"); //reposition the menu to it's default location'

        $(this).removeClass("hover"); //remove hover class
        $('ul:first', this).hide(); //hide the menu
        $(this).delay(100).queue(function () {
            $(this).removeClass("hover");
            $(this).dequeue();
        });
    });

    $("ul.js-jquery-dropdown li ul li:has(ul)").find("a:first").append(" &raquo; ");
};
function content_tab() {
    $(".tab-panel:not(:first-child)").hide();
    $(".tab-panel:first-child").addClass('tab-visible');
    $('.content-tab a').click(function (event) {
        event.preventDefault();
        $('.content-tab li').removeClass('tab-selected');
        $(this).parent().addClass('tab-selected');

        $(".tab-visible .video-content").attr("src", $('.video-content').attr('src')); //stop all youtube videos from the old visible tab

        //hide all tabs
        $(".tab-panel").hide();
        $(".tab-panel").removeClass('tab-visible'); //remove tab-visible

        //except the one clicked
        $('.' + $(this).parent().attr('id')).show();
        $('.' + $(this).parent().attr('id')).addClass('tab-visible'); //add the tab-visible

        //resize the nice scroll
        $(".content-scroll").getNiceScroll().resize();



    });
}


