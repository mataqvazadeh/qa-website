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
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Login1_Authenticate(object sender, AuthenticateEventArgs e)
        {
            using (var auth = new AccountControl())
            {
                if (auth.ValidateUser(Login1.UserName, Login1.Password))
                {
                    e.Authenticated = true;
                    FormsAuthentication.RedirectFromLoginPage(Login1.UserName, false);
                }
                else
                {
                    e.Authenticated = false;
                }
            }
        }
    }
}