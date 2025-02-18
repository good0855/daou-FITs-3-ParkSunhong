package com.daou.boardproject.board.controller;

import com.daou.boardproject.board.service.BoardService;
import com.daou.boardproject.board.service.BoardServiceImpl;
import com.daou.boardproject.board.vo.BoardVO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(value="/board")
public class BoardController extends HttpServlet {
    private final BoardService boardService = BoardServiceImpl.getInstance();
    @Override
    public void init() throws ServletException {
        System.out.println("Board init");
        super.init();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<BoardVO> contents = boardService.showAllContent();
        System.out.println(contents);
        req.setAttribute("contents", contents);
        req.getRequestDispatcher("/board/boardMain.jsp").forward(req, resp);
    }

    @Override
    public void destroy() {
        super.destroy();
    }
}
