<%-- 
    Document   : viewslots
    Created on : Jan 11, 2021, 6:32:09 PM
    Author     : momen
--%>

<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@ page import="tools.Database" %>
<%@ page import="tools.member" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    member person   = (member) request.getSession().getAttribute("member");
    String userName=person.userName;
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous">

        <link rel="stylesheet" href="welcomeStudent.css">

        <title>JSP Page</title>
    </head>
    <body>
    <jsp:include page="/headers/studentHeader.jsp"/>
    <%
            Connection Con = null;
            Statement Stmt = null;
            ResultSet RS = null;
            ResultSet RS2=null;


            Con = Database.getConnection();
            Stmt = Con.createStatement();
               String sql2 = "SELECT * FROM reservation where student  =  '" +userName+"'";
                 RS2 = Stmt.executeQuery(sql2);
                %>


    <br>

    <table class="table table-dark table-hover">
            <tr>
                <th cope="col">Student</th>
                <th cope="col"> Date</th>

                <th scope="col">Time</th>
                 <th scope="col">Subject</th>
                <th scope="col">Staff Member</th>
                <th scope="col">cancel</th>

            </tr>

             <%  while(RS2.next()){%>
            <tr>
                <td>  <%=RS2.getString("student")%> </td>
                <td> <%=RS2.getString("date")%></td>

                <td>  <%=RS2.getString("time")%></td>
                <td>  <%=RS2.getString("subject")%> </td>
                <td>  <%=RS2.getString("staffMember")%></td>
                <td> <button type="button" class="btn btn-danger"><a href="cancelSlot?ID=<%=RS2.getString("ID")%>&slotID=<%=RS2.getString("slotID")%>" style="text-decoration:none;color: white">submit</a></button></td>

            </tr>
                    <%}%>
        </table>

    </body>
</html>
