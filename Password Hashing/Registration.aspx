<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Registration.aspx.cs" Inherits="Password_Hashing.Registration" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
    <script type="text/javascript">
        function validate() {
            var str = document.getElementById('<%=tb_pwd.ClientID %>').value;
            var pattern = new RegExp("^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[-+_!@#$%^&*.,?]).+$");

            if (str.length < 12) {
                document.getElementById("lbl_pwdchecker").innerHTML = "Password Length must be at least 12 characters";
                document.getElementById("lbl_pwdchecker").style.color = "Red";
                return ("too_short");
            }
            if (!pattern.test(str)) {
                document.getElementById("lbl_pwdchecker").innerHTML = "Password require at least 1 number, combination of lower and upper-case and special characters";
                document.getElementById("lbl_pwdchecker").style.color = "Red";
                return ("no_loweruppernumberspecial");
            }
            document.getElementById("lbl_pwdchecker").innerHTML = "Excellent!"
            document.getElementById("lbl_pwdchecker").style.color = "Blue";
        }
    </script>
<body>
        <form id="form1" runat="server">
    <div>
    
    <h2>
        <br />
        <asp:Label ID="Label1" runat="server" Text="Account Registration"></asp:Label>
        <br />
        <br />
   </h2>
        <table class="style1">
            <tr>
                <td class="style3">
        <asp:Label ID="Label7" runat="server" Text="First Name"></asp:Label>
                </td>
                <td class="style2">
                    <asp:TextBox ID="tb_firstname" runat="server" Height="36px" Width="280px" required="true"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="style3">
        <asp:Label ID="Label8" runat="server" Text="Last Name"></asp:Label>
                </td>
                <td class="style2">
                    <asp:TextBox ID="tb_lastname" runat="server" Height="36px" Width="280px" required="true"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="style3">
        <asp:Label ID="Label9" runat="server" Text="Credit Card Number"></asp:Label>
                </td>
                <td class="style2">
                    <asp:TextBox ID="tb_creditcardno" runat="server" Height="36px" Width="280px" MaxLength="16" required="true" TextMode="Number"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="style3">
        <asp:Label ID="Label10" runat="server" Text="Expiration Date (mm/yy)"></asp:Label>
                </td>
                <td class="style2">
                    <asp:TextBox ID="tb_creditcarddate" runat="server" Height="36px" Width="280px" required="true" TextMode="Month"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="style3">
        <asp:Label ID="Label11" runat="server" Text="CVV"></asp:Label>
                </td>
                <td class="style2">
                    <asp:TextBox ID="tb_cvv" runat="server" Height="36px" Width="280px" required="true" MaxLength="3" TextMode="Number"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="style3">
        <asp:Label ID="Label2" runat="server" Text="Email"></asp:Label>
                </td>
                <td class="style2">
                    <asp:TextBox ID="tb_email" runat="server" Height="36px" Width="280px" required="true"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="style3">
        <asp:Label ID="Label3" runat="server" Text="Password"></asp:Label>
                </td>
                <td class="style2">
                    <asp:TextBox ID="tb_pwd" runat="server" Height="32px" Width="281px" required="true" onkeyup="javascript:validate()"></asp:TextBox>
                    <asp:Label ID="lbl_pwdchecker" runat="server" Text=""></asp:Label>
                </td>
            </tr>
            <tr>
                <td></td>
                <td>
                <asp:Label ID="Label14" Font-Size="Small" runat="server" Text="Example of a strong password would consist of min 12 chars,
use combination of lower-case, upper-case, numbers
and special characters"></asp:Label>
                    </td>
            </tr>

            <tr>
                <td class="style3">
        <asp:Label ID="Label4" runat="server" Text="Confirm Password" required="true"></asp:Label>
                </td>
                <td class="style2">
                    <asp:TextBox ID="tb_cfpwd" runat="server" Height="32px" Width="281px"></asp:TextBox>
                </td>
            </tr>
                        <tr>
                <td class="style6">
        <asp:Label ID="Label5" runat="server" Text="Date of Birth" required="true"></asp:Label>
                </td>
                <td class="style7">
                    <asp:TextBox ID="tb_dob" runat="server" Height="32px" Width="281px" MaxLength="10" TextMode="Date"></asp:TextBox>
                </td>
            </tr>
                        <tr>
                <td class="style3">
        <asp:Label ID="Label6" runat="server" Text="Photo" required="true"></asp:Label>
                </td>
                <td class="style2">
                    <asp:FileUpload ID="tb_photo" runat="server" Height="32px" Width="281px"></asp:FileUpload>
                </td>
            </tr>
                        <tr>
                <td class="style4">
                </td>
                <td class="style5">
    <asp:Button ID="btn_Submit" runat="server" Height="48px" 
        onclick="btn_Submit_Click" Text="Submit" Width="288px" />
                </td>
            </tr>
    </table>
&nbsp;<br />
        <asp:Label ID="lb_error1" runat="server"></asp:Label>
        <br />
        <asp:Label ID="lb_error2" runat="server"></asp:Label>
    <br />
        <br />
    
    </div>
    </form>
</body>
</html>
