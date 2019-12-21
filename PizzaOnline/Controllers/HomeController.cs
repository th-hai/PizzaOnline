using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.Mvc;
using PizzaOnline.Models;

namespace PizzaOnline.Controllers
{
    public class HomeController : Controller
    {
        private PizzaEntities db = new PizzaEntities();

        public ActionResult Index()
        {
            return View();
        }

        public ActionResult About()
        {
            ViewBag.Message = "Your application description page.";

            return View();
        }

        public ActionResult Contact()
        {
            ViewBag.Message = "Your contact page.";

            return View();
        }
        public ActionResult Login()
        {
            return View("Login");
        }
       
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Login(UserLogin userModelView)
        {
            if (ModelState.IsValid)
            {
                if (!string.IsNullOrEmpty(userModelView.UserName)
                    && !string.IsNullOrEmpty(userModelView.Password))
                {
                    //string password = EncMD5(userModelView.Password.Trim());

                    var customer = db.Customers.FirstOrDefault(u => u.CustomerName == userModelView.UserName.Trim() && u.Password == userModelView.Password.Trim());
                    var admin = db.Admins.FirstOrDefault(u =>
                        u.AdminName == userModelView.UserName.Trim() && u.Password == userModelView.Password.Trim());
                    if (customer != null)
                    {
                        Session["CustomerID"] = customer.CustomerID;
                        Session["AdminID"] = null;
                        return RedirectToAction("List", "Product");
                    }
                    else if (admin != null)
                    {
                        Session["AdminID"] = admin.AdminID;
                        Session["CustomerID"] = null;
                        return RedirectToAction("Index", "Product");
                    }
                    else
                    {
                        ViewBag.ErrorMessage = "User name or password is incorrect";
                    }

                }
                else
                {
                    ViewBag.ErrorMessage = "User name or password is empty";
                }

            }
            return View(userModelView);
        }

        public ActionResult Logout()
        {
            Session["CustomerID"] = null;
            Session["AdminID"] = null;
            return View("Index");
        }
        [HttpGet]
        public ActionResult Register()
        {
            UserRegister customerModel = new UserRegister();
            return View(customerModel);
        }

        [HttpPost]
        public ActionResult Register(UserRegister customerModel)
        {
            if(ModelState.IsValid)
            {
                Customer cus = new Customer();
                if (db.Customers.Any(x => x.CustomerName == customerModel.CustomerName) || db.Admins.Any(x => x.AdminName == customerModel.CustomerName))
                {
                    ViewBag.DuplicateMessage = "Customer name is already exist. Please choose another name";
                    return View("Register", customerModel);
                }
                customerModel.UpdateCustomer(cus);
                db.Customers.Add(cus);
                db.SaveChanges();
                ModelState.Clear();
                ViewBag.SuccessMessage = "Registration successfully";
            }
            return View("Register", new UserRegister());
        }
    }
}