﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Store.aspx.cs" Inherits="webClass.Store" %>

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
        .auto-style7 {
            width: 1494px;
        }
        .auto-style8 {
            height: 38px;
        }
        .auto-style9 {
            height: 38px;
            width: 358px;
        }
        .auto-style10 {
            width: 358px;
        }
    </style>
</head>
<body style="background-image: url('ji.jpg'); background-repeat: no-repeat; background-attachment: fixed; background-position: center center; background-size: cover;">
    <form id="form1" runat="server">
        <div class="auto-style1">
            歡迎來到茶水間</div>
        <table class="auto-style2">
            <tr>
                <td class="auto-style7">
                    <asp:Label ID="userShowLB" runat="server" CssClass="auto-style5" Text="將顯示使用者資料"></asp:Label>
                </td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style7">
                    <asp:Button ID="orderBT" runat="server" CssClass="auto-style6" Text="前往訂購" OnClick="orderBT_Click" />
                    <asp:Button ID="truncateTableBT" runat="server" CssClass="auto-style6" Text="重建表單" OnClick="truncateTableBT_Click" />
                </td>
                <td>&nbsp;</td>
            </tr>
            <tr>
                <td class="auto-style7">
                    <asp:DropDownList ID="drinkList" runat="server" AutoPostBack="True" DataSourceID="drinkData" DataTextField="drink_name" DataValueField="drink_Id" OnSelectedIndexChanged="drinkList_SelectedIndexChanged" CssClass="auto-style6">
                    </asp:DropDownList>
                    <asp:Label ID="drinkPriceLB" runat="server" CssClass="auto-style5" Text="X元"></asp:Label>
                    <asp:Label ID="drinkQtLB" runat="server" CssClass="auto-style5" Text="庫存：X個"></asp:Label>
                </td>
                <td>&nbsp;</td>
            </tr>
        </table>
        <table class="auto-style2">
            <tr>
                <td class="auto-style9">
                    <asp:DropDownList ID="cupList" runat="server" CssClass="auto-style6" Visible="False">
                    </asp:DropDownList>
                    <asp:Label ID="cupLB" runat="server" CssClass="auto-style5" Text="杯" Visible="False"></asp:Label>
                    <asp:DropDownList ID="sweetList" runat="server" CssClass="auto-style6" Visible="False">
                        <asp:ListItem>正常</asp:ListItem>
                        <asp:ListItem>半糖</asp:ListItem>
                        <asp:ListItem>少糖</asp:ListItem>
                        <asp:ListItem>微糖</asp:ListItem>
                        <asp:ListItem>無糖</asp:ListItem>
                    </asp:DropDownList>
                    <asp:DropDownList ID="iceList" runat="server" CssClass="auto-style6" Visible="False">
                        <asp:ListItem>正常</asp:ListItem>
                        <asp:ListItem>少冰</asp:ListItem>
                        <asp:ListItem>去冰</asp:ListItem>
                    </asp:DropDownList>
                    <asp:Button ID="addItemBT" runat="server" CssClass="auto-style6" Text="添加" Enabled="False" OnClick="addItemBT_Click" Visible="False" />
                </td>
                <td class="auto-style8"></td>
            </tr>
            <tr>
                <td class="auto-style10">
                    <asp:Image ID="drinkImage" runat="server" />
                </td>
                <td>
                    <asp:GridView ID="orderItemGridView" runat="server" AutoGenerateColumns="False" CssClass="auto-style5" DataKeyNames="編號" DataSourceID="orderItemDataSource" Visible="False">
                        <Columns>
                            <asp:BoundField DataField="編號" HeaderText="編號" InsertVisible="False" ReadOnly="True" SortExpression="編號" />
                            <asp:BoundField DataField="飲品" HeaderText="飲品" SortExpression="飲品" />
                            <asp:BoundField DataField="數量" HeaderText="數量" SortExpression="數量" />
                            <asp:BoundField DataField="甜度" HeaderText="甜度" SortExpression="甜度" />
                            <asp:BoundField DataField="冰度" HeaderText="冰度" SortExpression="冰度" />
                            <asp:BoundField DataField="小計" HeaderText="小計" ReadOnly="True" SortExpression="小計" />
                        </Columns>
                    </asp:GridView>
                </td>
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
        <asp:SqlDataSource ID="orderItemDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" InsertCommand="INSERT INTO orderItemTable(drink_id, order_id, num, sweet, ice) VALUES (@drink_id, @order_id, @num, @sweet, @ice)" SelectCommand="SELECT orderItemTable.orderItem_id AS 編號, drinkTable.drink_name AS 飲品, orderItemTable.num AS 數量, orderItemTable.sweet AS 甜度, orderItemTable.ice AS 冰度, orderItemTable.num * drinkTable.drink_price AS 小計 FROM orderItemTable INNER JOIN drinkTable ON orderItemTable.drink_id = drinkTable.drink_Id WHERE (orderItemTable.order_id = @order_id)">
            <InsertParameters>
                <asp:ControlParameter ControlID="drinkList" Name="drink_id" PropertyName="SelectedValue" />
                <asp:SessionParameter Name="order_id" SessionField="order_id" />
                <asp:ControlParameter ControlID="cupList" Name="num" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="sweetList" Name="sweet" PropertyName="SelectedValue" />
                <asp:ControlParameter ControlID="iceList" Name="ice" PropertyName="SelectedValue" />
            </InsertParameters>
            <SelectParameters>
                <asp:SessionParameter Name="order_id" SessionField="order_id" />
            </SelectParameters>
        </asp:SqlDataSource>
    </form>
</body>
</html>
