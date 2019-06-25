using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Data;
using Newtonsoft.Json;
using System.Data.SqlClient;
using System.Configuration;

namespace WebApplication1
{
    public class ColController : ApiController
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
        // GET api/<controller>
        public IEnumerable<string> Get()
        {
            return new string[] { "value1", "value2" };
        }

        // GET api/<controller>/5
        public HttpResponseMessage Get(int page, int limit)
        {
            //json数据初始化
            DataTable dt = new DataTable();
            DataColumn dcId = new DataColumn("id");
            DataColumn dcName = new DataColumn("name");
            DataColumn dcLink = new DataColumn("link");
            DataColumn dcOrder = new DataColumn("order");
            DataColumn dcStatus = new DataColumn("state");

            dt.Columns.Add(dcId);
            dt.Columns.Add(dcName);
            dt.Columns.Add(dcLink);
            dt.Columns.Add(dcOrder);
            dt.Columns.Add(dcStatus);

            //数据库数据
            string constr = ConfigurationManager.ConnectionStrings["Pubs"].ConnectionString;
            //string sql = string.Format("SELECT M_ID,M_Title,M_Content,U_User,CONVERT(varchar(10),M_Time, 120) as 'Date' FROM Message limit '{0}'*'{1}','{1}'",page,limit);
            string sql = string.Format("SELECT C_ID,C_Name,C_link,C_Order,C_On FROM [Column]  order by C_Order desc");
            SqlConnection con = new SqlConnection(constr);
            SqlCommand cmd = new SqlCommand(sql, con);
            //cmd.Parameters.AddWithValue("@limit", limit);
            //cmd.Parameters.AddWithValue("@num", page*limit);
            con.Open();
            SqlDataReader reader = cmd.ExecuteReader();


            while (reader.Read())
            {
                DataRow dr = dt.NewRow();
                dr[0] = reader[0];
                dr[1] = reader[1];
                dr[2] = reader[2];
                dr[3] = reader[3];
                dr[4] = reader[4];
                dt.Rows.Add(dr);
            }
            string json = JsonConvert.SerializeObject(dt);
            //var json2 = new HttpResponseMessage { Content = new StringContent(json, System.Text.Encoding.UTF8, "application/json") };
            json = "{\"code\":0,\"msg\":\"\",\"count\":5,\"data\":" + json + "}";

            return new HttpResponseMessage { Content = new StringContent(json, System.Text.Encoding.UTF8, "application/json") };
        }

        public class PostData
        {
            public int Id { get; set; }
            public int Order { get; set; }
            public string Memthodname { get; set; }
        }
        // POST api/<controller>
        public HttpResponseMessage Post([FromBody]PostData data)
        {
            if (data.Memthodname == "down")
            {
                string sql = string.Format("select top 1 [C_Order] from [db_lowvalue].[dbo].[Column] WHERE C_Order<{0} order by C_Order desc", data.Order);
                sqlread(sql);
                sql = string.Format("UPDATE [Column] SET [C_Order] = {0} WHERE C_ID={1}", sqlread(sql) - 1, data.Id);
                if (execute(sql) > 0)
                {
                    return new HttpResponseMessage { Content = new StringContent("{\"state\": 1}", System.Text.Encoding.UTF8, "application/json") };
                }
                else
                {
                    return new HttpResponseMessage { Content = new StringContent("{\"state\": 0}", System.Text.Encoding.UTF8, "application/json") };
                }
            }
            else if (data.Memthodname == "up")
            {
                string sql = string.Format("select top 1 [C_Order] from [db_lowvalue].[dbo].[Column] WHERE C_Order>{0} order by C_Order ASC", data.Order);
                sqlread(sql);
                sql = string.Format("UPDATE [Column] SET [C_Order] = {0} WHERE C_ID={1}", sqlread(sql) + 1, data.Id);
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