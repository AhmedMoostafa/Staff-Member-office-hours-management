package Ajax;

import tools.Database;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Random;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;

import static tools.capAndEmail.*;


@WebServlet(name = "EmailCheckAjax", value = "/EmailCheckAjax")
public class EmailCheckAjax extends HttpServlet {
    public void doPost(HttpServletRequest request, HttpServletResponse response) {



        Connection Con = null;
        Statement Stmt = null;
        ResultSet RS = null;
        try (PrintWriter out = response.getWriter()) {
            Con = Database.getConnection();
            Stmt = Con.createStatement();
            String email = request.getParameter("email");
            String userName = request.getParameter("userName");
            System.out.println(email+"  "+userName);
            RS = Stmt.executeQuery("SELECT email , userName FROM member where email="+ "'" + email + "' or userName="+ "'" + userName + "'");
            if(RS.isBeforeFirst())
            {
                out.println("Error: Email or Password is not valid!");

            }
            else
            {

                out.print(".") ;

            }
        } catch (SQLException | IOException throwables) {
            throwables.printStackTrace();
        }





    }

    public void destroy() {
    }
}