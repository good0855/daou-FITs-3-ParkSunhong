package example.dao;

import example.vo.BookVO;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import java.util.HashMap;
import java.util.List;

// SQLSessionFactory를 DAO에 전달할거에요!
public class BookDAO {

    private static BookDAO instance;

    private SqlSession session;

    public SqlSession getSession() {
        return session;
    }

    public void setSession(SqlSession session) {
        this.session = session;
    }

    private BookDAO() {}

    public static BookDAO getInstance() {
        if (instance == null) {
            instance = new BookDAO();
        }
        return instance;
    }

    // 1.  모든 책 조회
    public List<BookVO> selectAllBook() {
        return this.session.selectList("example.MyBook.selectAllBookVO");
    }

    // 2. 책 추가
    public int insertBook(BookVO book) {
        return this.session.insert("example.MyBook.insertBookVO", book);
    }

    // 3. title 기반 책 검색
    public List<BookVO> selectBookByTitle(String title) {
        return this.session.selectList("example.MyBook.selectByTitleBookVO", title);
    }

    // 4. isbn 기반 update
    public int updateBookByISBN(BookVO book) {
        return this.session.update("example.MyBook.updateBookByISBN", book);

    }

    // 5. isbn 기반 책 삭제
    public int deleteBookByISBN(String bisbn) {
        return this.session.delete("example.MyBook.deleteBookByISBN", bisbn);

    }
}
