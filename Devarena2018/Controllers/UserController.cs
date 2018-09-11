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
        private readonly Task _task;

        public UserController(
           Task task
       )
        {
            _task = task;
        }

        [HttpGet]
        [Produces(typeof(List<UserModel>))]
        public async Task<List<UserModel>> GetAll()
        {
            await _task;
            return null;
        }

        [HttpGet("{userId:Guid}")]
        public async Task<UserModel> Get(Guid userId)
        {
            await _task;
            return null;
        }

        [HttpDelete("{userId:Guid}")]
        public async Task Delete(Guid userId)
        {
            await _task;
        }
    }
}