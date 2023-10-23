package com.hanain.board.service;

import com.hanain.account.model.dto.BalanceDTO;
import com.hanain.board.model.dao.BoardDAO;
import com.hanain.board.model.dto.BoardDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class BoardService {

    @Autowired
    private BoardDAO boardDAO;

    public List<BoardDTO> getAllBoard() {
        return boardDAO.getAllBoard();
    }

    public List<BalanceDTO> getBalanceByBoardId(int boardId) {
        return boardDAO.getBalanceByBoardId(boardId);
    }

    public BoardDTO getBoardByBoardId(int boardId) {
        return boardDAO.getBoardByBoardId(boardId);
    }

}
