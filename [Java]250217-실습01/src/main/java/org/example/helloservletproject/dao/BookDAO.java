package org.example.helloservletproject.dao;

import org.apache.ibatis.session.SqlSession;
import org.example.helloservletproject.dto.BookRequestDTO;
import org.example.helloservletproject.vo.BookVO;

import java.util.List;

public class BookDAO {
    private static BookDAO instance;

    private BookDAO() {}

    public static BookDAO getInstance() {
        if (instance == null) {
            instance = new BookDAO();
        }
        return instance;
    }

    // session
    private SqlSession session;

    public void setSession(SqlSession session) {
        this.session = session;
    }

    // 1. 키워드 및 가격 조건에 따라 책 조회
    public List<BookVO> selectBookByKeywordAndPrice(BookRequestDTO bookRequestDTO) {
        return this.session.selectList("org.example.Book.selectBookByKeywordAndPrice", bookRequestDTO);
    }

    // 2. ISBN에 따라 책 검색
    public BookVO selectBookByBookId(String bisbn) {
        return this.session.selectOne("org.example.Book.selectBookDetail", bisbn);

    }


}
