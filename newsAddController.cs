using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Configuration;
using System.Net.Http.Headers;
using System.Data.SqlClient;
using System.Web;
using Newtonsoft.Json;
using System.Data;

namespace WebApplication1
{
    public class newsAddController : ApiController
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
        // GET api/<controller>
        public IEnumerable<string> Get()
        {
            return new string[] { "value1", "value2" };
        }

        // GET api/<controller>/5
        public HttpResponseMessage Get(int id)
        {
            //json数据初始化
            DataTable dt = new DataTable();

            DataColumn dcState = new DataColumn("state");
            DataColumn dcId = new DataColumn("id");
            DataColumn dcTitle = new DataColumn("title");
            DataColumn dcContent = new DataColumn("content");
            DataColumn dcLabel = new DataColumn("label");

            dt.Columns.Add(dcState);
            dt.Columns.Add(dcId);
            dt.Columns.Add(dcTitle);
            dt.Columns.Add(dcContent);
            dt.Columns.Add(dcLabel);

            //数据库数据
            string constr = ConfigurationManager.ConnectionStrings["Pubs"].ConnectionString;
            string sql = string.Format("SELECT M_Title,M_Content,M_Label FROM Message WHERE M_ID={0}", id);
            SqlConnection con = new SqlConnection(constr);
            SqlCommand cmd = new SqlCommand(sql, con);
            con.Open();
            SqlDataReader reader = cmd.ExecuteReader();


            while (reader.Read())
            {
                DataRow dr = dt.NewRow();
                dr[0] = "1";
                dr[1] = id;
                dr[2] = reader[0];
                dr[3] = reader[1];
                dr[4] = reader[2];
                dt.Rows.Add(dr);
            }
            string json = JsonConvert.SerializeObject(dt);
            return new HttpResponseMessage { Content = new StringContent(json, System.Text.Encoding.UTF8, "application/json") };

        }

        public class PostData
        {
            public int Label { get; set; }
            public string Title { get; set; }
            public string Content { get; set; }
            public int Memthodname { get; set; }
        }
        // POST api/<controller>
        public HttpResponseMessage Post([FromBody]PostData data)
        {
            string U_User = HttpContext.Current.Session["U_User"].ToString();
            string M_Label = "";
            if (data.Label == 0)
            {
               M_Label = "时政";
            }else if (data.Label == 1)
            {
               M_Label = "娱乐";
            }else if (data.Label == 2)
            {
                M_Label = "生活";
            }else if (data.Label == 3)
            {
                M_Label = "财经";
            }else if (data.Label == 4)
            {
                M_Label = "军事";
            }else if (data.Label == 5)
            {
                M_Label = "科技";
            }

            if (data.Memthodname == 0)
            { 
                string sql = string.Format("insert Message(M_Title,M_Content,U_User,M_Time,M_Label) values ('{0}','{1}','{2}','{3}','{4}')", data.Title, data.Content, U_User, DateTime.Now.ToString(),M_Label);
                if (execute(sql) > 0)
                {
                    return new HttpResponseMessage { Content = new StringContent("{\"state\": 1}", System.Text.Encoding.UTF8, "application/json") };
                }
                else
                {
                    return new HttpResponseMessage { Content = new StringContent("{\"state\": 0}", System.Text.Encoding.UTF8, "application/json") };
                }
            }
            else if (data.Memthodname != 0)
            {
                string sql = string.Format("UPDATE Message SET M_Title='{0}',M_Content='{1}',U_User='{2}' WHERE M_ID='{3}'", data.Title, data.Content, U_User,data.Memthodname);
                if (execute(sql) > 0)
                {
                    return new HttpResponseMessage { Content = new StringContent("{\"state\": 1}", System.Text.Encoding.UTF8, "application/json") };
                }
                else
                {
                    return new HttpResponseMessage { Content = new StringContent("{\"state\": 0}", System.Text.Encoding.UTF8, "application/json") };
                }
            }
            return new HttpResponseMessage { Content = new StringContent("{\"state\": 0}", System.Text.Encoding.UTF8, "application/json") };
        }

        // PUT api/<controller>/5
        public void Put(int id, [FromBody]string value)
        {
        }

        // DELETE api/<controller>/5
        public void Delete(int id)
        {
        }
    }
}