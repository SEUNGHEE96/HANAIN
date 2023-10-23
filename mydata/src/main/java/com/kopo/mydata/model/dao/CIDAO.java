package com.kopo.mydata.model.dao;

import org.apache.ibatis.annotations.Mapper;

import com.kopo.mydata.model.dto.CIDTO;

@Mapper
public interface CIDAO {

    CIDTO getCI(String identification);

}
