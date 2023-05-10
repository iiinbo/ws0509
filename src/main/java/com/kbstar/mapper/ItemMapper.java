package com.kbstar.mapper;



import com.kbstar.dto.Item;

import com.kbstar.dto.ItemSearch;
import com.kbstar.frame.KBMapper;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Mapper
public interface ItemMapper extends KBMapper<Integer, Item> {

    // 2가지 검색조건을 걸어서, item의 정보를 가져오고 싶다면?
    // 아래 함수 새로 만들기 전, DTO 새로 만들기(조건 개수만 딱 맞게)
    public List<Item> search(ItemSearch ic);
    // ItemSearch db에서 ic 스트링 가져오기.

}