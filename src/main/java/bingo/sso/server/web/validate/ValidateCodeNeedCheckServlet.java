package bingo.sso.server.web.validate;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bingo.sso.api.authentication.principal.CredentialsTypeEnum;
import bingo.sso.core.authentication.form.IRandomCodeValidator;

/**
 * 生成随机验证码
 * 
 * @author bitiliu
 * 
 */
public class ValidateCodeNeedCheckServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	
	private IRandomCodeValidator randomCodeValidator;

	protected void service(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, java.io.IOException {
		String username = req.getParameter("username");
		String credentialsType = req.getParameter("credential_type");
		if(credentialsType == null || "".equals(credentialsType)){
			credentialsType = CredentialsTypeEnum.PASSWORD.value();
		}
		boolean isNeed = false;
		if(randomCodeValidator == null){
			isNeed = false;
		} else if(username == null || "".equals(username)){
			isNeed = false;
		}else{
			isNeed = randomCodeValidator.isNeedValidate(credentialsType, username, req);
		}
		
		resp.getWriter().write(String.format("{\"needcode\":%s}", isNeed));
	}

	public void setRandomCodeValidator(IRandomCodeValidator randomCodeValidator) {
		this.randomCodeValidator = randomCodeValidator;
	}
}