using System;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using qa_website.Model;

namespace qa_website
{
    public partial class SiteMaster : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if(HttpContext.Current.User.Identity.IsAuthenticated)
            {
                var user = GetUser();

                askLink.Visible = true;

                var statsLinkTag = (HtmlAnchor) LoginView1.FindControl("UserStatLink");
                statsLinkTag.HRef = $"~/UserStats.aspx?UserId={user.Id}";

                var profileLinkTag = (HtmlAnchor) LoginView1.FindControl("UserProfileLink");
                profileLinkTag.HRef = $"~/Panel/Profile.aspx?UserId={user.Id}";

                var userDropDown = (HtmlAnchor) LoginView1.FindControl("UserNameDropDown");
                userDropDown.InnerText = user.FullName;
            }
        }

        protected void LoggingOut(object sender, LoginCancelEventArgs e)
        {
            FormsAuthentication.SignOut();
            Response.Redirect("~/");
        }

        public User GetUser()
        {
            var dbContext = new QAContext();
            var userIdentity = HttpContext.Current.User.Identity;
            IQueryable<User> query = dbContext.Users;

            query = userIdentity.IsAuthenticated ? query.Where(u => u.Email == userIdentity.Name) : null;

            return query?.Single();
        }
    }
}