﻿using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using qa_website.Logic;

namespace qa_website
{
    public partial class QuestionDetail : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            int questionId;

            if (int.TryParse(Request.QueryString["QuestionID"], out questionId))
            {
                using (var control = new QuestionController())
                {
                    var question = control.GetQuestion(questionId);
                    if (question != null)
                    {
                        QuestionTitle.InnerText = question.Title;
                        QuestionBody.InnerText = question.Body;
                        QuestionAuthor.InnerText = question.User.FullName;
                        QuestionDate.InnerText = question.CreateDate.ToString(CultureInfo.InvariantCulture);
                        QuestionVotes.InnerText = question.Votes.Count.ToString();
                    }
                }
            }
            else
            {
                Response.Redirect("~/Default.aspx");
            }
        }
    }
}