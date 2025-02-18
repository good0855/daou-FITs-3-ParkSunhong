package com.daou.boardproject.member.service;

import com.daou.boardproject.member.dto.LoginRequestDTO;
import com.daou.boardproject.member.vo.MemberVO;

public interface MemberService {
    // 1. 로그인
    MemberVO Login(LoginRequestDTO loginRequestDTO);
}
