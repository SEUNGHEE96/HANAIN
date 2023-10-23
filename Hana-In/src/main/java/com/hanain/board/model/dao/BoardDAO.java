package com.hanain.board.model.dao;

import com.hanain.account.model.dto.BalanceDTO;
import com.hanain.board.model.dto.BoardDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface BoardDAO {

    List<BoardDTO> getAllBoard();

    List<BalanceDTO> getBalanceByBoardId(int boardId);

    BoardDTO getBoardByBoardId(int boardId);

}
