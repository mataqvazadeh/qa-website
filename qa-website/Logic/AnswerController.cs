﻿using qa_website.Model;
using System;
using System.Data.Entity;
using System.Linq;
using System.Web;

namespace qa_website.Logic
{
    public class AnswerController : IDisposable
    {
        public enum VoteType
        {
            Up = 1,
            Non = 0,
            Down = -1
        }

        private QAContext _dbContext = new QAContext();

        public AnswerController()
        {
            _dbContext.Database.CommandTimeout = 120;
        }

        public void ManageVote(VoteType userVote, int id)
        {
            var user = _dbContext.Users.Single(u => u.Email == HttpContext.Current.User.Identity.Name);
            var answer = _dbContext.Answers.Single(q => q.Id == id);

            var userOldVoteVote = answer.Votes.SingleOrDefault(v => v.User == user);

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
                        Answer = answer,
                        VoteValue = (short) userVote,
                        CreateDate = DateTime.Now
                    };

                    answer.Votes.Add(vote);
            }

            _dbContext.SaveChanges();
        }

        public void AddComment(int answerId, string commentBody)
        {
            var user = _dbContext.Users.Single(u => u.Email == HttpContext.Current.User.Identity.Name);
            var answer = _dbContext.Answers.Single(a => a.Id == answerId);

            Comment comment = new Comment()
            {
                User = user,
                Answer = answer,
                Body = commentBody,
                CreateDate = DateTime.Now
            };

            answer.Comments.Add(comment);
            _dbContext.SaveChanges();
        }

        public string GetAnswerAutherEmail(int answerId)
        {
            var answer = _dbContext.Answers.Single(a => a.Id == answerId);

            return answer.User.Email;
        }

        public void Dispose()
        {
            _dbContext?.Dispose();
            _dbContext = null;
        }
    }
}