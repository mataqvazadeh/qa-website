using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using qa_website.Logic;

namespace qa_website.Panel
{
    public partial class AskQuestion : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void SubmitButton_OnClick(object sender, EventArgs e)
        {
            if (IsValid)
            {
                using (var controller = new QuestionController())
                {
                    if (controller.AskQuestion(TitleTextBox.Text, BodyTextBox.Text))
                    {
                        Response.Redirect("~/Default.aspx");
                    }
                    else
                    {
                        AlertDiv.Visible = true;
                    }
                }
            }
        }
    }
}