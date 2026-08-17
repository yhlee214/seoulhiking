package sh;

import java.sql.Connection;
import java.sql.SQLException;

import org.apache.tomcat.dbcp.dbcp2.BasicDataSource;

public class DBUtil {
	public static Connection getConnection() throws SQLException {
		BasicDataSource ds = new BasicDataSource();
		ds.setUrl("jdbc:mysql://localhost:3306/sh");
		ds.setUsername("root");
		ds.setPassword("rootroot");
		ds.setDriverClassName("com.mysql.cj.jdbc.Driver");
		Connection conn = ds.getConnection();
		return conn; 
	}
}	
