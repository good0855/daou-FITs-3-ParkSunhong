package com.daou.boardproject.board.service;

import com.daou.boardproject.board.vo.BoardVO;

import java.util.List;

public interface BoardService {
    // 모든 글 보여주기
    List<BoardVO> showAllContent();
}
