<%@page import="java.util.List"%>
<%@page import="bingo.sso.api.appspecifiedsecret.AppSpecifiedSecret"%>
<%@page import="bingo.sso.core.crypto.DES"%>
<%@page import="bingo.sso.core.authentication.password.Md5WithSaltPasswordEncoder"%>
<%@page import="bingo.dao.Dao"%>
<%! 
	int count = 0; 
	boolean hasInited = false;
%>
<%
count++;
String desKey = "f3n01oOrNPGACKJ2Fc2h6irVwinfaCl1";
DES des = new DES(DES.decode(desKey));
Md5WithSaltPasswordEncoder passwordEncoder = new Md5WithSaltPasswordEncoder();
((Md5WithSaltPasswordEncoder)passwordEncoder).setSaltText("DBAppSpecifiedSecretManager");
List<AppSpecifiedSecret> returnList =  Dao.get().queryForList(AppSpecifiedSecret.class, "appSpecifiedSecretManager.list",null);
boolean needInit = false;
boolean hasUnique = false;
String msg;
if(returnList == null || returnList.isEmpty()){
	msg = "没有应用专用密码数据，不需要初始化!";
} else if(hasInited){
	msg = "已经初始化过，不能再初始化!";
} else {
	for (AppSpecifiedSecret appSpecifiedSecret : returnList) {
		needInit = true;
		if("5ee4a841fbe2463984247f3916a67b02_init_data".equals(appSpecifiedSecret.getId())){
			needInit = false;
			break;
		}
	}
	if(needInit){
		hasInited = true;
		//插入数据，以表示已经初始化过
		AppSpecifiedSecret initSpecSecret = new AppSpecifiedSecret();
		initSpecSecret.setId("5ee4a841fbe2463984247f3916a67b02_init_data");
		initSpecSecret.setSecretUnique(false);
		initSpecSecret.setName("init_data");
		initSpecSecret.setUserId("init_data_user_id");
		initSpecSecret.setClientId("init_data_client_id");
		initSpecSecret.setSecretOri("init_data_secret");
		initSpecSecret.setSecret("init_data_secret");
		Dao.get().insert("appSpecifiedSecretManager.generate", initSpecSecret);
		
		for (AppSpecifiedSecret appSpecifiedSecret : returnList) {
			if(appSpecifiedSecret.isSecretUnique()){
				appSpecifiedSecret.setSecret(des.encrypte(appSpecifiedSecret.getSecret()));
			}else{
				appSpecifiedSecret.setSecret(passwordEncoder.encode(appSpecifiedSecret.getSecret()));
			}
			Dao.get().update("appSpecifiedSecretManager.update", appSpecifiedSecret);
		}
		msg = "总共更新了" + returnList.size() + "条记录";
	}else{
		msg = "已经初始化过，不能再初始化!";
	}
}
%>

<%=msg %>

