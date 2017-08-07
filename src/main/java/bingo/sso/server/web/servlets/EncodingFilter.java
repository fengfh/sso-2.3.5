package bingo.sso.server.web.servlets;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

/**
 * Set request's character encoding to UTF-8.
 * 
 * @author fenghm(fenghm@bingosoft.net)
 * @since 1.0.0
 */
public class EncodingFilter implements Filter {

	public static final String ENCODING = "UTF-8";
	
    public void init(FilterConfig filterConfig) throws ServletException {
    	
    }

    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        request.setCharacterEncoding(ENCODING);
        chain.doFilter(request, response);
    }

    public void destroy() {
    	
    }
}
