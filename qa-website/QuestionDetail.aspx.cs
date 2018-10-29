using System;
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
            if (IsPostBack)
            {
                ErrorDiv.Visible = false;
            }
        }

        protected void QuestionVote_OnClick(object sender, EventArgs e)
        {
            string username;
            var logginedUser = HttpContext.Current.User.Identity;
            var questionId = (int) QuestionDetailFormView.DataKey.Value;
            var voteLabel = (Label)QuestionDetailFormView.FindControl("QuestionVotes");

            using (var control = new QuestionController())
            {
                username = control.GetQuestionAutherEmail(questionId);
            }
            
            if (logginedUser.IsAuthenticated)
            {
                if (logginedUser.Name != username)
                {
                    var vote = (LinkButton)sender;

                    using (var control = new QuestionController())
                    {
                        control.ManageVote(
                            vote.ID.ToLower().Contains("up")
                                ? QuestionController.VoteType.Up
                                : QuestionController.VoteType.Down,
                            questionId);
                    }
                }
                else
                {
                    ErrorMessage.InnerText = "You can not vote yourself.";
                    ErrorDiv.Visible = true;
                }

                QuestionDetailFormView.DataBind();
            }
            else
            {
                var currentUrl = HttpUtility.UrlEncode(Request.Url.PathAndQuery);
                Response.Redirect($"~/Login.aspx?ReturnUrl={currentUrl}");
            }
        }

        public Question GetQuestion([QueryString("QuestionID")] int? questionId)
        {
            if (questionId != null)
            {
                using (var control = new QuestionController())
                {
                    var question = control.GetQuestion(questionId.Value);
                    Title = question.Title;
                    return question;
                }
            }
            else
            {
                Response.Redirect("~/");
                return null;
            }
        }

        protected void QuestionSubmitCommentButton_OnClick(object sender, EventArgs e)
        {
            var logginedUser = HttpContext.Current.User.Identity;

            if (logginedUser.IsAuthenticated)
            {
                var commentTextBox = (TextBox)QuestionDetailFormView.FindControl("QuestionCommentBody");

                using (var control = new QuestionController())
                {
                    control.AddComment((int)QuestionDetailFormView.DataKey.Value, commentTextBox.Text);
                }

                QuestionDetailFormView.DataBind();
            }
            else
            {
                var currentUrl = HttpUtility.UrlEncode(Request.Url.PathAndQuery);
                Response.Redirect($"~/Login.aspx?ReturnUrl={currentUrl}");
            }
        }

        protected void AnswerVote_OnClick(object sender, EventArgs e)
        {
            string username;
            var logginedUser = HttpContext.Current.User.Identity;
            var vote = (LinkButton)sender;
            var answerId = int.Parse(vote.CommandArgument);

            using (var control = new AnswerController())
            {
                username = control.GetAnswerAutherEmail(answerId);
            }

            if (logginedUser.IsAuthenticated)
            {
                if (logginedUser.Name != username)
                {

                    using (var control = new AnswerController())
                    {
                        control.ManageVote(
                            vote.ID.ToLower().Contains("up")
                                ? AnswerController.VoteType.Up
                                : AnswerController.VoteType.Down,
                            answerId);
                    }
                }
                else
                {
                    ErrorMessage.InnerText = "You can not vote yourself.";
                    ErrorDiv.Visible = true;
                }

                QuestionDetailFormView.DataBind();
            }
            else
            {
                var currentUrl = HttpUtility.UrlEncode(Request.Url.PathAndQuery);
                Response.Redirect($"~/Login.aspx?ReturnUrl={currentUrl}");
            }
        }

        protected void AnswerSubmitCommentButton_OnClick(object sender, EventArgs e)
        {
            var logginedUser = HttpContext.Current.User.Identity;

            if (logginedUser.IsAuthenticated)
            {
                var submitButton = (Button)sender;
                var answerId = int.Parse(submitButton.CommandArgument);
                var commentTextBox = (TextBox)submitButton.Parent.FindControl("AnswerCommentBody");

                using (var control = new AnswerController())
                {
                    control.AddComment(answerId, commentTextBox.Text);
                }

                QuestionDetailFormView.DataBind();
            }
            else
            {
                var currentUrl = HttpUtility.UrlEncode(Request.Url.PathAndQuery);
                Response.Redirect($"~/Login.aspx?ReturnUrl={currentUrl}");
            }
        }

        protected void AcceptAnswer_OnClick(object sender, EventArgs e)
        {
            var linkButton = (LinkButton)sender;
            var answerId = int.Parse(linkButton.CommandArgument);

            using (var control = new AnswerController())
            {
                control.SetAcceptedAnswer(answerId);
            }

            QuestionDetailFormView.DataBind();
        }
    }
}