using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.Security;
using qa_website.Helper;
using qa_website.Model;

namespace qa_website.Logic
{
    public class AccountController : IDisposable
    {
        private QAContext context = new QAContext();

        public bool ValidateUser(string userName, string password)
        {
            //string encodedPassword = PasswordEncryptor.ComputeHash(password);
            string encodedPassword = FormsAuthentication.HashPasswordForStoringInConfigFile(password, FormsAuthPasswordFormat.SHA1.ToString());

            try
            {
                var user = context.Users.Single(u => (u.Email == userName && u.Password == encodedPassword));
            }
            catch( InvalidOperationException )
            {
                return false;
            }

            return true;
        }

        public void LogIn(string userName)
        {
            FormsAuthentication.RedirectFromLoginPage(userName, false);

            var user = context.Users.Single(u => u.Email == userName);
            user.LastLogin = DateTime.Now;
            context.SaveChanges();
        }

        public void RegisterUser(string email, string password, string firstName, string lastName)
        {
            // check duplication
            var dbUser = context.Users.SingleOrDefault(u => u.Email == email);

            if (dbUser != null)
            {
                throw new DuplicateNameException("You can not use this email address.");
            }
            else
            {
                // encoding password for security
                string encodedPassword = PasswordEncryptor.ComputeHash(password);

                var user = new User()
                {
                    Email = email,
                    Password = encodedPassword,
                    FirstName = firstName,
                    LastName = lastName,
                    RegisterDate = DateTime.Now
                };

                context.Users.Add(user);
                context.SaveChanges();
            }
        }

        public void Dispose()
        {
            context?.Dispose();
            context = null;
        }
    }
}