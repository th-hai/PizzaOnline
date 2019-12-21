using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using PizzaOnline;
using PizzaOnline.Models;
using PagedList;

namespace PizzaOnline.Controllers
{
    public class ProductController : Controller
    {
        private PizzaEntities db = new PizzaEntities();

        // GET: Product
        [Filters.AuthorizeAdmin]
        public ActionResult Index()
        {
            var products = db.Products.Include(p => p.Category);
            return View(products.ToList());
        }

        // GET: Product/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Product product = db.Products.Find(id);
            if (product == null)
            {
                return HttpNotFound();
            }
            return View(product);
        }

        
        public ActionResult List(int? page,int? category)
        {
            var pageNumber = page ?? 1;
            var pageSize = 8;
            if (category != null)
            {
                ViewBag.category = category;
                var products = db.Products.Include(x => x.Category)
                    .OrderBy(x => x.ProductID)
                    .Where(x => x.CategoryID == category)
                    .ToPagedList(pageNumber, pageSize);
                return View(products);
            }
            else
            {
                var products = db.Products.Include(p => p.Category).OrderBy(x => x.ProductID).ToPagedList(pageNumber, pageSize);
                return View(products);
            }
            //var products = db.Products.Include(p => p.Category);
            
        }
        // GET: Product/Create
        [Filters.AuthorizeAdmin]
        public ActionResult Create()
        {
            ViewBag.CategoryID = new SelectList(db.Categories, "CategoryID", "CategoryName");
            ProductViewModel products = new ProductViewModel();
            return View(products);
        }

        // POST: Product/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        [Filters.AuthorizeAdmin]
        public ActionResult Create(ProductViewModel productsViewModel, HttpPostedFileBase ImageFile)
        {
            if (ModelState.IsValid)
            {
                var newProduct = new Product();
                if (ImageFile != null)
                {
                    // create relative path
                    string relativePath = "/ProductsImages/" + DateTime.Now.Ticks.ToString() + "_" + ImageFile.FileName;
                    // map the relative to physical path
                    string physicalPath = Server.MapPath(relativePath);


                    // check if the image folder exists
                    string imageFolder = Path.GetDirectoryName(physicalPath);
                    if (!Directory.Exists(imageFolder))
                    {
                        Directory.CreateDirectory(imageFolder);
                    }

                    // save the image to physical path
                    ImageFile.SaveAs(physicalPath);
                    productsViewModel.ImageURL = relativePath;
                }

                productsViewModel.UpdateProducts(newProduct);
                db.Products.Add(newProduct);
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(productsViewModel);
        }

        // GET: Product/Edit/5
        [Filters.AuthorizeAdmin]
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Product product = db.Products.Find(id);
            if (product == null)
            {
                return HttpNotFound();
            }
            ProductViewModel productViewModel = new ProductViewModel(product);

            ViewBag.CategoryID = new SelectList(db.Categories, "CategoryID", "CategoryName", productViewModel.CategoryID);
            return View(productViewModel);
        }

        // POST: Product/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        [Filters.AuthorizeAdmin]
        public ActionResult Edit(ProductViewModel productsViewModel, HttpPostedFileBase ImageFile)
        {
            if (ModelState.IsValid)
            {
                var newProduct = db.Products.Find(productsViewModel.ProductID);
                if (ImageFile != null)
                {
                    // create relative path
                    string relativePath = "/ProductsImages/" + DateTime.Now.Ticks.ToString() + "_" + ImageFile.FileName;
                    // map the relative to physical path
                    string physicalPath = Server.MapPath(relativePath);


                    // check if the image folder exists
                    string imageFolder = Path.GetDirectoryName(physicalPath);
                    if (!Directory.Exists(imageFolder))
                    {
                        Directory.CreateDirectory(imageFolder);
                    }

                    // save the image to physical path
                    ImageFile.SaveAs(physicalPath);
                    productsViewModel.ImageURL = relativePath;
                }

                productsViewModel.UpdateProducts(newProduct);
                db.Entry(newProduct).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.CategoryID = new SelectList(db.Categories, "CategoryID", "CategoryName", productsViewModel.CategoryID);
            return View(productsViewModel);
        }

        // GET: Product/Delete/5
        [Filters.AuthorizeAdmin]
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Product product = db.Products.Find(id);
            if (product == null)
            {
                return HttpNotFound();
            }
            return View(product);
        }

        // POST: Product/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        [Filters.AuthorizeAdmin]
        public ActionResult DeleteConfirmed(int id)
        {
            Product product = db.Products.Find(id);
            db.Products.Remove(product);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
