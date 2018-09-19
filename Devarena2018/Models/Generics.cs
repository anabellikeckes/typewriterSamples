using Devarena2018.Enums;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Devarena2018.Models
{

    public class Generics<T>
    {
        public List<User> UserInfo { get; set; }
        public Role Role{ get; set;}
        public bool EditModeAvailable { get; set; }
    }
}
