<%@ page import="tools.notification" %>
<%@ page import="tools.member" %><%--
  Created by IntelliJ IDEA.
  User: ahmed
  Date: 1/17/2021
  Time: 12:49 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
String userName = null;
    member person=new member();
    if(request.getSession().getAttribute("member")!=null)
    {
      person   = (member) request.getSession().getAttribute("member");
    }
    int count= notification.getNumberOfUnRead(person.userName);


%>
<html>
<head>
    <title>Title</title>
</head>
<body>

<nav>
    <a href="welcomestudent.jsp" style="text-decoration:none">  <div class="logo">Office Hours</div></a>
    <div class="nav-items">
        <li><a href="selectSubjects.jsp?student=<%=person.role%>">register in subject</a></li>
        <li><a href="subjects.jsp?type=contact">find  contact </a></li>
        <li><a href="subjects.jsp?type=choiceslot">register in slot </a></li>
        <li><a href="viewslots.jsp">slots </a></li>
        <li><a href="updateForm.jsp">Update info </a></li>
        <li><a href="sendForm.jsp">Send Message</a></li>

        <%if(count!=0){%>
        <li><a href="inbox.jsp" style="color: red">Inbox<sup><%=count%></sup></a></li>
        <%}else{%>
        <li><a href="inbox.jsp" >Inbox</a></li>
        <%}%>
    </div>
    <form action="#">
        <input type="search" class="search-data" placeholder="Search" required  name="search">
        <button type="submit" class="fas fa-search"></button>
    </form>
    <li><a href="Logout" style=" text-decoration:none; color: #cc3333" ><button type="button" class="btn btn-danger">Logout</button> </a></li>



</nav>
</body>
</html>
