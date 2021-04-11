<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="tools.Database" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="tools.member" %><%--
  Created by IntelliJ IDEA.
  User: ahmed
  Date: 1/14/2021
  Time: 6:25 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%

    String msg=null;
    boolean valid=true;
    ResultSet RS=null,RS2=null;
    member person   = (member) request.getSession().getAttribute("member");
    String  userName=person.userName;
    String name=person.name;
    if(request.getSession().getAttribute("msg")!=null) {
        msg = request.getSession().getAttribute("msg").toString();
        valid = false;
    }
    System.out.println(userName);
        Connection con ;
        con= Database.getConnection();
        Statement Stmt = con.createStatement();
    RS = Stmt.executeQuery("select subject.name ,subject.code from subject INNER JOIN registeredstaff where subject.code=registeredstaff.subjectCode and registeredstaff.userName='" +userName+ "'");
    Statement Stmt2 = con.createStatement();
    RS2 = Stmt2.executeQuery("select *  from slots  where staffMember='" +userName+ "'");

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

<div class="container-sm p-3 my-3 bg-dark text-white text-center" style="border: cadetblue solid;padding: unset;font-size: 15px">
<h1 style="color: aquamarine">Add new slot</h1>
    <form method="post" action="newSlot">
        Date: <input type="date"name="date" >
        Start: <input type="time" name="from">
        End: <input type="time" name="to">
        <input type="text" name="location" placeholder="Location">
     Subject   <select name="subject" >

            <%while (RS.next()){%>
            <option value="<%=RS.getString("code")%>"><%=RS.getString("name")%></option>
            <%}%>
        </select>
        <br>
        <br>
        <button type="submit" class="btn btn-success">Add slot</button>
    </form>


</div>

<table class="table table-dark table-hover">
    <tr>
        <th cope="col">name</th>
        <th cope="col"> location</th>
        <th scope="col">date</th>
        <th scope="col">from</th>
        <th scope="col">to</th>
        <th scope="col">subject</th>
        <th scope="col">update</th>
        <th scope="col">delete</th>
        <th scope="col">info</th>

    </tr>

    <%  while(RS2.next()){%>

    <tr>
        <form method="post" action="updateAndDeleteSlot">

            <td hidden>  <input type="text" value="<%=RS2.getString("ID")%>" name="ID"></td>

        <td>  <%=RS2.getString("name")%> </td>
        <td>  <input type="text" value="<%=RS2.getString("location")%>" name="location"></td>
        <td>   <input type="date" value="<%=RS2.getString("date")%>" name="date"></td>
        <td>   <input type="time" value="<%=RS2.getString("startTime")%>" name="from"> </td>
        <td>   <input type="time" value="<%=RS2.getString("endTime")%>"name="to"></td>
        <td>   <%=RS2.getString("subject")%></td>
        <td> <button type="submit" class="btn btn-warning">update</button></td>

    </form>
        <td> <button type="button" class="btn btn-danger"><a href="updateAndDeleteSlot?ID=<%=RS2.getString("id")%>" style="text-decoration:none;color: white">delete</a></button></td>
        <td> <button type="button" class="btn btn-info"><a href="slotInfo.jsp?ID=<%=RS2.getString("id")%>" style="text-decoration:none;color: white">Info</a></button></td>

    </tr>

    <%}%>
</table>




</body>
</html>
