using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using TaskManagement.Models;

namespace TaskManagement.Controllers
{
    public class ProjectMngReportController : Controller
    {
        TaskManagementEntities db = new TaskManagementEntities();
        //
        // GET: /ProjectMngReport/
        [PJManagerFilter]
        public ActionResult Index()
        {
            ModelRepository repository = new ModelRepository();
            repository.PersonelList = db.Personels.Where(it => it.PositionID != 3).ToList();
            repository.TaskList = db.Tasks.ToList();
            return View(repository);
        }

    }
}
