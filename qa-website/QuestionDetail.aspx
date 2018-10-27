<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="QuestionDetail.aspx.cs" Inherits="qa_website.QuestionDetail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div runat="server" ID="ErrorDiv" class="alert alert-dismissible alert-danger" Visible="False">
        <button type="button" class="close" data-dismiss="alert">&times;</button>
        <h4 class="alert-heading">Error</h4>
        <p class="mb-0" runat="server" ID="ErrorMessage"></p>
    </div>
    <div class="jumbotron">
        <asp:HiddenField runat="server" ID="QuestionId" />
        <h2 runat="server" id="QuestionTitle"></h2>
        <p>Asked by&nbsp;<a runat="server" id="QuestionAuthor" class="alert-link" href="#"></a>&nbsp;At&nbsp;<span runat="server" id="QuestionDate"></span></p>
        <hr />
        <div class="row">
            <div class="col-1 text-center">
                <asp:LinkButton runat="server" ID="QuestionVoteUp" OnClick="QuestionVote_OnClick"><i class="fa fa-4x fa-caret-up"></i></asp:LinkButton>
                <br />
                <asp:Label runat="server" ID="QuestionVotes" CssClass="fa-2x"></asp:Label>
                <br />
                <asp:LinkButton runat="server" ID="QuestionVoteDown" OnClick="QuestionVote_OnClick"><i class="fa fa-4x fa-caret-down"></i></asp:LinkButton>
            </div>
            <div class="col-11">
                <p runat="server" id="QuestionBody"></p>
            </div>
        </div>
    </div>
</asp:Content>
