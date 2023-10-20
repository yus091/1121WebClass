using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

namespace webClass
{
    public partial class Store : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            drinkDetailsView.DataBind();
            userShowLB.Text = Session["name"] + " 歡迎光臨<br>您還剩下： " + Session["money"] + " 元";
            if (!IsPostBack)
            {
                drinkPriceLB.Text = "";
                drinkQtLB.Text = "";
                drinkImage.ImageUrl = "./pic/未選取.jpg";
            }
            
        }

        protected void drinkList_SelectedIndexChanged(object sender, EventArgs e)
        {
            drinkImage.ImageUrl = "./pic/" + drinkList.SelectedItem.ToString() + ".jpg";
            drinkImage.Width = 300;
            if(0 == drinkList.SelectedIndex)
            {
                drinkPriceLB.Text = "";
                drinkQtLB.Text = "";
            }
            else
            {
                drinkPriceLB.Text = drinkDetailsView.Rows[1].Cells[1].Text + " 元";
                drinkQtLB.Text = "\t庫存： " + drinkDetailsView.Rows[0].Cells[1].Text + " 個";
            }
        }

        protected void orderBT_Click(object sender, EventArgs e)
        {
            drinkDataSelect.Insert();

            SqlConnection orderCon = new SqlConnection("Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\\clientData.mdf;Integrated Security=True");
            orderCon.Open();
            SqlCommand orderCmd = new SqlCommand("select top 1 order_id from [orderTable] order by order_id Desc", orderCon);
            SqlDataReader orderDr;
            orderDr = orderCmd.ExecuteReader();
            if (orderDr.Read())
            {
                Session["order_id"] = orderDr["order_id"];
                orderBT.Text = orderDr["order_id"] + " 號訂單";
                //orderBT.Enabled = false;
            }
            orderDr.Close();
        }

        protected void truncateTableBT_Click(object sender, EventArgs e)
        {
            SqlConnection orderCon = new SqlConnection("Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\\clientData.mdf;Integrated Security=True");
            orderCon.Open();
            SqlCommand orderTableTruncateCmd = new SqlCommand("truncate table orderTable", orderCon);
            orderTableTruncateCmd.ExecuteNonQuery();
            orderBT.Text = "前往訂購";
        }
    }
}