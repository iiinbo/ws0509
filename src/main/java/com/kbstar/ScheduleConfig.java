package com.kbstar;

import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.SchedulingConfigurer;
import org.springframework.scheduling.concurrent.ThreadPoolTaskScheduler;
import org.springframework.scheduling.config.ScheduledTaskRegistrar;

// 스케쥴이 돌아갈 수 있게 멀티스레드 환경으로 설정해주기. (한 브라우저에서 여러동작 가능)
@Configuration
public class ScheduleConfig implements SchedulingConfigurer

{
    private final int POOL_SIZE = 6; // 6개의 풀을 사용하기.

    @Override
    public void configureTasks(ScheduledTaskRegistrar registry) {
        ThreadPoolTaskScheduler threadPoolTaskScheduler = new ThreadPoolTaskScheduler();

        threadPoolTaskScheduler.setPoolSize(POOL_SIZE);
        threadPoolTaskScheduler.setThreadNamePrefix("CommB-Scheduled-task-");
        threadPoolTaskScheduler.initialize();

        registry.setTaskScheduler(threadPoolTaskScheduler);
    }

}