using System;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using qa_website.Logic;

namespace qa_website
{
    public partial class QuestionDetail : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            int questionId;

            if (int.TryParse(Request.QueryString["QuestionID"], out questionId))
            {
                using (var control = new QuestionController())
                {
                    var question = control.GetQuestion(questionId);
                    if (question != null)
                    {
                        QuestionId.Value = question.Id.ToString();
                        QuestionTitle.InnerText = question.Title;
                        QuestionBody.InnerText = question.Body;
                        QuestionAuthor.InnerText = question.User.FullName;
                        QuestionDate.InnerText = question.CreateDate.ToString(CultureInfo.InvariantCulture);
                        QuestionVotes.Text = question.Votes.Sum(v => v.VoteValue).ToString();
                    }
                }
            }
            else
            {
                Response.Redirect("~/");
            }
        }

        protected void QuestionVote_OnClick(object sender, EventArgs e)
        {
            if (HttpContext.Current.User.Identity.IsAuthenticated)
            {
                var vote = (LinkButton) sender;

                using (var control = new QuestionController())
                {
                    var result = control.ManageVote(
                        vote.ID.ToLower().Contains("up")
                            ? QuestionController.VoteType.Up
                            : QuestionController.VoteType.Down,
                        int.Parse(QuestionId.Value));

                    QuestionVotes.Text = result.ToString();
                }
            }
            else
            {
                var currentUrl = HttpUtility.UrlEncode(Request.Url.PathAndQuery);
                Response.Redirect($"~/Login.aspx?ReturnUrl={currentUrl}");
            }
        }
    }
}