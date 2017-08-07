/**
 * This file created at 2010-10-13.
 *
 * Copyright (c) 2002-2010 Bingosoft, Inc. All rights reserved.
 */
package bingo.sso.server.web.validate;

import java.util.Random;

import javax.servlet.http.HttpServletRequest;

/**
 * <code>{@link ValidateCodeUtil}</code>
 * 
 * TODO : document me
 * 
 * @author yohn
 */
public class ValidateCodeUtil {
	private final static String RANDOM_CODE_KEY_PREFIX = ValidateCodeUtil.class
			.getName()
			+ "_";
	private final static char[] codeSequence = { '0', '1', '2', '3', '4', '5',
			'6', '7', '8', '9' };
	private final static Random random = new Random();

	public static String genRandomCode(int codeCount) {

		StringBuffer ret = new StringBuffer();
		for (int i = 0; i < codeCount; i++) {
			ret.append(String.valueOf(codeSequence[random.nextInt(10)]));
		}

		return ret.toString();

	}

	public static void storeRandomCode(String randomCode, HttpServletRequest req) {
		String pageKey = req.getParameter("pageKey");
		req.getSession().setAttribute(RANDOM_CODE_KEY_PREFIX + pageKey,
				randomCode);
	}

	public static String revertRandomCode(HttpServletRequest req) {
		String pageKey = req.getParameter("pageKey");
		return (String) req.getSession().getAttribute(
				RANDOM_CODE_KEY_PREFIX + pageKey);
	}

	public static boolean validateCode(String randomCode, HttpServletRequest req) {
		String revertRandomCode = revertRandomCode(req);
		if (revertRandomCode != null && revertRandomCode.equals(randomCode)) {
			return true;
		}

		return false;
	}
}
