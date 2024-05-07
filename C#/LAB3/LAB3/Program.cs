using System;
using System.Linq;
using System.Collections.Generic;




namespace LAB3
{
    internal class Program
    {

        static void Main(string[] args)
        {
            List<Person> ListOfPersons = new List<Person>();
            

            int choice = 0;
            //Meny = Klar!
            while (choice != 100)
            {
                Console.WriteLine("Hej och välkommen till mitt program.");
                Console.WriteLine("Välj ett av dem fem alternativen genom att skriva 1-5, avsluta med Enter.");
                Console.WriteLine("1) 1-9:ans gångertabell");
                Console.WriteLine("2) Skriv in tal i en Array så räknar uträknaren ut totala summan, medelvärdet och högsta samt lägsta värdet");
                Console.WriteLine("3) Generera en slumpmässig Array och sortera den");
                Console.WriteLine("4) Lägg till egenskaper för personer");
                Console.WriteLine("5) Avsluta");

                Console.Write("\nVälj ett alternativ: ");
                choice = Convert.ToInt32(Console.ReadLine());
                Console.WriteLine();


                //skirv 1-9:ans gångertabell = Klar!
                switch (choice)
                {
                    case 1:
                        
                        Console.WriteLine("Här är 1-9:ans gångertabell:\n");
                        for (int i = 1; i < 10; i++)
                        {
                            Console.WriteLine("{0}:ans tabell", i);
                            for (int j = 1; j < 10; j++)
                            {
                                Console.WriteLine("{0} x {1} = {2}", i, j, i * j);
                            }
                            Console.WriteLine();
                        }
                        
                        ReturnToMenu();
                        
                        break;

                    // Skriv en array där användaren ger input med siffror.
                    // Räkna sedan ut totala summa, medelvärde, samt visa högsta och lägsta nummer.
                    // Klar!
                    case 2:
                        Console.Write("Du skapar nu en Array. Hur stor ska Arrayen vara? Ange ett heltal: ");
                        float Size = float.Parse(Console.ReadLine());
                        float[] Number = new float[(int)Size];
                        float NumSum = 0;
                        Console.WriteLine("\nAnge {0} tal. Decimaltal är tillåtet.", Size);
                        for (int n = 0; n < Number.Length; n++)
                        {
                            Console.WriteLine("Ange tal {0}: ", n + 1);
                            float Input = float.Parse(Console.ReadLine());
                            Number[n] = Input;
                            NumSum += Number[n];
                        }
                        float NumDiv = NumSum / Number.Length;
                        float MinNumber = Number.Min();
                        float MaxNumber = Number.Max();


                        Console.WriteLine("\nSumman av alla tal är: {0}", NumSum);
                        Console.WriteLine("Medelvärdet för Arrayen är: {0}", NumDiv);
                        Console.WriteLine("Det högsta talet i Arrayen är: {0} och det lägsta talet är: {1}", MaxNumber, MinNumber);
                        
                        ReturnToMenu();
                        
                        break;


                    //Skriv en array med olika nummer för att sedan sortera arrayen med Array.Sort = Klar!
                    case 3:
                        Console.WriteLine("Här är din slumpmässiga Array, tryck Enter för att sortera den.");
                        int min = int.MinValue;
                        int max = int.MaxValue;

                        int[] RandomArray = new int[10];

                        Random RandNum = new Random();
                        for (int k = 0; k < RandomArray.Length; k++)
                        {
                            RandomArray[k] = RandNum.Next(min, max);
                        }
                        foreach (int k in RandomArray)
                        {
                            Console.WriteLine(k);
                        }
                        Console.ReadLine();
                        Console.WriteLine("Här är din slumpmässiga Array sorterad Min-Max. :)");
                        Array.Sort(RandomArray);
                        foreach (int k in RandomArray)
                        {
                            Console.WriteLine(k);
                        }
                        
                        ReturnToMenu();
                        
                        break;


                    
                    case 4:

                    /*Gör en klass där användaren fyller i egenskaper för en person.
                     * Födelsedag(YYYY: MM:DD)
                     * Kön
                     * Hårfärg
                     * Hårlängd
                     * Ögonfärg
                     * Namn 
                     * Personerna ska sparas i en Array eller lista 
                     * Användaren ska kunna välja om den vill lägga till fler personer*/

                        bool answer = true;
                        int listMenu = 0;

                        while (listMenu != 3)
                        {
                            Console.WriteLine("Vill du lägga till personer i en lista eller vill du visa listan med personer?");
                            Console.WriteLine("1) Skapa och lägg till personer i listan");
                            Console.WriteLine("2) Visa alla personer i listan");
                            Console.WriteLine("3) Återgå till huvudmenyn.");
                            
                            Console.Write("\nVälj ett alternativ: ");
                            listMenu = Int32.Parse(Console.ReadLine());
                            

                            switch (listMenu)
                            {

                                case 1:
                                    
                                        while (answer == true)
                                        {
                                                Person person = new Person();

                                                Console.WriteLine("\nDu skapar nu personer med olika egenskaper och sparar dem i en lista. Tryck Enter för att börja.");
                                                Console.ReadLine();

                                                Console.WriteLine("När är personen född? Ange format: YYYY-MM-DD.");
                                                person.BirthDay = Convert.ToDateTime(Console.ReadLine());


                                                Console.WriteLine("Vad heter personen?");
                                                person.Name = Console.ReadLine();

                                                Console.WriteLine("Vilket kön har personen?");
                                                person.gender = Console.ReadLine();

                                                Console.WriteLine("Vilken ögonfärg har personen?");
                                                person.eyeColor = Console.ReadLine();

                                                person.HairFeatures(); //En metod som frågar om personens hårfärg och hårlängd.

                                                ListOfPersons.Add(person);

                                                Console.WriteLine("Vill du lägga till en ny person? Skriv 'y' för ja och 'n' för nej");
                                                string addAnotherPerson = Console.ReadLine().ToLower();

                                                if (addAnotherPerson == "y")
                                                {
                                                    answer = true;
                                                    Console.Clear();
                                                }
                                                else
                                                {
                                                    Console.Clear();
                                                    answer = false;
                                                }

                                            
                                        }
                                    break;


                                case 2:

                                    Console.Clear();

                                    int index = 0;

                                    foreach (var item in ListOfPersons)
                                    {
                                        Console.WriteLine("Egenskaper för personen {0} är följande:", index);
                                        Console.WriteLine("Namn: " + item.Name + "\nFödelsedag: " + item.BirthDay + "\nKön: " + item.gender + "\nÖgonfärg: " + item.eyeColor);
                                        item.WriteHairFeatures();
                                        index++;
                                    }
                                    ReturnToMenu();
                                    break;

                                
                          
                            }

                            
                        }
                        Console.Clear();    
                       
                        ReturnToMenu();

                            break;
                        






                    //Avsluta applikationen = Klar!
                    case 5:
                        choice = 100;
                        break;
                }
            }

            void ReturnToMenu()
            {
                Console.Write("\n\nTryck Enter för att återgå till menyn");
                Console.ReadLine();
                Console.Clear();
            }
        
        
        }
    
        
    
    }
}
