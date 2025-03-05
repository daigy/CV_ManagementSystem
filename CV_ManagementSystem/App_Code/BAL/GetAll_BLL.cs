using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using CV_ManagementSystem.App_Code.DAL;

namespace CV_ManagementSystem.App_Code.BAL
{
    public class GetAll_BLL
    {
        dbConnection obj = new dbConnection();
        public DataTable epromiseLoginValidated(string _EmployeeCode, string _EmployeePassword)
        {
            obj.OpenconnectionFR();
            obj.getcommandFR.CommandType = CommandType.Text;
            obj.getcommandFR.CommandText = "select * from tbl_EmployeeLogin where EmployeeCode = @EmployeeCode and EmployeePassword = @EmployeePassword";
            obj.getcommandFR.Parameters.Clear();
            obj.getcommandFR.Parameters.AddWithValue("@EmployeeCode", _EmployeeCode);
            obj.getcommandFR.Parameters.AddWithValue("@EmployeePassword", _EmployeePassword);
            SqlDataAdapter dataAdapter = new SqlDataAdapter();
            DataSet ds = new DataSet();
            dataAdapter.SelectCommand = obj.getcommandFR;
            dataAdapter.Fill(ds);
            return ds.Tables[0];
        }
        public DataTable Get_epromiseMaster(string _EmployeeCode)
        {
            obj.OpenconnectionFR();
            obj.getcommandFR.CommandType = CommandType.Text;
            obj.getcommandFR.CommandText = "select * from Vw_All_epromiseMaster where EmployeeCode= @EmployeeCode";
            obj.getcommandFR.Parameters.Clear();
            obj.getcommandFR.Parameters.AddWithValue("@EmployeeCode", _EmployeeCode);
            SqlDataAdapter dataAdapter = new SqlDataAdapter();
            DataSet ds = new DataSet();
            dataAdapter.SelectCommand = obj.getcommandFR;
            dataAdapter.Fill(ds);
            return ds.Tables[0];
        }

        public DataTable LoginValidate(string EmployeeCode)
        {
            try
            {
                obj.Openconnection();
                obj.getcommand.CommandType = CommandType.StoredProcedure;
                obj.getcommand.CommandText = "USP_LoginValidate";
                obj.getcommand.Parameters.Clear();
                obj.getcommand.Parameters.AddWithValue("@EmployeeCode", EmployeeCode);
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
        public DataTable GetLoginRole(string EmployeeCode)
        {
            try
            {
                obj.Openconnection();
                obj.getcommand.CommandType = CommandType.StoredProcedure;
                obj.getcommand.CommandText = "USP_GetLoginRole";
                obj.getcommand.Parameters.Clear();
                obj.getcommand.Parameters.AddWithValue("@EmployeeCode", EmployeeCode);
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