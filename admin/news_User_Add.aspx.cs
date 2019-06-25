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
    public partial class news_User_Add : System.Web.UI.Page
    {
        public int execute(String sql)
        {
            //执行SQL命令返回影响行数
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
            if (Session["U_User"] == null)
            {
                Response.Write("<script>alert('未登陆！');window.location.href = '../login.aspx';</script>");
                return;
            }
            Label2.Text = Session["U_User"].ToString();
        }

        protected void Button1_Click(object sender, EventArgs e)
        {      
            if (TextBox1.Text == "" || TextBox2.Text == "")
                return;
            //添加文章
            string sql = string.Format("insert [User]([U_User],[U_PWD]) values ('{0}','{1}')", TextBox1.Text, TextBox2.Text);
            if (execute(sql) > 0)
            {
                Response.Write("<script>alert('添加成功！');</script>");
                TextBox1.Text = string.Empty;  //清空文本框
                TextBox2.Text = string.Empty;  //清空文本框
            }
            else
            {
                Response.Write("<script>alert('添加失败，请稍后再试！');</script>");
            }
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            TextBox1.Text = string.Empty;  //清空文本框
            TextBox2.Text = string.Empty;  //清空文本框
        }
    

    }
}