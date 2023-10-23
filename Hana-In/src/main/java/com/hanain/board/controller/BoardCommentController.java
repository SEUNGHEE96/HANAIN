package com.hanain.board.controller;

import com.hanain.board.model.dto.BoardCommentDTO;
import com.hanain.board.service.BoardCommentService;
import com.hanain.member.model.dto.MemberDTO;
import com.hanain.proposal.model.dto.ProposalCommentDTO;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Controller
public class BoardCommentController {

    private BoardCommentService boardCommentService;

    public BoardCommentController(BoardCommentService boardCommentService) {
        this.boardCommentService = boardCommentService;
    }

    @ResponseBody
    @PostMapping("/board-reply")
    public void insertComment(BoardCommentDTO boardCommentDTO, HttpServletRequest request) {
        HttpSession session = request.getSession();
        MemberDTO memberDTO = (MemberDTO) session.getAttribute("currentUser");
        String memberId = memberDTO.getMemberId();

        boardCommentDTO.setMemberId(memberId);
        boardCommentService.insertComment(boardCommentDTO);
    }

    @ResponseBody
    @PostMapping("/board-rereply")
    public void insertReply(BoardCommentDTO boardCommentDTO, HttpServletRequest request) {
        HttpSession session = request.getSession();
        MemberDTO memberDTO = (MemberDTO) session.getAttribute("currentUser");
        String memberId = memberDTO.getMemberId();
        boardCommentDTO.setMemberId(memberId);

        if(boardCommentDTO.getParent() != 0) {
            boardCommentService.insertReply(boardCommentDTO);
        }
    }

}
