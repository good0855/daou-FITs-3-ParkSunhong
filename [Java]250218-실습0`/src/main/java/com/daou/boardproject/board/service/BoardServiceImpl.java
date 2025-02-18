package com.daou.boardproject.board.service;

import com.daou.boardproject.board.dao.BoardDAO;
import com.daou.boardproject.board.vo.BoardVO;
import com.daou.boardproject.util.MyBatisSessionFactory;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import java.util.Collections;
import java.util.List;

public class BoardServiceImpl implements BoardService {
    private static BoardService instance = new BoardServiceImpl();

    private BoardServiceImpl() {}

    public static BoardService getInstance() {
        if (instance == null) {
            instance = new BoardServiceImpl();
        }
        return instance;
    }
    private final BoardDAO boardDAO = BoardDAO.getInstance();

    // 모든 글을 가져오는 메소드
    @Override
    public List<BoardVO> showAllContent() {
        List<BoardVO> contents = null;
        SqlSessionFactory factory = MyBatisSessionFactory.getSqlSessionFactory();
        SqlSession session = factory.openSession();

        boardDAO.setSession(session);

        try {
            contents = boardDAO.selectAllContent();
            session.commit();

        } catch (Exception e) {
            e.printStackTrace();
            session.rollback();
        } finally {
            session.close();
        }

        return contents;
    }
}
