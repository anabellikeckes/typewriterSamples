using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Devarena2018.Models
{
    public class Customer
    {
        public int Id { get; set; }

        public string Name { get; set; }

        public ICollection<string> Orders { get; set; }
    }
}
