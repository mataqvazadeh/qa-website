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
                        var result = control.ManageVote(
                            vote.ID.ToLower().Contains("up")
                                ? QuestionController.VoteType.Up
                                : QuestionController.VoteType.Down,
                            questionId);
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

        protected override void OnPreLoad(EventArgs e)
        {
            Page.Title = "hello";
            base.OnPreLoad(e);
        }
    }
}