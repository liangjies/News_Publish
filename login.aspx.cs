using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication1
{
    public partial class login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string user = TextBox1.Text.Trim();
            string pwd = TextBox2.Text.Trim();
            string constr = ConfigurationManager.ConnectionStrings["Pubs"].ConnectionString;

            string sql = string.Format("SELECT count(*) FROM [User] WHERE U_User=@user and U_PWD=@pwd");

            SqlConnection con = new SqlConnection(constr);
            SqlCommand cmd = new SqlCommand(sql, con);
            cmd.Parameters.AddWithValue("@user", user);
            cmd.Parameters.AddWithValue("@pwd", pwd);
            con.Open();
            int count = (int)cmd.ExecuteScalar();

            if (count == 1)
            {
                Session["U_User"] = user;
                Response.Redirect("/admin/default.aspx", false);
            }
            else
            {
                TextBox1.Text = "";
                TextBox2.Text = "";
                Response.Write("<script>alert('用户名或密码不正确！')</script>");
            }
            con.Close();
        }
    }
}