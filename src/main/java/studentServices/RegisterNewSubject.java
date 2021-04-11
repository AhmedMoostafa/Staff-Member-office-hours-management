package studentServices;

import tools.Database;
import tools.member;

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

@WebServlet(name = "RegisterNewSubject",value = "/RegisterNewSubject")
public class RegisterNewSubject extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String user=null;
        String code=request.getParameter("code");
        member person=new member();
        String role=null;

          person   = (member) request.getSession().getAttribute("member");
          System.out.println(person.userName+"jaja");
        role=person.role;
        user=person.userName;

        Connection Con = null;
        Statement Stmt = null;
        ResultSet RS = null;
        HttpSession session=request.getSession(true);
        if(role.equals("student"))
        {
            try {
                Con = Database.getConnection();
                Stmt = Con.createStatement();
                RS = Stmt.executeQuery("SELECT *FROM registeredsubject where userName="+ "'" + user + "' and subjectCode="+ "'" + code + "'");
                if(!RS.isBeforeFirst()){

                    String sql = "INSERT INTO registeredsubject(userName, subjectCode) VALUES("
                            + "'" + user + "',"
                            + "'" + code + "')";
                    session.setAttribute("msg","successfully registered");

                    response.sendRedirect("selectSubjects.jsp");

                    int rows = Stmt.executeUpdate(sql);
                    Con.close();
                    Stmt.close();
                }
                else {


                    session.setAttribute("msg","You have already registered");
                    response.sendRedirect("selectSubjects.jsp");
                    Con.close();
                    Stmt.close();

                }

            } catch (SQLException throwables) {
                throwables.printStackTrace();
            }

        }
        else
        {
            try {
                Con = Database.getConnection();
                Stmt = Con.createStatement();
                RS = Stmt.executeQuery("SELECT *FROM registeredstaff where userName="+ "'" + user + "' and subjectCode="+ "'" + code + "'");
                if(!RS.isBeforeFirst()){

                    String sql = "INSERT INTO registeredstaff(userName, subjectCode) VALUES("
                            + "'" + user + "',"
                            + "'" + code + "')";
                    session.setAttribute("msg","successfully registered");

                    response.sendRedirect("selectSubjects.jsp");

                    int rows = Stmt.executeUpdate(sql);
                    Con.close();
                    Stmt.close();
                }
                else {


                    session.setAttribute("msg","You have already registered");
                    response.sendRedirect("selectSubjects.jsp");
                    Con.close();
                    Stmt.close();

                }

            } catch (SQLException throwables) {
                throwables.printStackTrace();
            }

        }



    }
}
