using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web;
using System.Web.Http;

namespace TaskManagement.Models
{
    public class testController : ApiController
    {
        private TaskManagementEntities db = new TaskManagementEntities();

        // GET api/test
        public IEnumerable<Personel> GetPersonels()
        {
            var personels = db.Personels.Include(p => p.Position);
            return personels.AsEnumerable();
        }

        // GET api/test/5
        public Personel GetPersonel(int id)
        {
            Personel personel = db.Personels.Find(id);
            if (personel == null)
            {
                throw new HttpResponseException(Request.CreateResponse(HttpStatusCode.NotFound));
            }

            return personel;
        }

        // PUT api/test/5
        public HttpResponseMessage PutPersonel(int id, Personel personel)
        {
            if (!ModelState.IsValid)
            {
                return Request.CreateErrorResponse(HttpStatusCode.BadRequest, ModelState);
            }

            if (id != personel.PersonnelID)
            {
                return Request.CreateResponse(HttpStatusCode.BadRequest);
            }

            db.Entry(personel).State = EntityState.Modified;

            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateConcurrencyException ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.NotFound, ex);
            }

            return Request.CreateResponse(HttpStatusCode.OK);
        }

        // POST api/test
        public HttpResponseMessage PostPersonel(Personel personel)
        {
            if (ModelState.IsValid)
            {
                db.Personels.Add(personel);
                db.SaveChanges();

                HttpResponseMessage response = Request.CreateResponse(HttpStatusCode.Created, personel);
                response.Headers.Location = new Uri(Url.Link("DefaultApi", new { id = personel.PersonnelID }));
                return response;
            }
            else
            {
                return Request.CreateErrorResponse(HttpStatusCode.BadRequest, ModelState);
            }
        }

        // DELETE api/test/5
        public HttpResponseMessage DeletePersonel(int id)
        {
            Personel personel = db.Personels.Find(id);
            if (personel == null)
            {
                return Request.CreateResponse(HttpStatusCode.NotFound);
            }

            db.Personels.Remove(personel);

            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateConcurrencyException ex)
            {
                return Request.CreateErrorResponse(HttpStatusCode.NotFound, ex);
            }

            return Request.CreateResponse(HttpStatusCode.OK, personel);
        }

        protected override void Dispose(bool disposing)
        {
            db.Dispose();
            base.Dispose(disposing);
        }
    }
}