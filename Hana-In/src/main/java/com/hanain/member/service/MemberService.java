package com.hanain.member.service;

import com.hanain.member.model.dao.MemberDAO;
import com.hanain.member.model.dto.LoginDTO;
import com.hanain.member.model.dto.MemberDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class MemberService{

    @Autowired
    private MemberDAO memberDAO;

    public MemberService(MemberDAO memberDAO) {
        this.memberDAO = memberDAO;
    }

    public List<MemberDTO> getAllMember() {
        return memberDAO.getAllMember();
    }

    public MemberDTO login(LoginDTO loginDTO) {
        return memberDAO.login(loginDTO);
    }

    public void updateStatus(String phone) {
        memberDAO.updateStatus(phone);
    }

    public void updateCIByMemberId(Map<String, Object> map) {
        memberDAO.updateCIByMemberId(map);
    }

}
