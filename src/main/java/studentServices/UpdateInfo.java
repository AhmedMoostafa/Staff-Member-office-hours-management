package studentServices;

import tools.member;
import tools.updateInfo;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "UpdateInfo",value = "/updateInfo")
public class UpdateInfo extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(true);
        boolean stat=false;
        System.out.println(request.getParameter("name")+" "+request.getParameter("email")+"  "+request.getParameter("password"));
        member person   = (member) request.getSession().getAttribute("member");
        String  userName=person.userName,role=person.role;

        if(request.getParameter("name")!=null&&request.getParameter("email")!=null&&request.getParameter("password")!=null)
        {

            try {
                 person=  updateInfo.update(request.getParameter("name"),request.getParameter("email"),request.getParameter("password"),userName);

                if(person!=null)
                {
                    person.userName=userName;
                    person.role=role;

                    session.setAttribute("member",person);

                    session.setAttribute("msg","done");

                }
                else {
                    session.setAttribute("msg","Error");

                }


            } catch (SQLException throwables) {
                throwables.printStackTrace();
            }
        }
        else
        {
            session.setAttribute("msg","Error");

        }
        response.sendRedirect("welcome"+person.role+".jsp");



    }


}
