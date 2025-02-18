package com.daou.boardproject.member.service;

import com.daou.boardproject.member.dao.MemberDAO;
import com.daou.boardproject.member.dto.LoginRequestDTO;
import com.daou.boardproject.member.vo.MemberVO;
import com.daou.boardproject.util.MyBatisSessionFactory;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

public class MemberServiceImpl implements MemberService {

    private static MemberService instance;
    private MemberServiceImpl() {}

    public static MemberService getInstance() {
        if (instance == null) {
            instance = new MemberServiceImpl();
        }
        return instance;
    }

    private final MemberDAO memberDAO = MemberDAO.getInstance();

    @Override
    public MemberVO Login(LoginRequestDTO loginRequestDTO) {
        MemberVO member = null;

        SqlSessionFactory factory = MyBatisSessionFactory.getSqlSessionFactory();
        SqlSession session = factory.openSession();

        memberDAO.setSession(session);

        try {
            System.out.println("Login Service Layer");
            member = memberDAO.selectMemberByIDAndPW(loginRequestDTO);
            System.out.println(member);
            session.commit();
        } catch (Exception e) {
            e.printStackTrace();
            session.rollback();
        } finally {
            session.close();
        }
        return member;
    }
}
