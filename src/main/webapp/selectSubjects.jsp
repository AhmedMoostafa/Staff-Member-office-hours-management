<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="tools.Database" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="tools.member" %><%--
  Created by IntelliJ IDEA.
  User: ahmed
  Date: 1/12/2021
  Time: 9:28 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%


    Connection Con= Database.getConnection();
    Statement Stmt = Con.createStatement();
    ResultSet RS = null;
    boolean valid=true;
    String msg=null;
    member person   = (member) request.getSession().getAttribute("member");
    String userName=person.userName;
    String role=person.role;

    if(request.getSession().getAttribute("msg")!=null)
    {
        msg=request.getSession().getAttribute("msg").toString();
        valid=false;
    }


    if(request.getParameter("search")!=null)
    {
        RS = Stmt.executeQuery("SELECT *  FROM subject where name="+ "'" + request.getParameter("search") + "'");

        if(!RS.isBeforeFirst()){

            valid=false;
            msg="the name is not valid";

        }
    }
    else
    {

        RS = Stmt.executeQuery("SELECT *  FROM subject ");

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
<jsp:include page="/headers/studentHeader.jsp"/>

<%}else{%>
<jsp:include page="/headers/staffHeader.jsp"/>

<%}%>

<% if (valid==false) { %>
<div class="container p-3 my-3 bg-primary text-white"><%=msg%></div>
<%valid=true;
    session.setAttribute("msg", null);
    session.removeAttribute("msg");
%>
<% }%>
<%while (RS.next()) {%>

<div class="container-sm p-3 my-3 bg-dark text-white text-center" style="border: cadetblue solid">

    <h2 s>  <%=RS.getString("name")%></h2>

    <a href="RegisterNewSubject?code=<%=RS.getString("code")%>&user=<%=userName%>"><button class="btn btn-success">register</button></a>
    <a href="cancelSubject?code=<%=RS.getString("code")%>&user=<%=userName%>"><button class="btn btn-danger">cancel</button></a>

</div>

<% } %>
<%
    Con.close();
    Stmt.close();
%>







</body>
</html>
