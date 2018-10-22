using qa_website.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace qa_website.Logic
{
    public class QuestionController : IDisposable
    {
        private QAContext context = new QAContext();

        public void Dispose()
        {
            context?.Dispose();
            context = null;
        }
    }
}