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
    public class PositionController : Controller
    {
        private TaskManagementEntities db = new TaskManagementEntities();

        //
        // GET: /Position/

        public ActionResult Index()
        {
            return View(db.Positions.ToList());
        }

        //
        // GET: /Position/Details/5

        public ActionResult Details(int id = 0)
        {
            Position position = db.Positions.Find(id);
            if (position == null)
            {
                return HttpNotFound();
            }
            return View(position);
        }

        //
        // GET: /Position/Create

        public ActionResult Create()
        {
            return View();
        }

        //
        // POST: /Position/Create

        [HttpPost]
        public ActionResult Create(Position position)
        {
            if (ModelState.IsValid)
            {
                db.Positions.Add(position);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(position);
        }

        //
        // GET: /Position/Edit/5

        public ActionResult Edit(int id = 0)
        {
            Position position = db.Positions.Find(id);
            if (position == null)
            {
                return HttpNotFound();
            }
            return View(position);
        }

        //
        // POST: /Position/Edit/5

        [HttpPost]
        public ActionResult Edit(Position position)
        {
            if (ModelState.IsValid)
            {
                db.Entry(position).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(position);
        }

        //
        // GET: /Position/Delete/5

        public ActionResult Delete(int id = 0)
        {
            Position position = db.Positions.Find(id);
            if (position == null)
            {
                return HttpNotFound();
            }
            return View(position);
        }

        //
        // POST: /Position/Delete/5

        public ActionResult DeleteConfirmed(int id)
        {
            Position position = db.Positions.Find(id);
            db.Positions.Remove(position);
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