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
                for(int i = 0; i < 50; i++)
                {
                    cupList.Items.Insert(i, new ListItem("" + (i + 1), "" + (i + 1)));
                }
                drinkList.SelectedIndex = 0;
                cupList.SelectedIndex = 0;
                sweetList.SelectedIndex = 0;
                iceList.SelectedIndex = 0;
            }
            
        }

        private void initial()
        {
            drinkList.SelectedIndex = 0;
            cupList.SelectedIndex = 0;
            sweetList.SelectedIndex = 0;
            iceList.SelectedIndex = 0;
            drinkPriceLB.Text = "";
            drinkQtLB.Text = "";
            drinkImage.ImageUrl = "./pic/未選取.jpg";

            orderBT.Text = "前往訂購";
            orderBT.Enabled = true;

            cupLB.Visible = false;
            cupList.Visible = false;
            sweetList.Visible = false;
            iceList.Visible = false;
            addItemBT.Visible = false;
            addItemBT.Enabled = false;
            orderItemGridView.Visible = false;
            totalLB.Visible = false;
            checkBT.Visible = false;
            cancelBT.Visible = false;
            errorLB.Visible = false;
        }

        protected void drinkList_SelectedIndexChanged(object sender, EventArgs e)
        {
            drinkImage.ImageUrl = "./pic/" + drinkList.SelectedItem.ToString() + ".jpg";
            drinkImage.Width = 300;
            if(0 == drinkList.SelectedIndex)
            {
                drinkPriceLB.Text = "";
                drinkQtLB.Text = "";
                addItemBT.Enabled = false;
            }
            else
            {
                drinkPriceLB.Text = drinkDetailsView.Rows[1].Cells[1].Text + " 元";
                drinkQtLB.Text = "\t庫存： " + drinkDetailsView.Rows[0].Cells[1].Text + " 個";
                addItemBT.Enabled = true;

                drinkPriceLB.ForeColor = System.Drawing.Color.FromArgb(99, 33, 66);
                drinkQtLB.ForeColor = System.Drawing.Color.FromArgb(99, 33, 66);

                if(Convert.ToInt32(Session["money"]) < Convert.ToInt32(drinkDetailsView.Rows[1].Cells[1].Text))
                {
                    drinkPriceLB.ForeColor = System.Drawing.Color.Red;
                    drinkPriceLB.Text += " 餘額不足";
                    addItemBT.Enabled = false;
                }
                if(Convert.ToInt32(drinkDetailsView.Rows[0].Cells[1].Text) <= 0)
                {
                    drinkQtLB.ForeColor = System.Drawing.Color.Red;
                    drinkQtLB.Text = "庫存不足";
                    addItemBT.Enabled = false;
                }
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
                orderBT.Enabled = false;

                cupLB.Visible = true;
                cupList.Visible = true;
                sweetList.Visible = true;
                iceList.Visible = true;
                addItemBT.Visible = true;
            }
            orderDr.Close();
        }

        protected void truncateTableBT_Click(object sender, EventArgs e)
        {
            SqlConnection orderCon = new SqlConnection("Data Source=(LocalDB)\\MSSQLLocalDB;AttachDbFilename=|DataDirectory|\\clientData.mdf;Integrated Security=True");
            orderCon.Open();
            SqlCommand orderTableTruncateCmd = new SqlCommand("truncate table orderTable", orderCon);
            orderTableTruncateCmd.ExecuteNonQuery();
            SqlCommand orderItemTableTruncateCmd = new SqlCommand("truncate table orderItemTable", orderCon);
            orderItemTableTruncateCmd.ExecuteNonQuery();
            initial();

        }

        protected void addItemBT_Click(object sender, EventArgs e)
        {
            orderItemDataSource.Insert();
            if (!orderItemGridView.Visible)
            {
                orderItemGridView.Visible = true;
            }
            totalLB.Visible = true;
            checkBT.Visible = true;
            cancelBT.Visible = true;
        }

        protected void orderItemGridView_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            errorLB.Text = "";
            errorLB.Visible = false;
            checkBT.Enabled = true;
            countTotalLB();
            qtCheck();
            qtCheckGridView.DataBind();

        }

        private void qtCheck()
        {
            int num;
            int qt;
            bool isError = false;
            for(int i = 0; i < qtCheckGridView.Rows.Count; i++)
            {
                if(qtCheckGridView.Rows[i].Cells[1].FindControl("qtNameLB") != null &&
                   qtCheckGridView.Rows[i].Cells[2].FindControl("totalNumLB") != null &&
                   qtCheckGridView.Rows[i].Cells[3].FindControl("checkQtLB") != null)
                {
                    using (Label qtNameLB = (Label)qtCheckGridView.Rows[i].Cells[1].FindControl("qtNameLB"),
                        totalNumLB = (Label)qtCheckGridView.Rows[i].Cells[2].FindControl("totalNumLB"),
                        checkQtLB = (Label)qtCheckGridView.Rows[i].Cells[3].FindControl("checkQtLB"))
                    {
                        num = Convert.ToInt32(totalNumLB.Text);
                        qt = Convert.ToInt32(checkQtLB.Text);
                        if(num > qt)
                        {
                            errorLB.Text += "<br>" + qtNameLB.Text + "庫存不足（剩下" + qt + "杯）";
                            isError = true;
                        }
                    }
                }
            }
            if (isError)
            {
                checkBT.Enabled = false;
                errorLB.Visible = true;
            }
        }

        private void countTotalLB()
        {
            string warmMsg = "";
            int total = 0;
            for(int i = 0; i < orderItemGridView.Rows.Count; i++)
            {
                if(orderItemGridView.Rows[i].Cells[4].FindControl("subTotalLB") != null)
                {
                    total += Convert.ToInt32(((Label)orderItemGridView.Rows[i].Cells[4].FindControl("subTotalLB")).Text);
                }
                cupEditCheck(ref warmMsg, i);
            }
            totalLB.Text = warmMsg + "總價：" + total + " 元";

            Session["total"] = total;

            if(total == 0)
            {
                checkBT.Enabled = false;
            }
            if(Convert.ToInt32(Session["money"]) < total){
                checkBT.Enabled = false;
                errorLB.Text = "餘額不足";
                errorLB.Visible = true;
            }
        }

        private void cupEditCheck(ref string msg, int i)
        {
            if (orderItemGridView.Rows[i].Cells[1].FindControl("itemCupLB") != null)
            {
                using(Label tempCupLB = (Label)orderItemGridView.Rows[i].Cells[1].FindControl("itemCupLB"))
                {
                    if(tempCupLB.Text == "0")
                    {
                        msg = "（錯誤的杯數）";
                        tempCupLB.ForeColor = System.Drawing.Color.Red;
                    }
                    else
                    {
                        tempCupLB.ForeColor = System.Drawing.Color.FromArgb(99, 33, 66);
                    }
                }
            }
        }

        protected void orderItemGridView_RowDeleted(object sender, GridViewDeletedEventArgs e)
        {
            if(orderItemGridView.Rows.Count == 1)
            {
                totalLB.Visible = false;
                errorLB.Visible = false;
                checkBT.Enabled = false;
            }
        }

        protected void editCupTB_TextChanged(object sender, EventArgs e)
        {
            foreach(char ch in ((TextBox)sender).Text)
            {
                if (!Char.IsDigit(ch))
                {
                    ((TextBox)sender).Text = "0";                }
            }
        }

        protected void checkBT_Click(object sender, EventArgs e)
        {
            Session["money"] = Convert.ToInt32(Session["money"]) - Convert.ToInt32(Session["total"]);
            userShowLB.Text = Session["name"] + "歡迎光臨<br>您還剩下：" + Session["money"] + "元";
            clientDataSource.Update();
            updateQt();
            initial();
        }

        private void updateQt()
        {
            int num;
            int qt;

            for (int i = 0; i < qtCheckGridView.Rows.Count; i++)
            {
                if (qtCheckGridView.Rows[i].Cells[0].FindControl("qtIdLB") != null &&
                   qtCheckGridView.Rows[i].Cells[2].FindControl("totalNumLB") != null &&
                   qtCheckGridView.Rows[i].Cells[3].FindControl("checkQtLB") != null)
                {
                    using (Label qtIdLB = (Label)qtCheckGridView.Rows[i].Cells[0].FindControl("qtIdLB"),
                        totalNumLB = (Label)qtCheckGridView.Rows[i].Cells[2].FindControl("totalNumLB"),
                        checkQtLB = (Label)qtCheckGridView.Rows[i].Cells[3].FindControl("checkQtLB"))
                    {
                        num = Convert.ToInt32(totalNumLB.Text);
                        qt = Convert.ToInt32(checkQtLB.Text);
                        Session["updateQtId"] = Convert.ToInt32(qtIdLB.Text);
                        Session["updateQtNum"] = qt - num;
                        drinkQtDataSource.Update();
                    }
                }
            }
        }

        protected void cancelBT_Click(object sender, EventArgs e)
        {
            drinkDataSelect.Delete();
            cancelOrderDataSource.Delete();
            initial();
        }
    }
}