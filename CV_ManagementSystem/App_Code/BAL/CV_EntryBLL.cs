using CV_ManagementSystem.App_Code.BO;
using CV_ManagementSystem.App_Code.DAL;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using Telerik.Web.UI.com.hisoftware.api2;

namespace CV_ManagementSystem.App_Code.BAL
{
    public class CV_EntryBLL
    {
        dbConnection obj = new dbConnection();
        CV_BO bo_obj=new CV_BO();
        public int Insert_PersonalInfo(CV_BO data)
        {
            try
            {
                obj.Openconnection();
                obj.getcommand.CommandType = CommandType.StoredProcedure;
                obj.getcommand.Parameters.Clear();
                obj.getcommand.CommandText = "USP_Insert_PersonalInfo";
                obj.getcommand.Parameters.AddWithValue("@Epromis", data.Epromis);
                obj.getcommand.Parameters.AddWithValue("@EmployeeName", data.EmployeeName);
                obj.getcommand.Parameters.AddWithValue("@CurrentPosition", data.CurrentPosition);
                obj.getcommand.Parameters.AddWithValue("@Tel_No", data.Tel_No);
                obj.getcommand.Parameters.AddWithValue("@Fax_No", data.Fax_No);
                obj.getcommand.Parameters.AddWithValue("@PO_Box", data.PO_Box);
                obj.getcommand.Parameters.AddWithValue("@Qualification", data.Qualification);
                obj.getcommand.Parameters.AddWithValue("@Nationality", data.Nationality);
                obj.getcommand.Parameters.AddWithValue("@Languages", data.Languages);
                obj.getcommand.Parameters.AddWithValue("@EntryBy", data.EntryBy);

                int result = obj.getcommand.ExecuteNonQuery();
                obj.Closeconnection();
                return result;
            }
            catch
            {
                throw;
            }
            finally
            {
                obj.getcommand.Dispose();
                obj.Closeconnection();
            }
        }
        public int Insert_ProfilePhoto(string Epromis, byte[] Photo_Data, string Photo_FileType, string Photo_FileName)
        {
            try
            {
                obj.Openconnection();
                obj.getcommand.CommandType = CommandType.StoredProcedure;
                obj.getcommand.Parameters.Clear();
                obj.getcommand.CommandText = "USP_Insert_Photo";
                obj.getcommand.Parameters.AddWithValue("@Epromis", Epromis);
                obj.getcommand.Parameters.AddWithValue("@Photo_Data", Photo_Data);
                obj.getcommand.Parameters.AddWithValue("@Photo_FileType", Photo_FileType);
                obj.getcommand.Parameters.AddWithValue("@Photo_FileName", Photo_FileName);
                int result = obj.getcommand.ExecuteNonQuery();
                obj.Closeconnection();
                return result;
            }
            catch
            {
                throw;
            }
            finally
            {
                obj.getcommand.Dispose();
                obj.Closeconnection();
            }
        }
        public int InsertSkills(DataTable dt_Courses, DataTable dt_Computer, string EntryBy,string SkillType)
        {
            try
            {
                obj.Openconnection();
                obj.getcommand.CommandType = CommandType.StoredProcedure;
                obj.getcommand.Parameters.Clear();
                obj.getcommand.CommandText = "USP_InsertSkills";
                obj.getcommand.Parameters.AddWithValue("@dt_Courses", dt_Courses);
                obj.getcommand.Parameters.AddWithValue("@dt_Computer", dt_Computer); 
                obj.getcommand.Parameters.AddWithValue("@EpromisID", EntryBy);
                obj.getcommand.Parameters.AddWithValue("@SkillType", SkillType);
                int result = obj.getcommand.ExecuteNonQuery();
                obj.Closeconnection();
                return result;
            }
            catch
            {
                throw;
            }
            finally
            {
                obj.getcommand.Dispose();
                obj.Closeconnection();
            }
        }
        public DataSet GetUserCVData(string EpromisID )
        {
            try
            {
                obj.Openconnection();
                obj.getcommand.CommandType = CommandType.StoredProcedure;
                obj.getcommand.Parameters.Clear();
                obj.getcommand.CommandText = "USP_GetUserCVData";
                obj.getcommand.Parameters.AddWithValue("@EpromisID ", EpromisID); 
                SqlDataAdapter dataAdapter = new SqlDataAdapter();
                DataSet ds = new DataSet();
                dataAdapter.SelectCommand = obj.getcommand;
                dataAdapter.Fill(ds);
                return ds ;
            }
            catch
            {
                throw;
            }
            finally
            {
                obj.getcommand.Dispose();
                obj.Closeconnection();
            }
        }
        public DataSet GetUserCVData_Report(string EpromisID)
        {
            try
            {
                obj.Openconnection();
                obj.getcommand.CommandType = CommandType.StoredProcedure;
                obj.getcommand.Parameters.Clear();
                obj.getcommand.CommandText = "USP_GetUserCVData_ForReport";
                obj.getcommand.Parameters.AddWithValue("@EpromisID ", EpromisID);
                SqlDataAdapter dataAdapter = new SqlDataAdapter();
                DataSet ds = new DataSet();
                dataAdapter.SelectCommand = obj.getcommand;
                dataAdapter.Fill(ds);
                return ds;
            }
            catch
            {
                throw;
            }
            finally
            {
                obj.getcommand.Dispose();
                obj.Closeconnection();
            }
        }
        public int InsertExperience(Experience_BO data)
        {
            try
            {
                obj.Openconnection();
                obj.getcommand.CommandType = CommandType.StoredProcedure;
                obj.getcommand.Parameters.Clear();
                obj.getcommand.CommandText = "USP_InsertExperience";
                obj.getcommand.Parameters.AddWithValue("@ExperienceTranID", data.ExperienceTranID);
                obj.getcommand.Parameters.AddWithValue("@Epromis", data.Epromis);
                obj.getcommand.Parameters.AddWithValue("@Employer", data.Employer);
                obj.getcommand.Parameters.AddWithValue("@JobTitle", data.JobTitle);
                obj.getcommand.Parameters.AddWithValue("@StartMonth", data.StartMonth);
                obj.getcommand.Parameters.AddWithValue("@StartYear", data.StartYear);
                obj.getcommand.Parameters.AddWithValue("@EndMonth", data.EndMonth);
                obj.getcommand.Parameters.AddWithValue("@EndYear", data.EndYear);
                obj.getcommand.Parameters.AddWithValue("@CurrentlyWorkStatus", data.CurrentlyWorkStatus);
                obj.getcommand.Parameters.AddWithValue("@JobDescription", data.JobDescription);
                obj.getcommand.Parameters.Add("@OutPut", SqlDbType.VarChar, 200).Direction = ParameterDirection.Output;
                int Result = obj.getcommand.ExecuteNonQuery();
                if (obj.getcommand.Parameters["@OutPut"].Value != DBNull.Value)
                {
                    Result = Convert.ToInt32(obj.getcommand.Parameters["@OutPut"].Value);
                }
                obj.Closeconnection();
                return Result;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                obj.getcommand.Dispose();
                obj.Closeconnection();
            }
        }
        public int Insert_ExperienceProject(ExperienceProject_BO data)
        {
            try
            {
                obj.Openconnection();
                obj.getcommand.CommandType = CommandType.StoredProcedure;
                obj.getcommand.Parameters.Clear();
                obj.getcommand.CommandText = "USP_Insert_ExperienceProject";
                obj.getcommand.Parameters.AddWithValue("@ExperienceTranID", data.ExperienceTranID);
                obj.getcommand.Parameters.AddWithValue("@ProjectName", data.ProjectName);
                obj.getcommand.Parameters.AddWithValue("@ScopeOfWork", data.ScopeOfWork);
                obj.getcommand.Parameters.AddWithValue("@Client", data.Client);
                obj.getcommand.Parameters.AddWithValue("@ContractPrice", data.ContractPrice);
                obj.getcommand.Parameters.AddWithValue("@Consultant", data.Consultant); 

                int result = obj.getcommand.ExecuteNonQuery();
                obj.Closeconnection();
                return result;
            }
            catch
            {
                throw;
            }
            finally
            {
                obj.getcommand.Dispose();
                obj.Closeconnection();
            }
        }
        public DataTable USP_GetExperienceByTranID(int ExperienceTranID)
        {
            try
            {
                obj.Openconnection();
                obj.getcommand.CommandType = CommandType.StoredProcedure;
                obj.getcommand.Parameters.Clear();
                obj.getcommand.CommandText = "USP_GetExperienceByTranID";
                obj.getcommand.Parameters.AddWithValue("@ExperienceTranID", ExperienceTranID);
                SqlDataAdapter dataAdapter = new SqlDataAdapter();
                DataSet ds = new DataSet();
                dataAdapter.SelectCommand = obj.getcommand;
                dataAdapter.Fill(ds);
                return ds.Tables[0];
            }
            catch
            {
                throw;
            }
            finally
            {
                obj.getcommand.Dispose();
                obj.Closeconnection();
            }
        }
        public DataTable GetExperienceProjectData(int ExperienceTranID)
        {
            try
            {
                obj.Openconnection();
                obj.getcommand.CommandType = CommandType.StoredProcedure;
                obj.getcommand.Parameters.Clear();
                obj.getcommand.CommandText = "USP_GetExperienceProjectData";
                obj.getcommand.Parameters.AddWithValue("@ExperienceTranID", ExperienceTranID);
                SqlDataAdapter dataAdapter = new SqlDataAdapter();
                DataSet ds = new DataSet();
                dataAdapter.SelectCommand = obj.getcommand;
                dataAdapter.Fill(ds);
                return ds.Tables[0];
            }
            catch
            {
                throw;
            }
            finally
            {
                obj.getcommand.Dispose();
                obj.Closeconnection();
            }
        }
        public int DeleteExperienceData( int ExperienceTranID)
        {
            try
            {
                obj.Openconnection();
                obj.getcommand.CommandType = CommandType.StoredProcedure;
                obj.getcommand.Parameters.Clear();
                obj.getcommand.CommandText = "USP_DeleteExperienceData";
                obj.getcommand.Parameters.AddWithValue("@ExperienceTranID", ExperienceTranID);
                int result = obj.getcommand.ExecuteNonQuery();
                obj.Closeconnection();
                return result;
            }
            catch
            {
                throw;
            }
            finally
            {
                obj.getcommand.Dispose();
                obj.Closeconnection();
            }
        }

        public int DeleteExperience_ProjectData(int ProjectTranID)
        {
            try
            {
                obj.Openconnection();
                obj.getcommand.CommandType = CommandType.StoredProcedure;
                obj.getcommand.Parameters.Clear();
                obj.getcommand.CommandText = "USP_DeleteExperience_ProjectData";
                obj.getcommand.Parameters.AddWithValue("@ProjectTranID", ProjectTranID);
                int result = obj.getcommand.ExecuteNonQuery();
                obj.Closeconnection();
                return result;
            }
            catch
            {
                throw;
            }
            finally
            {
                obj.getcommand.Dispose();
                obj.Closeconnection();
            }
        }
        public int BulkUpdate_ExperienceProjects(DataTable dt_Projects,int ExperienceTranID)
        {
            try
            {
                obj.Openconnection();
                obj.getcommand.CommandType = CommandType.StoredProcedure;
                obj.getcommand.Parameters.Clear();
                obj.getcommand.CommandText = "USP_BulkUpdate_ExperienceProjects";
                obj.getcommand.Parameters.AddWithValue("@dt_Projects", dt_Projects);
                obj.getcommand.Parameters.AddWithValue("@ExperienceTranID", ExperienceTranID);
                int result = obj.getcommand.ExecuteNonQuery();
                obj.Closeconnection();
                return result;
            }
            catch
            {
                throw;
            }
            finally
            {
                obj.getcommand.Dispose();
                obj.Closeconnection();
            }
        }
        public DataTable GetExistingProjectsDeatils(string ProjectName)
        {
            try
            {
                obj.Openconnection();
                obj.getcommand.CommandType = CommandType.StoredProcedure;
                obj.getcommand.Parameters.Clear();
                obj.getcommand.CommandText = "USP_GetExistingProjectsDeatils";
                obj.getcommand.Parameters.AddWithValue("@ProjectName", ProjectName);
                SqlDataAdapter dataAdapter = new SqlDataAdapter();
                DataSet ds = new DataSet();
                dataAdapter.SelectCommand = obj.getcommand;
                dataAdapter.Fill(ds);
                return ds.Tables[0];
            }
            catch
            {
                throw;
            }
            finally
            {
                obj.getcommand.Dispose();
                obj.Closeconnection();
            }
        }
        public DataTable GetAllCV_Data()
        {
            try
            {
                obj.Openconnection();
                obj.getcommand.CommandType = CommandType.StoredProcedure;
                obj.getcommand.Parameters.Clear();
                obj.getcommand.CommandText = "USP_GetAllCV_Data";
                SqlDataAdapter dataAdapter = new SqlDataAdapter();
                DataSet ds = new DataSet();
                dataAdapter.SelectCommand = obj.getcommand;
                dataAdapter.Fill(ds);
                return ds.Tables[0];
            }
            catch
            {
                throw;
            }
            finally
            {
                obj.getcommand.Dispose();
                obj.Closeconnection();
            }
        }
    }
}