using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Devarena2018.Models;
using Microsoft.AspNetCore.Mvc;

namespace Devarena2018.Controllers
{
    [Route("api/user")]
    public class UserController : Controller
    {
        [HttpGet]
        [Produces(typeof(List<UserModel>))]
        public async Task<List<UserModel>> GetAll() {
            return null;
        }
    }
}