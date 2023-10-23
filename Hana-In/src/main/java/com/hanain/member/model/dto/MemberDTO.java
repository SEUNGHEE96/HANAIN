package com.hanain.member.model.dto;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Data
public class MemberDTO {

    private String memberId;
    private String id;
    private String name;
    private String password;
    private String phone;
    private String email;
    private String address;
    private int status;
    private Long identification;
    private String ci;

}
