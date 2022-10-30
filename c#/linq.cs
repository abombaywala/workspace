using System;
using System.Collections.Concurrent;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Collections.Generic;


namespace LINQ
{
    class Customers
    {
        public string name;
        public string phone_no;
        public string address;
        public float balance;
        //constructor
        public Customers(string pname, string pphone_no, string paddress, float pbalance)
        {
            name = pname;
            phone_no = pphone_no;
            address = paddress;
            balance = pbalance;
        }
    }
    class Program
    {
        static void Main(string[] args)
        {
            //Console.WriteLine("Hello World!");
            int[] numbers = { 0, 1, 2, 3, 4, 5, 6 };
            var evenNumQuery =
                from num in numbers
                where (num % 2) == 0
                select num;
            foreach (int i in evenNumQuery)
            {
                Console.WriteLine("{0} is an even number", i);
            }
            List<Customers> customers = new List<Customers>();
            customers.Add(new Customers("Alan", "80911291", "ABC Street", 25.60f));
            customers.Add(new Customers("Bill", "19872131", "DEF Street", -32.1f));
            customers.Add(new Customers("Carl", "29812371", "GHI Street", -12.2f));
            customers.Add(new Customers("David", "78612312", "JKL Street", 12.6f));
            var overdue =
                from cust in customers
                where cust.balance < 0
                orderby cust.balance ascending
                select new { cust.name, cust.balance };
            foreach (var cust in overdue)
                Console.WriteLine("Name = {0}, Balance = {1}", cust.name, cust.balance);
        }
    }
}
