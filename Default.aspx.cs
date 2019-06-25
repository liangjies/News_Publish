using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;

namespace WebApplication1
{
    public partial class Default : System.Web.UI.Page
    {
        public int sqlread(String sql)
        {
            //执行SQL命令返回结果
            string constr = ConfigurationManager.ConnectionStrings["Pubs"].ConnectionString;
            SqlConnection con = new SqlConnection(constr);
            SqlCommand cmd = new SqlCommand(sql, con);
            con.Open();
            SqlDataReader reader = cmd.ExecuteReader();
            int num = 0;
            while (reader.Read())
            {
                num = (int)reader[0];
            }
            con.Close();
            return num;
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            string constr = ConfigurationManager.ConnectionStrings["Pubs"].ConnectionString;

            string page = Request.QueryString["page"];
            if (page == null)
            {
                page = "0";
            }
            int Page = int.Parse(page);

            string sql = string.Format("SELECT TOP {0} M_ID,M_Title,CONVERT(varchar(10),M_Time, 120) as 'Date',M_Label FROM Message WHERE M_Time not in (SELECT top {1} M_Time FROM Message order by M_Time desc) order by M_Time desc", 10, Page* 10);
            SqlConnection con = new SqlConnection(constr);
            SqlCommand cmd = new SqlCommand(sql, con);
            con.Open();
            SqlDataReader reader = cmd.ExecuteReader();
            string text = "";

            while (reader.Read())
            {
                string a = "<div class=\"item\"><div class=\"item-box  layer-photos-demo1 layer-photos-demo\"><h3><a href = \"Mshow.aspx?id=" + reader[0].ToString().Trim() + "\" >" + reader[1].ToString().Trim() + "</a></h3><span class=\"layui-badge layui-bg-blue\">"+ reader[3].ToString().Trim() +"</span><h5>发布于：<span>" + reader[2].ToString().Trim() + "</span></h5></div></div>";
                text = text + a;
            }

            con.Close();

            string sql2 = string.Format("SELECT TOP {0} M_ID,M_Title FROM Message order by NewID()", 10);
            SqlConnection con2 = new SqlConnection(constr);
            SqlCommand cmd2 = new SqlCommand(sql2, con);
            con.Open();
            SqlDataReader reader2 = cmd2.ExecuteReader();
            string text2 = "";

            while (reader2.Read())
            {
                string b = "<div class=\"\"><div class=\"item-box layer-photos-demo1 layer-photos-demo\" style=\"font-size:12px\"><p><a href = \"Mshow.aspx?id="+ reader2[0].ToString().Trim() + "\" >" + reader2[1].ToString().Trim() + "</a></p></div></div>";
                text2 = text2 + b;
            }

            con.Close();
            Label1.Text = text;
            Label2.Text = text2;
            int PageUp = Page - 1;
            int PageNext = Page + 1;
            string sql3 = string.Format("select count(M_ID) from [Message]");
            if (Page==0 && sqlread(sql3) <= PageNext * 10)
            {
                Label3.Text = "<a class=\"layui-btn layui-btn-primary\">上一页</a><a class=\"layui-btn layui-btn-primary\">下一页</a>";
            }else if(Page == 0 && sqlread(sql3) > PageNext * 10)
            {
                Label3.Text = "<a class=\"layui-btn layui-btn-primary\">上一页</a><a class=\"layui-btn btn-normal\" href=\"Default.aspx?page=" + PageNext + "\">下一页</a>";
            }else if (sqlread(sql3) > PageNext * 10)
            {
                
                 Label3.Text = "<a class=\"layui-btn btn-normal\" href=\"Default.aspx?page=" + PageUp + "\">上一页</a><a class=\"layui-btn btn-normal\" href=\"Default.aspx?page=" + PageNext + "\">下一页</a>";
            }else if (sqlread(sql3) < PageNext * 10)
            {
                Label3.Text = "<a class=\"layui-btn btn-normal\" href=\"Default.aspx?page=" + PageUp + "\">上一页</a><a class=\"layui-btn layui-btn-primary\">下一页</a>";
            }
        }
    }
}