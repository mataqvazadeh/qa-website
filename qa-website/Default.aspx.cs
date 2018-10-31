using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using qa_website.Model;

namespace qa_website
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        public IQueryable<Question> GetQuestions()
        {
            var dbContext = new QAContext();
            IQueryable<Question> query = dbContext.Questions;

            // sorting or filtering
            switch (QuestionSortValue.Value)
            {
                case "newest":
                    query = query.OrderByDescending(q => q.CreateDate);
                    break;
                case "votes":
                    query = query.OrderByDescending(q => q.Votes.Sum(v => v.VoteValue))
                        .ThenByDescending(q => q.Answers.Any(a => a.IsAccepted))
                        .ThenByDescending(q => q.Answers.Count)
                        .ThenByDescending(q => q.CreateDate);
                    break;
                case "unanswered":
                    query = query.Where(q => q.Answers.Count == 0).OrderByDescending(q => q.CreateDate);
                    break;
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
            var radioButton = (RadioButton) sender;
            QuestionSortValue.Value = radioButton.Text.ToLower();
            QuestionsList.DataBind();
            QuestionsCountLable_OnLoad(sender, e);
        }

        protected void QuestionsCountLable_OnLoad(object sender, EventArgs e)
        {
            var dbContext = new QAContext();
            IQueryable<Question> query = dbContext.Questions;

            if (QuestionSortValue.Value == "unanswered")
            {
                query = query.Where(q => q.Answers.Count == 0);
            }

            QuestionsCountLable.Text = query.Count().ToString("N0");
        }
    }
}