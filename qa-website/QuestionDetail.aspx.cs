using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.ModelBinding;
using System.Web.UI;
using System.Web.UI.WebControls;
using qa_website.Logic;
using qa_website.Model;

namespace qa_website
{
    public partial class QuestionDetail : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void QuestionVote_OnClick(object sender, EventArgs e)
        {
            var logginedUser = HttpContext.Current.User.Identity;
            Question question;
            using (var control = new QuestionController())
            {
                question = control.GetQuestion((int) QuestionDetailFormView.DataKey.Value);
            }
            
            var voteLabel = (Label) QuestionDetailFormView.FindControl("QuestionVotes");

            if (logginedUser.IsAuthenticated)
            {
                if (logginedUser.Name != question.User.Email)
                {
                    var vote = (LinkButton)sender;

                    using (var control = new QuestionController())
                    {
                        var result = control.ManageVote(
                            vote.ID.ToLower().Contains("up")
                                ? QuestionController.VoteType.Up
                                : QuestionController.VoteType.Down,
                            question.Id);
                        voteLabel.Text = result.ToString();
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

        public List<Comment> GetQuestionComments()
        {
            using (var control = new QuestionController())
            {
                return control.GetComments((int) QuestionDetailFormView.DataKey.Value);
            }
        }

        public Question GetQuestion([QueryString("QuestionID")] int? questionId)
        {
            if (questionId != null)
            {
                var voteLabel = (Label)QuestionDetailFormView.FindControl("QuestionVotes");

                using (var control = new QuestionController())
                {
                    return control.GetQuestion(questionId.Value);
                }
            }
            else
            {
                Response.Redirect("~/");
                return null;
            }
        }
    }
}