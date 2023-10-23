package com.hanain.member.controller;

import com.hanain.member.model.dto.MemberDTO;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@Component
public class LoginInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        HttpSession session = request.getSession();
        MemberDTO memberDTO = (MemberDTO) session.getAttribute("currentUser");
        session.setAttribute("dest", request.getServletPath());
        if(memberDTO == null) {
            response.sendRedirect(request.getContextPath()+"/login");
            return false;
        } else {
            return true;
        }
    }

}
