using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication1.admin
{
    public partial class news_Password : System.Web.UI.Page
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
        public string sqlread(String sql)
        {
            //执行SQL命令返回结果
            string constr = ConfigurationManager.ConnectionStrings["Pubs"].ConnectionString;
            SqlConnection con = new SqlConnection(constr);
            SqlCommand cmd = new SqlCommand(sql, con);
            con.Open();
            SqlDataReader reader = cmd.ExecuteReader();
            while (reader.Read())
            {
                return reader[0].ToString();
            }  
            con.Close();
            return "";
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["U_User"] == null)
            {
                Response.Write("<script>alert('未登陆！');window.location.href = '../login.aspx';</script>");
                return;
            }
            
            if (Request.Params["id"] == null)
            {
                Label2.Text = Session["U_User"].ToString();
                TextBox1.Text = Session["U_User"].ToString();
            }
            else
            {
                string sql = string.Format("SELECT [U_User] FROM [db_lowvalue].[dbo].[User] WHERE U_ID = {0}", Request.Params["id"]);
                TextBox1.Text = sqlread(sql);
            }
        }
        protected void Button1_Click(object sender, EventArgs e)
        {
            if (TextBox1.Text == "" || TextBox2.Text == "")
                return;

            string U_ID;
            string sql_ID = string.Format("SELECT [U_User] FROM [db_lowvalue].[dbo].[User] WHERE U_ID = {0}", Request.Params["id"]);
            if (Request.Params["id"] == null)
            {
                U_ID = Session["U_User"].ToString();
            }
            else
            {
                U_ID = sqlread(sql_ID);
            }

            //添加文章
            string sql = string.Format("UPDATE [db_lowvalue].[dbo].[User] SET [U_PWD] = {0} WHERE U_User LIKE '%{1}%'", TextBox2.Text, U_ID);
            if (execute(sql) > 0)
            {
                Response.Write("<script>alert('修改成功！');</script>");
                TextBox2.Text = string.Empty;  //清空文本框
            }
            else
            {
                Response.Write("<script>alert('修改失败，请稍后再试！');</script>");
            }
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            TextBox2.Text = string.Empty;  //清空文本框
        }
    }
}