package staffServices;

import tools.Database;
import tools.capAndEmail;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.*;

@WebServlet(name = "updateAndDeleteSlot",value = "/updateAndDeleteSlot")
public class updateAndDeleteSlot extends HttpServlet {
    PreparedStatement st = null;
    Connection Con = null;
    Statement Stmt = null;
    ResultSet RS = null;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String  userName=request.getSession().getAttribute("currentUser").toString();
        String slotID=request.getParameter("ID");
        HttpSession session = request.getSession(true);

        try {
            Statement Stmt2 = null;

            Con = Database.getConnection();
            Stmt2 = Con.createStatement();
            RS = Stmt2.executeQuery("select member.email,member.name  from member INNER JOIN reservation where member.userName=reservation.student and reservation.slotID='" +slotID+ "'");

            if(RS.isBeforeFirst())
            {
                String email=null,nameE=null;
                while (RS.next())
                {
                    email=RS.getString("email");
                    nameE=RS.getString("name");
                }

                String subject="Office hours cancel";
                String body="Welcome "+nameE+"\n slot"+slotID+"canceled\nthanks for using Office hours web site";

                st = Con.prepareStatement("DELETE FROM reservation WHERE slotID = ?");
                st.setString(1,slotID);
                st.executeUpdate();
                capAndEmail.sendEmail2(email,subject,body);


            }

            Con = Database.getConnection();

            st = Con.prepareStatement("DELETE FROM slots WHERE ID = ?");
            st.setString(1,slotID);
            st.executeUpdate();
            session.setAttribute("msg","done");
            response.sendRedirect("manageSlots.jsp");
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }


    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String date=request.getParameter("date");
        String start=request.getParameter("from");
        String end=request.getParameter("to");
        String location=request.getParameter("location");
        String slotID=request.getParameter("ID");
        HttpSession session = request.getSession(true);
       if(date==""||start==""||end==""||location=="")
        {
            session.setAttribute("msg","error");
            response.sendRedirect("manageSlots.jsp");
        }
        else {

           try {
               Con = Database.getConnection();
               Stmt = Con.createStatement();
                 String sql4 = "UPDATE slots SET date =?,startTime=?,endTime=?,location=? WHERE  ID='" + slotID + "';";
               PreparedStatement ps1 = Con.prepareStatement(sql4);
               ps1.setString(1, date);
               ps1.setString(2, start);
               ps1.setString(3, end);
               ps1.setString(4, location);

               int y = ps1.executeUpdate();
           } catch (SQLException throwables) {
               throwables.printStackTrace();
           }
           session.setAttribute("msg","done");
           response.sendRedirect("manageSlots.jsp");
       }
    }
}
