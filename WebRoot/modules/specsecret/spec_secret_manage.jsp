<%@page import="bingo.sso.server.web.SecurityContextUtil"%>
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@include file="/common/header.jsp"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>应用专用密码管理</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <%@include file="/common/meta.jsp"%>
    <link href="${themePath}/bootstrap.css" rel="stylesheet" type="text/css" />
    <link  href="${themePath}/style.css" rel="stylesheet" type="text/css"/>
    <script type="text/javascript" src="${contextPath}/scripts/jquery.min.js"></script>
    <script type="text/javascript" src="${contextPath}/scripts/jquery-ui-1.8.21.custom.min.js"></script>
    <script type="text/javascript" src="${contextPath}/scripts/baiduTemplate.js"></script>
    <script type="text/javascript" src="${contextPath}/scripts/fancybox/jquery.fancybox-1.3.4.pack.js"></script>
    <script type="text/javascript" src="${contextPath}/scripts/fx.js"></script>
    <script type="text/javascript" src="${contextPath}/scripts/jquery.nicescroll.min.js"></script>
    <script type="text/javascript" src="${contextPath}/scripts/jquery.masonry.min.js"></script>
    <script type="text/javascript" src="${contextPath}/modules/specsecret/spec_secret_manage.js"></script>
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
                <div class="js-jquery-dropdown-wrapper">
                    <ul class="js-jquery-dropdown">
                        <li class="sub_menu "><a href="javascript:void(0)">当前账户：<%=SecurityContextUtil.getAccount(request, response) %><div class="sub_menu_arrow">
                        </div>
                        </a>
                            <ul>
                                <li><a href="#" id="btnSignOut">注销</a>
                                    <div class="dropdown-separator">
                                    </div>
                                </li>
                            </ul>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <div class="page-index-featured responsive-center js-header-animation">
        <div class="container">
            <div class="row">
                <div class="span12">
                    <h2>
                        应用专用密码</h2>
                    <p>
某些使用您公司帐号登录的应用（如桌面应用，手机应用），可能会要求您在它的登录页面输入用户和密码来完成登录，这种登录方式是不够安全的。
<br/>
例如：
<br/>
1. 用户下载了被恶意篡改过的应用，在输入帐号和密码时被窃取，这种情况在手机和桌面应用上都有可能发生；
<br/>
2. 有些手机应用为了获得更好的用户体验，提供了记住密码功能，手机丢失后通过特定的工具可以获取到保存过的密码。
<br/>
为了保证您公司账号密码的安全性，需要使用称之为“应用专用密码”的验证码来替代公司账号密码，从而保证您公司账号密码不会泄漏。
                    </p>
                </div>
                <!-- <div class="span6">
                    <h2>
                        &nbsp;</h2>
                        <p>
                    <strong style="color: #CF0F0F">为什么要使用应用专用密码呢？</strong><br/>您不需要在应用程序上直接输入自己的帐号信息， 而是在您受信任的站点上获取<strong>"应用专用密码"</strong>,这样可以有效保障您的帐号信息不被泄漏。
                    <br/></p>
                </div> -->
            </div>
        </div>
    </div>
    <div class="container">
        <div class="row">
            <div class="span12">
                <ul id="tab-panel-1" class="content-tab">
                    <li id="tab-1" class="tab-selected"><a href="#">生成密码</a></li>
                    <li id="tab-2"><a href="#">密码管理</a></li>
                </ul>
            </div>
        </div>
        <div class="tab-panel-wrap tab-panel-1">
            <div class="tab-panel tab-1">
                <div class="row">
                    <div class="span6">
                        <h4 style="margin-top: 5px;">
                            <strong>第1步</strong>：<font style="font-size: 15px;">生成新的应用专用密码</font></h4>
                        <p> 请输入一个容易记住的名称，以帮助您记住该密码对应的应用。</p>
                        <p>例如："我的Iphone"、"我的HTC"、"我的投票应用"</p>
                        <table>
                            <tr>
                                <td style="padding-bottom: 5px; width: 70px;">
                                    <strong>名称：</strong>
                                </td>
                                <td>
                                    <input type="text" id="txtName" value="我的专用密码"/>
                                </td>
                                <td style="padding-bottom: 10px;">
                                    <span style="color: red">*</span>
                                </td>
                                <td style="padding-left: 10px; padding-bottom: 10px; vertical-align: middle">
                                </td>
                                
                            </tr>
                            <tr name="tr_pwd">
                                <td style="padding-bottom: 5px;">
                                    <strong>指定密码：</strong>
                                </td>
                                <td>
                                    <input type="password" id="txtPwd" />
                                </td>
                                <td>
                                    <span style="color: red">*  </span>密码至少6位
                                </td>
                            </tr>
                            <tr name="tr_pwd">
                                <td style="padding-bottom: 5px;">
                                    <strong>确认密码：</strong>
                                </td>
                                <td>
                                    <input type="password" id="txtSurePwd" />
                                </td>
                                <td>
                                    <span style="color: red">*</span>
                                </td>
                            </tr>
                        </table>
                        <table>
                            <tr>
                                <td style="padding-bottom: 10px;">
                                    <input type="button" id="btnCreate" class="btn" value="生成密码" />
                                </td>
                                <td style="padding-left: 10px;">
                                    <input type="checkbox" id="cbPwd" title="随机生成" />&nbsp;随机生成
                                </td>
                                <td>
                                </td>
                            </tr>
                        </table>
                      
                    </div>
               		<div class="span6">
               			  <h4 style="margin-top: 5px;">
                            <strong>第2步</strong>：<font style="font-size: 15px;">输入已经生成的应用专用密码</font></h4>
                        <p>
                            现在，您可以将新的应用专用密码输入到自己的应用中了!</p>
                        <div class="alert" style="width: 300px; text-align: center; font-size: 25px; height: 35px;color:#cf0f0f;vertical-align: middle">
                            <strong id="password"></strong>
                        </div>
                       
               		</div>
                </div>
            </div>
            <div class="tab-panel tab-2">
                <div class="row">
                    <div class="span12">
                        <table class="table table-condensed">
                            <thead>
                                <tr>
                                    <th>
                                        名称
                                    </th>
                                    <th>
                                        应用专用密码
                                    </th>
                                    <th>
                                        创建日期
                                    </th>
                                    <th>
                                        最近登录日期
                                    </th>
                                    <th>
                                        操作
                                    </th>
                                </tr>
                            </thead>
                            <tbody id="result">
                            </tbody>
                            <script type="text/html" id="t:pwdlist">
                                
                            </script>
                        </table>
                    </div>
                </div>
            </div>
            <p>
            </p>
            <p>
            </p>
            <p>
            </p>
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
</body>
<meta http-equiv="content-type" content="text/html;charset=UTF-8" />
</html>
