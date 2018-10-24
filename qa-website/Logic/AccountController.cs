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
        private QAContext _dbContext = new QAContext();

        public bool ValidateUser(string userName, string password)
        {
            // find user
            var user = _dbContext.Users.SingleOrDefault(u => (u.Email == userName));

            if (user != null) // if user exsist
            {
                // check password
                if (PasswordEncryptor.VerifyHash(password, user.Password))
                {
                    return true;
                }
            }

            return false;
        }

        public void LogIn(string userName)
        {
            FormsAuthentication.RedirectFromLoginPage(userName, false);

            var user = _dbContext.Users.Single(u => u.Email == userName);
            user.LastLogin = DateTime.Now;
            _dbContext.SaveChanges();
        }

        public void RegisterUser(string email, string password, string firstName, string lastName)
        {
            // check duplication
            var dbUser = _dbContext.Users.SingleOrDefault(u => u.Email == email);

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

                _dbContext.Users.Add(user);
                _dbContext.SaveChanges();
            }
        }

        public string GetName(string userName)
        {
            var user = _dbContext.Users.Single(u => u.Email == userName);
            return user.FullName;
        }

        public void Dispose()
        {
            _dbContext?.Dispose();
            _dbContext = null;
        }
    }
}