using qa_website.Logic;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

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

        }

        protected void SubmitButton_Click(object sender, EventArgs e)
        {
            if(IsValid)
            {
                using (var auth = new AccountController())
                {
                    string firstName = string.IsNullOrEmpty(FirstNameTextBox.Text) ? null : FirstNameTextBox.Text;
                    string lastName = string.IsNullOrEmpty(LastNameTextBox.Text) ? null : LastNameTextBox.Text;

                    if(auth.RegisterUser(EmailTextBox.Text, PasswordTextBox.Text, firstName, lastName))
                    {
                        FormsAuthentication.RedirectFromLoginPage(EmailTextBox.Text, false);
                        auth.LogIn(EmailTextBox.Text);
                    }
                }

            }
        }
    }
}