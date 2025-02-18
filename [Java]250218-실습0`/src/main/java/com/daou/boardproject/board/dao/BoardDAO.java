package com.daou.boardproject.board.dao;

import com.daou.boardproject.board.vo.BoardVO;
import org.apache.ibatis.session.SqlSession;

import javax.servlet.annotation.WebServlet;
import java.util.List;

public class BoardDAO {
    // 1. 모든 글 보여주기
    private static BoardDAO instance;
    // 기본 생성자 추가
    private BoardDAO() {
        // 기본 생성자
    }
    public static BoardDAO getInstance() {
        if (instance == null) {
            instance = new BoardDAO();
        }
        return instance;
    }

    private SqlSession session;

    public void setSession(SqlSession session) {
        this.session = session;
    }

    // 1. board 모든 글 보여주기
    public List<BoardVO> selectAllContent() {
        return this.session.selectList("com.daou.Board.selectAllContent");

    }
}
