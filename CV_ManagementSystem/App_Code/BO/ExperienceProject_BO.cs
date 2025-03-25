using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CV_ManagementSystem.App_Code.BO
{
    public class ExperienceProject_BO
    {
        public int ExperienceTranID { get; set; }
        public string ProjectName { get; set; }
        public string ScopeOfWork { get; set; }
        public string Client { get; set; }
        public string ContractPrice { get; set; }
        public string Consultant { get; set; }
        public string Position { get; set; }
        public string Description { get; set; }
    }
}