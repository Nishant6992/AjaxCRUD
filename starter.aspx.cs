using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using System.Web.Services;
namespace TestTaskAjax
{
    public partial class starter : System.Web.UI.Page
    {
        static string conSting = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["UserData"] != null)
            {
                submitButton.Value = "Update";
                DataTable userData = (DataTable)Session["UserData"];
                // Assume hdnIDUpdate is an HtmlInputHidden control and userData is a DataTable
                string contactIDString = userData.Rows[0]["ContactID"].ToString();

                // Convert the string value to an integer
                int contactID;
                bool isSuccess = int.TryParse(contactIDString, out contactID);

                if (isSuccess)
                {
                    // Successfully converted to an integer, use contactID
                    hdnIDUpdate.Value = contactID.ToString(); // If needed, update the hidden field value as a string
                }
                else
                {
                    // Handle the conversion failure
                    // For example, set a default value or log an error
                    Console.WriteLine("Conversion failed. Invalid ContactID value.");
                }

                txtname.Text = userData.Rows[0]["Name"].ToString();
                txtmail.Text = userData.Rows[0]["Email"].ToString();
                txtphone.Text = userData.Rows[0]["Phone"].ToString();
                txtaddress.Text = userData.Rows[0]["Address"].ToString();


            }
            Session.Remove("UserData");
        }
        [WebMethod]
        public static void sql_submit(string nameparam, string emailparam, string addressparam, string phoneparam)
        {
            
            SqlConnection Conn = new SqlConnection(conSting);
            Conn.Open();
            SqlCommand sqlCommand = new SqlCommand("InsertContacts", Conn);
            sqlCommand.Connection = Conn;
            sqlCommand.CommandType = CommandType.StoredProcedure;
            sqlCommand.Parameters.AddWithValue("@Name", nameparam);
            sqlCommand.Parameters.AddWithValue("@Email", emailparam);
            sqlCommand.Parameters.AddWithValue("@Phone", phoneparam);
            sqlCommand.Parameters.AddWithValue("@Address", addressparam);
            sqlCommand.Parameters.AddWithValue("@CreatedDate", DateTime.Today);
            //try
            //{
            //    SqlCommand sqlCommand2 = new SqlCommand("insert into loginfo(ActionLog) value('Insert log')", Conn);
            //    sqlCommand2.CommandType = CommandType.Text;
            //    sqlCommand2.ExecuteNonQuery();
            //}
            //catch(Exception e)
            //{
            //    Response.Redirect("starter.aspx");
            //}
            int i = sqlCommand.ExecuteNonQuery();
            
            Conn.Close();

        }
        [WebMethod]
        public static void sql_update(int contactID, string nameparam, string emailparam, string phoneparam, string addressparam)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;

            using (SqlConnection Conn = new SqlConnection(connectionString))
            {
                try
                {
                    Conn.Open();

                    using (SqlCommand sqlCommand = new SqlCommand("UpdateContact", Conn))
                    {
                        sqlCommand.CommandType = CommandType.StoredProcedure;

                        // Add parameters with values
                        sqlCommand.Parameters.AddWithValue("@ContactID", contactID);
                        sqlCommand.Parameters.AddWithValue("@Name", nameparam);
                        sqlCommand.Parameters.AddWithValue("@Email", emailparam);
                        sqlCommand.Parameters.AddWithValue("@Phone", phoneparam);
                        sqlCommand.Parameters.AddWithValue("@Address", addressparam);
                        sqlCommand.Parameters.AddWithValue("@CreatedDate", DateTime.Today);

                        // Execute the command
                        int rowsAffected = sqlCommand.ExecuteNonQuery();

                        // Optional: Check rowsAffected if needed
                        if (rowsAffected == 0)
                        {
                            // Handle the case where no rows were updated
                            throw new Exception("No rows were updated.");
                        }
                    }
                }
                catch (Exception ex)
                {
                    // Handle exceptions (log error, etc.)
                    Console.WriteLine("An error occurred: " + ex.Message);
                    // Optionally rethrow or handle differently
                    throw;
                }
                finally
                {
                    // Ensure the connection is closed
                    Conn.Close();
                }
            }
        }


    }
}