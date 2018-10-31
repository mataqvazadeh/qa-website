using System;
using System.Linq;
using qa_website.Logic;
using qa_website.Model;

namespace qa_website.Panel
{
    public partial class Profile : System.Web.UI.Page
    {
        private string _newFirstName;
        private string _newLastName;

        protected void Page_Load(object sender, EventArgs e)
        {
            int userId;

            if (int.TryParse(Request.QueryString["UserId"], out userId) && userId > 0)
            {
                // save user inut data
                _newFirstName = FirstNameTextBox.Text;
                _newLastName = LastNameTextBox.Text;

                try
                {
                    BindUserData(userId);
                }
                catch
                {
                    Response.Redirect("~/");
                }
            }
            else
            {
                Response.Redirect("~/");
            }

            if (IsPostBack)
            {
                ErrorDiv.Visible = false;
                SuccssDiv.Visible = false;
            }
        }

        protected void InformationSubmitButton_OnClick(object sender, EventArgs e)
        {
            using (var auth = new AccountController())
            {
                var firstName = string.IsNullOrEmpty(_newFirstName) ? null : _newFirstName;
                var lastName = string.IsNullOrEmpty(_newLastName) ? null : _newLastName;
                var userId = int.Parse(Request.QueryString["UserId"]);

                try
                {
                    auth.UpdateProfile(userId, firstName, lastName);
                    BindUserData(userId);
                    SuccssDiv.Visible = true;
                }
                catch (Exception)
                {
                    ErrorMessage.InnerText = "There was a problem with registration. Please try again later.";
                    ErrorDiv.Visible = true;
                }
            }
        }

        protected void ChangePsswordButton_OnClick(object sender, EventArgs e)
        {
            using (var auth = new AccountController())
            {
                var userId = int.Parse(Request.QueryString["UserId"]);

                try
                {
                    auth.UpdatePassword(userId, OldPasswordTextBox.Text, PasswordTextBox.Text);
                    SuccssDiv.Visible = true;
                }
                catch (Exception exception)
                {
                    ErrorMessage.InnerText = exception.Message;
                    ErrorDiv.Visible = true;
                }
            }
        }

        private void BindUserData(int userId)
        {
            var dbContext = new QAContext();
            var user = dbContext.Users.Single(u => u.Id == userId);

            Title = UserFullName.InnerText = user.FullName;

            FirstNameTextBox.Text = user.FirstName;
            LastNameTextBox.Text = user.LastName;
        }
    }
}