package com.kopo.mydata;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class MydataApplication {

	public static void main(String[] args) {
		SpringApplication.run(MydataApplication.class, args);
		System.out.println("마이데이터 API 실행");
	}

}
