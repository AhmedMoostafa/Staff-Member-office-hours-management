<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="tools.Database" %>
<%@ page import="tools.member" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    member person   = (member) request.getSession().getAttribute("member");
    String userName=person.userName;
 String type=request.getParameter("type");
%>
<html>
<head>
    <title>Contact with Staff</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous">
    <link rel="stylesheet" href="welcomeStudent.css">
</head>
<body>
<jsp:include page="/headers/studentHeader.jsp"/>
<div class="card bg-secondary text-white">
    <div class="card-body">   <h1>Your Subjects</h1></div>
</div>

<%
    Connection Con ;
    Statement Stmt ;
    ResultSet RS ;

        Con = Database.getConnection();
        Stmt = Con.createStatement();
        String query = "SELECT * FROM registeredsubject where userName='" +userName+ "'";
        RS = Stmt.executeQuery(query);


%>

    <%  while(RS.next()){%>
    <form method="post">

        <div class="container-sm p-3 my-3 bg-dark text-white text-center" style="border: cadetblue solid">
            <h3 s> <a href="<%=type%>.jsp?subject=<%=RS.getString("subjectCode")%>" tyle="text-decoration:none"><%=RS.getString("subjectCode")%></a></h3>

        </div>
    </form>
    <%}Stmt.close(); Con.close(); RS.close();%>
</body>
</html>
