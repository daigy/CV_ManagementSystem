using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;

namespace CV_ManagementSystem.App_Code.DAL
{
    public class dbConnection
    {
        SqlConnection con;
        SqlCommand cmd;

        SqlConnection con_Fr;
        SqlCommand cmd_Fr;

        string Cost = ConfigurationManager.ConnectionStrings["MyConnectionString"].ConnectionString;
        string fr = ConfigurationManager.ConnectionStrings["frConnectionString"].ConnectionString;

        private SqlDataAdapter da;
        private DataTable dt;
        private SqlDataReader dr;

        public dbConnection()
        {
            con = new SqlConnection(Cost);
            cmd = new SqlCommand();
            cmd.Connection = con;

            con_Fr = new SqlConnection(fr);
            cmd_Fr = new SqlCommand();
            cmd_Fr.Connection = con_Fr;
        }
        #region CV_Management_Command
        public bool Openconnection()
        {
            try
            {
                if (con.State == ConnectionState.Open)
                {
                    con.Close();
                }
                con.Open();
                return true;
            }
            catch (Exception ex)
            {
                System.Threading.Thread.Sleep(1000);
                SqlConnection.ClearAllPools();
                return false;
            }
        }
        public void Refreshconn()
        {
            if (con.State.Equals(System.Data.ConnectionState.Open))
            {
                con.Close();
                SqlConnection.ClearAllPools();
            }

            con.Open();
        }
        public SqlCommand getcommand
        {
            get { return cmd; }
        }
        public DataTable getdata(SqlCommand cmd)
        {
            try
            {
                // if (con.State == ConnectionState.Closed) { con.Open(); }
                con.Open();
                cmd.Connection = con;
                da = new SqlDataAdapter(cmd);
                dt = new DataTable();
                da.Fill(dt);
            }
            catch
            {
            }
            finally
            {
                con.Close();
            }
            return dt;
        }
        public void Closeconnection()
        {
            if (con.State == ConnectionState.Open)
            {
                con.Close();
            }
        }
        #endregion

        #region Farouq

        public bool OpenconnectionFR()
        {
            try
            {
                if (con_Fr.State == ConnectionState.Open)
                {
                    con_Fr.Close();
                }
                con_Fr.Open();
                return true;
            }
            catch (Exception ex)
            {
                System.Threading.Thread.Sleep(1000);
                SqlConnection.ClearAllPools();
                return false;
            }
        }
        public void RefreshconnFR()
        {
            if (con_Fr.State.Equals(System.Data.ConnectionState.Open))
            {
                con_Fr.Close();
                SqlConnection.ClearAllPools();
            }

            con.Open();
        }
        public SqlCommand getcommandFR
        {
            get { return cmd_Fr; }
        }
        public DataTable getdataFr(SqlCommand cmd)
        {
            try
            {
                // if (con.State == ConnectionState.Closed) { con.Open(); }
                con_Fr.Open();
                cmd_Fr.Connection = con_Fr;
                da = new SqlDataAdapter(cmd);
                dt = new DataTable();
                da.Fill(dt);
            }
            catch
            {
            }
            finally
            {
                con_Fr.Close();
            }
            return dt;
        }
        public void CloseconnectionFR()
        {
            if (con_Fr.State == ConnectionState.Open)
            {
                con_Fr.Close();
            }
        }
        #endregion
    }
}