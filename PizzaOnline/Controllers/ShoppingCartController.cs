using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using PizzaOnline.Models;

namespace PizzaOnline.Controllers
{
    public class ShoppingCartController : Controller
    {
        PizzaEntities db = new PizzaEntities();

        private string strCart = "Cart";
        // GET: ShoppingCart
        public ActionResult Index()
        {
            return View();
        }
        [Filters.AuthorizeCustomer]
        public ActionResult OrderProduct(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }

            if (Session[strCart] == null)
            {
                List<Cart> lsCart = new List<Cart>
                {
                    new Cart(db.Products.Find(id), 1)
                };
                Session[strCart] = lsCart;
            }
            else
            {
                List<Cart> lsCart = (List<Cart>) Session[strCart];
                int check = ExistingCheck(id);
                if (check == -1)
                    lsCart.Add(new Cart(db.Products.Find(id), 1));
                else
                    lsCart[check].Quantity++;
                Session[strCart] = lsCart;
            }
            return View("Index");
        }

        private int ExistingCheck(int? id)
        {
            List<Cart> lstCart = (List<Cart>) Session[strCart];
            for (int i = 0; i < lstCart.Count; i++)
            {
                if (lstCart[i].Product.ProductID == id) return i;
            }
            return -1;
        }

        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            int check = ExistingCheck(id);
            List<Cart> lstCart = (List<Cart>)Session[strCart];
            lstCart.RemoveAt(check);
            return View("Index");
        }
        public ActionResult UpdateCart(FormCollection frc)
        {
            string[] quantities = frc.GetValues("quantity");
            List<Cart> lstCart = (List<Cart>)Session[strCart];
            for (int i = 0; i < lstCart.Count; i++)
            {
                lstCart[i].Quantity = Convert.ToInt32(quantities[i]);
            }

            Session[strCart] = lstCart;
            return View("Index");
        }
        [Filters.AuthorizeCustomer]
        public ActionResult CheckOut()
        {
            return View();
        }
        [Filters.AuthorizeCustomer]
        public ActionResult ProcessCheckout(FormCollection frc)
        {
            List<Cart> lstCart = (List<Cart>) Session[strCart];
            Order order = new Order()
            {
                CustomerID = Int32.Parse(frc["cusID"]),
                Total = Int32.Parse(frc["tTotal"])
            };
            if (ModelState.IsValid)
            {
                db.Orders.Add(order);
                db.SaveChanges();
            }
            

            foreach (Cart cart in lstCart)
            {
                OrderDetail orderDetail = new OrderDetail()
                {
                    OrderID = order.OrderID,
                    ProductID = cart.Product.ProductID,
                    Quantity = cart.Quantity,
                    Price = cart.Product.Price
                };
                db.OrderDetails.Add(orderDetail);
                db.SaveChanges();
            }
            //Remove shopping cart session
            Session.Remove(strCart);
            return View("OrderSuccess");
        }
    }
}