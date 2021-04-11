<%@ page import="tools.member" %>
<%@ page import="tools.notification" %><%--
  Created by IntelliJ IDEA.
  User: ahmed
  Date: 1/17/2021
  Time: 4:33 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String userName = null;
    member person=new member();
    if(request.getSession().getAttribute("member")!=null)
    {
        person   = (member) request.getSession().getAttribute("member");
        System.out.println(person.userName);
    }
    int count= notification.getNumberOfUnRead(person.userName);
    System.out.println(count);

%>
<html>
<head>
    <title>Title</title>
</head>
<body>
<nav>
    <a href="welcomestaff.jsp" style="text-decoration:none">  <div class="logo">Office Hours</div></a>
    <div class="nav-items">
        <li><a href="selectSubjects.jsp">register in subject</a></li>
        <li><a href="sendMSG.jsp">Send Message</a></li>
        <li><a href="manageSlots.jsp">Manage slots</a></li>
        <%if(count!=0){%>
        <li><a href="inbox.jsp" style="color: red">Inbox<sup><%=count%></sup></a></li>
        <%}else{%>
        <li><a href="inbox.jsp" >Inbox</a></li>
        <%}%>
        <li><a href="updateForm.jsp">Update info </a></li>

    </div>
    <form action="#">
        <input type="search" class="search-data" placeholder="Search" required  name="search">
        <button type="submit" class="fas fa-search"></button>
    </form>
    <li><a href="Logout" style=" text-decoration:none; color: #cc3333" ><button type="button" class="btn btn-danger">Logout</button> </a></li>

</nav>
</body>
</html>
