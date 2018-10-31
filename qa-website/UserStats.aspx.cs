using System;
using System.Linq;
using System.Web.ModelBinding;
using System.Web.UI.WebControls;
using qa_website.Model;

namespace qa_website
{
    public partial class UserStats : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            var dbContext = new QAContext();
            int userId;

            if (int.TryParse(Request.QueryString["UserId"], out userId) && userId > 0)
            {
                var user = dbContext.Users.SingleOrDefault(u => u.Id == userId);
                Title = user?.FullName ?? "Untitled";
            }

        }

        #region User Methods

        public IQueryable<User> GetUser([QueryString("UserId")] int? userId)
        {
            var dbContext = new QAContext();
            IQueryable<User> query = dbContext.Users;

            if (userId.HasValue && userId > 0)
            {
                query = query.Where(u => u.Id == userId.Value);
            }
            else
            {
                Response.Redirect("~/");
                query = null;
            }

            return query;
        }

        #endregion

        #region Questions Methods

        public IQueryable<Question> GetQuestions([QueryString("UserId")] int? userId)
        {
            var dbContext = new QAContext();
            IQueryable<Question> query = dbContext.Questions;

            if (userId.HasValue && userId > 0)
            {
                query = query.Where(q => q.AuthorId == userId.Value);

                // sorting or filtering
                switch (QuestionSortValue.Value)
                {
                    case "newest":
                        query = query.OrderByDescending(q => q.CreateDate);
                        break;
                    case "votes":
                        query = query.OrderByDescending(q => q.Votes.Sum(v => v.VoteValue))
                            .ThenByDescending(q => q.CreateDate);
                        break;
                }
            }
            else
            {
                query = null;
            }

            return query;
        }

        protected void QuestionsList_OnPagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
        {
            //set current page startindex, max rows and rebind to false
            QuestionsDataPager.SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
            QuestionsList.DataBind();
        }

        protected void sortQuestionRadioButton_OnCheckedChanged(object sender, EventArgs e)
        {
            var radioButton = (RadioButton)sender;
            QuestionSortValue.Value = radioButton.Text.ToLower();
            QuestionsList.DataBind();
        }

        #endregion

        #region Answers Methods

        public IQueryable<Answer> GetAnswers([QueryString("UserId")] int? userId)
        {
            var dbContext = new QAContext();
            IQueryable<Answer> query = dbContext.Answers;

            if (userId.HasValue && userId > 0)
            {
                query = query.Where(a => a.AuthorId == userId.Value);

                // sorting or filtering
                switch (AnswerSortValue.Value)
                {
                    case "newest":
                        query = query.OrderByDescending(a => a.CreateDate);
                        break;
                    case "votes":
                        query = query.OrderByDescending(a => a.Votes.Sum(v => v.VoteValue))
                            .ThenByDescending(a => a.CreateDate);
                        break;
                }
            }
            else
            {
                query = null;
            }

            return query;
        }

        protected void AnswersList_OnPagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
        {
            //set current page startindex, max rows and rebind to false
            AnswersDataPager.SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
            AnswersList.DataBind();
        }

        protected void sortAnswerRadioButton_OnCheckedChanged(object sender, EventArgs e)
        {
            var radioButton = (RadioButton)sender;
            AnswerSortValue.Value = radioButton.Text.ToLower();
            AnswersList.DataBind();
        }

        #endregion
    }
}