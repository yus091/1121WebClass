using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace homework1
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            clientDetailsView.DataBind();
        }

        protected void passwordBT_TextChanged(object sender, EventArgs e)
        {

        }

        protected void loginBT_Click(object sender, EventArgs e)
        {
            clientDetailsView.Visible = false;
            entry.Visible = false;

            if(clientDetailsView.DataItemCount == 1)
            {
                Session["name"] = clientDetailsView.Rows[0].Cells[1].Text;
                Session["money"] = clientDetailsView.Rows[1].Cells[1].Text;
                entry.Visible = true;
            }
            else
            {
                Session["name"] = null;
                Session["money"] = null;
                clientDetailsView.Visible = true;
            }
        }
    }
}