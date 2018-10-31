<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="UserStats.aspx.cs" Inherits="qa_website.UserStats" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:FormView runat="server" ID="UserDetail"
        ItemType="qa_website.Model.User" DataKeyNames="Id" SelectMethod="GetUser" CssClass="col-12">
        <ItemTemplate>
            <div class="card border-dark my-3">
                <h2 class="card-header"><%# Item.FullName %></h2>
                <div class="card-body">
                    <div class="row">
                        <div class="col-3">
                            <b>Email:</b>&nbsp;
                        <a href="mailto:<%# Item.Email %>"><%# Item.Email %></a>
                        </div>
                        <div class="col-5">
                            <b>Registered At</b>&nbsp;
                        <%# Item.RegisterDate.ToLongDateString() %>
                        </div>
                        <div class="col-2">
                            <b>Answers:</b>&nbsp;
                        <%# Item.Answers.Count %>
                        </div>
                        <div class="col-2">
                            <b>Questions:</b>&nbsp;
                        <%# Item.Questions.Count %>
                        </div>
                    </div>
                </div>
            </div>
        </ItemTemplate>
    </asp:FormView>
    <div class="row">
        <div class="col-6">
            <asp:HiddenField runat="server" ID="QuestionSortValue" Value="votes" />
            <div class="card border-primary mb-3">
                <div class="card-header">
                    <div class="row">
                        <div class="col-6">
                            <h3>Questions</h3>
                        </div>
                        <div class="col-6 text-right">
                            <div class="btn-group btn-group-toggle">
                                <label class="btn btn-primary <%= QuestionSortValue.Value == "votes" ? "active" : "" %>">
                                    <asp:RadioButton runat="server" ID="QuestionSortVotes" AutoPostBack="True" Checked='<%# QuestionSortValue.Value == "votes" %>'
                                        GroupName="QuestionSort" Text="Votes" OnCheckedChanged="sortQuestionRadioButton_OnCheckedChanged" />
                                </label>
                                <label class="btn btn-primary <%= QuestionSortValue.Value == "newest" ? "active" : "" %>">
                                    <asp:RadioButton runat="server" ID="QuestionSortNewest" AutoPostBack="True" Checked='<%# QuestionSortValue.Value == "newest" %>'
                                        GroupName="QuestionSort" Text="Newest" OnCheckedChanged="sortQuestionRadioButton_OnCheckedChanged" />
                                </label>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="card-body">
                    <asp:ListView runat="server" ID="QuestionsList"
                        ItemType="qa_website.Model.Question" DataKeyNames="Id" SelectMethod="GetQuestions"
                        OnPagePropertiesChanging="QuestionsList_OnPagePropertiesChanging">
                        <ItemTemplate>
                            <div class="row">
                                <div class="col-1 text-center rounded <%# Item.Answers.Any( a => a.IsAccepted) ? "text-white bg-success" : "text-muted border" %>">
                                    <p class="my-2 "><%# Item.Votes.Sum(v => v.VoteValue) %></p>
                                </div>
                                <div class="col-8">
                                    <p class="my-2"><a runat="server" class="card-link" href='<%# $"~/QuestionDetail.aspx?QuestionID={Item.Id}" %>'><%# Item.Title %></a></p>
                                </div>
                                <div class="col-3">
                                    <p class="my-2"><%# Item.CreateDate.ToShortDateString() %></p>
                                </div>
                            </div>
                            <hr />
                        </ItemTemplate>
                    </asp:ListView>
                    <div class="mt-2 text-center">
                        <asp:DataPager ID="QuestionsDataPager" runat="server" PagedControlID="QuestionsList" PageSize="4" class="btn-group pager-buttons">
                            <Fields>
                                <asp:NumericPagerField ButtonType="Button" RenderNonBreakingSpacesBetweenControls="false" NumericButtonCssClass="btn btn-primary btn-lg" CurrentPageLabelCssClass="btn btn-primary btn-lg disabled" NextPreviousButtonCssClass="btn btn-primary btn-lg" />
                            </Fields>
                        </asp:DataPager>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-6">
            <asp:HiddenField runat="server" ID="AnswerSortValue" Value="votes" />
            <div class="card border-primary mb-3">
                <div class="card-header">
                    <div class="row">
                        <div class="col-6">
                            <h3>Answers</h3>
                        </div>
                        <div class="col-6 text-right">
                            <div class="btn-group btn-group-toggle">
                                <label class="btn btn-primary <%= AnswerSortValue.Value == "votes" ? "active" : "" %>">
                                    <asp:RadioButton runat="server" ID="AnswerSortVotes" AutoPostBack="True" Checked='<%# AnswerSortValue.Value == "votes" %>'
                                        GroupName="AnswerSort" Text="Votes" OnCheckedChanged="sortAnswerRadioButton_OnCheckedChanged" />
                                </label>
                                <label class="btn btn-primary <%= AnswerSortValue.Value == "newest" ? "active" : "" %>">
                                    <asp:RadioButton runat="server" ID="AnswerSortNewest" AutoPostBack="True" Checked='<%# AnswerSortValue.Value == "newest" %>'
                                        GroupName="AnswerSort" Text="Newest" OnCheckedChanged="sortAnswerRadioButton_OnCheckedChanged" />
                                </label>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="card-body">
                    <asp:ListView runat="server" ID="AnswersList"
                        ItemType="qa_website.Model.Answer" DataKeyNames="Id" SelectMethod="GetAnswers"
                        OnPagePropertiesChanging="AnswersList_OnPagePropertiesChanging">
                        <ItemTemplate>
                            <div class="row">
                                <div class="col-1 text-center rounded <%# Item.IsAccepted ? "text-white bg-success" : "text-muted border" %>">
                                    <p class="my-2 "><%# Item.Votes.Sum(v => v.VoteValue) %></p>
                                </div>
                                <div class="col-8">
                                    <p class="my-2"><a runat="server" class="card-link" href='<%# $"~/QuestionDetail.aspx?QuestionID={Item.QuestionId}#answer{Item.Id}" %>'><%# Item.Question.Title %></a></p>
                                </div>
                                <div class="col-3">
                                    <p class="my-2"><%# Item.CreateDate.ToShortDateString() %></p>
                                </div>
                            </div>
                            <hr />
                        </ItemTemplate>
                    </asp:ListView>
                    <div class="mt-2 text-center">
                        <asp:DataPager ID="AnswersDataPager" runat="server" PagedControlID="AnswersList" PageSize="4" class="btn-group pager-buttons">
                            <Fields>
                                <asp:NumericPagerField ButtonType="Button" RenderNonBreakingSpacesBetweenControls="false" NumericButtonCssClass="btn btn-primary btn-lg" CurrentPageLabelCssClass="btn btn-primary btn-lg disabled" NextPreviousButtonCssClass="btn btn-primary btn-lg" />
                            </Fields>
                        </asp:DataPager>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
