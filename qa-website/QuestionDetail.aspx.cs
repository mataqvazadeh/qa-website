using System;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using qa_website.Logic;
using qa_website.Model;

namespace qa_website
{
    public partial class QuestionDetail : Page
    {
        private Question _question;

        protected void Page_Load(object sender, EventArgs e)
        {
            int questionId;

            if (int.TryParse(Request.QueryString["QuestionID"], out questionId))
            {
                using (var control = new QuestionController())
                {
                    _question = control.GetQuestion(questionId);

                    if (_question != null)
                    {
                        QuestionId.Value = _question.Id.ToString();
                        QuestionTitle.InnerText = _question.Title;
                        QuestionBody.InnerText = _question.Body;
                        QuestionAuthor.InnerText = _question.User.FullName;
                        QuestionDate.InnerText = _question.CreateDate.ToString(CultureInfo.InvariantCulture);
                        QuestionVotes.Text = _question.Votes.Sum(v => v.VoteValue).ToString();
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
            var logginedUser = HttpContext.Current.User.Identity;

            if (logginedUser.IsAuthenticated)
            {
                if (logginedUser.Name != _question.User.Email)
                {
                    var vote = (LinkButton)sender;

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
                    ErrorMessage.InnerText = "You can not vote yourself.";
                    ErrorDiv.Visible = true;
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