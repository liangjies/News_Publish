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
    public class ColOnController : ApiController
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
            public int On { get; set; }
        }
        // POST api/<controller>
        public HttpResponseMessage Post([FromBody]PostData data)
        {

            if (data.On == 1)
            {
                string sql = string.Format("UPDATE [Column] SET [C_On] = 1 WHERE C_ID={0}", data.Id);
                if (execute(sql) > 0)
                {
                    return new HttpResponseMessage { Content = new StringContent("{\"state\": 1}", System.Text.Encoding.UTF8, "application/json") };
                }
                else
                {
                    return new HttpResponseMessage { Content = new StringContent("{\"state\": 0}", System.Text.Encoding.UTF8, "application/json") };
                }
            }
            else if (data.On == 0)
            {
                string sql = string.Format("UPDATE [Column] SET [C_On] = 0 WHERE C_ID={0}", data.Id);
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