package com.sunh.mms;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@MapperScan("com.sunh.mms.dao")
public class MmsApplication {

    public static void main(String[] args) {
        SpringApplication.run(MmsApplication.class, args);
    }

}
