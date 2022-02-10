<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Password_Hashing.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login Form</title>
        <script src ="https://www.google.com/recaptcha/api.js?render=6LchimUeAAAAAN1nCaoU0-u0OLPiUcWGRUdG0RZd"></script>
</head>
<body>
       <form id="form1" runat="server">
    <h2>
        <br />
        <asp:Label ID="Label1" runat="server" Text="Login"></asp:Label>
        <br />
        <br />
   </h2>
        <table class="style1">
            <tr>
                <td class="style3">
        <asp:Label ID="Label2" runat="server" Text="Email"></asp:Label>
                </td>
                <td class="style2">
                    <asp:TextBox ID="tb_userid" runat="server" Height="16px" Width="280px" required="true"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="style3">
        <asp:Label ID="Label3" runat="server" Text="Password"></asp:Label>
                </td>
                <td class="style2">
                    <asp:TextBox ID="tb_pwd" runat="server" Height="16px" Width="281px" required="true"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="style3">
                </td>
                <td class="style2">
   <input type="hidden" id="g-recaptcha-response" name="g-recaptcha-response" />    
                </td>
            </tr>
            <tr>
                <td class="style2">
                    <asp:Label ID="lbl_gScore" runat="server" Text=""></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="style3">
       
                </td>
                <td class="style2">
    <asp:Button ID="btn_Submit" runat="server" Text="Login" Height="48px" 
        onclick="btn_Submit_Click" Width="288px" />
                </td>
            </tr>
    </table>
&nbsp;&nbsp;&nbsp;
    <br />
           <br />
        <asp:Label ID="errMsg" runat="server" Visible="false" >Error message here (lblMessage)</asp:Label>
           <br />
           <br />
           <br />
        <br />
        <br />
   
    <div>
    
    </div>
    </form>
    <script>
        grecaptcha.ready(function () {
            grecaptcha.execute('6LchimUeAAAAAN1nCaoU0-u0OLPiUcWGRUdG0RZd', { action: 'Login' }).then(function (token) {
                document.getElementById("g-recaptcha-response").value = token;
            });
        });
    </script>
</body>
</html>
