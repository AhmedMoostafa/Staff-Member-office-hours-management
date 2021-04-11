package studentServices;

import tools.Database;
import tools.capAndEmail;
import tools.member;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;

@WebServlet(name = "cancelSlot",value = "/cancelSlot")
public class cancelSlot extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String ID=request.getParameter("ID");
        String slotID=request.getParameter("slotID");
        System.out.println(ID+"  "+slotID);

        Connection Con = null;
        Statement Stmt = null;
        ResultSet RS = null;
        try {
            Con = Database.getConnection();
            Stmt = Con.createStatement();


            response.sendRedirect("welcomestudent.jsp");
            Statement Stmt2 = null;
            Stmt2 = Con.createStatement();
            String email=null,nameE=null;

            ResultSet RS2 = Stmt2.executeQuery("select member.email,member.name  from member  INNER JOIN reservation where member.userName=reservation.staffMember and reservation.slotID=" + "'" + slotID + "'");

            while (RS2.next())
            {
                email=RS2.getString("email");
                nameE=RS2.getString("name");

            }

            PreparedStatement st = Con.prepareStatement("DELETE FROM reservation WHERE ID = ?");
            st.setString(1,ID);
            st.executeUpdate();

            st= Con.prepareStatement("UPDATE slots SET status =? WHERE  ID=?");
            st.setString(1,"true");
            st.setString(2,slotID);
            st.executeUpdate();

            member person   =null;
            person=(member) request.getSession().getAttribute("member");
            String  userName=person.userName;
            String subject="Registration canceled ";
            String body="Welcome "+nameE+"\n student "+userName+" cancel his registration\nthanks for using Office hours web site";

            capAndEmail.sendEmail2(email,subject,body);


        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }

    }
}
