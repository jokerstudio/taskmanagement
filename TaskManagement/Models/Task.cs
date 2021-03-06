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
    
    public partial class Task
    {
        public Task()
        {
            this.WorkDays = new HashSet<WorkDay>();
        }
    
        public int TaskID { get; set; }
        public string TaskName { get; set; }
        public string Description { get; set; }
        public Nullable<int> PersonelID { get; set; }
        public Nullable<int> Priority { get; set; }
        public string Status { get; set; }
        public Nullable<int> ProjectID { get; set; }
    
        public virtual Personel Personel { get; set; }
        public virtual Project Project { get; set; }
        public virtual ICollection<WorkDay> WorkDays { get; set; }
    }
}
