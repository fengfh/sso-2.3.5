package bingo.sso.server.web;

import org.apache.commons.jexl2.Expression;
import org.apache.commons.jexl2.JexlContext;
import org.apache.commons.jexl2.JexlEngine;
import org.apache.commons.jexl2.MapContext;
import org.junit.Test;

public class JXELTest {

	@Test
	public void test(){
		// Create a JexlEngine (could reuse one instead)   
        JexlEngine jexl = new JexlEngine();   
        // Create an expression object   
        String jexlExp = "runtime.user_mode.contains('ad')";   
        Expression e = jexl.createExpression( jexlExp );   

        // Create a context and add data   
        JexlContext jc = new MapContext();   
        jc.set("runtime.user_mode", "ad,db");   

        // Now evaluate the expression, getting the result   
        Object o = e.evaluate(jc);  
        System.out.println(o);
	}

}
