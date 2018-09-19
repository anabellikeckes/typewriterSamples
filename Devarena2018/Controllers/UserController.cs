using Devarena2018.Models;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;

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
        [Produces(typeof(List<User>))]
        public async Task<List<User>> GetAll()
        {
            await _task;
            return null;
        }

        [HttpGet("{userId:Guid}")]
        public async Task<User> Get(Guid userId)
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