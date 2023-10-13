using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace webClass
{
    public partial class Store : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            drinkDetailsView.DataBind();
            userShowLB.Text = Session["name"] + " 歡迎光臨<br>您還剩下： " + Session["money"] + " 元";
            drinkPriceLB.Text = "";
            drinkQtLB.Text = "";
            drinkImage.ImageUrl = "./pic/未選取.jpg";
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
    }
}