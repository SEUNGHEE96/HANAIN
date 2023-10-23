package com.hanain.member.model.dto;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

import javax.validation.constraints.NotEmpty;

@Data
@Getter
@Setter
public class LoginDTO {

    @NotEmpty(message= "필수항목")
    private String memberId;
    @NotEmpty(message= "필수항목")
    private String password;

}
