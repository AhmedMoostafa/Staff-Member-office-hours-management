<%@ page import="java.sql.Connection" %>
<%@ page import="tools.Database" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="tools.notification" %>
<%@ page import="tools.member" %><%--
  Created by IntelliJ IDEA.
  User: ahmed
  Date: 1/14/2021
  Time: 3:37 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%


    String msg=null;
    boolean valid=true;
    boolean search=false;
    ResultSet RS=null;
    member person   = (member) request.getSession().getAttribute("member");
    String  userName=person.userName;
    String name=person.name;
    if(request.getSession().getAttribute("msg")!=null) {
        msg = request.getSession().getAttribute("msg").toString();
        valid = false;
    }
    if(request.getParameter("search")!=null)
    {

        Connection con ;
        con= Database.getConnection();
        Statement s = con.createStatement();
        String x="student";
        String sql2 = "SELECT * FROM member WHERE name  = '"+request.getParameter("search") +"' and  role='" +x+ "'";
        RS = s.executeQuery(sql2);
        search=true;
    }
%>
<html>
<head>
    <title>Title</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous">
    <link rel="stylesheet" href="welcomeStudent.css">
</head>
<body>
<jsp:include page="headers/staffHeader.jsp"/>
<% if (valid==false) { %>
<div class="container p-3 my-3 bg-primary text-white"><%=msg%></div>
<%valid=true;
    session.setAttribute("msg", null);
    session.removeAttribute("msg");
%>
<% }%>
<h3 ><strong> Your User name:</strong> <%=userName%></h3 >

<%if(search==true){%>
<table class="table table-dark table-hover">
    <tr>
        <th scope="col">Name</th>
        <th scope="col">Email</th>
        <th scope="col">User name</th>
    </tr>

    <%  while(RS.next()){%>
    <tr>
        <td><%=RS.getString("name")%></td>
        <td><%=RS.getString("Email")%></td>
        <td><%=RS.getString("userName")%></td>

<%--
        <td> <button type="button" class="btn btn-danger"><a href="addSlot?slotID=<%=RS.getString("ID")%>" style="text-decoration:none;color: white">submit</a></button></td>
--%>

    </tr>
    <%}%>
</table>
<%}else{%>

<div class="content">
    <header>Welcome <%=name%></header>
        <%}%>



</body>
</html>
