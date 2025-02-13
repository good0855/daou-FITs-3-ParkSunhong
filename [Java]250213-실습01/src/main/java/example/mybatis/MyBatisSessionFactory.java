package example.mybatis;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import java.io.Reader;

// SQL session이라는 객체가 DAO에서 필요(mybatis는 connection이 아닌 session 단위로 설게)
// 그리고 이 SqlSession객체를 이용해야지만 우리가 SQL문 실행 가능(Mapper 이용가능_)
public class MyBatisSessionFactory {
    private static SqlSessionFactory sqlSessionFactory;

    // Singleton pattern
    static {
        try {
            String resource = "./SqlMapConfig.xml";
            Reader reader = Resources.getResourceAsReader(resource);

            if(sqlSessionFactory == null) {
                sqlSessionFactory = new SqlSessionFactoryBuilder().build(reader);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static SqlSessionFactory getSqlSessionFactory() {
        return sqlSessionFactory;
    }

}

