package com.cloud.web;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication(scanBasePackages= {"com.cloud.web"})
@MapperScan(value={"com.cloud.web"})
public class CloudProjectsApplication {

	public static void main(String[] args) {
		SpringApplication.run(CloudProjectsApplication.class, args);
	}
}