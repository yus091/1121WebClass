<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="homework1.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <style type="text/css">
        .auto-style1 {
            font-size: xx-large;
            color: #CC3399;
            background-color: #FFCCFF;
            text-align: center;
        }
        .auto-style2 {
            background-color: #FFCCFF;
        }
        .auto-style3 {
            width: 100%;
        }
        .auto-style4 {
            height: 28px;
        }
        .auto-style5 {
            height: 28px;
            text-align: center;
        }
        .auto-style6 {
            text-align: center;
        }
    </style>
</head>
<body style="background-image: url('ji.jpg'); background-repeat: no-repeat; background-attachment: fixed; background-position: center center; background-size: cover;">
    <form id="form1" runat="server">
        <div class="auto-style1">
            <strong class="新增樣式1"><span class="auto-style2">歡迎來到茶水間</span></strong></div>
        <table class="auto-style3" style="position: relative">
            <tr>
                <td class="auto-style6">&nbsp;</td>
                <td class="auto-style6">
                    <asp:Label ID="accountLB" runat="server" ForeColor="#CC0066" Text="帳號："></asp:Label>
                    <asp:TextBox ID="accountBT" runat="server" style="margin-left: 25px"></asp:TextBox>
                </td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style6">&nbsp;</td>
                <td class="auto-style6">
                    <asp:Label ID="passwordLB" runat="server" ForeColor="#CC0066" Text="密碼："></asp:Label>
                    <asp:TextBox ID="passwordBT" runat="server" style="margin-left: 27px" OnTextChanged="passwordBT_TextChanged" TextMode="Password"></asp:TextBox>
                </td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style5"></td>
                <td class="auto-style5">
                    <asp:Button ID="loginBT" runat="server" Text="登入" OnClick="loginBT_Click" />
                    <asp:LinkButton ID="entry" runat="server" Visible="False" PostBackUrl="~/Store.aspx">進入商店</asp:LinkButton>
                </td>
                <td class="auto-style4"></td>
            </tr>
        </table>
        <asp:DetailsView ID="clientDetailsView" runat="server" AutoGenerateRows="False" DataSourceID="clientDetail" EmptyDataText="帳號密碼錯誤" Height="50px" Visible="False" Width="125px">
            <Fields>
                <asp:BoundField DataField="user_money" HeaderText="user_money" SortExpression="user_money" />
                <asp:BoundField DataField="user_name" HeaderText="user_name" SortExpression="user_name" />
                <asp:BoundField DataField="user_phone" HeaderText="user_phone" SortExpression="user_phone" />
            </Fields>
        </asp:DetailsView>
        <asp:SqlDataSource ID="clientDetail" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [user_money], [user_name], [user_phone] FROM [userData] WHERE (([user_name] = @user_name) AND ([user_password] = @user_password))">
            <SelectParameters>
                <asp:ControlParameter ControlID="accountBT" Name="user_name" PropertyName="Text" Type="String" />
                <asp:ControlParameter ControlID="passwordBT" Name="user_password" PropertyName="Text" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
    </form>
</body>
</html>
