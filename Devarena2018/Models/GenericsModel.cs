﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Devarena2018.Models
{
    public class GenericsModel<T>
    {
        public IEnumerable<T> Result { get; set; }
    }
}
