package com.kbstar.mapper;

import com.kbstar.dto.Sales;
import com.kbstar.frame.KBMapper;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Mapper
public interface SalesMapper extends KBMapper<String, Sales> {
    // 성별 기준으로 월별 매출액 구하기
    public List<Sales> search();
}
