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

            query = query.OrderByDescending(q => q.CreateDate);

            return query;
        }

        protected void QuestionsList_OnPagePropertiesChanging(object sender, PagePropertiesChangingEventArgs e)
        {
            //set current page startindex, max rows and rebind to false
            QuestionsDataPager.SetPageProperties(e.StartRowIndex, e.MaximumRows, false);
            QuestionsList.DataBind();
        }
    }
}