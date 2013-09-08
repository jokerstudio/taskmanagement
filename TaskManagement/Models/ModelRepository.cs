using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace TaskManagement.Models
{
    public class ModelRepository
    {
        public Project Project { get; set; }
        public List<Project> ProjectsList { get; set; }
        public ProjectCategory ProjectCategory { get; set; }
        public List<ProjectCategory> ProjectCategoryList { get; set; }
        public Personel Personel { get; set; }
        public List<Personel> PersonelList { get; set; }
        public Position Position { get; set; }
        public List<Position> PositionList { get; set; }
        public Task Task { get; set; }
        public List<Task> TaskList { get; set; }
        public WorkDay WorkDay { get; set; }
        public List<WorkDay> WorkDayList { get; set; }

        public ModelRepository()
        {
            Project = new Project();
            ProjectsList = new List<Project>();
            ProjectCategory = new ProjectCategory();
            ProjectCategoryList = new List<ProjectCategory>();
            Personel = new Personel();
            PersonelList = new List<Personel>();
            Position = new Position();
            PositionList = new List<Position>();
            Task = new Task();
            TaskList = new List<Task>();
            WorkDay = new WorkDay();
            WorkDayList = new List<WorkDay>();
        }
    }    
}