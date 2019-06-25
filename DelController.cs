using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Data.SqlClient;
using System.Configuration;

namespace WebApplication1
{
    public class DelController : ApiController
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
        public string Get(int id)
        {
            return "value";
        }
        public class PostData
        {
            public int Id { get; set; }
            public string Memthodname { get; set; }
        }
        // POST api/<controller>
        public HttpResponseMessage Post([FromBody]PostData data)
        {


            if (data.Memthodname == "delete")
            {
                string sql = string.Format("DELETE FROM Message WHERE M_ID={0}", data.Id);
                if (execute(sql) > 0)
                {
                    return new HttpResponseMessage { Content = new StringContent("{\"state\": 1}", System.Text.Encoding.UTF8, "application/json") };
                }
                else
                {
                    return new HttpResponseMessage { Content = new StringContent("{\"state\": 0}", System.Text.Encoding.UTF8, "application/json") };
                }
            }
            else if (data.Memthodname == "C_delete")
            {
                string sql = string.Format("DELETE FROM [Column] WHERE C_ID={0}", data.Id);
                if (execute(sql) > 0)
                {
                    return new HttpResponseMessage { Content = new StringContent("{\"state\": 1}", System.Text.Encoding.UTF8, "application/json") };
                }
                else
                {
                    return new HttpResponseMessage { Content = new StringContent("{\"state\": 0}", System.Text.Encoding.UTF8, "application/json") };
                }
            }
            else if (data.Memthodname == "U_delete")
            {
                string sql = string.Format("DELETE FROM [db_lowvalue].[dbo].[User] WHERE U_ID={0}", data.Id);
                if (execute(sql) > 0)
                {
                    return new HttpResponseMessage { Content = new StringContent("{\"state\": 1}", System.Text.Encoding.UTF8, "application/json") };
                }
                else
                {
                    return new HttpResponseMessage { Content = new StringContent("{\"state\": 0}", System.Text.Encoding.UTF8, "application/json") };
                }
            }
                if (data.Memthodname != "delete")
            {
                return new HttpResponseMessage { Content = new StringContent("{\"state\": 0}", System.Text.Encoding.UTF8, "application/json") };
            }
            return new HttpResponseMessage { Content = new StringContent("{\"state\": 0}", System.Text.Encoding.UTF8, "application/json") };
        }

        // PUT api/<controller>/5
        public void Put(int id, [FromBody]string uvid)
        {
        }

        // DELETE api/<controller>/5
        public void Delete(int id)
        {
        }
    }
}