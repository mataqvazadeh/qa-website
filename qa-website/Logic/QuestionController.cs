using qa_website.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace qa_website.Logic
{
    public class QuestionController : IDisposable
    {
        private QAContext context = new QAContext();

        public bool AskQuestion(string title, string body)
        {
            var user = context.Users.Single(u => u.Email == HttpContext.Current.User.Identity.Name);

            var question = new Question()
            {
                Title = title,
                Body = body,
                CreateDate = DateTime.Now,
                User = user
            };

            try
            {
                context.Questions.Add(question);
                context.SaveChanges();
                return true;
            }
            catch (Exception)
            {
                return false;;
            }
        }

        public void Dispose()
        {
            context?.Dispose();
            context = null;
        }
    }
}