package com.kbstar.service;

import com.kbstar.dto.Chart;
import com.kbstar.mapper.ChartMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
@Slf4j
public class ChartService {
    @Autowired
    ChartMapper chartMapper;

    public List<Chart> MonthTotal() throws Exception{
        return chartMapper.MonthTotal();
    }
}
