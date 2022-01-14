package com.sennet.dbms;

import java.sql.SQLException;

import javax.sql.DataSource;

import lombok.extern.slf4j.Slf4j;

import org.apache.commons.dbcp.BasicDataSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import com.sennet.common.SennetProperty;
import com.sennet.gator.admin.client.util.DbconfigDecryptor;

@Configuration
@Slf4j
public class DbcpConfiguration {

	@Autowired
	private SennetProperty prop;

	@Bean
	public DataSource dataSource() throws SQLException {

		DbconfigDecryptor dbconfigDecryptor = new DbconfigDecryptor();

		if (!dbconfigDecryptor.initAESKey(prop.getKeypath())) {
			// TODO DB연결 장애시 에레 Response 처리하기!
		} else {
		}
		BasicDataSource dataSource = new BasicDataSource();
		dataSource.setUsername(dbconfigDecryptor.decryptUserid(prop.getDbid()));
		dataSource.setPassword(dbconfigDecryptor.decryptPassword(prop.getDbpassword()));
		dataSource.setUrl(prop.getDburl());
		dataSource.setDriverClassName(prop.getDriverclassname());
		dataSource.setTestWhileIdle(true);
		dataSource.setValidationQuery("select count(*) from um_user_profile");
		dataSource.setTimeBetweenEvictionRunsMillis(1000000);
		dataSource.setMaxIdle(20);
		dataSource.setMaxActive(50);
		dataSource.setMaxWait(10000);
		return dataSource;

	}
}