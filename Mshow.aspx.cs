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
    public partial class Mshow : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string M_ID = Request.Params["id"];
            if (Request.Params["id"] == null)
            {
                Response.Write("<script>window.location.href = '../Default.aspx';</script>");
            }

            string constr = ConfigurationManager.ConnectionStrings["Pubs"].ConnectionString;
            string sql = string.Format("SELECT M_Title,U_User,M_Content,CONVERT(varchar(10),M_Time, 120) as 'Date' FROM Message WHERE M_ID={0}", M_ID);
            SqlConnection con = new SqlConnection(constr);
            SqlCommand cmd = new SqlCommand(sql, con);
            con.Open();
            SqlDataReader reader = cmd.ExecuteReader();
            while (reader.Read())
            {
                Label1.Text = reader[0].ToString();
                Label2.Text = reader[1].ToString();
                Label3.Text = reader[3].ToString();
                Label4.Text = reader[2].ToString();
            }
        }
    }
}