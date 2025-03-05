using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CV_ManagementSystem.App_Code.BO
{
    public class CV_BO
    {
        public int CV_TranID { get; set; }
        public string Epromis { get; set; }
        public string EmployeeName { get; set; }
        public string CurrentPosition { get; set; }
        public string Tel_No { get; set; }
        public string Fax_No { get; set; }
        public string PO_Box { get; set; }
        public string Qualification { get; set; }
        public string Nationality { get; set; }
        public string Languages { get; set; }
        public string EntryBy { get; set; }
    }
}