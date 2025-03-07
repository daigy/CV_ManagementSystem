using CV_ManagementSystem.App_Code.BAL;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Security.Cryptography;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CV_ManagementSystem
{
    public partial class Login : System.Web.UI.Page
    {
        DataTable dtlogin = new DataTable();
        GetAll_BLL obj = new GetAll_BLL();
        protected void Page_Load(object sender, EventArgs e)
        {
            string strReq = "";
            strReq = Request.RawUrl;
            strReq = strReq.Substring(strReq.IndexOf('?') + 1);
            string EmployeeCode = "";
            if (!strReq.Equals(""))
            {
                strReq = DecryptQueryString(strReq);
                string[] arrMsgs = strReq.Split('&');
                string[] arrIndMsg;
                if (arrMsgs.Length > 1)
                {
                    arrIndMsg = arrMsgs[0].Split('=');
                    EmployeeCode = arrIndMsg[1].ToString().Trim();

                    if (EmployeeCode != "")
                    {
                        DataTable dt = obj.LoginValidate(EmployeeCode);
                        if (dt.Rows.Count >= 1)
                        {
                            Session["LOGIN_Epromise"] = dt.Rows[0]["UserName"].ToString();
                            Session["LOGIN_ROLE"] = dt.Rows[0]["Role"].ToString();

                            switch (Session["LOGIN_ROLE"].ToString())
                            {
                                case "PM":
                                    Response.Redirect("CV_Entry.aspx", false);
                                    break;
                                case "HR":
                                    Response.Redirect("PM_CVList.aspx", false);
                                    break;
                                default:
                                    Response.Redirect("Default.aspx", false);
                                    break;
                            }
                        }
                        else
                        {
                            Response.Redirect("frm_Access_Denied.aspx");
                        }
                    }
                    else
                    {
                        Response.Redirect("frm_Access_Denied.aspx");
                    }
                }
            }
        }

        private string DecryptQueryString(string strQueryString)
        {
            EncryptDecryptQueryString objEDQueryString = new EncryptDecryptQueryString();
            return objEDQueryString.Decrypt(strQueryString, "r0b1nr0y");
        }
        public class EncryptDecryptQueryString
        {
            private byte[] key = { };
            private byte[] IV = { 0x12, 0x34, 0x56, 0x78, 0x90, 0xab, 0xcd, 0xef };
            public string Decrypt(string stringToDecrypt, string sEncryptionKey)
            {
                byte[] inputByteArray = new byte[stringToDecrypt.Length + 1];
                try
                {
                    key = System.Text.Encoding.UTF8.GetBytes(sEncryptionKey);
                    DESCryptoServiceProvider des = new DESCryptoServiceProvider();
                    inputByteArray = Convert.FromBase64String(stringToDecrypt);
                    MemoryStream ms = new MemoryStream();
                    CryptoStream cs = new CryptoStream(ms,
                    des.CreateDecryptor(key, IV), CryptoStreamMode.Write);
                    cs.Write(inputByteArray, 0, inputByteArray.Length);
                    cs.FlushFinalBlock();
                    System.Text.Encoding encoding = System.Text.Encoding.UTF8;
                    return encoding.GetString(ms.ToArray());
                }
                catch (Exception e)
                {
                    return e.Message;
                }
            }
        }
        protected void Button1_Click(object sender, EventArgs e)
        {
            try
            {
                DataTable dtLog = obj.epromiseLoginValidated(txt_UserName.Text.ToString(), txt_Password.Text.ToString());
                if (dtLog.Rows.Count >= 1)
                {
                    DataTable dt = obj.LoginValidate(txt_UserName.Text.ToString());
                    if (dt.Rows.Count >= 1)
                    {
                        Session["LOGIN_Epromise"] = dt.Rows[0]["UserName"].ToString();
                        Session["LOGIN_ROLE"] = dt.Rows[0]["Role"].ToString();

                        switch (Session["LOGIN_ROLE"].ToString())
                        {
                            case "PM":
                                Response.Redirect("CV_Entry.aspx", false);
                                break;
                            case "HR":
                                Response.Redirect("PM_CVList.aspx", false);
                                break;
                            default:
                                Response.Redirect("Default.aspx", false);
                                break;
                        }
                    }
                    else
                    {
                        Response.Redirect("Login.aspx");
                    }
                }
                else
                {
                    Response.Redirect("Login.aspx");
                }
            }

            catch (Exception ex)
            {

            }
        }
    }
}