using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using qa_website.Model;

namespace qa_website.Panel
{
    public partial class Profile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            var dbContext = new QAContext();
            int userId;

            if (int.TryParse(Request.QueryString["UserId"], out userId) && userId > 0)
            {
                var user = dbContext.Users.SingleOrDefault(u => u.Id == userId);

                if (user != null)
                {
                    Title = UserFullName.InnerText = user.FullName;
                    FirstNameTextBox.Text = user.FirstName;
                    LastNameTextBox.Text = user.LastName;
                }
                else
                {
                    Response.Redirect("~/");
                }
            }
            else
            {
                Response.Redirect("~/");
            }
        }

        protected void InformationSubmitButton_OnClick(object sender, EventArgs e)
        {
            throw new NotImplementedException();
        }

        protected void ChangePsswordButton_OnClick(object sender, EventArgs e)
        {
            throw new NotImplementedException();
        }
    }
}