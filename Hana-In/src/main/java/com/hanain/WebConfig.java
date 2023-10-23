package com.hanain;

import com.hanain.member.controller.LoginInterceptor;
import com.hanain.stock.controller.SidebarInterceptor;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer {

    private final LoginInterceptor loginInterceptor;
    private final SidebarInterceptor sidebarInterceptor;

    // LoginInterceptor 빈을 주입받습니다.
    // LoginInterceptor 클래스는 실제 구현에 따라 @Component 또는 @Service 어노테이션으로 빈으로 등록되어 있어야 합니다.
    public WebConfig(LoginInterceptor loginInterceptor, SidebarInterceptor sidebarInterceptor) {
        this.loginInterceptor = loginInterceptor;
        this.sidebarInterceptor = sidebarInterceptor;
    }

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        // 인터셉터를 등록합니다.
        registry.addInterceptor(loginInterceptor)
                /* .addPathPatterns("/**")  // 모든 경로에 적용 */
                .addPathPatterns("/board", "/member", "/proposal", "/stock", "/mypage", "/mybalance", "/board/**")  // 적용 경로
                .excludePathPatterns("/login", "/");  // 제외할 경로
        registry.addInterceptor(sidebarInterceptor)
                .addPathPatterns("/proposal", "/board", "/stock", "/writeproposal", "/stockinfo", "/board/**");  // 사이드바 있는 경로
    }

}
