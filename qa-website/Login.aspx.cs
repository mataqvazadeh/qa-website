using qa_website.Logic;
using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace qa_website
{
    public partial class Login : Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            var returnUrl = HttpUtility.UrlEncode(Request.QueryString["ReturnUrl"]);
            if (!string.IsNullOrEmpty(returnUrl))
            {
                // todo: there is an problem with nested pages
                Login1.DestinationPageUrl = returnUrl;
            }
        }

        protected void Login1_Authenticate(object sender, AuthenticateEventArgs e)
        {
            using (var auth = new AccountController())
            {
                e.Authenticated = auth.ValidateUser(Login1.UserName, Login1.Password);
            }
        }

        protected void Login1_LoggedIn(object sender, EventArgs e)
        {
            using(var auth = new AccountController())
            {
                auth.LogIn(Login1.UserName);
            }
        }

        protected override void OnPreLoad(EventArgs e)
        {
            if(HttpContext.Current.User.Identity.IsAuthenticated)
            {
                Response.Redirect("~/");
            }
            base.OnPreLoad(e);
        }
    }
}