<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="QuestionDetail.aspx.cs" Inherits="qa_website.QuestionDetail" %>

<%@ Import Namespace="System.Globalization" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div runat="server" id="ErrorDiv" class="alert alert-dismissible alert-danger" visible="False">
        <button type="button" class="close" data-dismiss="alert">&times;</button>
        <h4 class="alert-heading">Error</h4>
        <p class="mb-0" runat="server" id="ErrorMessage"></p>
    </div>
    <asp:FormView runat="server" ID="QuestionDetailFormView"
        SelectMethod="GetQuestion"
        ItemType="qa_website.Model.Question"
        DataKeyNames="Id"
        RenderOuterTable="False">
        <ItemTemplate>
            <div class="jumbotron">
                <h2><%# Item.Title %></h2>
                <p>Asked by&nbsp;<a href="#"><%# Item.User.FullName %></a>&nbsp;At&nbsp;<%# Item.CreateDate.ToString(CultureInfo.InvariantCulture) %></p>
                <hr />
                <div class="row">
                    <div class="col-1 text-center">
                        <asp:LinkButton runat="server" ID="QuestionVoteUp" OnClick="QuestionVote_OnClick"><i class="fa fa-4x fa-caret-up"></i></asp:LinkButton>
                        <br />
                        <asp:Label runat="server" ID="QuestionVotes" CssClass="fa-2x"><%# Item.Votes.Sum(v => v.VoteValue) %></asp:Label>
                        <br />
                        <asp:LinkButton runat="server" ID="QuestionVoteDown" OnClick="QuestionVote_OnClick"><i class="fa fa-4x fa-caret-down"></i></asp:LinkButton>
                    </div>
                    <div class="col-11">
                        <p class="lead"><%# Item.Body %></p>
                    </div>
                </div>
                <div class="bg-secondary" style="margin-left: 8%; padding: 1px 10px">
                    <asp:ListView runat="server" ID="QuestionCommentsList"
                        ItemType="qa_website.Model.Comment" SelectMethod="GetQuestionComments"
                        DataKeyNames="Id">
                        <ItemTemplate>
                            <hr />
                            <p><%# Item.Body %>&nbsp;-&nbsp;<a href="#"><%# Item.User.FullName %></a>&nbsp;At&nbsp;<%# Item.CreateDate.ToString(CultureInfo.InvariantCulture) %></p>
                        </ItemTemplate>
                    </asp:ListView>
                </div>
            </div>

        </ItemTemplate>
    </asp:FormView>
</asp:Content>
