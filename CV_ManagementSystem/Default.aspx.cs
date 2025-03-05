using CV_ManagementSystem.App_Code.BAL;
using CV_ManagementSystem.App_Code.BO;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web;

namespace CV_ManagementSystem
{
    public partial class _Default : Page
    {
        CV_EntryBLL obj =new CV_EntryBLL();
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            string base64String = hiddenCroppedImage.Value;

            if (string.IsNullOrEmpty(base64String))
            {
                lblMessage.Text = "No image selected.";
                return;
            }

            try
            {

                string fileType = "";
                if (base64String.StartsWith("data:image/jpeg;base64,"))
                {
                    base64String = base64String.Replace("data:image/jpeg;base64,", "");
                    fileType = "image/jpeg";
                }
                else if (base64String.StartsWith("data:image/png;base64,"))
                {
                    base64String = base64String.Replace("data:image/png;base64,", "");
                    fileType = "image/png";
                }
                else if (base64String.StartsWith("data:image/gif;base64,"))
                {
                    base64String = base64String.Replace("data:image/gif;base64,", "");
                    fileType = "image/gif";
                }
                else
                {
                    lblMessage.Text = "Invalid image format. Only JPEG, PNG, and GIF are allowed.";
                    return;
                }



                byte[] imageBytes = Convert.FromBase64String(base64String);

                string Epromis = Session["LOGIN_Epromise"]?.ToString();
                if (string.IsNullOrEmpty(Epromis))
                {
                    lblMessage.Text = "Session expired. Please log in again.";
                    return;
                }
                string fileExtension = fileType.Split('/')[1]; // "jpeg" -> "jpg"

                // Ensure correct file extension for JPG
                if (fileExtension == "jpeg") fileExtension = "jpg";

                // Construct file name
                string fileName = $"{Epromis}.{fileExtension}";

                // Insert into the database
                int result = obj.Insert_ProfilePhoto(Epromis, imageBytes, fileType, fileName);
                if (result > 0)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "SuccessAlert(1);", true);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "SuccessAlert(0);", true);
                }



                lblMessage.ForeColor = System.Drawing.Color.Green;
                lblMessage.Text = "Image uploaded successfully!";
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Error: " + ex.Message;
            }
        }
    }
   
}