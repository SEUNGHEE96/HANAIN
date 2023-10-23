package com.hanain.stock.controller;

import com.hanain.member.model.dto.MemberDTO;
import com.hanain.stock.model.dto.StockDTO;
import com.hanain.stock.service.StockService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.List;

@Component
public class SidebarInterceptor implements HandlerInterceptor {

    @Autowired
    private StockService stockService; // 사용자 서비스 등 필요한 서비스 인젝션

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        // 로그인한 사용자의 세션 정보 가져오기
        HttpSession session = request.getSession();
        MemberDTO memberDTO = (MemberDTO) session.getAttribute("currentUser");
        if (memberDTO != null) {
            // 데이터베이스 또는 다른 서비스를 통해 필요한 정보 조회
            List<StockDTO> userStocks = stockService.getStockByMemberId(memberDTO.getMemberId());
            // request의 attribute로 추가하여 뷰에서 사용 가능하도록 함
            request.setAttribute("userStocks", userStocks);

            List<StockDTO> userStocks2 = stockService.getLikedStockByMemberId(memberDTO.getMemberId());
            request.setAttribute("userStocks2", userStocks2);
        }
        return true;
    }

}
