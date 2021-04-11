<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="tools.Database" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="tools.member" %><%--
  Created by IntelliJ IDEA.
  User: ahmed
  Date: 1/15/2021
  Time: 4:58 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String ID=null;
    Connection Con = Database.getConnection();
    ResultSet RS=null;

    member person   = (member) request.getSession().getAttribute("member");
    String role=person.role;
        ID=request.getParameter("ID");

        Statement s = Con.createStatement();
        RS = s.executeQuery("select member.email ,member.name ,member.userName from member INNER JOIN reservation where member.userName= reservation.student and reservation.slotID='" + ID + "'");



%>
<html>
<head>
    <title>Title</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous">
    <link rel="stylesheet" href="welcomeStudent.css">
</head>
<body>
<jsp:include page="headers/staffHeader.jsp"/>
<table class="table table-dark table-hover">
    <tr>
        <th scope="col">Name</th>
        <th scope="col">Email</th>
        <th scope="col">User name</th>
    </tr>

    <%  while(RS.next()){%>
    <tr>
        <td><%=RS.getString("name")%></td>
        <td><%=RS.getString("email")%></td>
        <td><%=RS.getString("userName")%></td>
    </tr>
    <%}%>
</table>
</body>
</html>
