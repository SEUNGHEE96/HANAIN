package com.hanain.board.model.dao;

import com.hanain.board.model.dto.BoardCommentDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface BoardCommentDAO {

    List<BoardCommentDTO> getCommentByBoardId(int boardId);

    void insertComment(BoardCommentDTO boardCommentDTO);

    void insertReply(BoardCommentDTO boardCommentDTO);

}
