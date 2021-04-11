<%@ page import="tools.Database" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="tools.member" %><%--
  Created by IntelliJ IDEA.
  User: ahmed
  Date: 1/13/2021
  Time: 9:25 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Connection Con = null;
    Statement Stmt = null;
    ResultSet RS = null;

    String email=null,password=null,name=null;
    String msg=null;
    boolean valid=false;
    member person   = (member) request.getSession().getAttribute("member");
     name=person.name;
    password=person.password;
    email=person.email;
    String role=person.role;

    if(request.getSession().getAttribute("msg")!=null)
    {
        msg=request.getSession().getAttribute("msg").toString();
        valid=true;
    }



%>
<html>
<head>
    <title>Title</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous">
    <link rel="stylesheet" href="welcomeStudent.css">
</head>
<body>
<%if(role.equals("student")){%>
<jsp:include page="headers/studentHeader.jsp"/>
<%}else {%>
<jsp:include page="headers/staffHeader.jsp"/>

<%}%><form method="post" action="updateInfo">
    <div class="form-group">
        <label for="exampleInputEmail1">Email address</label>
        <input type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="Enter email" name="email" value="<%=email%>" >
        <small id="emailHelp" class="form-text text-muted">We'll never share your email with anyone else.</small>
    </div>
    <div class="form-group">
        <label for="exampleInputPassword1">Password</label>
        <input type="password" class="form-control" id="exampleInputPassword1" placeholder="Password" name="password" value="<%=password%>">
    </div>
    <div class="form-group">
        <label for="name">Name</label>
        <input type="text" class="form-control" id="name" placeholder="name" name="name" value="<%=name%>">
    </div>
    <button type="submit" class="btn btn-primary">Submit</button>
</form>

<% if (valid==true) { %>
<div class="container p-3 my-3 bg-primary text-white"><%=msg%></div>
<%valid=false;
    session.setAttribute("msg", null);
    session.removeAttribute("msg");
%>
<% }%>
</body>

</html>
