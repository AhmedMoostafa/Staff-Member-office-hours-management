<%@ page import="tools.Database" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.Connection" %><%--
  Created by IntelliJ IDEA.
  User: ahmed
  Date: 1/12/2021
  Time: 6:18 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    ResultSet RS =null ;
    Statement Stmt =null;
    Connection Con =null;
    Con = Database.getConnection();
    Stmt = Con.createStatement();
    if(request.getParameter("search")!=null)
    {
        String u=request.getParameter("search");
        System.out.println(request.getParameter("search"));
        RS = Stmt.executeQuery("SELECT name ,email  FROM member where name="+ "'" + request.getParameter("search") + "'");
    }
    else
    {

            String subject=request.getParameter("subject");
            RS = Stmt.executeQuery("select member.email ,member.name from member INNER JOIN registeredstaff where member.userName=registeredstaff.userName and registeredstaff.subjectCode='" +subject+ "'");

    }

%>
<html>
<head>
    <title>Title</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous">
    <link rel="stylesheet" href="welcomeStudent.css">
</head>
<body>
<jsp:include page="headers/studentHeader.jsp"/>
<%while (RS.next()) {%>

<div class="container-sm p-3 my-3 bg-dark text-white text-center" style="border: cadetblue solid">

    <h2 s>  <%=RS.getString("email")%></h2>
    <h3 s>  <%=RS.getString("name")%></h3>


</div>

<% } %>
<%
    Con.close();
    Stmt.close();
%>

</body>
</html>
