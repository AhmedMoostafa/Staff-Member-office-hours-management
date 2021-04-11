package staffServices;

import tools.Database;
import tools.capAndEmail;
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

@WebServlet(name = "newSlot",value = "/newSlot")
public class newSlot extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        member person   = (member) request.getSession().getAttribute("member");
        String  userName=person.userName;
        String name=person.name;
        String  email=person.email;
        String date=request.getParameter("date");
        String start=request.getParameter("from");
        String end=request.getParameter("to");
        String location=request.getParameter("location");
        String subject=request.getParameter("subject");
        String status="true";
        HttpSession session = request.getSession(true);
        if(date==""||start==""||end==""||location==""||subject=="")
                {
                    session.setAttribute("msg","error");
                    response.sendRedirect("manageSlots.jsp");
                }
        else {
            Connection Con = null;
            Statement Stmt = null;
            ResultSet RS = null;
            try {
                Con = Database.getConnection();
                Stmt = Con.createStatement();
                System.out.println(date);
                System.out.println(start);
                String sql = "INSERT INTO slots(date, startTime, endTime,subject,location,status,name,staffMember) VALUES("
                        + "'" + date + "',"
                        + "'" + start + "',"
                        + "'" + end + "',"
                        + "'" + subject + "',"
                        + "'" + location + "',"
                        + "'" + status + "',"
                        + "'" + name + "',"
                        + "'" + userName + "')";

                String subject2="reminding";
                String body2="Welcome "+name+"\n Today you have an office hour meeting in subject "+subject;
                System.out.println(email);
                capAndEmail  tool= new capAndEmail();
                tool.sendEmail3(email,date,subject2,body2);
                int rows = Stmt.executeUpdate(sql);
                session.setAttribute("msg", "done");

                response.sendRedirect("manageSlots.jsp");
            } catch (SQLException throwables) {
                throwables.printStackTrace();
            }
        }

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
