using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Configuration;

namespace WebApplication1.admin
{
    public partial class news_Edit : System.Web.UI.Page
    {
        public int execute(String sql)
        {
            string constr = ConfigurationManager.ConnectionStrings["Pubs"].ConnectionString;
            SqlConnection con = new SqlConnection(constr);
            SqlCommand cmd = new SqlCommand(sql, con);
            con.Open();
            int num = cmd.ExecuteNonQuery();
            con.Close();
            return num;
        }
        protected void Page_Load(object sender, EventArgs e)
        {

            //判断是否登陆
            
            if (Session["U_User"] == null)
            {
                Response.Write("<script>alert('未登陆！');window.location.href = '../login.aspx';</script>");
                return;
            }
            
            //判断文章id是否空
            if (Request.Params["id"] == null)
            {
                Response.Write("<script>window.location.href = 'Default.aspx';</script>");
                return;
            }

            //数据显示
            string constr = "Data Source=DESKTOP-JLKEOJG;Initial Catalog=db_lowvalue;Integrated Security=True;Connect Timeout=30;Encrypt=False;TrustServerCertificate=False;ApplicationIntent=ReadWrite;MultiSubnetFailover=False";
            string sql = string.Format("SELECT M_Title,M_Content FROM Message WHERE M_ID={0}", Request.Params["id"]);
            SqlConnection con = new SqlConnection(constr);
            SqlCommand cmd = new SqlCommand(sql, con);
            con.Open();
            SqlDataReader reader = cmd.ExecuteReader();

            while (reader.Read() && !IsPostBack)
            {
                //TextBox1.Text = reader[0].ToString();
                //TextBox2.Text = reader[1].ToString();
            }
        }
        protected void Button1_Click(object sender, EventArgs e)
        {
        }
    }
}