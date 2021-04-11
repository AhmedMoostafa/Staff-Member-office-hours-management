
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String msg=null;
    boolean valid=true;

    if(request.getSession().getAttribute("msg")==null)
    {
    }
    else
    {
        msg=request.getSession().getAttribute("msg").toString();
        valid = false;

    }

%>
<!DOCTYPE html>
<html lang="en" dir="ltr">
<head>
    <meta charset="utf-8">
    <title>Login & Sign Up Form</title>
    <link rel="stylesheet" href="Login.css">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://kit.fontawesome.com/a076d05399.js"></script>
    <script src="https://www.google.com/recaptcha/api.js"></script>

</head>
<body>
<nav>
    <div class="items"></div>
    <div class="logo">Office Hours</div>
    <div class="nav-items">
        <li><a href="#">Home</a></li>
        <li><a href="#">About</a></li>
        <li><a href="#">Contact</a></li>
        <li><a href="#">Feedback</a></li>
    </div>
    <div class="search-icon"></div>
    <form action="#">
        <input type="search" class="search-data" placeholder="Search" required>
        <button type="submit" class="fas fa-search"></button>
    </form>
</nav>

<div class="container">
    <form  class="form" onsubmit= "return checkForm2(this)" id="login" action="validateLogin" method="post">
        <h1 class="formtitle">Login</h1>
        <div class="formmessage form__message--error"></div>
        <div class="formInput">
            <input type="text" class="forminput" id="email" autofocus placeholder="Email"required name="email" onblur= "return checkForm(this);">
            <div class="errormessage"></div>
        </div>
        <div class="formInput">
            <input type="password" name="password" class="forminput" id="password" autofocus placeholder="Password"required onblur= "return checkForm(this);">
            <div class="errormessage"></div>
        </div>
        <div class="g-recaptcha"
             data-sitekey="6LdQ-CgaAAAAAIc5QuuvXnQm8CWUymF7VmFJyToF"></div>
        <br/>
        <p style="color: red"  id="EmailError"></p>

        <% if (valid==false) { %>
        <p style="color: red"><%=msg%></p>
        <%valid=true;
            session.setAttribute("msg", null);
            session.removeAttribute("msg");
        %>
        <% }%>
        <br/>
        <button class="formbutton" type="submit">Log in</button>
        <p class="formtext">
            <a class="formlink" href="./" id="SignUp">Sign Up</a><br>
        </p>

    </form>
    <%--****************************************--%>
    <form class="form form--hidden" onsubmit= "return checkSignUp2(this)" id="signUpForm" action="validate"  method="post">
        <h1 class="formtitle">Sign Up</h1>
        <div class="formmessage form__message--error"></div>
        <div class="formInput">
            <input type="text" id="signupFrist Name" class="forminput" autofocus placeholder="Name" required name="name" >
            <div class="errormessage"></div>
        </div>
        <div class="formInput">
            <input type="text" id="UserName" class="forminput" autofocus placeholder="User Name" required name="userName"onblur= "return checkSignUp(this);">
            <div class="errormessage"></div>
        </div>
        <div class="formInput">
            <input type="text" class="forminput" id="Email" autofocus placeholder="Email Address" required name="email" onblur= "return checkSignUp (this);">
            <div class="errormessage" id="error"></div>
        </div>
        <div class="formInput">
            <select name="role">
                <option value="student">student</option>
                <option value="staff">staff Member</option>
            </select>
        </div>
        <div class="g-recaptcha"
             data-sitekey="6LdQ-CgaAAAAAIc5QuuvXnQm8CWUymF7VmFJyToF"></div>
        <br>
        <button class="formbutton" type="submit">Sign Up</button>
        <p class="formtext">
            <a class="formlink" href="./" id="Login">Already Sign Up? Log in</a>
        </p>
    </form>
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
    function setFormMessage(formElement, type, message) {
        const messageElement = formElement.querySelector(".formmessage");

        messageElement.textContent = message;
        messageElement.classList.remove("form__message--success", "form__message--error");
        messageElement.classList.add(`form__message--${type}`);
    }
    function setInputError(inputElement, message) {
        inputElement.classList.add("form__input--error");
        inputElement.parentElement.querySelector(".errormessage").textContent = message;
    }
    function clearInputError(inputElement) {
        inputElement.classList.remove("form__input--error");
        inputElement.parentElement.querySelector(".errormessage").textContent = "";
    }
    document.addEventListener("DOMContentLoaded", () => {
        const loginForm = document.querySelector("#login");
        const createAccountForm = document.querySelector("#signUpForm");
        document.querySelector("#SignUp").addEventListener("click", e => {
            e.preventDefault();
            loginForm.classList.add("form--hidden");
            createAccountForm.classList.remove("form--hidden");
        });
        document.querySelector("#Login").addEventListener("click", e => {
            e.preventDefault();
            loginForm.classList.remove("form--hidden");
            createAccountForm.classList.add("form--hidden");
        });
        function ValidateEmail(email)
        {
            if (/^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$/.test(email))
            {
                return true;
            }
            else
            {
                return false;
            }

        }

        document.querySelectorAll(".forminput").forEach(inputElement => {
            inputElement.addEventListener("blur", e => {
                if ((e.target.id === "signupUser Name" || e.target.id==="user") && e.target.value.length > 0 && e.target.value.length < 8) {
                    setInputError(inputElement, "Username must be at least 8 characters in length");
                }
                else if (e.target.id === "password" && e.target.value.length > 0 && e.target.value.length < 8) {
                    setInputError(inputElement, "Password must be at least 8 characters in length");
                }
                else  if(e.target.id=="Email"&&ValidateEmail(e.target.value)==false)
                {
                    setInputError(inputElement, "please Enter valid email ");
                }
            });
            inputElement.addEventListener("input", e => {
                clearInputError(inputElement);
            });
        });
    });

    function checkForm(form)
    {
        console.log(document.getElementById("email").value,document.getElementById("password").value)

         login2(document.getElementById("email").value,document.getElementById("password").value)
    }
    function checkForm2(form)
    {
        console.log(document.getElementById("EmailError").innerHTML)
        if(document.getElementById("EmailError").innerHTML===".")
        {
            console.log("false")
            return true;
        }
        else
        {
            console.log(document.getElementById("EmailError").innerHTML)

            console.log("nznnzn")

            return  false;
        }
    }

    function login2(email,password)
    {
        var xmlhttp = new XMLHttpRequest();
        xmlhttp.open("POST", "PasswordEmailCheckAjax",true);
        xmlhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
        xmlhttp.send("email="+email+"&password="+password);;
        var userName = document.getElementById("EmailError");
        xmlhttp.onreadystatechange = function ()
        {
            if (xmlhttp.readyState === 4 && xmlhttp.status === 200)
            {

                if(xmlhttp.responseText) {
                    userName.innerHTML = xmlhttp.responseText.toString();
                    console.log("sla")
                }


            }

        };
    }
    function checkSignUp(form)
    {
/*
*/
        console.log(document.getElementById("Email").value,document.getElementById("UserName").value)

        SignUpAjax(document.getElementById("Email").value,document.getElementById("UserName").value)
    }
    function checkSignUp2(form)
    {
        console.log(document.getElementById("error").innerHTML)
        console.log("jajja")
        if(document.getElementById("error").innerHTML==".")
        {
            return true;
        }
        else
        {
            return  false;
        }
    }
    function SignUpAjax(email,userName)
    {
        var xmlhttp = new XMLHttpRequest();
        xmlhttp.open("POST", "EmailCheckAjax",true);
        xmlhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
        xmlhttp.send("email="+email+"&userName="+userName);;
        var error = document.getElementById("error");
        xmlhttp.onreadystatechange = function ()
        {
            if (xmlhttp.readyState === 4 && xmlhttp.status === 200)
            {

                if(xmlhttp.responseText) {
                    error.innerHTML = xmlhttp.responseText.toString();
                }


            }

        };
    }

</script>
</body>
</html>
