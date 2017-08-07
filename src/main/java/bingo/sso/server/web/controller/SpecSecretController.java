package bingo.sso.server.web.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import bingo.sso.api.ISingleSignOnController;
import bingo.sso.api.appspecifiedsecret.AppSpecifiedSecret;
import bingo.sso.api.appspecifiedsecret.IAppSpecifiedSecretManager;
import bingo.sso.api.authentication.Authentication;
import bingo.sso.api.ticket.TicketGrantingTicket;

@Controller
public class SpecSecretController {
	private ISingleSignOnController singleSignOnController;
	private IAppSpecifiedSecretManager appSpecifiedSecretManager; 

	@RequestMapping(value = "/specsecret/list")
	public @ResponseBody List<AppSpecifiedSecret> list(HttpServletRequest req, HttpServletResponse resp) {
		String userId = validateLogin(req, resp);
		Map params = new HashMap();
		params.put("userId", userId);
		params.put("secretUnique", 0);
		return appSpecifiedSecretManager.list(params);
	}

	@RequestMapping(value = "/specsecret/gen")
	public @ResponseBody String gen(HttpServletRequest req, HttpServletResponse resp,String name, String secret) {
		String userId = validateLogin(req, resp);
		AppSpecifiedSecret appSpecifiedSecret = new AppSpecifiedSecret();
		appSpecifiedSecret.setSecretUnique(false);
		appSpecifiedSecret.setName(name);
		appSpecifiedSecret.setUserId(userId);
		appSpecifiedSecret.setSecretOri(secret);
		appSpecifiedSecret = appSpecifiedSecretManager.generate(appSpecifiedSecret);
		
		return appSpecifiedSecret.getSecretOri();
	}

	@RequestMapping(value = "/specsecret/cancel/{id}")
	public @ResponseBody void cancel(HttpServletRequest req, HttpServletResponse resp,@PathVariable String id) {
		String userId = validateLogin(req, resp);
		appSpecifiedSecretManager.delete(id);
	}	

	public void setAppSpecifiedSecretManager(
			IAppSpecifiedSecretManager appSpecifiedSecretManager) {
		this.appSpecifiedSecretManager = appSpecifiedSecretManager;
	}

	public void setSingleSignOnController(
			ISingleSignOnController singleSignOnController) {
		this.singleSignOnController = singleSignOnController;
	}
	
	public String validateLogin(HttpServletRequest req, HttpServletResponse resp){
		//为应用分配的应用专用密码ClientId，在产生之前就绑定.（另外一种思路是，在第一次消费的时候进行绑定,推荐这种）
		TicketGrantingTicket ticketGrantingTicket = singleSignOnController.getCurrentTicketGrantingTicket(req, resp);
		if (ticketGrantingTicket != null && !ticketGrantingTicket.isExpired()){
			Authentication authentication = ticketGrantingTicket.getAuthentication();
			String userId = authentication.getPrincipal().getId();
			
			return userId;
		}
		
		throw new RuntimeException("只有登录用户才能操作！");
	}

}
