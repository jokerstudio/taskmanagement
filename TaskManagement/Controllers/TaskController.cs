using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using TaskManagement.Models;

namespace TaskManagement.Controllers
{
    [PJManagerFilter]
    public class TaskController : Controller
    {
        private TaskManagementEntities db = new TaskManagementEntities();

        //
        // GET: /Task/

        public ActionResult Index(int id)
        {
            var repository = new ModelRepository();
            repository.TaskList = db.Tasks.Include(t => t.Personel).Include(t => t.Project).Where(it => it.ProjectID == id).ToList();
            repository.Project = db.Projects.Find(id);
            var task = db.Tasks.Where(it => it.ProjectID == id);
            repository.WorkDayList = db.WorkDays.ToList();
            foreach (var item in task)
            {
                if (item.Status != "Success")
                {
                    foreach (var time in db.WorkDays.Where(it => it.TaskID == item.TaskID).ToList())
                    {
                        if (time.Date == DateTime.Now.Date)
                        {
                            item.Status = "Running";
                            db.Tasks.Find(item.TaskID).Status = "Running";
                        }
                        else item.Status = "Standby";
                    }
                }
            }
            db.SaveChanges();
            return View(repository);
        }

        //
        // GET: /Task/Details/5

        public ActionResult Details(int id = 0)
        {
            Task task = db.Tasks.Find(id);
            if (task == null)
            {
                return HttpNotFound();
            }
            return View(task);
        }

        //
        // GET: /Task/Create

        public ActionResult Create(int id)
        {
            var list = new List<Personel>();
            foreach (var item in db.Projects.Find(id).Personels.ToList())
            {
                var count = item.Tasks.Count();
                double totaltask = count / 2;
                var successtask = item.Tasks.Where(it => it.Status == "Success").Count();
               
                    if (successtask >= totaltask)
                    {
                        list.Add(item);
                    }
            }

            ViewBag.PersonelID = new SelectList(list.ToList(), "PersonnelID", "Name", db.Projects.Find(id).Personels.First().PersonnelID);
            ViewBag.ProjectID = new SelectList(db.Projects, "ProjectID", "Name");
            
            var repository = new ModelRepository();
            repository.Project = db.Projects.Find(id);
            return View(repository);
        }

        //
        // POST: /Task/Create

        [HttpPost]
        public ActionResult Create(ModelRepository repository)
        {
            Task task = repository.Task;
            task.ProjectID = repository.Project.ProjectID;
            task.PersonelID = Int32.Parse(Request.Form.GetValues("PersonelID").FirstOrDefault().ToString());
            task.Status = "Standby";
            if (ModelState.IsValid)
            {
                db.Tasks.Add(task);
                var day = Request.Form.GetValues("date[]").ToList();
                foreach (var item in day)
                {
                    if(item != string.Empty)
                    {
                        int check = 0;
                        var workday = new WorkDay();
                        var datetime = DateTime.Parse(item);
                        if (day.Where(it => it == item).Count() > 1) check++;
                        if (db.WorkDays.Any(it => it.Date == datetime && it.PersonelID == task.PersonelID))
                        {
                            check++;
                        }
                        if (check == 0)
                        {
                            workday.TaskID = task.TaskID;
                            workday.Date = DateTime.Parse(item);
                            workday.PersonelID = task.PersonelID;
                            db.Tasks.Find(task.TaskID).WorkDays.Add(workday);
                            db.SaveChanges();
                        }
                        else
                        {
                            ViewBag.alert = "เวลาซ้ำกัน";
                            return RedirectToAction("Create", new { id = repository.Project.ProjectID }); 
                        }
                    }
                }
                
                return RedirectToAction("Index", new {id = repository.Project.ProjectID });
            }

            ViewBag.PersonelID = new SelectList(db.Projects.Find(repository.Project.ProjectID).Personels.ToList(), "PersonnelID", "Name", db.Projects.Find(repository.Project.ProjectID).Personels.First().PersonnelID);
            ViewBag.ProjectID = new SelectList(db.Projects, "ProjectID", "Name", task.ProjectID);
            return View(task);
        }

        //
        // GET: /Task/Edit/5
        public struct status
        {
            public string val;
            public string text;
        }

        public ActionResult Edit(int taskid = 0, int projectid = 0)
        {
            var repository = new ModelRepository();
            Task task = db.Tasks.Find(taskid);
            repository.Task = task;
            repository.Project = db.Projects.Find(projectid);
            repository.Task.WorkDays = db.WorkDays.Where(it => it.TaskID == task.TaskID).ToList();
            if (task == null)
            {
                return HttpNotFound();
            }
            IEnumerable<status> statuslist = new List<status>(){
                new status(){val = "Runing",text = "Runing"},
                new status(){val = "Success",text = "Success"}
            };
            ViewBag.Status = new SelectList(new[] { "Running", "Success", "Standby" }
                .Select(x => new { value = x, text = x }),
                "value", "text", task.Status);
            ViewBag.PersonelID = new SelectList(db.Projects.First(it => it.ProjectID == projectid).Personels.ToList(), "PersonnelID", "Name", task.PersonelID);
            ViewBag.ProjectID = new SelectList(db.Projects, "ProjectID", "Name", task.ProjectID);
            return View(repository);
        }

        //
        // POST: /Task/Edit/5

        [HttpPost]
        public ActionResult Edit(ModelRepository repository)
        {
            Task task = repository.Task;
            task.ProjectID = repository.Project.ProjectID;
            task.PersonelID = Int32.Parse(Request.Form.GetValues("PersonelID").FirstOrDefault().ToString());
            task.Status = Request.Form.GetValues("Status").FirstOrDefault().ToString();
            var day = Request.Form.GetValues("date[]").ToList();
            if (ModelState.IsValid)
            {
                db.Entry(task).State = EntityState.Modified;
                db.SaveChanges();
            }
            var allworkday = db.WorkDays.Where(it => it.TaskID == task.TaskID && it.PersonelID == task.PersonelID).ToList();
            foreach (var wd in allworkday)
            {
                db.WorkDays.Remove(db.WorkDays.First(it => it.TaskID == task.TaskID && it.PersonelID == task.PersonelID));
                db.SaveChanges();
            }
            if(day != null)
            {
                foreach (var item in day)
                {
                    if (item != string.Empty)
                    {
                        int check = 0;
                        var workday = new WorkDay();
                        var datetime = DateTime.Parse(item);
                        if (day.Where(it => it == item).Count() > 1) check++;
                        if (db.WorkDays.Any(it => it.Date == datetime && it.PersonelID == task.PersonelID))
                        {
                            check++;
                        }
                        if (check == 0)
                        {
                            workday.PersonelID = task.PersonelID;
                            workday.TaskID = task.TaskID;
                            workday.Date = DateTime.Parse(item);
                            db.Tasks.Find(task.TaskID).WorkDays.Add(workday);
                            db.SaveChanges();
                        }
                        else
                        {
                            ViewBag.alert = "เวลาซ้ำกัน";
                            return RedirectToAction("Edit", new { id = repository.Project.ProjectID });
                        }
                    }
                }
                return RedirectToAction("Index", new { id = task.ProjectID });
            }
            
            ViewBag.PersonelID = new SelectList(db.Personels, "PersonnelID", "Name", task.PersonelID);
            ViewBag.ProjectID = new SelectList(db.Projects, "ProjectID", "Name", task.ProjectID);
            return View(task);
        }

        //
        // GET: /Task/Delete/5

        public ActionResult Delete(int id = 0)
        {
            Task task = db.Tasks.Find(id);
            if (task == null)
            {
                return HttpNotFound();
            }
            return View(task);
        }

        //
        // POST: /Task/Delete/5

       
        public ActionResult DeleteConfirmed(int id, int projectid)
        {
            Task task = db.Tasks.Find(id);
            db.Tasks.Remove(task);
            db.SaveChanges();
            return RedirectToAction("Index", new { id = projectid });
        }

        protected override void Dispose(bool disposing)
        {
            db.Dispose();
            base.Dispose(disposing);
        }
    }
}