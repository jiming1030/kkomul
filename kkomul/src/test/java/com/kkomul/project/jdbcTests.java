package com.kkomul.project;

import java.sql.Connection;
import java.sql.DriverManager;

import org.junit.Test;

import lombok.extern.log4j.Log4j;

@Log4j
public class jdbcTests {

	// DB 연동
	private static final String DRIVER = "oracle.jdbc.driver.OracleDriver";
	private static final String URL = "jdbc:oracle:thin:@localhost:1521:XE";
	private static final String USER = "kkomul_s";
	private static final String PW = "1234";

	static {
		try {
			Class.forName(DRIVER);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@Test
	public void testConnection() {
		
		try(Connection con = DriverManager.getConnection(URL, USER, PW)) {
			log.info(con);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
