//------------------------------------------------------------------------------
// <auto-generated>
//    This code was generated from a template.
//
//    Manual changes to this file may cause unexpected behavior in your application.
//    Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace TaskManagement.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class ProjectCategory
    {
        public ProjectCategory()
        {
            this.Projects = new HashSet<Project>();
        }
    
        public int ProjectCategoryID { get; set; }
        public string CategoryName { get; set; }
        public string Description { get; set; }
    
        public virtual ICollection<Project> Projects { get; set; }
    }
}
