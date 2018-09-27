using Devarena2018.Enums;
using System.Collections.Generic;

namespace Devarena2018.Models
{

    public class Generics<T>
    {
        public T GenericField { get; set; }

        public List<T> GenericArray { get; set; }

        public List<User> UserInfo { get; set; }

        public Role Role { get; set;}

        public bool EditModeAvailable { get; set; }
    }
}
