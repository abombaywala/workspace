using System;
using System.Collections.Concurrent;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
//comment
namespace HelloWorld
{
    class Program
    {
        static void Main(string[] args)
        {
            //int [] userAge = {10,11,12,13,14};
            Console.WriteLine("Hello World!");
            //Console.WriteLine(userAge[2]);
            //string userInput = Console.ReadLine();
            //Console.WriteLine(userInput);
            string userName = "";
            int userAge = 0;
            int currentYear = 0;
            Console.Write("Please enter your name: ");
            userName = Console.ReadLine();
            Console.Write("Please enter your age: ");
            userAge = Convert.ToInt32(Console.ReadLine());
            Console.Write("Please enter the current year: ");
            currentYear = Convert.ToInt32(Console.ReadLine());
            Console.WriteLine("Hello World! My name is {0} and I am {1} years old. I was born in {2}.", userName, userAge, currentYear - userAge);

        }
    }
}