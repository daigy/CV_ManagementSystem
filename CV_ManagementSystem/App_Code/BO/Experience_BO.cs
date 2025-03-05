using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CV_ManagementSystem.App_Code.BO
{
    public class Experience_BO
    {
        public int ExperienceTranID { get; set; } 
        public string Epromis { get; set; }
        public string Employer { get; set; }
        public string JobTitle { get; set; }
        public int StartMonth { get; set; }
        public int StartYear { get; set; }
        public int EndMonth { get; set; }
        public int EndYear { get; set; }
        public bool CurrentlyWorkStatus { get; set; }
        public string JobDescription { get; set; }

    }
}