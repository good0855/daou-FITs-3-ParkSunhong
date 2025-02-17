package org.example.helloservletproject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(value="/myServlet") // 반드시 / 붙여줘야 함
public class MyFirstServlet extends HttpServlet {

    public MyFirstServlet() {
        System.out.println("생성자 호출");
    }

    @Override
    public void init() throws ServletException {
        super.init();
        System.out.println("init");
    }


    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("doGet");

        // 한글 깨짐 방지
        req.setCharacterEncoding("UTF-8");

        // 입력받기
        String name = req.getParameter("name");
        String age = req.getParameter("age");
        String address = req.getParameter("address");

        // 로직처리하기

        // 출력하기
        // 1, 데이터 전달 통로를 열어서 결과데이터를 전달해야 하는데
        // 이 통로를 통해서 전달되는 데이터의 형태가 어떤 형태인지를 먼저 지정해야 함
        resp.setContentType("text/html; charset=utf-8"); // MIME type


        // 2. 결과를 돌려주기 위한 데이터 통로를 하나 열어야 함.
        // 데이터 통로는 일반적으로 PrintWriter 이용
        PrintWriter out = resp.getWriter();

        // 3. 이 통로를 통해서 데이터를 전송하면 된다.
        out.println("<html>");
        out.println("<head></head>");
        out.println("<body> 정상적으로 호출되었어요</body>");
        out.println("</html>");
        out.flush(); // 명시적으로 하는 게 좋음 => 클라이언트에 넘겨주기 쉬움
        out.close();

        // servlet은 MVC관점에서 controller 역할을 수행!


    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("doPost");

        // 한글 깨짐 방지
        req.setCharacterEncoding("UTF-8");

        // 입력받기
        String name = req.getParameter("name");
        String age = req.getParameter("age");

        // 로직처리하기

        // 출력하기
        // 1, 데이터 전달 통로를 열어서 결과데이터를 전달해야 하는데
        // 이 통로를 통해서 전달되는 데이터의 형태가 어떤 형태인지를 먼저 지정해야 함
        resp.setContentType("text/html; charset=utf-8"); // MIME type


        // 2. 결과를 돌려주기 위한 데이터 통로를 하나 열어야 함.
        // 데이터 통로는 일반적으로 PrintWriter 이용
        PrintWriter out = resp.getWriter();

        // 3. 이 통로를 통해서 데이터를 전송하면 된다.
        out.println("<html>");
        out.println("<head></head>");
        out.println("<body>" + name  + ", " + age + "</body>");
        out.println("</html>");
        out.flush(); // 명시적으로 하는 게 좋음 => 클라이언트에 넘겨주기 쉬움
        out.close();
    }

    @Override
    public void destroy() {
        super.destroy();
        System.out.println("destroy");
    }
}
