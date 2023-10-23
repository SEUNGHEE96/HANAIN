package com.hanain.proposal.controller;

import com.hanain.chat.model.dto.ChatRoomDTO;
import com.hanain.chat.service.ChatMessageService;
import com.hanain.chat.service.ChatRoomService;
import com.hanain.member.model.dto.MemberDTO;
import com.hanain.proposal.model.dto.ProposalCommentDTO;
import com.hanain.proposal.model.dto.ProposalDTO;
import com.hanain.proposal.model.dto.UnionDTO;
import com.hanain.proposal.service.ProposalCommentService;
import com.hanain.proposal.service.ProposalService;
import com.hanain.proposal.service.UnionService;
import com.hanain.stock.model.dto.StockDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Controller
public class ProposalController {

    private ProposalService proposalService;

    private UnionService unionService;

    private ProposalCommentService proposalCommentService;

    private ChatRoomService chatRoomService;

    private ChatMessageService chatMessageService;

    @Autowired
    public ProposalController(ProposalService proposalService, UnionService unionService, ProposalCommentService proposalCommentService, ChatRoomService chatRoomService, ChatMessageService chatMessageService) {
        this.proposalService = proposalService;
        this.unionService = unionService;
        this.proposalCommentService = proposalCommentService;
        this.chatRoomService = chatRoomService;
        this.chatMessageService = chatMessageService;
    }

    @GetMapping("/proposal")
    public ModelAndView proposal(@RequestParam(value = "page", defaultValue = "1") int page) {
        ModelAndView mv = new ModelAndView("/proposal/proposal");
        List<ProposalDTO> proposallist = proposalService.getPaginatedProposal(page);
        for(ProposalDTO proposalDTO : proposallist) {
            int commentCount = proposalCommentService.getCommentCountByProposalId(proposalDTO.getProposalId());
            proposalDTO.setComments(commentCount);
        };
        int totalPages = proposalService.getTotalPages();

        List<Integer> proposalIds = proposallist.stream()
                .map(ProposalDTO::getProposalId) // getProposalId는 ProposalDTO에서 proposalId를 반환하는 메서드라고 가정합니다.
                .collect(Collectors.toList());

        Map<String, Object> params = new HashMap<>();
        params.put("proposalIds", proposalIds);
        List<UnionDTO> unions = unionService.getUnionsByProposalIds(params);

        mv.addObject("proposallist", proposallist);
        mv.addObject("unions", unions);
        mv.addObject("currentPage", page);
        mv.addObject("totalPages", totalPages);
        return mv;
    }

    /**
     * 주주 제안 상세페이지 (개별게시글)
     * @param proposal_Id
     * @return
     */
    @GetMapping("/proposal/{proposalId}")
    public ModelAndView proposalDetail(@PathVariable("proposalId") int proposal_Id) {
        ModelAndView mv = new ModelAndView("/proposal/proposaldetail");
        ProposalDTO proposal = proposalService.getProposalById(proposal_Id);

        Map<String, Object> params = new HashMap<>();
        List<Integer> proposalIds = List.of(proposal.getProposalId());
        params.put("proposalIds", proposalIds);
        List<UnionDTO> unions = unionService.getUnionsByProposalIds(params);

        List<ProposalCommentDTO> comments = proposalCommentService.getCommentsByProposalId(proposal_Id);

        mv.addObject("comments", comments);
        mv.addObject("unions", unions);
        mv.addObject("proposal", proposal);
        return mv;
    }

    /**
     * 주주 제안 동참하기 버튼
     * @param proposalId
     * @param request
     * @return
     */
    @ResponseBody
    @PostMapping("/joinProposal")
    @Transactional
    public String joinProposal(@RequestParam("proposalId") int proposalId, HttpServletRequest request) {
        HttpSession session = request.getSession();
        MemberDTO memberDTO = (MemberDTO) session.getAttribute("currentUser");
        String memberId = memberDTO.getMemberId();

        UnionDTO unionDTO = new UnionDTO();
        unionDTO.setMemberId(memberId);
        unionDTO.setProposalId(proposalId);

        int check = unionService.checkUnion(unionDTO);
        if (check > 0) {
            return "이미 동참한 주주제안 입니다.";
        } else {
            unionService.insertUnion(unionDTO);
            proposalService.insertProposalParticipation(unionDTO);

            int chatRoomId = chatRoomService.findChatRoomById(proposalId);
            Map<String, Object> params = new HashMap<>();
            params.put("roomId", chatRoomId);
            params.put("memberId", memberId);
            chatRoomService.addParticipant(params);
            return "동참하였습니다.";
        }
    }

    /**
     * 주주제안 철회하기 버튼
     * @param proposalId
     * @param request
     * @return
     */
    @ResponseBody
    @PostMapping("/leaveProposal")
    @Transactional
    public String leaveProposal(@RequestParam("proposalId") int proposalId, HttpServletRequest request) {
        HttpSession session = request.getSession();
        MemberDTO memberDTO = (MemberDTO) session.getAttribute("currentUser");
        String memberId = memberDTO.getMemberId();

        UnionDTO unionDTO = new UnionDTO();
        unionDTO.setMemberId(memberId);
        unionDTO.setProposalId(proposalId);

        int check = unionService.checkUnion(unionDTO);
        if (check > 0) {
            unionService.deleteUnion(unionDTO);
            proposalService.leaveProposalParticipation(unionDTO);

            int chatRoomId = chatRoomService.findChatRoomById(proposalId);
            Map<String, Object> params = new HashMap<>();
            params.put("roomId", chatRoomId);
            params.put("memberId", memberId);
            chatRoomService.deleteParticipant(params);
            return "철회하였습니다.";
        } else {
            return "동참하지 않은 주주제안 입니다.";
        }
    }

    /**
     * 주주제안 작성 폼으로 이동
     * @param request
     * @return
     */
    @GetMapping("/writeproposal")
    public ModelAndView writeProposal(HttpServletRequest request) {
        ModelAndView mv = new ModelAndView("/proposal/proposalform");
        List<StockDTO> userStocks = (List<StockDTO>) request.getAttribute("userStocks");
        mv.addObject("userStocks", userStocks);
        return mv;
    }

    /**
     * 새로운 주주제안 작성
     * @param postRequest
     * @return
     */
    @PostMapping("/createPost")
    @Transactional
    public String createPost(@ModelAttribute ProposalDTO postRequest) {// content에서 <p></p> 태그 제거
        // 내용에 <p></p>들어가는 것 방지
        String content = postRequest.getContent();
        content = content.replace("<p>", "");
        content = content.replace("</p>", "");
        postRequest.setContent(content);

        proposalService.insertProposal(postRequest);
        
        // 주주제안 이름의 채팅방 생성
        ChatRoomDTO chatRoomDTO = new ChatRoomDTO();
        chatRoomDTO.setTitle(postRequest.getTitle());
        chatRoomDTO.setType(1);
        chatRoomService.createChatRoom(chatRoomDTO);

        // 주주제안 작성자는 해당 채팅방에 추가하고 시작
        int createdChatRoomId = chatRoomDTO.getRoomId();
        Map<String, Object> params = new HashMap<>();
        params.put("roomId", createdChatRoomId);
        params.put("memberId", postRequest.getMemberId());
        chatRoomService.addParticipant(params);
        chatMessageService.insertFirstMessage(params);

        // 주주제안 작성자는 Union에 추가하고 시작
        UnionDTO unionDTO = new UnionDTO();
        unionDTO.setMemberId(postRequest.getMemberId());
        unionDTO.setProposalId(postRequest.getProposalId());
        unionService.insertUnion(unionDTO);

        return "redirect:/proposal";
    }

}
