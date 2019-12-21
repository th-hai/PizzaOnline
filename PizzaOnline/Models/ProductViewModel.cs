using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Mvc;

namespace PizzaOnline.Models
{
    public class ProductViewModel
    {
        private Product _product;

        public ProductViewModel(Product products)
        {
            _product = products;
            ProductID = products.ProductID;
            ProductName = products.ProductName;
            Description = Regex.Replace(products.Description, @"<[^>]*>", String.Empty); 
            CategoryID = products.CategoryID;
            Price = products.Price;
            ImageURL = products.ImageURL;
            
        }

        public void UpdateProducts(Product product)
        {
            product.ProductID = ProductID;
            product.ProductName = ProductName;
            product.Description = Regex.Replace(Description, @"<[^>]*>", String.Empty); 
            product.CategoryID = CategoryID;
            product.Price = Price;
            product.ImageURL = ImageURL;
        }
        public ProductViewModel()
        { }
        [Required]
        public int ProductID { get; set; }
        [DisplayName("Product Name")]
        public string ProductName { get; set; }
        
        [AllowHtml]
        public string Description { get; set; }
        public int CategoryID { get; set; }
        public int Price { get; set; }
        public string ImageURL { get; set; }
        //public virtual ICollection<Category> Categories { get; set; }
        //public List<int> CategoryID { get; set; }
    }
}