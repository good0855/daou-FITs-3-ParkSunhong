package example.service;

import example.vo.BookVO;
import javafx.collections.ObservableList;

public interface BookService {
    // 모든 책 검색
    public ObservableList<BookVO> findAllBooks();

    // 단일 책 검색
    public ObservableList<BookVO> findBookByTitle(String btitle);

    // 책 추가
    public void saveBook(String bisbn, String btitle, int bprice, String bauthor);

    // 책 업데이트
    public void updateBook(BookVO book);

    // 책 삭제
    public void removeBook(String isbn);
}
