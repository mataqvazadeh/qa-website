using qa_website.Model;
using System;
using System.Data.Entity;
using System.Linq;
using System.Web;

namespace qa_website.Logic
{
    public class QuestionController : IDisposable
    {
        public enum VoteType
        {
            Up = 1,
            Non = 0,
            Down = -1
        }

        private QAContext _dbContext = new QAContext();

        public QuestionController()
        {
            _dbContext.Database.CommandTimeout = 120;
        }

        public int AskQuestion(string title, string body)
        {
            var user = _dbContext.Users.Single(u => u.Email == HttpContext.Current.User.Identity.Name);

            var question = new Question()
            {
                Title = title,
                Body = body,
                CreateDate = DateTime.Now,
                User = user
            };

            try
            {
                _dbContext.Questions.Add(question);
                _dbContext.SaveChanges();
                return question.Id;
            }
            catch (Exception)
            {
                return -1;
            }
        }

        public Question GetQuestion(int id)
        {
            var question = _dbContext.Questions
                .Include(q => q.User )
                .Include(q => q.Votes)
                .Include(q => q.Comments.Select(c => c.User))
                .Include(q => q.Answers.Select(a => a.User))
                .Include(q => q.Answers.Select(a => a.Votes))
                .Include(q => q.Answers.Select(a => a.Comments.Select(c => c.User)))
                .SingleOrDefault(q => q.Id == id);
            return question;
        }

        public void ManageVote(VoteType userVote, int id)
        {
            var user = _dbContext.Users.Single(u => u.Email == HttpContext.Current.User.Identity.Name);
            var question = _dbContext.Questions.Single(q => q.Id == id);

            var userOldVoteVote = question.Votes.SingleOrDefault(v => v.User == user);

            // Check if user voted before
            if (userOldVoteVote != null)
            {
                if ((VoteType)userOldVoteVote.VoteValue == userVote) // user wants to delete his/her vote
                {
                    userOldVoteVote.VoteValue = (short) VoteType.Non;
                }
                else // user wants to change his/her vote
                {
                    userOldVoteVote.VoteValue = (short) userVote;
                }

                userOldVoteVote.CreateDate = DateTime.Now;
            }
            else // if user did not vote until now, so create vote
            {
                    var vote = new Vote()
                    {
                        User = user,
                        Question = question,
                        VoteValue = (short) userVote,
                        CreateDate = DateTime.Now
                    };

                    question.Votes.Add(vote);
            }

            _dbContext.SaveChanges();
        }

        public void AddComment(int questionId, string commentBody)
        {
            var user = _dbContext.Users.Single(u => u.Email == HttpContext.Current.User.Identity.Name);
            var question = _dbContext.Questions.Single(q => q.Id == questionId);

            Comment comment = new Comment()
            {
                User = user,
                Question = question,
                Body = commentBody,
                CreateDate = DateTime.Now
            };

            question.Comments.Add(comment);
            _dbContext.SaveChanges();
        }

        public string GetQuestionAutherEmail(int questionId)
        {
            var question = _dbContext.Questions.Single(q => q.Id == questionId);

            return question.User.Email;
        }

        public void Dispose()
        {
            _dbContext?.Dispose();
            _dbContext = null;
        }
    }
}