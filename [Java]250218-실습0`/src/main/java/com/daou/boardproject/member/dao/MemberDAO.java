package com.daou.boardproject.member.dao;
import com.daou.boardproject.member.dto.LoginRequestDTO;
import org.apache.ibatis.session.SqlSession;
import com.daou.boardproject.member.vo.MemberVO;

public class MemberDAO {

    private static MemberDAO instance;

    private MemberDAO() {}

    public static MemberDAO getInstance() {
        if (instance == null) {
            instance = new MemberDAO();
        }
        return instance;
    }

    private SqlSession session;

    public void setSession(SqlSession session) {
        this.session = session;
    }

    // 1. 회원 로그인
    public MemberVO selectMemberByIDAndPW(LoginRequestDTO loginRequestDTO) {
        return this.session.selectOne("selectMemberByIDAndPW", loginRequestDTO);
    }
}
