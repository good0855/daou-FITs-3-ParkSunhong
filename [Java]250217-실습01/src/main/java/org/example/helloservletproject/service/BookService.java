package org.example.helloservletproject.service;

import org.example.helloservletproject.dto.BookRequestDTO;
import org.example.helloservletproject.vo.BookVO;

import java.util.List;

public interface BookService {
    List<BookVO> searchBookByKeywordAndPrice(BookRequestDTO bookRequestDTO);
    BookVO searchBookByIsbn(String isbn);
}
