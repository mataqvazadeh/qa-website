using System;
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
            var dbContext = new QAContext();
            int questionId;

            if (int.TryParse(Request.QueryString["QuestionID"], out questionId) && questionId > 0)
            {
                var question = dbContext.Questions.SingleOrDefault(q => q.Id == questionId);
                Title = question?.Title ?? "Untitled";
            }

            if (IsPostBack)
            {
                ErrorDiv.Visible = false;
            }
        }

        #region Question Methods

        public IQueryable<Question> GetQuestion([QueryString("QuestionID")] int? questionId)
        {
            var dbContext = new QAContext();
            IQueryable<Question> query = dbContext.Questions;

            if (questionId.HasValue && questionId > 0)
            {
                query = query.Where(q => q.Id == questionId.Value);
            }
            else
            {
                Response.Redirect("~/");
                query = null;
            }

            return query;
        }

        protected void QuestionVote_OnClick(object sender, EventArgs e)
        {
            string username;
            var logginedUser = HttpContext.Current.User.Identity;
            var vote = (LinkButton)sender;
            var questionId = int.Parse(vote.CommandArgument);

            using (var control = new QuestionController())
            {
                username = control.GetQuestionAutherEmail(questionId);
            }

            if (logginedUser.IsAuthenticated)   // only logined users can vote
            {
                if (logginedUser.Name != username)  // nobody can't voye himself/herself
                {

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

        protected void QuestionSubmitCommentButton_OnClick(object sender, EventArgs e)
        {
            var logginedUser = HttpContext.Current.User.Identity;

            if (logginedUser.IsAuthenticated)   // only logined users can submit comment
            {
                var submitButton = (Button)sender;
                var questionId = int.Parse(submitButton.CommandArgument);
                var commentTextBox = (TextBox)QuestionDetailFormView.FindControl("QuestionCommentBody");

                using (var control = new QuestionController())
                {
                    control.AddComment(questionId, commentTextBox.Text);
                }

                QuestionDetailFormView.DataBind();
            }
            else
            {
                var currentUrl = HttpUtility.UrlEncode(Request.Url.PathAndQuery);
                Response.Redirect($"~/Login.aspx?ReturnUrl={currentUrl}");
            }
        }

        #endregion

        #region Answers Methods

        public IQueryable<Answer> GetAnswers([QueryString("QuestionID")] int? questionId)
        {
            var dbContext = new QAContext();
            IQueryable<Answer> query = dbContext.Answers;

            if (questionId.HasValue && questionId > 0)
            {
                query = query.Where(a => a.QuestionId == questionId.Value);

                // sort
                if (AnswersSortValue.Value == "oldest")
                {
                    query = query.OrderBy(a => a.CreateDate);
                }
                else
                {
                    query =
                        query.OrderByDescending(a => a.IsAccepted)
                            .ThenByDescending(a => a.Votes.Sum(v => v.VoteValue))
                            .ThenBy(a => a.CreateDate);
                }
            }
            else
            {
                query = null;
            }

            return query;
        }

        protected void AcceptAnswer_OnClick(object sender, EventArgs e)
        {
            var linkButton = (LinkButton)sender;
            var answerId = int.Parse(linkButton.CommandArgument);

            using (var control = new AnswerController())
            {
                control.SetAcceptedAnswer(answerId);
            }

            AnswersList.DataBind();
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

            if (logginedUser.IsAuthenticated)   // only logedin users can vote to answers
            {
                if (logginedUser.Name != username)  // nobody can't vote his/her answer
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

                AnswersList.DataBind();
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

            if (logginedUser.IsAuthenticated)   // only logedin users can comment on answers
            {
                var submitButton = (Button)sender;
                var answerId = int.Parse(submitButton.CommandArgument);
                var commentTextBox = (TextBox)submitButton.Parent.FindControl("AnswerCommentBody");

                using (var control = new AnswerController())
                {
                    control.AddComment(answerId, commentTextBox.Text);
                }

                AnswersList.DataBind();
            }
            else
            {
                var currentUrl = HttpUtility.UrlEncode(Request.Url.PathAndQuery);
                Response.Redirect($"~/Login.aspx?ReturnUrl={currentUrl}");
            }
        }

        protected void SortButton_OnClick(object sender, EventArgs e)
        {
            var dropDownList = (DropDownList)QuestionDetailFormView.FindControl("SortOptionsList");
            AnswersSortValue.Value = dropDownList.SelectedValue;
            AnswersList.DataBind();
        }

        protected void AnswerSubmitButton_OnClick(object sender, EventArgs e)
        {
            var logginedUser = HttpContext.Current.User.Identity;

            if (logginedUser.IsAuthenticated) // only logedin users can answer to question
            {
                int questionId;

                if (int.TryParse(Request.QueryString["QuestionID"], out questionId) && questionId > 0)
                {
                    using (var control = new AnswerController())
                    {
                        control.AnswerToQuestion(questionId, AnswerBodyTextBox.Text);
                    }

                    AnswerBodyTextBox.Text = "";
                    QuestionDetailFormView.DataBind();
                    AnswersList.DataBind();
                }
                else
                {
                    ErrorMessage.InnerText = "Please try again later";
                    ErrorDiv.Visible = true;
                }
            }
            else
            {
                var currentUrl = HttpUtility.UrlEncode(Request.Url.PathAndQuery);
                Response.Redirect($"~/Login.aspx?ReturnUrl={currentUrl}");
            }
        }

        #endregion
    }
}