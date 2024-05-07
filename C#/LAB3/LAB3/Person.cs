using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace LAB3
{
    public class Person
    {
        /*Gör en klass där användaren fyller i egenskaper för en person.
                    * Födelsedag(YYYY: MM:DD)
                    * Kön
                    * Hårfärg
                    * Hårlängd
                    * Ögonfärg
                    * Namn 
                    * Personerna ska sparas i en Array eller lista 
                    * Användaren ska kunna välja om den vill lägga till fler personer*/


        private string name;
        public string gender;
        private DateTime birthDay;
        public string eyeColor;




        public struct Hair
        {
            public string hairColor;
            public int hairLength;
        }
        Hair hairFeatures;

        public void HairFeatures()
        {
            Console.WriteLine("Vilken hårfärg har personen?");
            hairFeatures.hairColor = Console.ReadLine();
            Console.WriteLine("Hur långt är personens hår? Ange i CM");
            hairFeatures.hairLength = Int32.Parse(Console.ReadLine());
            
        }


        public void WriteHairFeatures()
        {
            Console.WriteLine("Hårfärg: " + hairFeatures.hairColor +  "\n" + "Hårlängd i CM: " + hairFeatures.hairLength + "\n");
        }


        
        
        public string Name
        {
            get { return name; }
            set { name = value; }
            
        }
        
        public DateTime BirthDay
        {
            get { return birthDay; }
            set { birthDay = value; }
        }
    }
}


