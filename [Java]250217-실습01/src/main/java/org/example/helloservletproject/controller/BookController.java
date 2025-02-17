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

@WebServlet(value="/book")
public class BookController extends HttpServlet {

    private final BookServiceImpl bookServiceImpl = BookServiceImpl.getInstance();

    @Override
    public void init() throws ServletException {
        super.init();
        System.out.println("BookController init");
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doGet(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        // 키워드 및 가격 제한 가져오기
        String keyword = req.getParameter("keyword");
        int priceLimit = Integer.parseInt(req.getParameter("priceLimit"));

        System.out.println(keyword);
        System.out.println(priceLimit);

        BookRequestDTO bookRequestDto = new BookRequestDTO(keyword, priceLimit);
        List<BookVO> books = bookServiceImpl.searchBookByKeywordAndPrice(bookRequestDto);

        // 응답 설정
        resp.setContentType("text/html;charset=UTF-8");
        PrintWriter out = resp.getWriter();

        // HTML 응답 출력
        out.println("<html>");
        out.println("<head><title>도서 검색 결과</title></head>");
        out.println("<body>");
        out.println("<h1>도서 검색 결과</h1>");
        out.println("<ul>");

        // books 리스트 출력
//        for (BookVO book : books) {
//            out.println("<li>" + book.getBtitle() + " - " + book.getBprice() + "원</li>");
//        }
        // books 리스트 출력
        for (BookVO book : books) {
            // 책 제목을 클릭하면 해당 책의 상세 페이지로 이동하는 링크 추가
            out.println("<li><a href='http://localhost:8080/HelloServletProject/bookdetail?isbn=" + book.getBisbn() + "'>" + book.getBtitle() + "</a> - " + book.getBprice() + "원</li>");
        }
        out.println("</ul>");
        out.println("</body>");
        out.println("</html>");

        out.flush();
        out.close();
    }


}
