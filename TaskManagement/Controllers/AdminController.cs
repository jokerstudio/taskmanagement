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
    [AdminFilter]
    public class AdminController : Controller
    {
        private TaskManagementEntities db = new TaskManagementEntities();

        //
        // GET: /Admin/
        public ActionResult Index()
        {
            var projects = db.Projects.Include(p => p.ProjectCategory);
            var repository = new ModelRepository();
            repository.ProjectsList = projects.ToList();
            repository.PersonelList = db.Personels.ToList();
            return View(repository);
        }

        //
        // GET: /Admin/Details/5

        public ActionResult Details(int id = 0)
        {
            Project project = db.Projects.Find(id);
            if (project == null)
            {
                return HttpNotFound();
            }
            return View(project);
        }

        //
        // GET: /Admin/Create

        public ActionResult Create()
        {

            ViewBag.ProjectManagerID = new SelectList(db.Personels.Where(it => it.PositionID == 3).ToList(), "PersonnelID", "Name");
            ViewBag.CategoryId = new SelectList(db.ProjectCategories, "ProjectCategoryID", "CategoryName");
            
            return View();
        }

        //
        // POST: /Admin/Create

        [HttpPost]
        public ActionResult Create(Project project)
        {
            if (ModelState.IsValid)
            {
                db.Projects.Add(project);
                db.SaveChanges();
                
                return RedirectToAction("Index");
            }
            ViewBag.ProjectManagerID = new SelectList(db.Personels, "PersonnelID", "Name", db.Personels.ToList().First(it => it.PersonnelID == project.ProjectManagerID).PersonnelID);
            ViewBag.CategoryId = new SelectList(db.ProjectCategories, "ProjectCategoryID", "CategoryName", project.CategoryId);
            

            return View();
        }

        //
        // GET: /Admin/Edit/5

        public ActionResult Edit(int id = 0)
        {
            var Project = db.Projects.Find(id);
            if (Project == null)
            {
                return HttpNotFound();
            }
            ViewBag.ProjectManagerID = new SelectList(db.Personels.Where(it => it.PositionID == 3).ToList(), "PersonnelID", "Name", db.Personels.ToList().First(it => it.PersonnelID == Project.ProjectManagerID).PersonnelID);
            ViewBag.CategoryId = new SelectList(db.ProjectCategories, "ProjectCategoryID", "CategoryName", Project.CategoryId);
            return View(Project);
        }

        //
        // POST: /Admin/Edit/5

        [HttpPost]
        public ActionResult Edit(Project project)
        {
            if (ModelState.IsValid)
            {
                db.Entry(project).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.ProjectManagerID = new SelectList(db.Personels, "PersonnelID", "FirstName", db.Personels.ToList().First(it => it.PersonnelID == project.ProjectManagerID).PersonnelID);
            ViewBag.CategoryId = new SelectList(db.ProjectCategories, "ProjectCategoryID", "CategoryName", project.CategoryId);
            return View(project);
        }

        //
        // GET: /Admin/Delete/5

        public ActionResult Delete(int id = 0)
        {
            Project project = db.Projects.Find(id);
            if (project == null)
            {
                return HttpNotFound();
            }
            return View(project);
        }

        //
        // POST: /Admin/Delete/5

       
        public ActionResult DeleteConfirmed(int id)
        {
            Project project = db.Projects.Find(id);
            db.Projects.Remove(project);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            db.Dispose();
            base.Dispose(disposing);
        }
        public ActionResult Logout()
        {
            HttpContext.Session.RemoveAll();
            return RedirectToAction("Index","Login");
        }
    }
}