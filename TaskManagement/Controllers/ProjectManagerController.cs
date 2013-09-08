using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using TaskManagement.Models;
using System.Web.SessionState;

namespace TaskManagement.Controllers
{
    [PJManagerFilter]
    public class ProjectManagerController : Controller
    {
        //
        // GET: /ProjectManager/
        private TaskManagementEntities db = new TaskManagementEntities();
        public ActionResult Index()
        {
            int Id = 0;
            if (HttpContext.Session["Id"] != null)
            {
                Id = Int32.Parse(HttpContext.Session["Id"].ToString());
            }
            var projectlist = db.Projects.Where(it => it.ProjectManagerID == Id);

            return View(projectlist.ToList());
        }

        public ActionResult ProjectDetail(int id)
        {
            var repository = new ModelRepository();
            var project = db.Projects.FirstOrDefault(it => it.ProjectID == id).Personels.ToList();
            var list = new List<Personel>();
            foreach (var item in db.Personels.Where(it => it.PositionID != 3).ToList())
            {
                var count = item.Tasks.Count();
                double totaltask = count / 2;
                var successtask = item.Tasks.Where(it => it.Status == "Success").Count();
                if (!(project.Any(it => it.PersonnelID == item.PersonnelID)))
                {
                    if (successtask >= totaltask)
                    {
                        list.Add(item);
                    }
                }
            }
            ViewBag.PersonnelID = new SelectList(list, "PersonnelID", "Name");
            repository.Project = db.Projects.FirstOrDefault(it => it.ProjectID == id);
            repository.PersonelList = db.Personels.ToList();
            repository.ProjectCategoryList = db.ProjectCategories.ToList();
            return View(repository);
        }

        [HttpPost]
        public ActionResult Addtoteam(ModelRepository repository)
        {
            
            var user = Int32.Parse(Request.Form.GetValues("PersonnelID").First().ToString());

            db.Projects.First(it => it.ProjectID == repository.Project.ProjectID).Personels.Add(db.Personels.First(it => it.PersonnelID == user));
            db.SaveChanges();
            return RedirectToAction("ProjectDetail", new {id = repository.Project.ProjectID });
        }

        public ActionResult DeleteConfirmed(int personelid, int projectid)
        {
            Personel personel = db.Personels.Find(personelid);
            db.Projects.FirstOrDefault(it => it.ProjectID == projectid).Personels.Remove(personel);
            db.SaveChanges();
            return RedirectToAction("ProjectDetail", new { id = projectid });
        }

        public ActionResult Logout()
        {
            HttpContext.Session.RemoveAll();
            return RedirectToAction("Index", "Login");
        }

       

        

    }
}
