using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;

namespace PizzaOnline.Models
{
    public class UserRegister
    {
        private Customer _customer;

        public UserRegister(Customer customer)
        {
            _customer = customer;
            CustomerID = customer.CustomerID;
            CustomerName = customer.CustomerName;
            Password = customer.Password;
            FullName = customer.FullName;
            Address = customer.Address;
            PhoneNumber = customer.PhoneNumber;

        }

        public void UpdateCustomer(Customer customer)
        {
            customer.CustomerID = CustomerID;
            customer.CustomerName = CustomerName;
            customer.Password = Password;
            customer.FullName = FullName;
            customer.Address = Address;
            customer.PhoneNumber = PhoneNumber;
        }
        public UserRegister()
        { }

        public int CustomerID { get; set; }
        [Required(ErrorMessage = "Customer name is required!")]
        [RegularExpression("^[A-z]+[A-z0-9]+$", ErrorMessage = "User name has to begin with a letter and no space or special character")]
        [DisplayName("Customer Name")]
        public string CustomerName { get; set; }
        [Required(ErrorMessage = "Password is required")]
        [DataType(DataType.Password)]
        public string Password { get; set; }
        [Compare("Password")]
        [DataType(DataType.Password)]
        [DisplayName("Confirm Password")]
        public string ConfirmPassword { get; set; }
        [Required(ErrorMessage = "Full Name is required")]
        [DisplayName("Full Name")]
        public string FullName { get; set; }
        [Required(ErrorMessage = "Address is required")]
        public string Address { get; set; }
        [Required(ErrorMessage = "Phone number is required")]
        [DisplayName("Phone Number")]
        [RegularExpression(@"^(\d{10,11})$", ErrorMessage = "Invalid phone number")]
        public string PhoneNumber { get; set; }

        //[System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        //public virtual ICollection<Order> Orders { get; set; }
    }
}