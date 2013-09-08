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
    public class LoginController : Controller
    {
        //
        // GET: /Login/
        private TaskManagementEntities db = new TaskManagementEntities();

        public ActionResult Index()
        {
                return View();
        }

        [HttpPost]
        public ActionResult Index(Project project)
        {
            var Username = Request.Form.GetValues("Username").First();
            var Password = Request.Form.GetValues("Password").First();
            if (db.Admins.Any(it => it.Username == Username && it.Password == Password))
            {
                HttpContext.Session["Username"] = "Admin";
                return RedirectToAction("Index", "Admin");
            }
            else
            {
                if (db.Personels.Any(it => it.Username == Username && it.Password == Password))
                {
                    var user = db.Personels.First(it => it.Username == Username);
                    if (user.IsActive == 1)
                    {
                        HttpContext.Session["Username"] = Username;
                        HttpContext.Session["Id"] = user.PersonnelID.ToString();
                        return RedirectToAction("Index", "ProjectManager");
                    }
                    else
                    {
                        HttpContext.Session["Username"] = "Active";
                        HttpContext.Session["Id"] = user.PersonnelID.ToString();
                        return RedirectToAction("Active");
                    } 


                    
                }
            }
            return View();
        }

        public ActionResult Active()
        {
            return View();
        }

        [HttpPost]
        public ActionResult ActiveConfirmed()
        {
            var id = Int32.Parse(HttpContext.Session["Id"].ToString());
            var Password = Request.Form.GetValues("Password").First();
            var user = db.Personels.First(it => it.PersonnelID == id);
            if (HttpContext.Session["Username"].ToString() == "Active")
            {
                if (Password != user.Password)
                {
                    user.Password = Password;
                    user.IsActive = 1;
                    db.SaveChanges();
                    return RedirectToAction("Index", "ProjectManager");
                }
                else
                {
                    ViewBag.Alert = "กรุณาเปลี่ยนรหัสผ่านใหม่";
                    return RedirectToAction("Active");
                }
            }
            return View();
        }
    }
}
