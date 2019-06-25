using System;
using System.Data;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;

namespace WebApplication1
{
    public partial class Site1 : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //显示栏目数据
            string constr = ConfigurationManager.ConnectionStrings["Pubs"].ConnectionString;
            string sql = string.Format("SELECT C_Link,C_Name FROM [Column] WHERE C_On=1 order by C_Order desc");
            SqlConnection con = new SqlConnection(constr);
            SqlCommand cmd = new SqlCommand(sql, con);
            con.Open();
            SqlDataReader reader = cmd.ExecuteReader();
            string text = "";
            string nav = "";
            
            while (reader.Read())
            {
                string Col = "<li class=\"layui-nav-item\"><a href=\"" + reader[0].ToString().Trim() + "\">" + reader[1].ToString().Trim() + "</a></li>";
                string Col2 = "<li><a href=\"" + reader[0].ToString().Trim() + "\">" + reader[1].ToString().Trim() + "</a></li>";
                text = text + Col;
                nav = nav + Col2;
            }
            Label1.Text = text;
            Label2.Text = nav;
        }
    }
}