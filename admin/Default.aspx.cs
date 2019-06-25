using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
namespace WebApplication1.admin
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["U_User"] == null)
            {
                Response.Write("<script>alert('未登陆！');window.location.href = '../login.aspx';</script>");
                return;
            }
            
            Label1.Text = Session["U_User"].ToString();
            Label2.Text = Session["U_User"].ToString();
        }
    }
}
 