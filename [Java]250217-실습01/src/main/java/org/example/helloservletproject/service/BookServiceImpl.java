package org.example.helloservletproject.service;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.example.helloservletproject.dao.BookDAO;
import org.example.helloservletproject.dto.BookRequestDTO;
import org.example.helloservletproject.utils.MyBatisSessionFactory;
import org.example.helloservletproject.vo.BookVO;

import java.util.Collections;
import java.util.List;

public class BookServiceImpl implements BookService {

    private static BookServiceImpl instance;

    private BookServiceImpl() {}

    public static BookServiceImpl getInstance() {
        if(instance == null) {
            instance = new BookServiceImpl();
        }
        return instance;
    }

    // DAO bring
    private final BookDAO bookDAO = BookDAO.getInstance();

    @Override
    // 책 검색
    public List<BookVO> searchBookByKeywordAndPrice(BookRequestDTO bookRequestDTO) {
        List<BookVO> books = Collections.emptyList();
        SqlSessionFactory factory = MyBatisSessionFactory.getSqlSessionFactory();
        SqlSession session = factory.openSession();
        // session setter
        bookDAO.setSession(session);

        try {
            System.out.println(bookRequestDTO);
            books = bookDAO.selectBookByKeywordAndPrice(bookRequestDTO);

            for(BookVO book : books) {
                System.out.println(book);
            }
            session.commit();
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("SQL Error");
            session.rollback();
        } finally {
            session.close();
        }

        return books;
    }

    @Override
    public BookVO searchBookByIsbn(String isbn) {
        BookVO book = null;
        SqlSessionFactory factory = MyBatisSessionFactory.getSqlSessionFactory();
        SqlSession session = factory.openSession();
        // session setter
        bookDAO.setSession(session);

        try {
            System.out.println(isbn);
            book = bookDAO.selectBookByBookId(isbn);

            System.out.println(book);
            session.commit();
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("SQL Error");
            session.rollback();
        } finally {
            session.close();
        }

        return book;
    }
}
