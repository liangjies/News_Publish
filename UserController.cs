using System;
using System.Data;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using Newtonsoft.Json;
using Newtonsoft.Json.Converters;
using System.Data.SqlClient;
using System.Configuration;

namespace WebApplication1
{
    public class UserController : ApiController
    {
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
            DataColumn dcTime = new DataColumn("time");

            dt.Columns.Add(dcId);
            dt.Columns.Add(dcName);
            dt.Columns.Add(dcTime);

            //数据库数据
            string constr = ConfigurationManager.ConnectionStrings["Pubs"].ConnectionString;
            //string sql = string.Format("SELECT M_ID,M_Title,M_Content,U_User,CONVERT(varchar(10),M_Time, 120) as 'Date' FROM Message limit '{0}'*'{1}','{1}'",page,limit);
            string sql = string.Format("SELECT U_ID,U_User,CONVERT(varchar(10),U_Time, 120) as 'Date' FROM [User]");
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
                dt.Rows.Add(dr);
            }
            string json = JsonConvert.SerializeObject(dt);
            //var json2 = new HttpResponseMessage { Content = new StringContent(json, System.Text.Encoding.UTF8, "application/json") };
            json = "{\"code\":0,\"msg\":\"\",\"count\":5,\"data\":" + json + "}";

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