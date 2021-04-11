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
    String userName=null;
    Connection Con = Database.getConnection();
    ResultSet RS=null;
    String role=null;

   boolean check=false;
        member person   = (member) request.getSession().getAttribute("member");
        userName=person.userName;
         role=person.role;


        Statement s = Con.createStatement();
        String sql2 = "SELECT * FROM message WHERE toMember  ='" +userName+ "'";
        RS = s.executeQuery(sql2);

        String sql4 = "UPDATE message SET status =? WHERE  toMember='" + userName + "';";
        PreparedStatement ps = Con.prepareStatement(sql4);
        ps.setString(1, "false");
        int y = ps.executeUpdate();


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

<%}%>
<%while(RS.next()){%>
<div class="container-sm p-3 my-3 bg-dark " style="border: cadetblue solid ;color: white">
    <h1 style="color: cornflowerblue;">Subject: <%=RS.getString("subject")%></h1>
    <h5>From:</h5>
    <h6><span style="color: darksalmon;">name:</span> <%=RS.getString("fromName")%> &nbsp; <span style="color: darksalmon;">user name:</span> <%=RS.getString("fromMember")%> </h6>
    <h2 style="color: cornflowerblue;">Subject:</h2>
    <h3> <%=RS.getString("body")%></h3>
    <%if(role.equals("staff")){%>
    <a href="sendForm.jsp?type=replay&subject=<%=RS.getString("subject")%>&to=<%=RS.getString("fromMember")%>" style=" text-decoration:none;"  > <button type="button" class="btn btn-primary">replay</button> </a>
    <%}%>
</div>
<%check=true;%>
<%}%>
<%if(check==false){%>
<div class="container p-3 my-3 bg-primary text-white">empty</div>

<%}%>
</body>
</html>
