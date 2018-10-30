<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="qa_website._Default" %>

<%@ Import Namespace="System.Globalization" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="jumbotron">
        <h1>Recent Questions</h1>
        <asp:ListView runat="server" ID="QuestionsList"
            ItemType="qa_website.Model.Question" DataKeyNames="Id" SelectMethod="GetQuestions"
            OnPagePropertiesChanging="QuestionsList_OnPagePropertiesChanging">
            <ItemTemplate>
                <hr />
                <div class="row">
                    <div class="col-1 text-center text-muted">
                        <h4><%# Item.Votes.Sum(v => v.VoteValue) %></h4>
                        <p>votes</p>
                    </div>
                    <div
                        class="col-1 text-center rounded <%# Item.Answers.Count > 0 && !Item.Answers.Any( a => a.IsAccepted) ? "border border-success text-success" : (Item.Answers.Any( a => a.IsAccepted) ? "text-white bg-success" : "text-muted" ) %>">
                        <h4><%# Item.Answers.Count %></h4>
                        <p>answers</p>
                    </div>
                    <div class="col-10">
                        <h4><a runat="server" class="card-link" href='<%# $"~/QuestionDetail.aspx?QuestionID={Item.Id}" %>'><%# Item.Title %></a></h4>
                        <p class="text-muted">Asked by&nbsp;<a href="#"><%# Item.User.FullName %></a>&nbsp;At&nbsp;<%# Item.CreateDate.ToString(CultureInfo.InvariantCulture) %></p>
                    </div>
                </div>
            </ItemTemplate>
        </asp:ListView>
        <div class="mt-5 text-center">
            <asp:DataPager ID="QuestionsDataPager" runat="server" PagedControlID="QuestionsList" PageSize="5" class="btn-group pager-buttons">
                <Fields>
                    <asp:NumericPagerField ButtonType="Button" RenderNonBreakingSpacesBetweenControls="false" NumericButtonCssClass="btn btn-primary btn-lg" CurrentPageLabelCssClass="btn btn-primary btn-lg disabled" NextPreviousButtonCssClass="btn btn-primary btn-lg" />
                </Fields>
            </asp:DataPager>
        </div>
    </div>
</asp:Content>
