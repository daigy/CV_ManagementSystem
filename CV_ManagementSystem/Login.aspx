<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="CV_ManagementSystem.Login" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>CV Management System</title>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <!--===============================================================================================-->
    <link rel="icon" type="image/png" href="Resources/Login/images/icons/favicon.ico" />
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css" href="Resources/Login/bootstrap/css/bootstrap.min.css"/>
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css" href="Resources/Login/fonts/font-awesome-4.7.0/css/font-awesome.min.css"/>
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css" href="Resources/Login/animate/animate.css" />
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css" href="Resources/Login/css-hamburgers/hamburgers.min.css" />
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css" href="Resources/Login/select2/select2.min.css" />
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css" href="Resources/Login/util.css" />
    <link rel="stylesheet" type="text/css" href="Resources/Login/main.css" />
    <!--===============================================================================================-->
    <style>
         #loader {  
    position: fixed;  
    left: 0px;  
    top: 0px;  
    width: 100%;  
    height: 100%;  
    z-index: 9999;  
    background: url('Resources/Images/loader.gif') 50% 50% no-repeat rgb(249,249,249);  
}  
    </style>
</head>
<body>
      <form id="form2" runat="server">
          <div id="loader"></div> 
    <div class="limiter">
        <div >
        <div class="container-login100">
             
            <div class="wrap-login100" style="box-shadow: 15px 20px 0px rgb(0 0 0 / 10%);">
                <div class="row h-100 justify-content-center align-items-center" style="width: 960px;margin-top:-12%;border:0;border-bottom: 1px solid rgba(0,0,0,.1);">
                       <div class="d-flex justify-content-center" style="margin-bottom: 10px;" >
                          <span style="font-size: 34px;font-style: oblique;color: #de6262;font-weight: bolder;">CV
                              <span style="font-size: 34px;font-style: oblique;color: #0c8190;font-weight: bolder;"> Management System </span>  </span> 
                       </div> 
                    </div>
                <div class="login100-form validate-form" id="form1" >
                    
                    <span class="login100-form-title">Login <span style="color:#DE6262;font-size: 1rem;">Now </span>
                    </span>
                    
                    <div class="wrap-input100 validate-input" data-validate="Valid email is required: ex@abc.xyz">
                        
                        <asp:TextBox ID="txt_UserName" runat="server" class="input100" placeholder="USERNAME"></asp:TextBox>
                        <%--<input class="input100" type="text" name="email" placeholder="Email"><span class="focus-input100"></span>--%>
                        <span class="symbol-input100">
                            <i class="fa fa-user" aria-hidden="true"></i>
                        </span>
                    </div>

                    <div class="wrap-input100 validate-input" data-validate="Password is required">
                       <asp:TextBox ID="txt_Password" runat="server" class="input100" placeholder="PASSWORD" TextMode="Password"></asp:TextBox>
                        
                        <%--<input class="input100" type="password" name="pass" placeholder="Password"><span class="focus-input100"></span>--%>
                        <span class="symbol-input100">
                            <i class="fa fa-lock" aria-hidden="true"></i>
                        </span>
                    </div>

                    <div class="container-login100-form-btn">
                         <asp:Button ID="Button1" runat="server" class="btn login100-form-btn" Text="Login" OnClick="Button1_Click"/>
                        <%--<button class="login100-form-btn">
                            Login
                        </button>--%>
                    </div>

                    <div class="text-center p-t-12">
                        <%--<span class="txt1">Forgot
                        </span>
                        <a class="txt2" href="#">Username / Password?
                        </a>--%>
                    </div>

                    <div class="text-center p-t-86">
                        <%--<a class="txt2" href="#">Create your Account
							<i class="fa fa-long-arrow-right m-l-5" aria-hidden="true"></i>
                        </a>--%>
                        <div style="font-size: 13px;">Designed by <i class="fa fa-mobile" style="color:#FEB58A"></i> IT Department</div>
                    </div>
                </div>
                <div class="login100-pic">
                    <img src="Resources/Login/images/ECCGroup.gif" style="border-radius: 15px;" />
                </div>

            </div>
        </div>
            </div>
    </div>
          </form>
    <!--===============================================================================================-->	
    <script src="Resources/Login/jquery/jquery-3.2.1.min.js"></script>
<!--===============================================================================================-->
    <script src="Resources/Login/bootstrap/js/popper.js"></script>
    <script src="Resources/Login/bootstrap/js/bootstrap.min.js"></script>
<!--===============================================================================================-->
    <script src="Resources/Login/select2/select2.min.js"></script>
<!--===============================================================================================-->
    <script src="Resources/Login/main.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
    <script type="text/javascript">  
    $(window).load(function () {
        $("#loader").fadeOut(1500);
    });
    </script>  
</body>
</html>

