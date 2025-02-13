package example.service;

import example.dao.BookDAO;
import example.mybatis.MyBatisSessionFactory;
import example.vo.BookVO;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import java.util.List;

public class BookServiceImpl implements BookService {

    private SqlSessionFactory sqlSessionFactory;

    private static BookServiceImpl instance;

    private BookServiceImpl() {
        this.sqlSessionFactory = MyBatisSessionFactory.getSqlSessionFactory();
    }

    public static BookServiceImpl getInstance() {
        if (instance == null) {
            instance = new BookServiceImpl();
        }
        return instance;
    }

    private final BookDAO bookDAO = BookDAO.getInstance();

    @Override
    public ObservableList<BookVO> findAllBooks() {
        List<BookVO> bookList = null;
        SqlSessionFactory factory = MyBatisSessionFactory.getSqlSessionFactory();
        SqlSession session = factory.openSession();
        bookDAO.setSession(session); // setter로 의존성 주입

        try {
            bookList = bookDAO.selectAllBook();
            session.commit();
        } catch (Exception e){
            session.rollback();
        } finally {
            session.close();
        }
        return FXCollections.observableArrayList(bookList);
    }

    @Override
    public void saveBook(String bisbn, String btitle, int bprice, String bauthor) {
        // TODO : 유효성 검사 해주기
        int result = 0;
        BookVO book = new BookVO(bisbn, btitle, bprice, bauthor);
        SqlSessionFactory factory = MyBatisSessionFactory.getSqlSessionFactory();
        SqlSession session = factory.openSession();
        bookDAO.setSession(session); // setter로 의존성 주입

        try {
            result = bookDAO.insertBook(book);
            session.commit();
        } catch (Exception e){
            session.rollback();
        } finally {
            session.close();
        }
    }

    @Override
    public ObservableList<BookVO> findBookByTitle(String btitle) {
        List<BookVO> bookList = null;
        SqlSessionFactory factory = MyBatisSessionFactory.getSqlSessionFactory();
        SqlSession session = factory.openSession();
        bookDAO.setSession(session); // setter로 의존성 주입

        try {
            bookList = bookDAO.selectBookByTitle(btitle);
            session.commit();
        } catch (Exception e){
            session.rollback();
        } finally {
            session.close();
        }
        return FXCollections.observableArrayList(bookList);
    }

    @Override
    public void updateBook(BookVO book) {
        int result = 0;
        SqlSessionFactory factory = MyBatisSessionFactory.getSqlSessionFactory();
        SqlSession session = factory.openSession();
        bookDAO.setSession(session); // setter로 의존성 주입

        try {
            result = bookDAO.updateBookByISBN(book);
            session.commit();
        } catch (Exception e){
            session.rollback();
        } finally {
            session.close();
        }
    }

    @Override
    public void removeBook(String bisbn) {
        int result = 0;
        SqlSessionFactory factory = MyBatisSessionFactory.getSqlSessionFactory();
        SqlSession session = factory.openSession();
        bookDAO.setSession(session); // setter로 의존성 주입

        try {
            result = bookDAO.deleteBookByISBN(bisbn);
            session.commit();
        } catch (Exception e){
            session.rollback();
        } finally {
            session.close();
        }
    }
}
