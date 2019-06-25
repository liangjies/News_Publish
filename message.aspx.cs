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
    public partial class message : System.Web.UI.Page
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

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            //添加文章
            string sql = string.Format("insert LeaveMessage(L_Content,L_Time) values ('{0}','{1}')", TextBox1.Text, DateTime.Now.ToString());
            if (execute(sql) > 0)
            {
                Response.Write("<script>alert('留言成功！');</script>");
                TextBox1.Text = string.Empty;  //清空文本框
            }
        }
    }
}