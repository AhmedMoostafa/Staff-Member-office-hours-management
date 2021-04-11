package validation;

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

import static tools.capAndEmail.*;


@WebServlet(name = "validate", value = "/validate")
public class validateSignUp extends HttpServlet {
    private String message;
    private static char[] generatePassword(int length) {
        String capitalCaseLetters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
        String lowerCaseLetters = "abcdefghijklmnopqrstuvwxyz";
        String specialCharacters = "!@#$";
        String numbers = "1234567890";
        String combinedChars = capitalCaseLetters + lowerCaseLetters + specialCharacters + numbers;
        Random random = new Random();
        char[] password = new char[length];

        password[0] = lowerCaseLetters.charAt(random.nextInt(lowerCaseLetters.length()));
        password[1] = capitalCaseLetters.charAt(random.nextInt(capitalCaseLetters.length()));
        password[2] = specialCharacters.charAt(random.nextInt(specialCharacters.length()));
        password[3] = numbers.charAt(random.nextInt(numbers.length()));

        for(int i = 4; i< length ; i++) {
            password[i] = combinedChars.charAt(random.nextInt(combinedChars.length()));
        }
        return password;
    }
    private  boolean checkEmailAndUserName(String email,String userName) throws SQLException {
        Connection Con = null;
        Statement Stmt = null;
        ResultSet RS = null;
        Con = Database.getConnection();
        Stmt = Con.createStatement();

        RS = Stmt.executeQuery("SELECT email , userName FROM member where email="+ "'" + email + "' or userName="+ "'" + userName + "'");
        if(!RS.isBeforeFirst()){
            Con.close();
            Stmt.close();
           return  true;
        }
        else {
            Con.close();
            Stmt.close();
            return false;

        }

    }
    public void doPost(HttpServletRequest request, HttpServletResponse response) {
        String cap=request.getParameter("g-recaptcha-response");

        Connection Con = null;
        Statement Stmt = null;
        ResultSet RS = null;
        HttpSession session=request.getSession(true);
        String email=request.getParameter("email");
        String userName=request.getParameter("userName");
        String name=request.getParameter("name");
        String password=String.valueOf(generatePassword(8));
        String role=request.getParameter("role");
        try {

            if (captchaValidate(cap) == true && checkEmailAndUserName(email, userName) == true)
            {
                Con = Database.getConnection();
                Stmt = Con.createStatement();
                String sql = "INSERT INTO member(userName, name, email,role,password) VALUES("
                            + "'" + userName + "',"
                            + "'" + name + "',"
                            + "'" + email + "',"
                            + "'" + role + "',"
                            + "'" + password + "')";

                int rows = Stmt.executeUpdate(sql);
                sendEmail(email,name,password);
                session.setAttribute("msg","your password hase sent to your email");
                response.sendRedirect("index.jsp");
                Con.close();
                Stmt.close();
            }
            else
            {
                session.setAttribute("msg","Error in signup please check your data and try again");
                response.sendRedirect("index.jsp");

            }


        }catch (SQLException | IOException throwables) {
            throwables.printStackTrace();
        }







    }

    public void destroy() {
    }
}