package com.hanain.member.controller;

import com.hanain.account.model.dto.AccountDTO;
import com.hanain.account.model.dto.BalanceDTO;
import com.hanain.account.model.dto.TradeDTO;
import com.hanain.account.service.AccountService;
import com.hanain.account.service.BalanceService;
import com.hanain.account.service.TradeService;
import com.hanain.chat.model.dto.ChatRoomDTO;
import com.hanain.chat.service.ChatRoomService;
import com.hanain.member.model.dto.LoginDTO;
import com.hanain.member.model.dto.MemberDTO;
import com.hanain.member.service.MemberService;
import com.hanain.proposal.model.dto.ProposalDTO;
import com.hanain.proposal.service.ProposalService;
import com.hanain.stock.model.dto.StockDTO;
import com.hanain.stock.service.StockService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.net.URI;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.concurrent.TimeUnit;
import java.util.stream.Collectors;

@Controller
public class MemberController {

    @Autowired
    private MemberService memberService;

    @Autowired
    private ProposalService proposalService;

    @Autowired
    private AccountService accountService;

    @Autowired
    private TradeService tradeService;

    @Autowired
    private BalanceService balanceService;

    @Autowired
    private ChatRoomService chatRoomService;

    @Autowired
    private StockService stockService;

    @RequestMapping("/about")
    public ModelAndView about() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("about");
        return mv;
    }

    @RequestMapping("/service")
    public ModelAndView service() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("service");
        return mv;
    }

    @RequestMapping("/blog")
    public ModelAndView blog() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("blog");
        return mv;
    }

    @RequestMapping("/contact")
    public ModelAndView contact() {
        ModelAndView mv = new ModelAndView();
        mv.setViewName("contact");
        return mv;
    }

    // ------------------------------템플릿 끝--------------------------------

    @GetMapping("/login")
    public String loginForm(Model model) {
        model.addAttribute("loginDTO", new LoginDTO());
        return "member/login";
    }

    @PostMapping("/login")
    public String loginProcess(@Valid LoginDTO loginDTO, Errors errors, Model model, HttpServletRequest request, HttpSession session) {
        if (errors.hasErrors()) { // error가 존재시에 다시 로그인 페이지로 이동
            return "member/login";
        } else {
            MemberDTO memberDTO = memberService.login(loginDTO);
            if(memberDTO == null) {  //id와 password가 틀린경우, 사용자 없음,
                model.addAttribute("msg","id와 password를 다시 확인하세요.");
                return "member/login";  //다시 로그인 하는 페이지로 이동
            }
            session.setAttribute("currentUser", memberDTO);
            session.setMaxInactiveInterval(30 * 60); // 30분
            System.out.println(memberDTO);
            String dest = (String) session.getAttribute("dest");
            session.removeAttribute("dest");
            if (dest == null) {
                return "redirect:/";
            } else {
                return "redirect:" + dest;
            }
        } // 존재하지 않을 때
    }

    @GetMapping("/join")
    public ModelAndView join() {
        ModelAndView mv = new ModelAndView("/member/join");
        return mv;
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }

    @GetMapping("/mypage")
    public String mypage(HttpSession session, Model model, @RequestParam(value = "page", defaultValue = "1") int page) {
        // 세션에서 현재 로그인한 사용자 정보를 가져옴
        MemberDTO currentUser = (MemberDTO) session.getAttribute("currentUser");
        if (currentUser == null) {
            // 만약 사용자 정보가 세션에 없다면 (즉, 로그인하지 않은 상태라면)
            return "redirect:/login";  // 로그인 페이지로 리다이렉트
        }
        // Model에 로그인한 사용자 정보 추가
        model.addAttribute("currentUser", currentUser);

        Map<String, Object> params = new HashMap<>();
        params.put("page", page);
        params.put("memberId", currentUser.getMemberId());
        List<ProposalDTO> participatedProposalList = proposalService.getParticipatedProposalByMemberId(params);
        model.addAttribute("participatedProposalList", participatedProposalList);

        List<ProposalDTO> participatedProposalList2 = proposalService.getParticipatedProposalByMemberId2(currentUser.getMemberId());
        model.addAttribute("participatedProposalList2", participatedProposalList2);
        //participatedProposalList 길이
        int totalProposals = proposalService.getProposalCountByMemberId(currentUser.getMemberId());
        model.addAttribute("totalProposals", totalProposals);

        int countOnGoing = 0;
        for(ProposalDTO p : participatedProposalList2) {
            if(p.getStatus() == 0 ) {
                countOnGoing++;
            }
        }
        model.addAttribute("countOnGoing", countOnGoing);

        int totalPages = (int) Math.ceil((double)totalProposals / 5);
        model.addAttribute("totalPages", totalPages);

        Date now = new Date();
        model.addAttribute("now", now);

        List<ChatRoomDTO> privateChatRoomList = chatRoomService.findPrivateChatRoomByMemberId(currentUser.getMemberId());
        List<ChatRoomDTO> groupChatRoomList = chatRoomService.findGroupChatRoomByMemberId(currentUser.getMemberId());

        List<ChatRoomDTO> allChatRoomList = new ArrayList<>();
        allChatRoomList.addAll(privateChatRoomList);
        allChatRoomList.addAll(groupChatRoomList);

        // lastMessage의 regDate 기준으로 내림차순 정렬
        allChatRoomList.sort(Comparator.comparing(
                (ChatRoomDTO chatRoomDTO) -> chatRoomDTO.getLastMessage().getRegDate()).reversed());
        model.addAttribute("allChatRoomList", allChatRoomList);

        // 주주제안 차트용 데이터
        // Java Controller
        List<Double> rates = participatedProposalList.stream()
                .map(proposal -> Math.max(proposal.getRate1(), proposal.getRate2()))
                .collect(Collectors.toList());
        model.addAttribute("rates", rates);

        return "member/mypage";
    }

    @GetMapping("/mybalance")
    public String mybalance(HttpSession session, Model model, @RequestParam(value = "page", defaultValue = "1") int page) {
        // 세션에서 현재 로그인한 사용자 정보를 가져옴
        MemberDTO currentUser = (MemberDTO) session.getAttribute("currentUser");
        if (currentUser == null) {
            // 만약 사용자 정보가 세션에 없다면 (즉, 로그인하지 않은 상태라면)
            return "redirect:/login";  // 로그인 페이지로 리다이렉트
        }
        // Model에 로그인한 사용자 정보 추가
        model.addAttribute("currentUser", currentUser);

        List<AccountDTO> accountlist = accountService.getAccountByMemberId(currentUser.getMemberId());
        long totalBalance = 0;
        for (AccountDTO account : accountlist) {
            totalBalance += account.getCash();
        }
        model.addAttribute("accountlist", accountlist);
        model.addAttribute("totalBalance", totalBalance);

        // 거래내역 목록에 보여줄 거래 내역 (페이징)
        Map<String, Object> params = new HashMap<>();
        params.put("page", page);
        params.put("memberId", currentUser.getMemberId());
        List<TradeDTO> tradelist = tradeService.getTradeByMemberId(params);
        model.addAttribute("tradelist", tradelist);

        // 거래내역 페이지 갯수 구하기
        int totalTradeCount = tradeService.getTradeCountByMemberId(currentUser.getMemberId());
        int totalPages = (int) Math.ceil((double)totalTradeCount / 7);
        model.addAttribute("totalPages", totalPages);

        // 이번 달에 거래한 trade 갯수 세기
        int thisMonthTradeCount = tradeService.getTradeCountThisMonthByMemberId(currentUser.getMemberId());
        model.addAttribute("thisMonthTradeCount", thisMonthTradeCount);

        // 파이차트 그릴 때 필요한 잔고(=보유 주식) 리스트
        List<BalanceDTO> balancelist = balanceService.getBalanceByMemberId(currentUser.getMemberId());
        model.addAttribute("balancelist", balancelist);
        long totalStockPrice = 0;
        for (BalanceDTO balance : balancelist) {
            totalStockPrice += balance.getAveragePrice() * balance.getQuantity();
        }
        model.addAttribute("totalStockPrice", totalStockPrice);
        return "member/mybalance";
    }

    @PostMapping("/ocrResult")
    public ResponseEntity<String> ocrResult(@RequestBody List<String> ocrResults, HttpSession session) {
        // 세션에서 현재 로그인한 사용자 정보를 가져옴
        MemberDTO currentUser = (MemberDTO) session.getAttribute("currentUser");

        // OCR 인식 결과
        String stockCompany = ocrResults.get(0).replace("(주)", "").trim();
        String quantity = ocrResults.get(1).trim();
        String address = ocrResults.get(2).split(",")[0].trim();
        String name = ocrResults.get(3).trim();
        String date = ocrResults.get(4).replace("(화)", "").trim();
        String company = ocrResults.get(5).replace("(", "").trim();

        // 주식회사 이름을 6글자로 줄이는 부분
        if(stockCompany.length() > 6) {
            stockCompany = stockCompany.substring(0, 6);
        }

        if(currentUser.getAddress().equals(address) && currentUser.getName().equals(name)) {
            // System.out.println("주소와 이름이 일치합니다.");
            AccountDTO account = new AccountDTO();
            account.setMemberId(currentUser.getMemberId());
            account.setCompany(company);
            account.setAccountNumber(1000000000);
            account.setCash(0);
            accountService.insertAccount(account);

            int generatedAccountId = account.getAccountId(); // 시퀀스를 사용해 생성된 ID 저장
            StockDTO stockDTO = stockService.findByNameByWildCard(stockCompany);

            BalanceDTO balance = new BalanceDTO();
            balance.setAccountId(generatedAccountId);
            balance.setIsin(stockDTO.getIsin());
            balance.setQuantity(Integer.parseInt(quantity));
            balance.setAveragePrice(0);
            balanceService.insertBalance(balance);  // balance를 DB에 저장하는 서비스 메서드
            return ResponseEntity.ok("계좌 저장 완료");
        } else {
            System.out.println("주소와 이름이 일치하지 않습니다.");
        }
        return ResponseEntity.ok("OCR 데이터 수신 완료");
    }

    // --------------- API ----------------
    /**
     * 마이데이터 약관 동의 -> CI값 하나증권에 등록
     */
    @PostMapping("/getCIByAPI")
    public ResponseEntity<String> getCIByAPI(@RequestBody Map<String, Object> data, HttpSession session) {
        // 세션에서 현재 로그인한 사용자 정보를 가져옴
        MemberDTO currentUser = (MemberDTO) session.getAttribute("currentUser");

        String ci = (String) data.get("ci");
        Long identification = Long.valueOf(data.get("identification").toString());
        //System.out.println("ci : " + ci);

        Map<String, Object> params = new HashMap<>();
        params.put("memberId", currentUser.getMemberId());
        params.put("ci", ci);
        memberService.updateCIByMemberId(params);

        return ResponseEntity.ok("데이터 수신 완료");
    }

    /**
     * 모달창에 마이데이터를 이용하여 계좌 조회
     */
    @PostMapping("/getAccountByAPI")
    public ResponseEntity<String> getAccountByAPI(@RequestBody List<Map<String, Object>> dataList) {
        // 여기서 dataList 변수는 클라이언트에서 보낸 JSON 배열 데이터를 리스트 형식으로 받아옵니다.
        for (Map<String, Object> data : dataList) {
            // System.out.println("API로 받은 계좌 : " + data);
        }
        return ResponseEntity.ok("데이터 수신 완료");
    }

    /**
     * 마이데이터 계좌 조회 -> 하나증권에 등록
     * @param accountDataList
     * @return
     */
    @PostMapping("/submitAccount")
    public ResponseEntity<?> submitAccount(@RequestBody List<Map<String, Object>> accountDataList, HttpSession session) {
        // 세션에서 현재 로그인한 사용자 정보를 가져옴
        MemberDTO currentUser = (MemberDTO) session.getAttribute("currentUser");

        //반복문으로 전체 조회 + 계좌 저장
        for (Map<String, Object> accountData : accountDataList) {
            AccountDTO account = new AccountDTO();
            account.setMemberId(currentUser.getMemberId());
            account.setCompany((String)accountData.get("company"));
            account.setAccountNumber(Long.parseLong((String)accountData.get("accountNumber")));
            account.setCash(Long.parseLong((String)accountData.get("cash")));
            accountService.insertAccount(account);
            int generatedAccountId = account.getAccountId(); // 시퀀스를 사용해 생성된 ID 저장

            // 계좌 저장 후, 해당 계좌의 ID 혹은 계좌 번호를 사용하여 balance 데이터를 저장
            List<Map<String, Object>> balances = (List<Map<String, Object>>) accountData.get("balances");
            for (Map<String, Object> balanceData : balances) {
                BalanceDTO balance = new BalanceDTO();
                balance.setAccountId(generatedAccountId);
                balance.setIsin((String)balanceData.get("isin"));
                balance.setQuantity((Integer)balanceData.get("quantity"));
                balance.setAveragePrice((Integer)balanceData.get("averagePrice"));
                balanceService.insertBalance(balance);  // balance를 DB에 저장하는 서비스 메서드
            }
        }
        return ResponseEntity.ok("데이터 수신 완료");
    }
}
