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
    [AdminFilter]
    public class ProjectCategoryController : Controller
    {
        private TaskManagementEntities db = new TaskManagementEntities();

        //
        // GET: /ProjectCategory/

        public ActionResult Index()
        {
            return View(db.ProjectCategories.ToList());
        }

        //
        // GET: /ProjectCategory/Details/5

        public ActionResult Details(int id = 0)
        {
            ProjectCategory projectcategory = db.ProjectCategories.Find(id);
            if (projectcategory == null)
            {
                return HttpNotFound();
            }
            return View(projectcategory);
        }

        //
        // GET: /ProjectCategory/Create

        public ActionResult Create()
        {
            return View();
        }

        //
        // POST: /ProjectCategory/Create

        [HttpPost]
        public ActionResult Create(ProjectCategory projectcategory)
        {
            if (ModelState.IsValid)
            {
                db.ProjectCategories.Add(projectcategory);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(projectcategory);
        }

        //
        // GET: /ProjectCategory/Edit/5

        public ActionResult Edit(int id = 0)
        {
            ProjectCategory projectcategory = db.ProjectCategories.Find(id);
            if (projectcategory == null)
            {
                return HttpNotFound();
            }
            return View(projectcategory);
        }

        //
        // POST: /ProjectCategory/Edit/5

        [HttpPost]
        public ActionResult Edit(ProjectCategory projectcategory)
        {
            if (ModelState.IsValid)
            {
                db.Entry(projectcategory).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(projectcategory);
        }

        //
        // GET: /ProjectCategory/Delete/5

        public ActionResult Delete(int id = 0)
        {
            ProjectCategory projectcategory = db.ProjectCategories.Find(id);
            if (projectcategory == null)
            {
                return HttpNotFound();
            }
            return View(projectcategory);
        }

        //
        // POST: /ProjectCategory/Delete/5

        public ActionResult DeleteConfirmed(int id)
        {
            ProjectCategory projectcategory = db.ProjectCategories.Find(id);
            db.ProjectCategories.Remove(projectcategory);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            db.Dispose();
            base.Dispose(disposing);
        }
    }
}