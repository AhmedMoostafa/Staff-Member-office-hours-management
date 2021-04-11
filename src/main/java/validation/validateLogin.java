package validation;

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

import static tools.capAndEmail.captchaValidate;

@WebServlet(name = "validateLogin", value = "/validateLogin")
public class validateLogin extends HttpServlet {
    private  member checkEmailAndUserName(String email,String password) throws SQLException {
        Connection Con = null;
        Statement Stmt = null;
        ResultSet RS = null;
        member person = new member();

        Con = Database.getConnection();
        Stmt = Con.createStatement();
        System.out.println(email+"  "+password);
        RS = Stmt.executeQuery("SELECT * FROM member where email=" + "'" + email + "' and password=" + "'" + password + "'");
        if (RS.isBeforeFirst()) {
            while (RS.next()) {
                person.userName=RS.getString("userName");
                person.name=RS.getString("name");
                person.email=RS.getString("email");
                person.role=RS.getString("role");
                person.password=RS.getString("password");

            }
            Con.close();
            Stmt.close();
            return person;
        } else {
            Con.close();
            Stmt.close();
            return null;
        }

    }


    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String cap = request.getParameter("g-recaptcha-response");
        HttpSession session = request.getSession(true);
        String email=request.getParameter("email");
        String password = request.getParameter("password");
        try {
            System.out.println(email+" "+password);
            member person=checkEmailAndUserName(email, password);
            System.out.println(person.userName);
            if (captchaValidate(cap) == true && person!=null) {

                System.out.println(email +"  "+ password+"  "+person.role);

                if(person.role.equals("student"))
                {
                    response.sendRedirect("welcomestudent.jsp");
                }
                else if(person.role.equals("staff"))
                {
                    response.sendRedirect("welcomestaff.jsp");

                }
                session.setAttribute("member",person);


            }
            else
            {
                session.setAttribute("msg","Error in signup please check your data and try again");
                response.sendRedirect("index.jsp");
            }
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        }

    }

}