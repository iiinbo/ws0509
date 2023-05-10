package com.kbstar;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
@EnableScheduling // 스케쥴링 사용하겠다고 선언하기
@SpringBootApplication
public class Ws0509Application {

    public static void main(String[] args) {
        SpringApplication.run(Ws0509Application.class, args);
    }
    // JSP SETTING
    @Bean
    public InternalResourceViewResolver setupViewResolver() {
        InternalResourceViewResolver resolver = new InternalResourceViewResolver();
        resolver.setPrefix("/views/");
        resolver.setSuffix(".jsp");
        return resolver;
    }
}
