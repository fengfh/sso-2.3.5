package bingo.sso.server.web.validate;

import javax.servlet.http.HttpServletRequest;

import bingo.sso.core.authentication.IBadAuthenticateCounter;
import bingo.sso.core.authentication.form.IRandomCodeValidator;

public class RandomCodeValidator implements IRandomCodeValidator{
	protected IBadAuthenticateCounter badAuthenticateCounter;
	/**
	 * 迁移到IBadAuthenticateCounter中,由IBadAuthenticateCounter直接给出帐号是否被锁定
	 */
	@Deprecated
	protected int badAuthenticateCount = 5;
	
	public boolean validateCode(String randomCode, HttpServletRequest req) {
		return ValidateCodeUtil.validateCode(randomCode, req);
	}

	public boolean isNeedValidate(String credentialsType, String identity, HttpServletRequest req) {
		if(badAuthenticateCounter == null){
			return false;
		}
		
		return badAuthenticateCounter.isLocked(credentialsType, identity);
	}

	public void setBadAuthenticateCounter(
			IBadAuthenticateCounter badAuthenticateCounter) {
		this.badAuthenticateCounter = badAuthenticateCounter;
	}

	@Deprecated
	public void setBadAuthenticateCount(int badAuthenticateCount) {
		this.badAuthenticateCount = badAuthenticateCount;
	}


}
