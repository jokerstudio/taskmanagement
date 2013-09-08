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
    
    public partial class Project
    {
        public Project()
        {
            this.Tasks = new HashSet<Task>();
            this.Personels = new HashSet<Personel>();
        }
    
        public int ProjectID { get; set; }
        public string Name { get; set; }
        public Nullable<int> ProjectManagerID { get; set; }
        public Nullable<int> CategoryId { get; set; }
        public Nullable<DateTime> DateofCreate { get; set; }
        public string Description { get; set; }
        public Nullable<int> Status { get; set; }
    
        public virtual ProjectCategory ProjectCategory { get; set; }
        public virtual ICollection<Task> Tasks { get; set; }
        public virtual ICollection<Personel> Personels { get; set; }
    }
}