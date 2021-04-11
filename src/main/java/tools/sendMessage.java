package tools;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

@WebServlet(name = "sendMessage",value = "/sendMessage")
public class sendMessage extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String type=request.getParameter("type");
        String to=request.getParameter("to");
        String subject=request.getParameter("subject");
        String body=request.getParameter("body");
        member person   = (member) request.getSession().getAttribute("member");
        String  from=person.userName;
        String fromName=person.name;
        HttpSession session=request.getSession(true);

        Connection Con = null;
        Statement Stmt = null;
        Statement Stmt2 = null;

        ResultSet RS = null;
        try {
            Con = Database.getConnection();
            Stmt = Con.createStatement();
            Stmt2 = Con.createStatement();
            System.out.println(type+"  "+to);
            if(type.equals("all"))
            {
                String staff=request.getParameter("staff");

                RS = Stmt.executeQuery("SELECT userName FROM registeredstaff where subjectCode=" + "'" + staff + "'AND userName!="+ "'" + from + "'");
                while (RS.next())
                {

                    String sql = "INSERT INTO message(subject, body, fromMember,fromName,toMember) VALUES("
                            + "'" + subject + "',"
                            + "'" + body + "',"
                            + "'" + from + "',"
                            + "'" + fromName + "',"
                            + "'" + RS.getString("userName") + "')";

                    int rows = Stmt2.executeUpdate(sql);
                }
                session.setAttribute("msg","Done");

            }
            else
            {
                System.out.println(to);
                RS = Stmt.executeQuery("SELECT userName FROM member where userName=" + "'" + to + "'");
                if(RS.isBeforeFirst())
                {
                    System.out.println(to+"zzz");

                    String sql = "INSERT INTO message(subject, body, fromMember,fromName,toMember) VALUES("
                            + "'" + subject + "',"
                            + "'" + body + "',"
                            + "'" + from + "',"
                            + "'" + fromName + "',"
                            + "'" +to + "')";

                    int rows = Stmt.executeUpdate(sql);
                    session.setAttribute("msg","Done");

                }
                else
                {
                    session.setAttribute("msg","Error! User name not found");

                }
            }
            response.sendRedirect("welcome"+person.role+".jsp");

        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }


    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
