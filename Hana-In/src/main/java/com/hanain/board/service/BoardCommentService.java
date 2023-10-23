package com.hanain.board.service;

import com.hanain.board.model.dao.BoardCommentDAO;
import com.hanain.board.model.dto.BoardCommentDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BoardCommentService {

    @Autowired
    private BoardCommentDAO boardCommentDAO;

    public List<BoardCommentDTO> getCommentByBoardId(int boardId) {
        return boardCommentDAO.getCommentByBoardId(boardId);
    }

    public void insertComment(BoardCommentDTO boardCommentDTO) {
        boardCommentDAO.insertComment(boardCommentDTO);
    }

    public void insertReply(BoardCommentDTO boardCommentDTO) {
        boardCommentDAO.insertReply(boardCommentDTO);
    }

}
