<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="QuestionDetail.aspx.cs" Inherits="qa_website.QuestionDetail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="jumbotron">
        <h2 runat="server" id="QuestionTitle"></h2>
        <p>Asked by <span runat="server" id="QuestionAuthor"></span> At <span runat="server" id="QuestionDate"></span></p>
        <hr />
        <div class="row">
            <div class="col-2 text-center">
                <i class="fa fa-4x fa-caret-up"></i>
                <br/>
                <span class="fa-2x" runat="server" ID="QuestionVotes"></span>
                <br/>
                <i class="fa fa-caret-down fa-4x"></i>
            </div>
            <div class="col-10">
                <p runat="server" id="QuestionBody" class="col-12"></p>
            </div>
        </div>
    </div>
</asp:Content>
