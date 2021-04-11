package studentServices;

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
import java.sql.*;

@WebServlet(name = "addSlot",value = "/addSlot")
public class addSlot extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Connection Con = null;
        Statement Stmt = null;
        ResultSet RS = null;
        HttpSession session=request.getSession(true);

        member person   = (member) request.getSession().getAttribute("member");
        String  userName=person.userName;
        String name=person.name;
        String studentEmail=person.email;

        String slotID=request.getParameter("slotID");
        try {
            Con = Database.getConnection();
            Stmt = Con.createStatement();
            RS = Stmt.executeQuery("SELECT * FROM slots where ID=" + "'" + slotID + "'");

String date=null,studentSubject=null;
    while (RS.next())
    {


        date=RS.getString("date");
        studentSubject= RS.getString("subject");
        String sql = "INSERT INTO reservation(student, name,date, time,staffMember,subject,slotID) VALUES("
                + "'" + userName + "',"
                + "'" + name + "',"
                + "'" + RS.getString("date") + "',"
                + "'" + RS.getString("startTime") + "',"
                + "'" + RS.getString("staffMember") + "',"
                + "'" + RS.getString("subject") + "',"
                + "'" + slotID+ "')";

        int rows = Stmt.executeUpdate(sql);
        String sql4 = "UPDATE slots SET status =? WHERE  ID='"+slotID+"';";
        PreparedStatement ps1 = Con.prepareStatement(sql4);
        ps1.setString(1, "false");
        int y=  ps1.executeUpdate();
        Statement Stmt2 = null;

        Stmt2 = Con.createStatement();
        String email=null,nameE=null;

        ResultSet RS2 = Stmt2.executeQuery("select member.email,member.name  from member  INNER JOIN reservation where member.userName=reservation.staffMember and reservation.slotID=" + "'" + slotID + "'");

        while (RS2.next())
        {
            email=RS2.getString("email");
            nameE=RS2.getString("name");

        }



        String subject="New registration process";
        String body="Welcome "+nameE+"\n student "+userName+" registered to new slot\nthanks for using Office hours web site";

        String subject2="reminding";
        String body2="Welcome "+name+"\n Today you have an office hour meeting in subject "+studentSubject;

        capAndEmail.sendEmail2(email,subject,body);
        System.out.println(date);
        capAndEmail  tool= new capAndEmail();
        tool. sendEmail3(studentEmail,date,subject2,body2);
        session.setAttribute("msg","done");
        response.sendRedirect("welcomestudent.jsp");
    }

        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }
    }
}
