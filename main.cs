using System.Reflection;

namespace AOC
{
    class Run {
        static void Main () {
            Console.WriteLine("What year? (blank for 22)");
            string year = Console.ReadLine()!;
            try {
                int.Parse(year);
            }
            catch {
                year = "22";
            }
            Console.WriteLine("What day? (blank for 1)");
            string day = Console.ReadLine()!;
            try {
                int.Parse(day);
            }
            catch {
                day = "1";
            }
            day = day.PadLeft(2, '0');
            day = day.Substring(day.Length - 2);
            string className = "Year" + year + ".Day" + day + ".Challenge";
            className = className.Trim();
            // You have to add ! at the end to make it null forgiving since it'll never be null if used right.
            Type type = Type.GetType(className)!;
            MethodInfo method = type.GetMethod("Day" + day)!;
            method.Invoke(null, null);
        }
    }
}