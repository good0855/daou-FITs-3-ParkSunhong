package com.daou.boardproject.member.controller;

import com.daou.boardproject.member.dto.LoginRequestDTO;
import com.daou.boardproject.member.service.MemberService;
import com.daou.boardproject.member.service.MemberServiceImpl;
import com.daou.boardproject.member.vo.MemberVO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(value="/login")
public class LoginController extends HttpServlet {
    private final MemberService memberServiceImpl = MemberServiceImpl.getInstance();


    @Override
    public void init() throws ServletException {
        System.out.println("init");
        super.init();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // login.jsp로 포워딩
        System.out.println("doGet");
        req.getRequestDispatcher("login/login.jsp").forward(req, resp);
    }
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("doPost");
        String memberId = req.getParameter("member_id");
        String password = req.getParameter("password");
        LoginRequestDTO loginRequestDTO = new LoginRequestDTO(memberId, password);
        MemberVO member = memberServiceImpl.Login(loginRequestDTO);

        if (member != null) {
            // 세션 추가
            HttpSession session = req.getSession();
            session.setAttribute("member", member);

            // 로그인 후 boardMain.jsp로 포워딩
//            resp.sendRedirect("board/boardMain.jsp");
            resp.sendRedirect("board");

        } else {
            resp.sendRedirect("error/loginError.jsp");
//            resp.sendRedirect("login");
        }

    }

    @Override
    public void destroy() {
        super.destroy();
    }
}
