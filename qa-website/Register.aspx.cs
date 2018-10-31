using qa_website.Logic;
using System;
using System.Data;
using System.Web;
using System.Web.Security;

namespace qa_website
{
    public partial class Register : System.Web.UI.Page
    {
        protected override void OnPreLoad(EventArgs e)
        {
            if (HttpContext.Current.User.Identity.IsAuthenticated)
            {
                Response.Redirect("~/");
            }
            base.OnPreLoad(e);
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                AlertDiv.Visible = false;
            }
        }

        protected void SubmitButton_Click(object sender, EventArgs e)
        {
            if (IsValid)
            {
                using (var auth = new AccountController())
                {
                    string firstName = string.IsNullOrEmpty(FirstNameTextBox.Text) ? null : FirstNameTextBox.Text;
                    string lastName = string.IsNullOrEmpty(LastNameTextBox.Text) ? null : LastNameTextBox.Text;

                    try
                    {
                        auth.RegisterUser(EmailTextBox.Text, PasswordTextBox.Text, firstName, lastName);
                        auth.LogIn(EmailTextBox.Text);
                    }
                    catch (DuplicateNameException exception)
                    {
                        ErrorMessage.InnerText = exception.Message;
                        AlertDiv.Visible = true;
                    }
                    catch (Exception)
                    {
                        ErrorMessage.InnerText = "There was a problem with registration. Please try again later.";
                        AlertDiv.Visible = true;
                    }
                }

            }
        }
    }
}