package bingo.sso.server.web;

import bingo.dao.sql.dialect.BaseDialect;

/**
 * <code>{@link H2Dialect}</code>
 *
 * TODO : document me
 *
 * @author yohn
 */
public class H2Dialect extends BaseDialect{
	
	private final static String dialectName = "H2";

	public H2Dialect() {
		this.setName(dialectName);
	}

	/* (non-Javadoc)
	 * @see bingo.dao.sql.dialect.BaseDialect#wrapPageSql(java.lang.String, java.lang.String)
	 */
	@Override
	public String wrapPageSql(String sql, String orderClause) {
		// TODO implement BaseDialect.wrapPageSql
		return sql;
	}
}
