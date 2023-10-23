package com.hanain.proposal.controller;

import com.hanain.member.model.dto.MemberDTO;
import com.hanain.proposal.model.dto.ProposalCommentDTO;
import com.hanain.proposal.service.ProposalCommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Controller
public class ProposalCommentController {

    @Autowired
    private ProposalCommentService proposalCommentService;

    @ResponseBody
    @PostMapping("/reply")
    public void insertComment(ProposalCommentDTO proposalCommentDTO, HttpServletRequest request) {
        HttpSession session = request.getSession();
        MemberDTO memberDTO = (MemberDTO) session.getAttribute("currentUser");
        String memberId = memberDTO.getMemberId();

        proposalCommentDTO.setMemberId(memberId);
        proposalCommentService.insertComment(proposalCommentDTO);
    }

    @ResponseBody
    @PostMapping("/rereply")
    public void insertReply(ProposalCommentDTO proposalCommentDTO, HttpServletRequest request) {
        HttpSession session = request.getSession();
        MemberDTO memberDTO = (MemberDTO) session.getAttribute("currentUser");
        String memberId = memberDTO.getMemberId();
        proposalCommentDTO.setMemberId(memberId);

        if(proposalCommentDTO.getParent() != 0) {
            proposalCommentService.insertReply(proposalCommentDTO);
        }
    }

}
