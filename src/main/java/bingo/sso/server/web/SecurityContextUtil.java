/**
 * This file created at 2012-3-31.
 *
 * Copyright (c) 2002-2012 Bingosoft, Inc. All rights reserved.
 */
package bingo.sso.server.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bingo.sso.api.ISingleSignOnController;
import bingo.sso.api.ticket.TicketGrantingTicket;
import bingo.sso.openid.IOpenIdIdentifierParser;

/**
 * <code>{@link SecurityContextUtil}</code>
 *
 * TODO : document me
 *
 * @author yohn
 */
public class SecurityContextUtil {
	private static ISingleSignOnController singleSignOnController;
	private static IOpenIdIdentifierParser openIdIdentifierParser;
	
	public static boolean isLogined(HttpServletRequest req, HttpServletResponse resp){
		TicketGrantingTicket ticketGrantingTicket = singleSignOnController.getCurrentTicketGrantingTicket(req, resp);
		return ticketGrantingTicket != null && !ticketGrantingTicket.isExpired();
	}

	public static String getAccount(HttpServletRequest req, HttpServletResponse resp){
		TicketGrantingTicket ticketGrantingTicket = singleSignOnController.getCurrentTicketGrantingTicket(req, resp);
		if (ticketGrantingTicket != null && !ticketGrantingTicket.isExpired()){
			return ticketGrantingTicket.getAuthentication().getPrincipal().getId();
		}
		
		return null;
	}
	
	public static String getOpenIdIdentifier(HttpServletRequest req, HttpServletResponse resp){
		TicketGrantingTicket ticketGrantingTicket = singleSignOnController.getCurrentTicketGrantingTicket(req, resp);
		if (ticketGrantingTicket != null && !ticketGrantingTicket.isExpired()){
			return openIdIdentifierParser.account2Identifier(req, ticketGrantingTicket.getAuthentication().getPrincipal().getId());
		}

		return null;
	}


	/**
	 * @param openIdIdentifierParser the openIdIdentifierParser to set
	 */
	public void setOpenIdIdentifierParser(
			IOpenIdIdentifierParser openIdIdentifierParser) {
		SecurityContextUtil.openIdIdentifierParser = openIdIdentifierParser;
	}

	public void setSingleSignOnController(
			ISingleSignOnController singleSignOnController) {
		SecurityContextUtil.singleSignOnController = singleSignOnController;
	}

		
}
