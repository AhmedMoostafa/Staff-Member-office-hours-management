package studentServices;

import tools.Database;

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

@WebServlet(name = "cancelSubject",value = "/cancelSubject")
public class cancelSubject extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String user=request.getParameter("user");
        String code=request.getParameter("code");
        String role=request.getSession().getAttribute("role").toString();
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
                if(RS.isBeforeFirst()){

                    String sql ="DELETE FROM registeredsubject where userName="+ "'" + user + "' and subjectCode="+ "'" + code + "'";
                    session.setAttribute("msg","Registration canceled");

                    response.sendRedirect("selectSubjects.jsp");

                    int rows = Stmt.executeUpdate(sql);
                    Con.close();
                    Stmt.close();
                }
                else {


                    session.setAttribute("msg","You are not already registered");
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
                if(RS.isBeforeFirst()){

                    String sql ="DELETE FROM registeredstaff where userName="+ "'" + user + "' and subjectCode="+ "'" + code + "'";
                    session.setAttribute("msg","Registration canceled");

                    response.sendRedirect("selectSubjects.jsp");

                    int rows = Stmt.executeUpdate(sql);
                    Con.close();
                    Stmt.close();
                }
                else {


                    session.setAttribute("msg","You are not already registered");
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

