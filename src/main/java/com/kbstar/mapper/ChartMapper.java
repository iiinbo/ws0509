package com.kbstar.mapper;

import com.kbstar.dto.Chart;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Mapper
public interface ChartMapper  {
    // extends 를 지금까진 KBMapper를 받았지만 의미가 없다. 5가지 함수는 안쓰니까.
    // 그래서, 어드민에서 차트뿌리는 목적이 데이터 분석 관리라면, 새로운 별도 인터페이스를 만드는 것도 방법이다.
    // 성별 기준으로 월별 매출액 구하기
    List<Chart> MonthTotal();
}
