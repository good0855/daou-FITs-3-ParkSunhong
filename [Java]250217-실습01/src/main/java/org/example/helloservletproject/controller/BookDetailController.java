package org.example.helloservletproject.controller;

import org.example.helloservletproject.dto.BookRequestDTO;
import org.example.helloservletproject.service.BookServiceImpl;
import org.example.helloservletproject.vo.BookVO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet(value="/bookdetail")
public class BookDetailController extends HttpServlet {
    private final BookServiceImpl bookServiceImpl = BookServiceImpl.getInstance();

    @Override
    public void init() throws ServletException {
        super.init();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        // 키워드 및 가격 제한 가져오기
        String isbn = req.getParameter("isbn");

        System.out.println(isbn);

        BookVO book = bookServiceImpl.searchBookByIsbn(isbn);

        // 응답 설정
        resp.setContentType("text/html;charset=UTF-8");
        PrintWriter out = resp.getWriter();

        // HTML 응답 출력
        out.println("<html>");
        out.println("<head><title>도서 검색 결과</title></head>");
        out.println("<body>");
        out.println("<h1> + " + book.getBtitle() + " </h1>");
        out.println("<p>isbn: " + book.getBisbn() + "</p>");
        out.println("<p>가격: " + book.getBprice() + "원</p>");
        out.println("<p>작가: " + book.getBauthor() + "</p>");

        out.println("</body>");
        out.println("</html>");

        out.flush();
        out.close();
    }
}
