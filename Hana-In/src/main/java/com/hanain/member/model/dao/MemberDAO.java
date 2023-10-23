package com.hanain.member.model.dao;

import com.hanain.member.model.dto.LoginDTO;
import com.hanain.member.model.dto.MemberDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface MemberDAO {

    List<MemberDTO> getAllMember();
    MemberDTO login(LoginDTO loginDTO);

    void updateStatus(String phone);

    void updateCIByMemberId(Map<String, Object> map);
}
