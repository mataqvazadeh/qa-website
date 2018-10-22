using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.Security;
using qa_website.Model;

namespace qa_website.Logic
{
    public class AccountController : IDisposable
    {
        private QAContext context = new QAContext();

        public bool ValidateUser(string userName, string password)
        {
            string encodedPassword = FormsAuthentication.HashPasswordForStoringInConfigFile(password, FormsAuthPasswordFormat.SHA1.ToString());

            try
            {
                var user = context.Users.Where(u => (u.Email == userName && u.Password == encodedPassword)).Single();
            }
            catch( InvalidOperationException )
            {
                return false;
            }

            return true;
        }

        public void LogIn(string userName)
        {
            var user = context.Users.Where(u => u.Email == userName).Single();
            user.LastLogin = DateTime.Now;
            context.SaveChanges();
        }

        public bool RegisterUser(string email, string password, string firstName, string lastName)
        {
            string encodedPassword = FormsAuthentication.HashPasswordForStoringInConfigFile(password, FormsAuthPasswordFormat.SHA1.ToString());

            var user = new User()
            {
                Email = email,
                Password = encodedPassword,
                FirstName = firstName,
                LastName = lastName,
                RegisterDate = DateTime.Now
            };

            try
            {
                context.Users.Add(user);
                context.SaveChanges();
                return true;
            } catch
            {
                return false;
            }
        }

        public void Dispose()
        {
            context?.Dispose();
            context = null;
        }
    }
}