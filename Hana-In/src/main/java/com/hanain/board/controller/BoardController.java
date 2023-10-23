package com.hanain.board.controller;

import com.hanain.account.model.dto.BalanceDTO;
import com.hanain.board.model.dto.BoardCommentDTO;
import com.hanain.board.model.dto.BoardDTO;
import com.hanain.board.service.BoardCommentService;
import com.hanain.board.service.BoardService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

@Controller
public class BoardController {

    private BoardService boardService;

    private BoardCommentService boardCommentService;

    public BoardController(BoardService boardService, BoardCommentService boardCommentService) {
        this.boardService = boardService;
        this.boardCommentService = boardCommentService;
    }

    @RequestMapping("/board")
    public ModelAndView board() {
        ModelAndView mav = new ModelAndView("/board/board");
        List<BoardDTO> boardlist = boardService.getAllBoard();
        for (BoardDTO boardDTO : boardlist) {
            List<BalanceDTO> balancelist = boardService.getBalanceByBoardId(boardDTO.getBoardId());
            if (balancelist.size() == 0) {
                boardDTO.setBalanceDTO(null);
            } else if(balancelist.size() > 1) {
                BalanceDTO balanceDTO2 = new BalanceDTO();
                balanceDTO2.setAccountId(balancelist.get(0).getAccountId());
                balanceDTO2.setIsin(balancelist.get(0).getIsin());
                for (BalanceDTO balanceDTO1 : balancelist) {
                    balanceDTO2.setGradeId(Math.max(balanceDTO1.getGradeId(), balanceDTO2.getGradeId()));
                    balanceDTO2.setQuantity(balanceDTO1.getQuantity() + balanceDTO2.getQuantity());
                    balanceDTO2.setAveragePrice( (balanceDTO1.getAveragePrice() * balanceDTO1.getQuantity()) + (balanceDTO2.getAveragePrice() * balanceDTO2.getQuantity()) / (balanceDTO1.getQuantity() + balanceDTO2.getQuantity()));
                }
                boardDTO.setBalanceDTO(balanceDTO2);
            } else {
                boardDTO.setBalanceDTO(balancelist.get(0));
            }
        }
        mav.addObject("boardlist", boardlist);
        return mav;
    }

    @GetMapping("/board/{boardId}")
    public ModelAndView boardDetail(@PathVariable("boardId") int boardId) {
        ModelAndView mv = new ModelAndView("/board/boarddetail");
        BoardDTO board = boardService.getBoardByBoardId(boardId);

        List<BoardCommentDTO> boardCommentList = boardCommentService.getCommentByBoardId(boardId);
        mv.addObject("boardCommentList", boardCommentList);
        mv.addObject("board", board);
        return mv;
    }

}
