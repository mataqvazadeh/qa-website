using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.ModelBinding;
using System.Web.UI;
using System.Web.UI.WebControls;
using qa_website.Model;

namespace qa_website
{
    public partial class UserStats : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            var dbContext = new QAContext();
            int userId;

            if (int.TryParse(Request.QueryString["UserId"], out userId) && userId > 0)
            {
                var user = dbContext.Users.SingleOrDefault(u => u.Id == userId);
                Title = user?.FullName ?? "Untitled";
            }

        }

        public IQueryable<User> GetUser([QueryString("UserId")] int? userId)
        {
            var dbContext = new QAContext();
            IQueryable<User> query = dbContext.Users;

            if (userId.HasValue && userId > 0)
            {
                query = query.Where(q => q.Id == userId.Value);
            }
            else
            {
                Response.Redirect("~/");
                query = null;
            }

            return query;
        }
    }
}