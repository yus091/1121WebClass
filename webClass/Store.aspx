<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Store.aspx.cs" Inherits="webClass.Store" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <style type="text/css">
        .auto-style1 {
            text-align: center;
            font-size: xx-large;
            color: #CC3399;
            background-color: #FFCCFF;
        }
        .auto-style2 {
            width: 100%;
        }
        .auto-style5 {
            color: #993366;
            background-color: #FFCCCC;
            font-size: large;
        }
        .auto-style6 {
            font-size: large;
        }
    </style>
</head>
<body style="background-image: url('ji.jpg'); background-repeat: no-repeat; background-attachment: fixed; background-position: center center; background-size: cover;">
    <form id="form1" runat="server">
        <div class="auto-style1">
            歡迎來到茶水間</div>
        <table class="auto-style2">
            <tr>
                <td>
                    <asp:Label ID="userShowLB" runat="server" CssClass="auto-style5" Text="將顯示使用者資料"></asp:Label>
                </td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>
                    <asp:DropDownList ID="drinkList" runat="server" AutoPostBack="True" DataSourceID="drinkData" DataTextField="drink_name" DataValueField="drink_Id" OnSelectedIndexChanged="drinkList_SelectedIndexChanged" CssClass="auto-style6">
                    </asp:DropDownList>
                    <asp:Label ID="drinkPriceLB" runat="server" CssClass="auto-style5" Text="X元"></asp:Label>
                    <asp:Label ID="drinkQtLB" runat="server" CssClass="auto-style5" Text="庫存：X個"></asp:Label>
                </td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>
                    <asp:Image ID="drinkImage" runat="server" />
                </td>
                <td>&nbsp;</td>
            </tr>
        </table>
        <table class="auto-style2">
            <tr>
                <td>
                    <asp:Button ID="orderBT" runat="server" CssClass="auto-style6" Text="前往訂購" OnClick="orderBT_Click" />
                    <asp:Button ID="truncateTableBT" runat="server" CssClass="auto-style6" Text="重建表單" OnClick="truncateTableBT_Click" />
                </td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
        </table>
        <br />
        <br />
        <asp:SqlDataSource ID="drinkData" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [drink_Id], [drink_name] FROM [drinkTable]"></asp:SqlDataSource>
        <asp:SqlDataSource ID="drinkDataSelect" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" SelectCommand="SELECT [drink_price], [drink_qt] FROM [drinkTable] WHERE ([drink_Id] = @drink_Id)" InsertCommand="INSERT INTO orderTable(order_time, order_userPhone) VALUES (GETDATE(), @order_userPhone)">
            <InsertParameters>
                <asp:SessionParameter Name="order_userPhone" SessionField="phone" />
            </InsertParameters>
            <SelectParameters>
                <asp:ControlParameter ControlID="drinkList" Name="drink_Id" PropertyName="SelectedValue" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:DetailsView ID="drinkDetailsView" runat="server" AutoGenerateRows="False" DataSourceID="drinkDataSelect" Height="50px" Visible="False" Width="125px">
            <Fields>
                <asp:BoundField DataField="drink_qt" HeaderText="drink_qt" SortExpression="drink_qt" />
                <asp:BoundField DataField="drink_price" HeaderText="drink_price" SortExpression="drink_price" />
            </Fields>
        </asp:DetailsView>
    </form>
</body>
</html>
