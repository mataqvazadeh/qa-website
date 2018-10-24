using qa_website.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace qa_website.Logic
{
    public class QuestionController : IDisposable
    {
        public enum VoteType
        {
            Up = 1,
            Down = -1
        }

        private QAContext context = new QAContext();

        public int AskQuestion(string title, string body)
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
                return question.Id;
            }
            catch (Exception)
            {
                return -1;
            }
        }

        public Question GetQuestion(int id)
        {
            var question = context.Questions.SingleOrDefault(q => q.Id == id);
            return question;
        }

        public int ManageVote(VoteType userVote, int id)
        {
            var user = context.Users.Single(u => u.Email == HttpContext.Current.User.Identity.Name);
            var question = context.Questions.Single(q => q.Id == id);

            var similarVote =
                question.Votes.SingleOrDefault(v => v.User == user && v.VoteValue == (byte) userVote);

            int result;

            // Check delete, change or add vote
            if (similarVote != null) // delete vote
            {
                context.Votes.Remove(similarVote);
                result = -1*(int) userVote; // result should be inverse of vote
            }
            else
            {
                var similarUserVote = question.Votes.SingleOrDefault(v => v.User == user);

                if (similarUserVote != null) // change vote
                {
                    similarUserVote.VoteValue = (byte) userVote;
                    result = 2*(int) userVote; // result should be double of vote (delete old one and add new one)
                }
                else // add vote
                {
                    var vote = new Vote()
                    {
                        User = user,
                        Question = question,
                        VoteValue = (byte) userVote,
                        CreateDate = DateTime.Now
                    };

                    question.Votes.Add(vote);
                    result = (int) userVote; // result should be user vote
                }
            }

            try
            {
                context.SaveChanges();
                return result;
            }
            catch (Exception)
            {

                return 0;
            }

        }

        public void Dispose()
        {
            context?.Dispose();
            context = null;
        }
    }
}