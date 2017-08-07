ssodb.h2.db使用 
1、配置JDBC
<entry key="jdbc.driverClassName">org.h2.Driver</entry>
<entry key="jdbc.url">jdbc:h2:~/ssodb;DB_CLOSE_DELAY=-1;MODE=Oracle</entry>
<entry key="jdbc.username">sso</entry>
<entry key="jdbc.password">sso123</entry>
<entry key="jdbc.initialSize">2</entry>
<entry key="jdbc.maxActive">5</entry>
<entry key="jdbc.maxIdle">5</entry>
<entry key="jdbc.minIdle">1</entry>
<entry key="jdbc.validationQuery">select 1 from dual</entry>
2、把ssodb.h2.db拷贝到某个目录下，并和jdbc.url指定的路径一致