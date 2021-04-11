<%--
  Created by IntelliJ IDEA.
  User: ahmed
  Date: 1/15/2021
  Time: 1:00 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String msg=null;boolean valid=false;
    if(request.getSession().getAttribute("msg")!=null) {
         msg = request.getSession().getAttribute("msg").toString();
        valid = true;
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
<button type="button" class="btn btn-primary btn-lg btn-block" onclick="specific();">for specific Member</button>
<button type="button" class="btn btn-secondary btn-lg btn-block" onclick="AllStaff();">for All staff Member</button>
<% if (valid==true) { %>
   <div class="container p-3 my-3 bg-primary text-white"><%=msg%></div>
   <%valid=true;
       session.setAttribute("msg", null);
       session.removeAttribute("msg");
   %>
   <% }%>
<div  id="demo">
</div>
<script type="text/javascript">
    function specific() {
        var xhttp = new XMLHttpRequest();
        xhttp.onreadystatechange = function() {
            if (this.readyState == 4 && this.status == 200) {
                document.getElementById("demo").innerHTML = this.responseText;
            }
        };
        xhttp.open("GET", "sendForm.jsp?type=specific", true);
        xhttp.send();
    }
    function AllStaff() {
        var xhttp = new XMLHttpRequest();
        xhttp.onreadystatechange = function() {
            if (this.readyState == 4 && this.status == 200) {
                document.getElementById("demo").innerHTML = this.responseText;
            }
        };
        xhttp.open("post", "sendForm.jsp?type=all", true);
        xhttp.send();

    }
</script>

</body>
</html>
