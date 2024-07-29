using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Bussinesslogic;
using BussinessObjects;

namespace TestTaskAjax
{
    public partial class List : System.Web.UI.Page
    {

        private int iPageSize = 10;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                GetDetails();
            }
        }
        protected void lnk_Command(object sender, CommandEventArgs e)
        {
            string commandName = e.CommandName;
            string commandArgument = e.CommandArgument.ToString();

            switch (commandName)
            {
                case "Edit":



                    int userId;
                    if (int.TryParse(commandArgument, out userId))
                    {
                        DataTable userData = FetchUserDataFromDatabase(userId);
                        Session["UserData"] = userData;
                        Response.Redirect("starter.aspx");
                    }
                    else
                    {

                    }
                    break;
                case "Delete":

                    DeleteUser(commandArgument);
                    break;

                case "Email":

                    EmailUser(commandArgument);
                    break;


                default:

                    break;
            }
        }

        public void EmailUser(string userID)
        {
            int intUserId;
            string email;
            string name;
            if (int.TryParse(userID, out intUserId))
            {

                using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["constr"].ConnectionString))
                {
                    using (SqlCommand cmd = new SqlCommand("SELECT * FROM Contacts WHERE ContactID = @id", con))
                    {
                        cmd.Parameters.AddWithValue("@id", intUserId);
                        con.Open();
                        SqlDataReader reader = cmd.ExecuteReader();
                        DataTable EmailTable = new DataTable();

                        while (reader.Read())
                        {
                            DataRow taskRow = EmailTable.NewRow();
                            email = reader["Email"].ToString();
                            name = reader["Name"].ToString();
                            MailMessage mail = new MailMessage();
                            mail.To.Add(email);
                            mail.From = new MailAddress("nishant@concept.co.in");
                            mail.Subject = "Thank You for Registering with us.";
                            string emailBody = "";

                            emailBody += "<h1>Hello " + name + ",</h1>";

                            //Query String below

                            emailBody += "Thank You!!";
                            mail.Body = emailBody;
                            mail.IsBodyHtml = true;
                            SmtpClient smtp = new SmtpClient();
                            smtp.Port = 25;
                            // smtp.EnableSsl = true;
                            smtp.UseDefaultCredentials = false;
                            smtp.Host = "mail.concept.co.in";
                            smtp.Credentials = new System.Net.NetworkCredential("nishant@concept.co.in", "nishant#123");
                            smtp.Send(mail);
                        }

                    }
                }







            }
        }

        private DataTable FetchUserDataFromDatabase(int userId)
        {

            DataTable userData = new DataTable();

            string conString = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
            using (SqlConnection sqlCon = new SqlConnection(conString))
            {
                sqlCon.Open();
                SqlCommand sqlCmd = new SqlCommand("SELECT * FROM Contacts WHERE ContactID=@UserID", sqlCon);
                sqlCmd.Parameters.AddWithValue("@UserID", userId);

                SqlDataAdapter sqlDa = new SqlDataAdapter(sqlCmd);
                sqlDa.Fill(userData);
            }

            return userData;
        }

        private void DeleteUser(string userId)
        {
            int intUserId;
            if (int.TryParse(userId, out intUserId))
            {
                // Update the IsDeleted column to 1 for the specified user
                string conString = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
                using (SqlConnection sqlCon = new SqlConnection(conString))
                {
                    sqlCon.Open();
                    SqlCommand sqlCmd = new SqlCommand("UPDATE Contacts SET IsDeleted = 1 WHERE ContactID = @UserId", sqlCon);
                    sqlCmd.Parameters.AddWithValue("@UserId", intUserId);
                    sqlCmd.ExecuteNonQuery();
                }


                GetDetails();
            }
            else
            {

            }
        }




        private void GetDetails()
        {
            DataTable dtData = new DataTable();
            string conString = ConfigurationManager.ConnectionStrings["constr"].ConnectionString;
            using (SqlConnection sqlCon = new SqlConnection(conString))
            {
                sqlCon.Open();
                SqlCommand sqlCmd = new SqlCommand("SELECT * FROM Contacts WHERE IsDeleted=0", sqlCon);
                SqlDataAdapter sqlDa = new SqlDataAdapter(sqlCmd);
                sqlDa.Fill(dtData);
            }

            PagedDataSource pdsData = new PagedDataSource();
            DataView dv = new DataView(dtData);
            pdsData.DataSource = dv;
            pdsData.AllowPaging = true;
            pdsData.PageSize = iPageSize;
            if (ViewState["PageNumber"] != null)
            {
                pdsData.CurrentPageIndex = Convert.ToInt32(ViewState["PageNumber"]) - 1;
            }
            else
            {
                pdsData.CurrentPageIndex = 0;
            }

            repeater1.Visible = true;
            Repeater2.Visible = true;

            ArrayList alPages = new ArrayList();
            for (int i = 1; i <= pdsData.PageCount; i++)
            {
                alPages.Add(i.ToString());
            }

            Repeater2.DataSource = alPages;
            Repeater2.DataBind();

            repeater1.DataSource = pdsData;
            repeater1.DataBind();
        }

        protected void Repeater1_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Page")
            {
                ViewState["PageNumber"] = Convert.ToInt32(e.CommandArgument);
                GetDetails();
            }
        }

        protected void txtsearchSql_Click(object sender, EventArgs e)
        {


            string key = txtSearch.Text.Trim();

            Bussinesslogic.blogic blogickey = new blogic();
            List<bobjects> Contacts = blogickey.Fetch(key);
            repeater1.DataSource = Contacts;
            repeater1.DataBind();

        }

        
    }
}

