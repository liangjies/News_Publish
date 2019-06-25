using System;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using System.Net;
using System.Web.Script.Serialization;
using System.Net.Http;
using Newtonsoft.Json;
using Newtonsoft.Json.Converters;
using System.Web.Http;
using System.Data.SqlClient;
using System.Configuration;

namespace WebApplication1
{
    public class newsController : ApiController
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
        // GET api/<controller>
        public IEnumerable<string> Get()
        {
            return new string[] { "value1", "value2" };
        }

        // GET api/<controller>/5
        public HttpResponseMessage Get(int page,int limit,string keyword="")
        {
            //json数据初始化
            DataTable dt = new DataTable();
            DataColumn dcId = new DataColumn("id");
            DataColumn dcTitle = new DataColumn("title");
            DataColumn dcContent = new DataColumn("content");
            DataColumn dcUser = new DataColumn("user");
            DataColumn dcTime = new DataColumn("time");
            DataColumn dcLabel = new DataColumn("label");

            dt.Columns.Add(dcId);
            dt.Columns.Add(dcTitle);
            dt.Columns.Add(dcContent);
            dt.Columns.Add(dcUser);
            dt.Columns.Add(dcTime);
            dt.Columns.Add(dcLabel);

            //数据库数据
            string constr = ConfigurationManager.ConnectionStrings["Pubs"].ConnectionString;
            string sql;
            if (keyword == "")
            {
                sql = string.Format("SELECT TOP {0} M_ID,M_Title,M_Content,U_User,CONVERT(varchar(10),M_Time, 120) as 'Date',M_Label FROM Message WHERE M_Time not in (SELECT top {1} M_Time FROM Message order by M_Time desc) order by M_Time desc", limit, (page - 1) * limit);
            }
            else
            {
                sql = string.Format("SELECT M_ID,M_Title,M_Content,U_User,CONVERT(varchar(10),M_Time, 120) as 'Date',M_Label FROM Message WHERE M_Content LIKE '%{0}%' order by M_Time desc", keyword);
            }

            
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
                dr[2] = reader[2];
                dr[3] = reader[3];
                dr[4] = reader[4];
                dr[5] = reader[5];
                dt.Rows.Add(dr);
            }
            string json = JsonConvert.SerializeObject(dt);
            int count=sqlread("SELECT COUNT(M_ID) FROM[db_lowvalue].[dbo].[Message]");
            //var json2 = new HttpResponseMessage { Content = new StringContent(json, System.Text.Encoding.UTF8, "application/json") };
            json = "{\"code\":0,\"msg\":\"\",\"count\":" + count + ",\"data\":" + json + "}";
            
            return new HttpResponseMessage { Content = new StringContent(json, System.Text.Encoding.UTF8, "application/json") };
        }

        // POST api/<controller>
        public void Post([FromBody]string value)
        {
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