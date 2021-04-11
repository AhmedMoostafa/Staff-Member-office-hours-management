<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="tools.Database" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="tools.notification" %>
<%@ page import="tools.member" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    String msg=null;
    boolean valid=true;
    boolean search=false;
    ResultSet RS=null;
    member person   = (member) request.getSession().getAttribute("member");
     String  userName=person.userName;
    String name=person.name;

    if(request.getSession().getAttribute("msg")!=null)
    {
        msg=request.getSession().getAttribute("msg").toString();
        valid=false;
    }
    if(request.getParameter("search")!=null)
    {

        Connection con ;
        con= Database.getConnection();
        Statement s = con.createStatement();
        String x="true";
        String sql2 = "SELECT * FROM slots WHERE name  = '"+request.getParameter("search") +"' and  status='" +x+ "'";
         RS = s.executeQuery(sql2);
        search=true;
    }

%>
<html lang="en" dir="ltr">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous">
      <link rel="stylesheet" href="welcomeStudent.css">
  </head>
  <body>
<jsp:include page="/headers/studentHeader.jsp"/>
<h3 ><strong> Your User name:</strong> <%=userName%></h3 >

  <% if (valid==false) { %>
  <div class="container p-3 my-3 bg-primary text-white"><%=msg%></div>
  <%valid=true;
      session.setAttribute("msg", null);
      session.removeAttribute("msg");
  %>
  <% }%>
  <%if(search==true){%>
  <table class="table table-dark table-hover">
      <tr>
          <th scope="col">Staff Member</th>
          <th scope="col">date</th>
          <th scope="col">start time</th>
          <th scope="col">end Time</th>
          <th scope="col">subject</th>
          <th scope="col">register</th>
      </tr>

  <%  while(RS.next()){%>
      <tr>
  <td><%=RS.getString("name")%></td>
  <td><%=RS.getString("date")%></td>
  <td><%=RS.getString("startTime")%></td>
  <td><%=RS.getString("endTime")%></td>
  <td><%= RS.getString("subject")%></td>
 <td> <button type="button" class="btn btn-danger"><a href="addSlot?slotID=<%=RS.getString("ID")%>" style="text-decoration:none;color: white">submit</a></button></td>

      </tr>
  <%}%>
  </table>
  <%}else{%>
    <div class="content" style="font-size: 50px">

        <strong>  Welcome <%=name%></strong>

   <%}%>
</div>


  <script>
      const menuBtn = document.querySelector(".items");
      const searchBtn = document.querySelector(".search-icon");
      const items = document.querySelector(".nav-items");
      const form = document.querySelector("form");
      menuBtn.onclick = ()=>{
          items.classList.add("active");
          menuBtn.classList.add("hide");
          searchBtn.classList.add("hide");
          cancelBtn.classList.add("show");
      }
      searchBtn.onclick = ()=>{
          form.classList.add("active");
          searchBtn.classList.add("hide");
          cancelBtn.classList.add("show");
      }
  </script>
  </body>

</html>