<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="tools.Database" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="tools.member" %><%--
  Created by IntelliJ IDEA.
  User: ahmed
  Date: 1/15/2021
  Time: 1:00 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String type=null;
    ResultSet RS=null;
    boolean valid=false;
    boolean replay=false;
    String subject=null,to=null;
    member person   = (member) request.getSession().getAttribute("member");
    String  userName=person.userName;
    String role=person.role;

    if(request.getParameter("type")!=null)
    {
        if(request.getParameter("type").equals("replay"))
        {
            subject="replay about: "+request.getParameter("subject");
            to=request.getParameter("to");
            type = request.getParameter("type");
            replay=true;
        }else {

            System.out.println(request.getParameter("type"));
            type = request.getParameter("type");

            if (type.equals("all")) {
                Connection con;
                con = Database.getConnection();
                Statement Stmt = con.createStatement();
                RS = Stmt.executeQuery("select subject.name ,subject.code from subject INNER JOIN registeredstaff where subject.code=registeredstaff.subjectCode and registeredstaff.userName='" + userName + "'");
                Statement Stmt2 = con.createStatement();
                valid = true;
                System.out.println(valid);
            }
        }
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
<%}%>
<form method="post" action="sendMessage">
    <input type="text" class="form-control" hidden value="<%=type%>" name="type">

    <%if(replay==true){%>
    <%System.out.println(to);%>
    <div class="form-group">
        <label for="To">To:</label>
        <input type="text" class="form-control" id="To" aria-describedby="emailHelp" placeholder="To"name="to" value="<%=to%>">
    </div>

    <div class="form-group">
        <label for="subject">subject</label>
        <input type="text" class="form-control" id="subject" placeholder="subject" name="subject" value="<%=subject%>" >
    </div>
    <div class="form-group">
        <label for="body">body:</label>
        <input type="text" class="form-control" id="body" aria-describedby="emailHelp" placeholder="body" name="body">
    </div>
    <%}else{%>

    <%if(valid==true){%>
    <div class="form-group">
        <label for="To">To:</label>
        <input type="text" class="form-control" id="To" aria-describedby="emailHelp" placeholder="To" value="For All staff" disabled name="to">
    </div>

    <%}else{%>
    <div class="form-group">
        <label for="To">To:</label>
        <input type="text" class="form-control" id="To" aria-describedby="emailHelp" placeholder="To"name="to">
    </div>
    <%}%>
    <div class="form-group">
        <label for="subject">subject</label>
        <input type="text" class="form-control" id="subject" placeholder="subject" name="subject">
    </div>
    <div class="form-group">
        <label for="body">body:</label>
        <input type="text" class="form-control" id="body" aria-describedby="emailHelp" placeholder="body" name="body">
    </div>


    <%if(valid==true){%>
    Staff: <select name="staff">

            <%while (RS.next()){%>
            <option value="<%=RS.getString("code")%>"><%=RS.getString("name")%></option>
            <%}%>
    </select>
    <%}%>
<%}%>
 <br>
    <div class="text-center">
        <button type="submit" class="btn btn-primary">send button</button>
    </div>
</form>
<a href="welcome<%=role%>.jsp "style="text-decoration:none"> <button type="button" class="btn btn-danger">back</button> </a>

</body>
</html>
