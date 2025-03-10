using CV_ManagementSystem.App_Code.BAL;
using CV_ManagementSystem.App_Code.BO;
using GleamTech.DocumentUltimate.AspNet.WebForms;
using Microsoft.Reporting.WebForms;
using System;
using System.Collections.Generic;
using System.Data;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Services.Description;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web;
using Telerik.Web.UI;
using static Telerik.Web.UI.OrgChartStyles;

namespace CV_ManagementSystem
{
    public partial class CV_Entry : System.Web.UI.Page
    {
        CV_EntryBLL obj = new CV_EntryBLL();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Session["dt_SectionA"] = null;
                Session["dt_SectionB"] = null;
                Session["dt_Experience"] = null;
                BindCV_Data();
                BindProfilePhoto();
                BindExperience();
                BindMonths();
                BindReportsSection();
            }
        }
        public void BindMonths()
        {
            for (int x = 0; x < 12; x++)
            {
                ddl_StartMonth.Items.Add(new DropDownListItem(CultureInfo.CurrentCulture.DateTimeFormat.MonthNames.GetValue(x).ToString(), (x + 1).ToString()));
                ddl_EndMonth.Items.Add(new DropDownListItem(CultureInfo.CurrentCulture.DateTimeFormat.MonthNames.GetValue(x).ToString(), (x + 1).ToString()));
                ddl_EditStartMonth.Items.Add(new DropDownListItem(CultureInfo.CurrentCulture.DateTimeFormat.MonthNames.GetValue(x).ToString(), (x + 1).ToString()));
                ddl_EditEndMonth.Items.Add(new DropDownListItem(CultureInfo.CurrentCulture.DateTimeFormat.MonthNames.GetValue(x).ToString(), (x + 1).ToString()));
            }
        }
        #region Personal info
        protected void btn_SavePersonalDetails_Click(object sender, EventArgs e)
        {
            CV_BO data = new CV_BO();
            data.Epromis = Session["LOGIN_Epromise"].ToString();
            data.EmployeeName = txt_FullName.Text.ToString();
            data.CurrentPosition = txt_CurrentPosition.Text.ToString();
            data.Tel_No = txt_TelNo.Text.ToString();
            data.Fax_No = txt_FaxNo.Text.ToString();
            data.PO_Box = txt_POBOx.Text.ToString();
            data.Qualification = txt_Qualification.Text.ToString();
            data.Nationality = txt_Nationality.Text.ToString();
            data.Languages = txt_Languages.Text.ToString();
            data.EntryBy = Session["LOGIN_Epromise"].ToString();

            int Result = obj.Insert_PersonalInfo(data);
            if (Result > 0)
            {
                BindReportsSection();
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "SuccessAlert(1);", true);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "SuccessAlert(0);", true);
            }
        }
        protected void btnOpenPhotoModal_Click(object sender, EventArgs e)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "OpenPhotoModal(1);", true);
        }
        protected void btnSave_ProfilePhoto_Click(object sender, EventArgs e)
        {
            string base64String = hiddenCroppedImage.Value;

            if (string.IsNullOrEmpty(base64String))
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "SuccessAlert(10);", true);
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
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "FileTypeValidation();", true);
                    return;
                }
                byte[] imageBytes = Convert.FromBase64String(base64String);

                string Epromis = Session["LOGIN_Epromise"]?.ToString();
                if (string.IsNullOrEmpty(Epromis))
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "Session_Expired();", true);
                    return;
                }
                string fileExtension = fileType.Split('/')[1]; // "jpeg" -> "jpg"

                if (fileExtension == "jpeg") fileExtension = "jpg";

                string fileName = $"{Epromis}.{fileExtension}";
                int result = obj.Insert_ProfilePhoto(Epromis, imageBytes, fileType, fileName);
                if (result > 0)
                {
                    BindProfilePhoto();
                    BindReportsSection();
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "SuccessAlert(4);", true);
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "SuccessAlert(0);", true);
                }
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "SuccessAlert(0);", true);
            }
        }
        #endregion
        #region Courses
        public void Set_SessionDt_Courses()
        {
            DataTable dtRecords = new DataTable();
            dtRecords.Columns.Add("SkillsTranID");
            dtRecords.Columns.Add("Courses");

            foreach (GridDataItem item in SectionA_Courses.Items)
            {
                DataRow dr = dtRecords.NewRow();
                TextBox txt1 = (TextBox)item.FindControl("txt_Courses_Edit");
                dr["SkillsTranID"] = item.GetDataKeyValue("SkillsTranID").ToString();
                dr["Courses"] = txt1.Text;
                dtRecords.Rows.Add(dr);
            }
            Session["dt_SectionA"] = dtRecords;
        }
        protected void btn_AddCOURSES_Click(object sender, EventArgs e)
        {
            var Flag = false;
            int count = SectionA_Courses.MasterTableView.Items.Count;
            if (count > 0)
            {
                Set_SessionDt_Courses();//for setting Datatable
                DataTable Check_dt = (DataTable)Session["dt_SectionA"];
                string new_courses = txt_Courses.Text.ToString();
                if (new_courses != "")
                {
                    DataRow newRow = Check_dt.NewRow();
                    newRow["SkillsTranID"] = "0";
                    newRow["Courses"] = new_courses;
                    Check_dt.Rows.Add(newRow);
                    txt_Courses.Text = "";
                    Session["dt_SectionA"] = Check_dt;
                }
                else
                {
                    Flag = true;
                }
            }
            else
            {
                string new_courses = txt_Courses.Text.ToString();
                if (new_courses != "")
                {
                    DataTable dt_crs = new DataTable();
                    dt_crs.Columns.Add("Courses");
                    dt_crs.Columns.Add("SkillsTranID");
                    DataRow dr = dt_crs.NewRow();
                    dr["SkillsTranID"] = "0";
                    dr["Courses"] = new_courses;
                    dt_crs.Rows.Add(dr);
                    txt_Courses.Text = "";
                    Session["dt_SectionA"] = dt_crs;

                }
                else
                {
                    Flag = true;
                }
            }
            DataTable Radgrid_dt = (DataTable)Session["dt_SectionA"];
            SectionA_Courses.DataSource = Radgrid_dt;
            SectionA_Courses.DataBind();
            if (Flag)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "Courses_Validation();", true);
            }

        }

        protected void SectionA_Courses_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName == "Delete")
            {
                Set_SessionDt_Courses();
                DataTable dt = (DataTable)Session["dt_SectionA"];
                GridDataItem dataItem = (GridDataItem)e.Item;
                string _Courses = dataItem.GetDataKeyValue("Courses").ToString().Trim();
                for (int i = dt.Rows.Count - 1; i >= 0; i--)
                {
                    DataRow dr = dt.Rows[i];
                    string ss = dr["Courses"].ToString().Trim();
                    if (dr["Courses"].ToString().Trim() == _Courses)
                    {
                        dr.Delete();
                    }
                }
                //-------------------------------------
                Session["dt_SectionA"] = dt;
                dt = (DataTable)Session["dt_SectionA"];
                SectionA_Courses.DataSource = dt;
                SectionA_Courses.DataBind();
            }
        }

        protected void SectionA_Courses_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {

        }
        protected void btn_SaveCourses_Click(object sender, EventArgs e)
        {
            string SkillType = "Courses";
            SaveToDB(SkillType);
        }
        #endregion
        #region ComputerSkills
        protected void SectionB_ComputerSkills_ItemCommand(object sender, GridCommandEventArgs e)
        {
            if (e.CommandName == "Delete")
            {
                Set_SessionDt_ComputerSkills();
                DataTable dt = (DataTable)Session["dt_SectionB"];
                GridDataItem dataItem = (GridDataItem)e.Item;
                string _ComputerSkills = dataItem.GetDataKeyValue("ComputerSkills").ToString().Trim();
                for (int i = dt.Rows.Count - 1; i >= 0; i--)
                {
                    DataRow dr = dt.Rows[i];
                    string ss = dr["ComputerSkills"].ToString().Trim();
                    if (dr["ComputerSkills"].ToString().Trim() == _ComputerSkills)
                    {
                        dr.Delete();
                    }
                }
                //-------------------------------------
                Session["dt_SectionB"] = dt;
                dt = (DataTable)Session["dt_SectionB"];
                SectionB_ComputerSkills.DataSource = dt;
                SectionB_ComputerSkills.DataBind();
            }
        }
        protected void SectionB_ComputerSkills_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {

        }
        protected void btn_AddComputerSkills_Click(object sender, EventArgs e)
        {
            var Flag = false;
            int count = SectionB_ComputerSkills.MasterTableView.Items.Count;
            if (count > 0)
            {
                Set_SessionDt_ComputerSkills();//for setting Datatable
                DataTable Check_dt = (DataTable)Session["dt_SectionB"];
                string new_ComputerSkills = txt_ComputerSkills.Text.ToString();
                if (new_ComputerSkills != "")
                {
                    DataRow newRow = Check_dt.NewRow();
                    newRow["SkillsTranID"] = "0";
                    newRow["ComputerSkills"] = new_ComputerSkills;
                    Check_dt.Rows.Add(newRow);
                    txt_ComputerSkills.Text = "";
                    Session["dt_SectionB"] = Check_dt;
                }
                else
                {
                    Flag = true;
                }
            }
            else
            {
                string new_ComputerSkills = txt_ComputerSkills.Text.ToString();
                if (new_ComputerSkills != "")
                {
                    DataTable dt_Cmp = new DataTable();
                    dt_Cmp.Columns.Add("SkillsTranID");
                    dt_Cmp.Columns.Add("ComputerSkills");
                    DataRow dr = dt_Cmp.NewRow();
                    dr["SkillsTranID"] = "0";
                    dr["ComputerSkills"] = new_ComputerSkills;
                    dt_Cmp.Rows.Add(dr);
                    txt_ComputerSkills.Text = "";
                    Session["dt_SectionB"] = dt_Cmp;
                }
                else
                {
                    Flag = true;
                }
            }
            DataTable Radgrid_dt = (DataTable)Session["dt_SectionB"];
            SectionB_ComputerSkills.DataSource = Radgrid_dt;
            SectionB_ComputerSkills.DataBind();
            if (Flag)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "ComputerSkills_Validation();", true);
            }
        }
        public void Set_SessionDt_ComputerSkills()
        {
            DataTable dtRecords = new DataTable();
            dtRecords.Columns.Add("SkillsTranID");
            dtRecords.Columns.Add("ComputerSkills");

            foreach (GridDataItem item in SectionB_ComputerSkills.Items)
            {
                DataRow dr = dtRecords.NewRow();
                TextBox txt1 = (TextBox)item.FindControl("txt_ComputerSkills_Edit");

                dr["SkillsTranID"] = item.GetDataKeyValue("SkillsTranID").ToString();
                dr["ComputerSkills"] = txt1.Text;
                dtRecords.Rows.Add(dr);
            }
            Session["dt_SectionB"] = dtRecords;
        }
        protected void btn_SaveComputerSkills_Click(object sender, EventArgs e)
        {
            string SkillType = "ComputerSkills";
            SaveToDB(SkillType);
        }
        #endregion
        public void SaveToDB(string SkillType)
        {
            Set_SessionDt_Courses();
            Set_SessionDt_ComputerSkills();
            DataTable dt_Courses = (DataTable)Session["dt_SectionA"];
            DataTable dt_Computer = (DataTable)Session["dt_SectionB"];
            int Result = obj.InsertSkills(dt_Courses, dt_Computer, Session["LOGIN_Epromise"].ToString(), SkillType);
            if (Result > 0)
            {
                int alertval;
                if (SkillType == "Courses")
                {
                    alertval = 2;
                }
                else
                {
                    alertval = 3;
                }
                BindReportsSection();
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "SuccessAlert(" + alertval + ");", true);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "SuccessAlert(0);", true);
            }
        }

        #region BindData()
        public DataSet GetCVData()
        {
            DataSet ds = new DataSet();
            ds = obj.GetUserCVData(Session["LOGIN_Epromise"].ToString());
            return ds;
        }
        public void BindCV_Data()
        {
            GetAll_BLL obj_data = new GetAll_BLL();
            DataSet ds = new DataSet();
            DataTable dtSkills = new DataTable();
            DataTable dtPersonal = new DataTable();
            ds = GetCVData();
            dtPersonal = ds.Tables[0];
            dtSkills = ds.Tables[2];


            #region PersonalDetails
            if (dtPersonal.Rows.Count > 0)
            {
                txt_FullName.Text = dtPersonal.Rows[0]["EmployeeName"].ToString();
                txt_CurrentPosition.Text = dtPersonal.Rows[0]["CurrentPosition"].ToString();
                txt_Nationality.Text = dtPersonal.Rows[0]["Nationality"].ToString();
                txt_TelNo.Text = dtPersonal.Rows[0]["Tel_No"].ToString();
                txt_FaxNo.Text = dtPersonal.Rows[0]["Fax_No"].ToString();
                txt_POBOx.Text = dtPersonal.Rows[0]["PO_Box"].ToString();
                txt_Qualification.Text = dtPersonal.Rows[0]["Qualification"].ToString();
                txt_Languages.Text = dtPersonal.Rows[0]["Languages"].ToString(); 
            }
            else
            {
                DataTable dt_Epromis = obj_data.Get_epromiseMaster(Session["LOGIN_Epromise"].ToString());
                txt_FullName.Text = dt_Epromis.Rows[0]["EmployeeName"].ToString();
                txt_CurrentPosition.Text = dt_Epromis.Rows[0]["WorkingAsName"].ToString();
                txt_Nationality.Text = dt_Epromis.Rows[0]["NationalityName"].ToString();
                txt_TelNo.Text = "04-3736777";
                txt_FaxNo.Text = "04-367773/4";
                txt_POBOx.Text = "62393 Dubai,UAE";
                txt_Qualification.Text = "";
                txt_Languages.Text = "";
            }
            #endregion


            #region SkillsSection


            var courses_dt= new DataTable() ;
            var computerSkills_dt = new DataTable();
            var filteredRows = dtSkills.AsEnumerable()
                           .Where(row => row.Field<int>("SkillsSectionID") == 1);

            if (filteredRows.Any())  
            {
                 courses_dt = filteredRows.CopyToDataTable();
            }
            else
            {
                 courses_dt = dtSkills.Clone();
            }

            var filteredRows2 = dtSkills.AsEnumerable()
                           .Where(row => row.Field<int>("SkillsSectionID") == 2);

            if (filteredRows2.Any())
            {
                computerSkills_dt = filteredRows2.CopyToDataTable();
            }
            else
            {
                computerSkills_dt = dtSkills.Clone();
            }
          

            DataTable dt_Courses = new DataTable();
            dt_Courses.Columns.Add("SkillsTranID");
            dt_Courses.Columns.Add("Courses");

            DataTable dt_ComputerSkills = new DataTable();
            dt_ComputerSkills.Columns.Add("SkillsTranID");
            dt_ComputerSkills.Columns.Add("ComputerSkills");

            foreach (DataRow rows in courses_dt.Rows)
            {
               
                DataRow dr = dt_Courses.NewRow();
                dr["SkillsTranID"] = rows["SkillsTranID"];
                dr["Courses"] = rows["Details"];
                dt_Courses.Rows.Add(dr);
            }
            foreach (DataRow rows in computerSkills_dt.Rows)
            {
                
                DataRow dr = dt_ComputerSkills.NewRow();
                dr["SkillsTranID"] = rows["SkillsTranID"];
                dr["ComputerSkills"] = rows["Details"];
                dt_ComputerSkills.Rows.Add(dr);
            }
            if (dt_Courses != null && dt_Courses.Rows.Count>0)
            {
                    Session["dt_SectionA"] = dt_Courses;
                    SectionA_Courses.DataSource = dt_Courses;
                    SectionA_Courses.DataBind();
            }
            if (dt_ComputerSkills != null && dt_ComputerSkills.Rows.Count>0)
            {
                    Session["dt_SectionB"] = dt_ComputerSkills;
                    SectionB_ComputerSkills.DataSource = dt_ComputerSkills;
                    SectionB_ComputerSkills.DataBind();
            }
            #endregion
        }
        public void BindProfilePhoto()
        {
            DataSet ds = new DataSet();
            DataTable dt = new DataTable();
            ds = GetCVData();
            dt = ds.Tables[1];
            byte[] bytes;
            string base64String = string.Empty;
            if (dt.Rows.Count > 0)
            {
                if (dt.Rows[0]["Photo_FileName"].ToString() != "")
                {
                    bytes = (byte[])dt.Rows[0]["Photo_Data"];
                    base64String = Convert.ToBase64String(bytes, 0, bytes.Length);
                    img_ProfilePhoto.Visible = true;
                    Profilephot0_Icon.Visible = false;
                    img_ProfilePhoto.ImageUrl = "data:image/png;base64," + base64String;
                }
                else
                {
                    img_ProfilePhoto.Visible = false;
                    Profilephot0_Icon.Visible = true;
                }
            }
            else
            {
                img_ProfilePhoto.Visible = false;
                Profilephot0_Icon.Visible = true;
            }
        }
        #endregion

        #region Experience
        public void BindExperience()
        {
            DataSet ds = GetCVData();
            DataTable dt_Experience = ds.Tables[3];
            if (dt_Experience.Rows.Count > 0)
            {
                AllExperience_List.Visible = true;
                AllExperience_RadListView.Visible = true;
                AllExperience_RadListView.DataSource = dt_Experience;
                AllExperience_RadListView.DataBind();
                //MainExperience.Visible = false;
            }
            else
            {
                AllExperience_List.Visible = false;
                //MainExperience.Visible = true;
                AllExperience_RadListView.Visible = false;
            }

        }
        protected void btn_SaveMainExperience_Click(object sender, EventArgs e)
        {
            Experience_BO data=new Experience_BO();
            data.ExperienceTranID = 0;
            data.Epromis = Session["LOGIN_Epromise"].ToString();
            data.Employer = txt_Employer.Text.ToString();
            data.JobTitle = txt_JobTitle.Text.ToString();
            data.StartMonth=Convert.ToInt32(ddl_StartMonth.SelectedValue);
            string PYear = txt_StartYear.SelectedDate.ToString();
            DateTime date = Convert.ToDateTime(PYear);
            data.StartYear = Convert.ToInt32(date.Year);
            
            if (chk_CurrentlyWorking.Checked==true)
            {
                data.CurrentlyWorkStatus = true;
                data.EndMonth = 0;
                data.EndYear = 0;
            }
            else
            {
                data.CurrentlyWorkStatus = false;
                string PYear1 = txt_EndYear.SelectedDate.ToString();
                DateTime date1 = Convert.ToDateTime(PYear1);
                data.EndMonth = Convert.ToInt32(ddl_EndMonth.SelectedValue);
                data.EndYear = Convert.ToInt32(date1.Year);
            }
            data.JobDescription=txt_JobDescription.Text.ToString();
            int LastInserted_TranID= obj.InsertExperience(data);
           
            CurrentInserted_hdnTranID.Value=LastInserted_TranID.ToString();
            if (LastInserted_TranID > 0)
            {
                SetCurretlyInserting_Experience(LastInserted_TranID);
            }
        }
        public void SetCurretlyInserting_Experience(int TranID)
        {
            DataTable dt = obj.USP_GetExperienceByTranID(TranID);
            RadListView_Experience.DataSource = dt;
            RadListView_Experience.DataBind();

            ShowMainExperienceEntry.Visible = false;
            MainExperience_Entry.Style["display"] = "none";
            Project_Section.Style["display"] = "block";
            AllExperience_List.Style["display"] = "none";
            BindReportsSection();
        }
        protected void RadListView_Experience_ItemDataBound(object sender, RadListViewItemEventArgs e)
        {
            if (e.Item is RadListViewDataItem dataItem)
            {
                object RefNo = ((System.Data.DataRowView)(((RadListViewDataItem)e.Item).DataItem)).Row.ItemArray[0].ToString();
                int ExperienceTranID = Convert.ToInt32(RefNo.ToString());
                RadListView RadListView_Project = (RadListView)dataItem.FindControl("RadListView_Project");

                if (RadListView_Project != null)
                {
                    DataTable dt_Projects = new DataTable();
                    dt_Projects = obj.GetExperienceProjectData(ExperienceTranID);
                    RadListView_Project.DataSource = dt_Projects;
                    RadListView_Project.DataBind();

                }
            }
        }
        protected void btn_SaveProject_Click(object sender, EventArgs e)
        {
            ExperienceProject_BO data = new ExperienceProject_BO();
            if (CurrentInserted_hdnTranID.Value != "")
            {
                string selectedPRJCT = Combo_NewProject.SelectedValue.ToString().Trim();
                if (selectedPRJCT == "OTHERS")
                {
                    data.ProjectName = txt_Project.Text.ToString();
                }
                else
                {
                    data.ProjectName = selectedPRJCT;
                }
                data.ExperienceTranID =Convert.ToInt32(CurrentInserted_hdnTranID.Value);
                data.ScopeOfWork = txt_ScopeOfWork.Text.ToString();
                data.Client = txt_Client.Text.ToString();
                data.ContractPrice = txt_ContractPrice.Text.ToString();
                data.Consultant = txt_Consultant.Text.ToString();
                int Result = obj.Insert_ExperienceProject(data);
                if (Result > 0)
                {
                    txt_Project.Text = "";
                    txt_ScopeOfWork.Text = "";
                    txt_Client.Text = "";
                    txt_ContractPrice.Text = "";
                    txt_Consultant.Text = "";
                    Combo_NewProject.ClearSelection();
                }
                SetCurretlyInserting_Experience(data.ExperienceTranID);
            }
        }
        protected void AllExperience_RadListView_ItemDataBound(object sender, RadListViewItemEventArgs e)
        {
            if (e.Item is RadListViewDataItem dataItem)
            {
                object RefNo = ((System.Data.DataRowView)(((RadListViewDataItem)e.Item).DataItem)).Row.ItemArray[0].ToString();
                int ExperienceTranID = Convert.ToInt32(RefNo.ToString());
                RadListView lvProjects = (RadListView)dataItem.FindControl("lvProjects");

                if (lvProjects != null)
                {
                    DataTable dt_Projects = new DataTable();
                    dt_Projects = obj.GetExperienceProjectData(ExperienceTranID);
                    lvProjects.DataSource = dt_Projects;
                    lvProjects.DataBind();

                }
            }
        }
        protected void lvProjects_ItemDataBound(object sender, RadListViewItemEventArgs e)
        {
            if (e.Item is RadListViewDataItem dataItem)
            {
                
                RadListView lvProjects = (RadListView)dataItem.FindControl("lvProjects");

                if (lvProjects != null)
                {
                   

                }
            }
        }
        protected void ShowMainExperienceEntry_Click(object sender, EventArgs e)
        {
            ShowMainExperienceEntry.Visible = false;
            MainExperience_Entry.Style["display"] = "block";
            Project_Section.Style["display"] = "none";
            AllExperience_List.Style["display"] = "none";

            txt_Employer.Text = "";
            txt_JobTitle.Text = "";
            txt_StartYear.Clear();
            txt_EndYear.Clear();
            txt_JobDescription.Text = "";

        }
        protected void ViewAllExperience_FromProjects_Click(object sender, EventArgs e)
        {
            ShowMainExperienceEntry.Visible = true;
            MainExperience_Entry.Style["display"] = "none";
            Project_Section.Style["display"] = "none";
            AllExperience_List.Style["display"] = "block";
            BindExperience();
        }
        protected void btn_GoBack_FromAddExperiencePage_Click(object sender, EventArgs e)
        {
            ShowMainExperienceEntry.Visible = true;
            MainExperience_Entry.Style["display"] = "none";
            Project_Section.Style["display"] = "none";
            AllExperience_List.Style["display"] = "block";

            txt_Employer.Text = "";
            txt_JobTitle.Text = "";
            txt_StartYear.Clear();
            txt_EndYear.Clear();
            txt_JobDescription.Text = "";
            BindExperience();
        }
        public void EditClick_VisibleSection()
        {
            ShowMainExperienceEntry.Visible = false;
            MainExperience_Entry.Style["display"] = "none";
            Project_Section.Style["display"] = "none";
            AllExperience_List.Style["display"] = "none";
            EditWorkExperience.Style["display"] = "block";
            Other_NewProject.Style["display"] = "none";
            int ExperienceTranID=Convert.ToInt32(edit_ExperienceTranID.Value);
            BindData_WhenClickEditButton(ExperienceTranID);
            
        }
        protected void btn_EditGoBack_FromAddExperience_Click(object sender, EventArgs e)
        {
            ShowMainExperienceEntry.Visible = true;
            MainExperience_Entry.Style["display"] = "none";
            Project_Section.Style["display"] = "none";
            AllExperience_List.Style["display"] = "block";
            EditWorkExperience.Style["display"] = "none";
            BindExperience();
        }
        protected void btn_SaveEditMainExperience_Click(object sender, EventArgs e)
        {
            #region Employer

            Experience_BO data = new Experience_BO();
            data.ExperienceTranID =Convert.ToInt32(edit_ExperienceTranID.Value);
            data.Epromis = Session["LOGIN_Epromise"].ToString();
            data.Employer = txt_EditEmployer.Text.ToString();
            data.JobTitle = txt_EditJobTitle.Text.ToString();
            data.StartMonth = Convert.ToInt32(ddl_EditStartMonth.SelectedValue);
            string PYear = txt_EditStartYear.SelectedDate.ToString();
            DateTime date = Convert.ToDateTime(PYear);
            data.StartYear = Convert.ToInt32(date.Year);

            if (chk_EditCurrentlyWorking.Checked == true)
            {
                data.CurrentlyWorkStatus = true;
                data.EndMonth = 0;
                data.EndYear = 0;
            }
            else
            {
                data.CurrentlyWorkStatus = false;
                string PYear1 = txt_EditEndYear.SelectedDate.ToString();
                DateTime date1 = Convert.ToDateTime(PYear1);
                data.EndMonth = Convert.ToInt32(ddl_EditEndMonth.SelectedValue);
                data.EndYear = Convert.ToInt32(date1.Year);
            }
            data.JobDescription = txt_EditJobDescription.Text.ToString();
            int LastInserted_TranID = obj.InsertExperience(data);
            #endregion
            #region EmployerProjects
            DataTable dt_projects = obj.GetExperienceProjectData(Convert.ToInt32(edit_ExperienceTranID.Value));
            if (dt_projects.Rows.Count > 0)
            {
                DataTable dt = new DataTable();
                //dt.Columns.Add("ExperienceTranID", typeof(int));
                dt.Columns.Add("ProjectTranID", typeof(int));
                dt.Columns.Add("ProjectName", typeof(string));
                dt.Columns.Add("ScopeOfWork", typeof(string));
                dt.Columns.Add("Client", typeof(string));
                dt.Columns.Add("ContractPrice", typeof(string));
                dt.Columns.Add("Consultant", typeof(string));

                foreach (RadListViewDataItem item in RadListView_EditProjects.Items)
                {
                   
                    HiddenField hd_ExperienceTranID = (HiddenField)item.FindControl("hdn_ExperienceTranID");
                    int experienceTranID = Convert.ToInt32(hd_ExperienceTranID.Value);
                    HiddenField hd_ProjectTranID = (HiddenField)item.FindControl("hdn_ProjectTranID");
                    int ProjectTranID = Convert.ToInt32(hd_ProjectTranID.Value);

                    TextBox txtProject = (TextBox)item.FindControl("txt_EditProject");
                    TextBox txtClient = (TextBox)item.FindControl("txt_EditClient");
                    TextBox txtContractPrice = (TextBox)item.FindControl("txt_EditContractPrice");
                    TextBox txtScopeOfWork = (TextBox)item.FindControl("txt_EditScopeOfWork");
                    TextBox txtConsultant = (TextBox)item.FindControl("txt_EditConsultant");

                    dt.Rows.Add( ProjectTranID, txtProject.Text.Trim(), txtScopeOfWork.Text.Trim(), txtClient.Text.Trim(), txtContractPrice.Text.Trim(), txtConsultant.Text.Trim());
                }
                int result = obj.BulkUpdate_ExperienceProjects(dt, Convert.ToInt32(edit_ExperienceTranID.Value));
                if (result > 0)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "BulkDataUpdated();", true);
                }
            }
            #endregion
            BindReportsSection();
            EditClick_VisibleSection();
        }
        public void BindHome_ExperienceSection()
        {
            ShowMainExperienceEntry.Visible = true;
            MainExperience_Entry.Style["display"] = "none";
            Project_Section.Style["display"] = "none";
            AllExperience_List.Style["display"] = "block";
            BindExperience();
            EditWorkExperience.Style["display"] = "none";
        }
        protected void AllExperience_RadListView_ItemCommand(object sender, RadListViewCommandEventArgs e)
        {
            if (e.CommandName == "EditItem")
            {
                int ExperienceTranID = Convert.ToInt32(e.CommandArgument.ToString());
                edit_ExperienceTranID.Value= ExperienceTranID.ToString();
                BindData_WhenClickEditButton(ExperienceTranID);

                ShowMainExperienceEntry.Visible = false;
                MainExperience_Entry.Style["display"] = "none";
                Project_Section.Style["display"] = "none";
                AllExperience_List.Style["display"] = "none";
                EditWorkExperience.Style["display"] = "block";
            }
            if(e.CommandName== "DeleteItem")
            {
                int ExperienceTranID = Convert.ToInt32(e.CommandArgument.ToString());
                int DeleResult=obj.DeleteExperienceData(ExperienceTranID);
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "DeleteAlert();", true);

                BindExperience();
                BindReportsSection();
            }
        }
        public void BindData_WhenClickEditButton(int ExperienceTranID)
        {
            DataTable dt = obj.USP_GetExperienceByTranID(ExperienceTranID);
            if (dt.Rows.Count > 0)
            {
                txt_EditEmployer.Text = dt.Rows[0]["Employer"].ToString();
                txt_EditJobTitle.Text = dt.Rows[0]["JobTitle"].ToString();
                ddl_EditStartMonth.SelectedValue = dt.Rows[0]["StartMonth"].ToString();
                ddl_EditEndMonth.SelectedValue = dt.Rows[0]["EndMonth"].ToString();
                int startYear = Convert.ToInt32(dt.Rows[0]["StartYear"]);
                txt_EditStartYear.SelectedDate = new DateTime(startYear, 1, 1);
                if (Convert.ToBoolean(dt.Rows[0]["CurrentlyWorkStatus"]) == true)
                {
                    chk_EditCurrentlyWorking.Checked = true;
                    txt_EditEndYear.Clear();
                }
                else
                {
                    chk_EditCurrentlyWorking.Checked = false;
                    int endYear = Convert.ToInt32(dt.Rows[0]["EndYear"]);
                    txt_EditEndYear.SelectedDate = new DateTime(endYear, 1, 1);
                }
                txt_EditJobDescription.Text = dt.Rows[0]["JobDescription"].ToString();
            }
            DataTable dt_projects = obj.GetExperienceProjectData(ExperienceTranID);
            if (dt_projects.Rows.Count > 0)
            {
                Edit_ProjectList.Visible = true;
                RadListView_EditProjects.DataSource = dt_projects;
                RadListView_EditProjects.DataBind();
            }
            else
            {
                Edit_ProjectList.Visible = false;

            }
        }
        protected void RadListView_EditProjects_ItemCommand(object sender, RadListViewCommandEventArgs e)
        {
            if (e.CommandName == "DeleteProject")
            {
                int ProjectTranID = Convert.ToInt32(e.CommandArgument.ToString());
                int DeleResult = obj.DeleteExperience_ProjectData(ProjectTranID);
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "DeleteAlert();", true);
                EditClick_VisibleSection();
                BindReportsSection();
            }
        }
        protected void btn_Edit_NewProject_Click(object sender, EventArgs e)
        {
            ExperienceProject_BO data = new ExperienceProject_BO();
            if (edit_ExperienceTranID.Value != "")
            {
                data.ExperienceTranID = Convert.ToInt32(edit_ExperienceTranID.Value);
                string selectedPRJCT = ComboProject.SelectedValue.ToString().Trim();
                if (selectedPRJCT == "OTHERS")
                {
                    data.ProjectName = txt_NewProject.Text.ToString();
                }
                else
                {
                    data.ProjectName = selectedPRJCT;
                }
                   
                data.ScopeOfWork = txt_NewScopeOfWork.Text.ToString();
                data.Client = txt_NewClient.Text.ToString();
                data.ContractPrice = txt_NewContractPrice.Text.ToString();
                data.Consultant = txt_NewConsultant.Text.ToString();
                int Result = obj.Insert_ExperienceProject(data);
                if (Result > 0)
                {
                    txt_NewProject.Text = "";
                    txt_NewScopeOfWork.Text = "";
                    txt_NewClient.Text = "";
                    txt_NewContractPrice.Text = "";
                    txt_NewConsultant.Text = "";
                    ComboProject.ClearSelection();
                    EditClick_VisibleSection();
                    BindReportsSection();
                }
              
            }
        }
        protected void ComboProject_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            string selectedPRJCT = ComboProject.SelectedValue.ToString().Trim();
            if (selectedPRJCT == "OTHERS")
            {
                Other_NewProject.Style["display"] = "block";
                txt_NewClient.Text = "";
                txt_NewContractPrice.Text = "";
                txt_NewScopeOfWork.Text = "";
                txt_NewClient.Text = "";
                txt_NewConsultant.Text = "";
            }
            else
            {
                Other_NewProject.Style["display"] = "none";
                DataTable dt = obj.GetExistingProjectsDeatils(selectedPRJCT);
                if(dt.Rows.Count > 0)
                {
                    
                    txt_NewClient.Text = dt.Rows[0]["Client"].ToString();
                    txt_NewContractPrice.Text = dt.Rows[0]["ContractPrice_M_AED"].ToString();
                    txt_NewScopeOfWork.Text = dt.Rows[0]["ProjectDescription"].ToString();
                    txt_NewClient.Text = dt.Rows[0]["Client"].ToString();
                    txt_NewConsultant.Text = dt.Rows[0]["Consultant"].ToString();
                }
            }
            
    
            
        }
        protected void Combo_NewProject_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            string selectedPRJCT = Combo_NewProject.SelectedValue.ToString().Trim();
            if (selectedPRJCT == "OTHERS")
            {
                txt_Project.Text = "";
                Other_newEntryProject.Style["display"] = "block";
                txt_Client.Text = "";
                txt_ContractPrice.Text = "";
                txt_ScopeOfWork.Text = "";
                txt_Client.Text = "";
                txt_Consultant.Text = "";
            }
            else
            {
                Other_newEntryProject.Style["display"] = "none";
                DataTable dt = obj.GetExistingProjectsDeatils(selectedPRJCT);
                if (dt.Rows.Count > 0)
                {

                    txt_Client.Text = dt.Rows[0]["Client"].ToString();
                    txt_ContractPrice.Text = dt.Rows[0]["ContractPrice_M_AED"].ToString();
                    txt_ScopeOfWork.Text = dt.Rows[0]["ProjectDescription"].ToString();
                    txt_Client.Text = dt.Rows[0]["Client"].ToString();
                    txt_Consultant.Text = dt.Rows[0]["Consultant"].ToString();
                }
            }
            
        }
        #endregion
        #region Report Section
        public void BindReportsSection()
        {
            try
            {
                string TemplateVal = Combo_Template.SelectedValue.ToString();
                DataSet ds =obj.GetUserCVData_Report(Session["LOGIN_Epromise"].ToString());
                DataTable dt_Personal = ds.Tables[0];
                DataTable dt_Courses = ds.Tables[1];
                DataTable dt_Skills = ds.Tables[2];
                
                DataTable dt_Experience = ds.Tables[3];
                DataTable dt_Experience2 = ds.Tables[4];
                DataTable dt_Projects = ds.Tables[5];
           


                //DataTable dtParam = new DataTable();
                //dtParam.Columns.AddRange(new DataColumn[9] { new DataColumn("SupplierName", typeof(string)),
                //                                new DataColumn("TypeOfBusiness", typeof(string)),
                //                                new DataColumn("Address",typeof(string)),
                //                                new DataColumn("ContactDetails",typeof(string)),
                //                                new DataColumn("Category",typeof(string)),
                //                                new DataColumn("PaymentTerms",typeof(string)),
                //                                new DataColumn("NoOfComplaint",typeof(string)),
                //                                 new DataColumn("Company",typeof(string)),
                //                                new DataColumn("ProjectName",typeof(string)),
                // });
                if (dt_Personal.Rows.Count > 0)
                {
                    string DownloadedFileName = "";
                    if (TemplateVal == "1")
                    {
                        DownloadedFileName = "CV_Template1.";
                        ReportViewer1.LocalReport.ReportPath = HttpContext.Current.Request.MapPath("Reports/ReportFullTemp.rdlc");
                    }
                    else if (TemplateVal == "2")
                    {
                        DownloadedFileName = "CV_Template2.";
                        ReportViewer1.LocalReport.ReportPath = HttpContext.Current.Request.MapPath("Reports/ReportFullTemp_2.rdlc");
                    }
                    else if (TemplateVal == "3")
                    {
                        DownloadedFileName = "CV_Template3.";
                        ReportViewer1.LocalReport.ReportPath = HttpContext.Current.Request.MapPath("Reports/ReportFullTemp_3.rdlc");
                    }
                    else if (TemplateVal == "4")
                    {
                        DownloadedFileName = "CV_Template4.";
                        ReportViewer1.LocalReport.ReportPath = HttpContext.Current.Request.MapPath("Reports/ReportFullTemp_4.rdlc");
                    }
                    ReportViewer1.LocalReport.DataSources.Clear();
                    ReportViewer1.LocalReport.DataSources.Add(new ReportDataSource("Personal_Info", dt_Personal));
                    ReportViewer1.LocalReport.DataSources.Add(new ReportDataSource("Skills", dt_Skills));
                    ReportViewer1.LocalReport.DataSources.Add(new ReportDataSource("Courses", dt_Courses));
                    ReportViewer1.LocalReport.DataSources.Add(new ReportDataSource("Experience", dt_Experience));
                    ReportViewer1.LocalReport.DataSources.Add(new ReportDataSource("Projects", dt_Projects));
                    ReportViewer1.LocalReport.DataSources.Add(new ReportDataSource("Experience2", dt_Experience2));
                    ReportViewer1.LocalReport.SubreportProcessing += new SubreportProcessingEventHandler(ReportProcessing);
                    ReportViewer1.AsyncRendering = false;
                    ReportViewer1.Visible = false;
                    ReportViewer1.LocalReport.Refresh();

                    Warning[] warnings;
                    string[] streamIds;
                    string contentType;
                    string encoding;
                    string extension;
                    byte[] bytes = ReportViewer1.LocalReport.Render("PDF", null, out contentType, out encoding, out extension, out streamIds, out warnings);

                    string serverFilePath = "";
                    string folderPath = HttpContext.Current.Server.MapPath("~/FileView_Data/");  // Ensure the folder exists on the server
                    if (!Directory.Exists(folderPath))
                    {
                        Directory.CreateDirectory(folderPath);  // Create the folder if it doesn't exist
                    }
                    else
                    {
                        serverFilePath = Server.MapPath("~/FileView_Data/" + Path.GetFileName(DownloadedFileName + extension));

                        FileInfo file = new FileInfo(serverFilePath);
                        if (file.Exists)//check file exsit or not  
                        {
                            file.Delete();
                        }
                    }
                    string filePath = Path.Combine(folderPath, DownloadedFileName + extension);
                    try
                    {
                        File.WriteAllBytes(filePath, bytes);

                    }
                    catch (Exception ex)
                    {
                        Response.Write("Error: " + ex.Message);
                    }
                    DocumentViewerControl1.Visible = true;
                    DocumentViewerControl1.Document = serverFilePath;
                }
            }
            catch (Exception)
            {

                throw;
            }
        }
        void ReportProcessing(object sender, SubreportProcessingEventArgs e)
        {
            int ExperienceTranID =Convert.ToInt32(e.Parameters["ExperienceTranID"].Values[0]);
            DataTable dt_Projects = obj.GetExperienceProjectData(ExperienceTranID); 

            ReportDataSource ds_Project = new ReportDataSource("Projects", dt_Projects);
            e.DataSources.Add(ds_Project);
           
        }
        protected void Combo_Template_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
        {
            BindReportsSection();
        }
        #endregion
    }
}