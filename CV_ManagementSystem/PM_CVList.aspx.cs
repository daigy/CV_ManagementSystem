using CV_ManagementSystem.App_Code.BAL;
using Microsoft.Reporting.WebForms;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using System.IO.Compression;
using System.Security.Cryptography.Xml;

namespace CV_ManagementSystem
{
    public partial class PM_CVList : System.Web.UI.Page
    {
        CV_EntryBLL obj = new CV_EntryBLL();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                RadGrid_CV.DataSource = GetAll_CVData();
                RadGrid_CV.DataBind();
            }
        }
        public DataTable GetAll_CVData()
        {
            DataTable dt = new DataTable();
            dt = obj.GetAllCV_Data();
            return dt;
        }
        protected void RadGrid_CV_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
        {
            RadGrid_CV.DataSource = GetAll_CVData();
        }
        protected void chkHeader_CheckedChanged(object sender, EventArgs e)
        {
            int count = 0;
            CheckBox headerCheckBox = (CheckBox)sender;
            foreach (GridDataItem item in RadGrid_CV.MasterTableView.Items)
            {
                CheckBox chkSelect = (CheckBox)item.FindControl("chkSelect");
                if (chkSelect != null)
                {
                    if (chkSelect.Checked)
                    {
                        count++;
                        item.BackColor = System.Drawing.ColorTranslator.FromHtml("#d1d1d1");
                    }
                    else
                    {
                       item.BackColor = System.Drawing.ColorTranslator.FromHtml("#fff");
                    }
                }
            }
        }
       
        protected void RadGrid_CV_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName == "DownLoad")
            {
                GridDataItem dataItem = e.Item as GridDataItem;
                int cvTranID = Convert.ToInt32(dataItem.GetDataKeyValue("CV_TranID").ToString());
                string Epromis = dataItem.GetDataKeyValue("Epromis").ToString();
                GenerateReports(Epromis, cvTranID);
            }
        }
        public void GenerateReports(string epromis, int cvTranID)
        {
            string TemplateVal = Combo_Template.SelectedValue.ToString();
            DataSet ds = obj.GetUserCVData_Report(epromis);
            DataTable dt_Personal = ds.Tables[0];
            DataTable dt_Courses = ds.Tables[1];
            DataTable dt_Skills = ds.Tables[2];

            DataTable dt_Experience = ds.Tables[3];
            DataTable dt_Experience2 = ds.Tables[4];
            DataTable dt_Projects = ds.Tables[5];
            DataTable dt_Qualification = ds.Tables[6];
            DataTable dt_Hobbies = ds.Tables[7];
            string DownloadedFileName = "";
            string EmployeeName = dt_Personal.Rows[0]["EmployeeName"].ToString();
            string CurrentPosition = dt_Personal.Rows[0]["CurrentPosition"].ToString(); 
            string year = DateTime.Now.Year.ToString(); // e.g. "2025"
            string date = DateTime.Now.ToString("MM-dd"); // e.g. "10-22"
            DownloadedFileName = "ECC_" + CurrentPosition.Replace(" ", "_") + "_" + EmployeeName.Replace(" ", "_") + "_" + year + "-" + date; ;

            if (dt_Personal.Rows.Count > 0)
            {
                ReportViewer ReportViewer_1 = new ReportViewer();
                
                if (TemplateVal == "1")
                {
                    //DownloadedFileName = epromis + "_CV_Template1.";
                    ReportViewer_1.LocalReport.ReportPath = HttpContext.Current.Request.MapPath("Reports/ReportFullTemp.rdlc");
                }
                else if (TemplateVal == "2")
                {
                    //DownloadedFileName = epromis + "_CV_Template2.";
                    ReportViewer_1.LocalReport.ReportPath = HttpContext.Current.Request.MapPath("Reports/ReportFullTemp_2.rdlc");
                }
                else if (TemplateVal == "3")
                {
                    //DownloadedFileName = epromis + "_CV_Template3.";
                    ReportViewer_1.LocalReport.ReportPath = HttpContext.Current.Request.MapPath("Reports/ReportFullTemp_3.rdlc");
                }
                else if (TemplateVal == "4")
                {
                    //DownloadedFileName = epromis + "_CV_Template4.";
                    ReportViewer_1.LocalReport.ReportPath = HttpContext.Current.Request.MapPath("Reports/ReportFullTemp_4.rdlc");
                }


                ReportViewer_1.LocalReport.DataSources.Clear();
                ReportViewer_1.LocalReport.DataSources.Add(new ReportDataSource("Personal_Info", dt_Personal));
                ReportViewer_1.LocalReport.DataSources.Add(new ReportDataSource("Skills", dt_Skills));
                ReportViewer_1.LocalReport.DataSources.Add(new ReportDataSource("Courses", dt_Courses));
                ReportViewer_1.LocalReport.DataSources.Add(new ReportDataSource("Experience", dt_Experience));
                ReportViewer_1.LocalReport.DataSources.Add(new ReportDataSource("Projects", dt_Projects));
                ReportViewer_1.LocalReport.DataSources.Add(new ReportDataSource("Experience2", dt_Experience2));
                ReportViewer_1.LocalReport.DataSources.Add(new ReportDataSource("Qualification", dt_Qualification));
                ReportViewer_1.LocalReport.DataSources.Add(new ReportDataSource("Hobbies", dt_Hobbies));

                ReportViewer_1.LocalReport.SubreportProcessing += new SubreportProcessingEventHandler(ReportProcessing);
                ReportViewer_1.AsyncRendering = false;
                ReportViewer_1.Visible = true;
                ReportViewer_1.LocalReport.Refresh();
                Warning[] warnings;
                string[] streamIds;
                string contentType;
                string encoding;
                string extension;

                string deviceInfo = "<DeviceInfo>" +
                    "  <OutputFormat>PDF</OutputFormat>" +
                    "  <PageWidth>8.27in</PageWidth>" +
                    "  <PageHeight>11.69in</PageHeight>" +
                    "  <MarginTop>0in</MarginTop>" +
                    "  <MarginLeft>0in</MarginLeft>" +
                    "  <MarginRight>0in</MarginRight>" +
                    "  <MarginBottom>0in</MarginBottom>" +
                    "  <EmbedFonts>None</EmbedFonts>" +
                    "</DeviceInfo>";
                //Export the RDLC Report to Byte Array.
                byte[] bytes = ReportViewer_1.LocalReport.Render("PDF", deviceInfo, out contentType, out encoding, out extension, out streamIds, out warnings);

                Response.Clear();
                Response.Buffer = true;
                Response.Charset = "";
                Response.Cache.SetCacheability(HttpCacheability.NoCache);
                Response.ContentType = contentType;
                Response.AppendHeader("Content-Disposition", "attachment; filename=" + DownloadedFileName + "." + extension);
                Response.BinaryWrite(bytes);
                //Response.Flush();
                Response.End();
            }
        }
        void ReportProcessing(object sender, SubreportProcessingEventArgs e)
        {
            int ExperienceTranID = Convert.ToInt32(e.Parameters["ExperienceTranID"].Values[0]);
            DataTable dt_Projects = obj.GetExperienceProjectData(ExperienceTranID);
            ReportDataSource ds_Project = new ReportDataSource("Projects", dt_Projects);
            e.DataSources.Add(ds_Project);
        }
        #region DownloadAll_CV
        protected void btn_DownloadAllCV_Click(object sender, EventArgs e)
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("CV_TranID", typeof(int));
            dt.Columns.Add("Epromis", typeof(string));
            dt.Columns.Add("EmployeeName", typeof(string));
            dt.Columns.Add("CurrentPosition", typeof(string));
            // Get selected CVs
            foreach (GridDataItem item in RadGrid_CV.MasterTableView.Items)
            {
                CheckBox chk = (item.FindControl("chkSelect") as CheckBox);
                if (chk != null && chk.Checked)
                {
                    int cvTranID = Convert.ToInt32(item.GetDataKeyValue("CV_TranID"));
                    string epromis = item["Epromis"].Text.Trim();
                    string EmployeeName = item["EmployeeName"].Text.Trim();
                    string CurrentPosition = item["CurrentPosition"].Text.Trim();
                    dt.Rows.Add(cvTranID, epromis, EmployeeName, CurrentPosition);
                }
            }
            string DownloadedFileName = "";
            if (dt.Rows.Count > 0)
            {
                using (MemoryStream zipStream = new MemoryStream())
                {
                    using (ZipArchive zip = new ZipArchive(zipStream, ZipArchiveMode.Create, true))
                    {
                        foreach (DataRow rw in dt.Rows)
                        {
                            string epromis = rw["Epromis"].ToString();
                            string Employee_Name = rw["EmployeeName"].ToString();
                            string Current_Position = rw["CurrentPosition"].ToString();
                            int cvTranID = Convert.ToInt32(rw["CV_TranID"]);
                            byte[] reportBytes = GenerateReports_Zip(epromis, cvTranID);

                            if (reportBytes != null)
                            {
                                string year = DateTime.Now.Year.ToString(); // e.g. "2025"
                                string date = DateTime.Now.ToString("MM-dd"); // e.g. "10-22"
                                DownloadedFileName = "ECC_" + Current_Position.Replace(" ", "_") + "_" + Employee_Name.Replace(" ", "_") + "_" + year + "-" + date; 
                                ZipArchiveEntry zipEntry = zip.CreateEntry(DownloadedFileName + ".pdf");
                                using (var entryStream = zipEntry.Open())
                                {
                                    entryStream.Write(reportBytes, 0, reportBytes.Length);
                                }
                            }
                        }
                    }

                    // Send ZIP file to client
                    Response.Clear();
                    Response.ContentType = "application/zip";
                    Response.AddHeader("Content-Disposition", "attachment; filename=CV_Reports.zip");
                    Response.BinaryWrite(zipStream.ToArray());
                    Response.Flush();
                    HttpContext.Current.ApplicationInstance.CompleteRequest();
                }
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "ValidationGrid();", true);
            }
        }
        public byte[] GenerateReports_Zip(string epromis, int cvTranID)
        {
            string TemplateVal = Combo_Template.SelectedValue.ToString();
            DataSet ds = obj.GetUserCVData_Report(epromis);
           

            DataTable dt_Personal = ds.Tables[0];
            DataTable dt_Courses = ds.Tables[1];
            DataTable dt_Skills = ds.Tables[2];

            DataTable dt_Experience = ds.Tables[3];
            DataTable dt_Experience2 = ds.Tables[4];
            DataTable dt_Projects = ds.Tables[5];
            DataTable dt_Qualification = ds.Tables[6];
            DataTable dt_Hobbies = ds.Tables[7];

            if (dt_Personal.Rows.Count > 0)
            {
                ReportViewer ReportViewer_1 = new ReportViewer();
                string reportPath = "";

                switch (TemplateVal)
                {
                    case "1": reportPath = "Reports/ReportFullTemp.rdlc"; break;
                    case "2": reportPath = "Reports/ReportFullTemp_2.rdlc"; break;
                    case "3": reportPath = "Reports/ReportFullTemp_3.rdlc"; break;
                    case "4": reportPath = "Reports/ReportFullTemp_4.rdlc"; break;
                }

                ReportViewer_1.LocalReport.ReportPath = HttpContext.Current.Request.MapPath(reportPath);
                ReportViewer_1.LocalReport.DataSources.Clear();
                ReportViewer_1.LocalReport.DataSources.Add(new ReportDataSource("Personal_Info", dt_Personal));
                ReportViewer_1.LocalReport.DataSources.Add(new ReportDataSource("Skills", dt_Skills));
                ReportViewer_1.LocalReport.DataSources.Add(new ReportDataSource("Courses", dt_Courses));
                ReportViewer_1.LocalReport.DataSources.Add(new ReportDataSource("Experience", dt_Experience));
                ReportViewer_1.LocalReport.DataSources.Add(new ReportDataSource("Projects", dt_Projects));
                ReportViewer_1.LocalReport.DataSources.Add(new ReportDataSource("Experience2", dt_Experience2));
                ReportViewer_1.LocalReport.DataSources.Add(new ReportDataSource("Qualification", dt_Qualification));
                ReportViewer_1.LocalReport.DataSources.Add(new ReportDataSource("Hobbies", dt_Hobbies));
                ReportViewer_1.LocalReport.SubreportProcessing += new SubreportProcessingEventHandler(ReportProcessing);
                ReportViewer_1.LocalReport.Refresh();

                Warning[] warnings;
                string[] streamIds;
                string contentType;
                string encoding;
                string extension;

                string deviceInfo = "<DeviceInfo>" +
                    "  <OutputFormat>PDF</OutputFormat>" +
                    "  <PageWidth>8.27in</PageWidth>" +
                    "  <PageHeight>11.69in</PageHeight>" +
                    "  <MarginTop>0in</MarginTop>" +
                    "  <MarginLeft>0in</MarginLeft>" +
                    "  <MarginRight>0in</MarginRight>" +
                    "  <MarginBottom>0in</MarginBottom>" +
                    "  <EmbedFonts>None</EmbedFonts>" +
                    "</DeviceInfo>";

                return ReportViewer_1.LocalReport.Render("PDF", deviceInfo, out contentType, out encoding, out extension, out streamIds, out warnings);
            }

            return null;  // Return null if no data
        }
        #endregion

        protected void RadGrid_CV_ItemDataBound(object sender, GridItemEventArgs e)
        {
            try
            {
                if (e.Item is GridDataItem)
                {
                    GridDataItem dataBoundItem = e.Item as GridDataItem;
                    TableCell Missing_Sections = dataBoundItem["Missing_Sections"];
                    RadButton btn_Download = dataBoundItem.FindControl("btn_Download") as RadButton;
                    Label lb_pendingDetails = dataBoundItem.FindControl("lb_pendingDetails") as Label;
                    if (Missing_Sections.Text.Trim() == "Done")
                    {
                        btn_Download.Visible = true;
                        lb_pendingDetails.Visible = false;
                    }
                    else 
                    {
                        btn_Download.Visible = false;
                        lb_pendingDetails.Visible = true;
                    }
                }
            }
            catch (Exception ex)
            {

                throw;
            }
        }
    }
}