<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="QuestionDetail.aspx.cs" Inherits="qa_website.QuestionDetail" %>

<%@ Import Namespace="System.Globalization" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {
            $('a.addComment').click(function () {
                $(this).parent().find('div.commentForm').fadeToggle();
                return false;
            });
        });
    </script>
    <div runat="server" id="ErrorDiv" class="alert alert-dismissible alert-danger" visible="False">
        <button type="button" class="close" data-dismiss="alert">&times;</button>
        <h4 class="alert-heading">Error</h4>
        <p class="mb-0" runat="server" id="ErrorMessage"></p>
    </div>
    <asp:HiddenField runat="server" ID="AnswersSortValue" Value="vote" />
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
                        <asp:LinkButton runat="server" ID="QuestionVoteUp" OnClick="QuestionVote_OnClick" CausesValidation="False" CommandArgument="<%# Item.Id %>"><i class="fa fa-4x fa-caret-up"></i></asp:LinkButton>
                        <br />
                        <asp:Label runat="server" ID="QuestionVotes" CssClass="fa-2x"><%# Item.Votes.Sum(v => v.VoteValue) %></asp:Label>
                        <br />
                        <asp:LinkButton runat="server" ID="QuestionVoteDown" OnClick="QuestionVote_OnClick" CausesValidation="False" CommandArgument="<%# Item.Id %>"><i class="fa fa-4x fa-caret-down"></i></asp:LinkButton>
                    </div>
                    <div class="col-11">
                        <p class="lead"><%# Item.Body %></p>
                    </div>
                </div>
                <div class="bg-secondary py-1 px-2" style="margin-left: 8%;">
                    <asp:ListView runat="server" ID="QuestionCommentsList" DataSource="<%# Item.Comments.OrderBy(c => c.CreateDate) %>"
                        ItemType="qa_website.Model.Comment" DataKeyNames="Id">
                        <ItemTemplate>
                            <hr />
                            <p><%# Item.Body %>&nbsp;-&nbsp;<a href="#"><%# Item.User.FullName %></a>&nbsp;At&nbsp;<%# Item.CreateDate.ToString(CultureInfo.InvariantCulture) %></p>
                        </ItemTemplate>
                    </asp:ListView>
                </div>
                <div style="margin-left: 8%;">
                    <hr />
                    <a href="#" class="card-link addComment">add a comment</a>
                    <div class="card commentForm" style="display: none">
                        <div class="card-body">
                            <div class="row">
                                <div class="form-group col-10">
                                    <asp:TextBox runat="server" ID="QuestionCommentBody"
                                        CssClass="form-control col-12" TextMode="MultiLine"
                                        placeholder="Enter your comment ..."
                                        Rows="2">
                                    </asp:TextBox>
                                    <asp:RequiredFieldValidator runat="server" ID="CommentRequiredFieldValidator"
                                        CssClass="text-danger"
                                        ControlToValidate="QuestionCommentBody"
                                        Display="Dynamic"
                                        EnableClientScript="True"
                                        ErrorMessage="Comment's Body required."
                                        ValidationGroup="QuestionComment">
                                    </asp:RequiredFieldValidator>
                                </div>
                                <div class="col-2  my-auto">
                                    <asp:Button runat="server" ID="QuestionSubmitCommentButton" CssClass="btn btn-secondary col-12"
                                        Text="Send" CausesValidation="True" ValidationGroup="QuestionComment" CommandArgument="<%# Item.Id %>"
                                        OnClick="QuestionSubmitCommentButton_OnClick" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <asp:PlaceHolder runat="server" Visible="<%# Item.Answers.Count != 0 %>">
                <div class="row mb-2">
                    <div class="col-6 text-center">
                        <h3><%# Item.Answers.Count() %>&nbsp;Answer<%# Item.Answers.Count > 1 ? "s" : "" %></h3>
                    </div>
                    <div class="col-6 text-center">
                        <div class="btn-group btn-group-toggle">
                            <label class="btn btn-primary <%= AnswersSortValue.Value == "vote" ? "active" : "" %>">
                                <asp:RadioButton runat="server" ID="sortVote" AutoPostBack="True" Checked='<%# AnswersSortValue.Value == "vote" %>'
                                    GroupName="AnswerSort" Text="Vote" OnCheckedChanged="sortAnswerRadioButton_OnCheckedChanged" />
                            </label>
                            <label class="btn btn-primary <%= AnswersSortValue.Value == "oldest" ? "active" : "" %>">
                                <asp:RadioButton runat="server" ID="sortOldest" AutoPostBack="True" Checked='<%# AnswersSortValue.Value == "oldest" %>'
                                    GroupName="AnswerSort" Text="Oldest" OnCheckedChanged="sortAnswerRadioButton_OnCheckedChanged" />
                            </label>
                        </div>
                    </div>
                </div>
            </asp:PlaceHolder>
        </ItemTemplate>
    </asp:FormView>
    <asp:ListView runat="server" ID="AnswersList"
        SelectMethod="GetAnswers"
        ItemType="qa_website.Model.Answer" DataKeyNames="Id">
        <ItemTemplate>
            <div class="card <%#: Item.IsAccepted ? "border-success" : "border-primary" %> mb-3" style="border-width: 3px;" id='<%# $"answer{Item.Id}" %>'>
                <div class="card-header">
                    <asp:PlaceHolder runat="server" Visible="<%# Item.Question.User.Email == HttpContext.Current.User.Identity.Name %>">
                        <asp:LinkButton runat="server" ID="AcceptAnswer" OnClick="AcceptAnswer_OnClick" CausesValidation="False" CommandArgument="<%# Item.Id %>">
                                    <i class="fa fa-check fa-2x <%#: Item.IsAccepted ? "text-success" : "" %>"></i>
                        </asp:LinkButton>
                    </asp:PlaceHolder>
                    &nbsp;&nbsp;
                            Answerd By&nbsp;<a href="#" class="card-link"><%# Item.User.FullName %></a>&nbsp;At&nbsp;<%# Item.CreateDate.ToString(CultureInfo.InvariantCulture) %>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-1 text-center">
                            <asp:LinkButton runat="server" ID="AnswerVoteUp" OnClick="AnswerVote_OnClick" CausesValidation="False" CommandArgument="<%# Item.Id %>"><i class="fa fa-2x fa-caret-up"></i></asp:LinkButton>
                            <br />
                            <asp:Label runat="server" ID="AnswerVotes" Font-Size="25px"><%# Item.Votes.Sum(v => v.VoteValue) %></asp:Label>
                            <br />
                            <asp:LinkButton runat="server" ID="AnswerVoteDown" OnClick="AnswerVote_OnClick" CausesValidation="False" CommandArgument="<%# Item.Id %>"><i class="fa fa-2x fa-caret-down"></i></asp:LinkButton>
                        </div>
                        <div class="col-11">
                            <p class="card-text"><%# Item.Body %></p>
                        </div>
                    </div>
                    <div class="bg-secondary py-1 px-2" style="margin-left: 8%;">
                        <asp:ListView runat="server" ID="AnswerCommentsList" DataSource="<%# Item.Comments.OrderBy(c => c.CreateDate) %>"
                            ItemType="qa_website.Model.Comment" DataKeyNames="Id">
                            <ItemTemplate>
                                <hr />
                                <p><%# Item.Body %>&nbsp;-&nbsp;<a href="#"><%# Item.User.FullName %></a>&nbsp;At&nbsp;<%# Item.CreateDate.ToString(CultureInfo.InvariantCulture) %></p>
                            </ItemTemplate>
                        </asp:ListView>
                    </div>
                    <div style="margin-left: 8%;">
                        <hr />
                        <a href="#" class="card-link addComment">add a comment</a>
                        <div class="card commentForm" style="display: none">
                            <div class="card-body">
                                <div class="row">
                                    <div class="form-group col-10">
                                        <asp:TextBox runat="server" ID="AnswerCommentBody"
                                            CssClass="form-control col-12" TextMode="MultiLine"
                                            placeholder="Enter your comment ..."
                                            Rows="2">
                                        </asp:TextBox>
                                        <asp:RequiredFieldValidator runat="server" ID="CommentRequiredFieldValidator"
                                            CssClass="text-danger"
                                            ControlToValidate="AnswerCommentBody"
                                            Display="Dynamic"
                                            EnableClientScript="True"
                                            ErrorMessage="Comment's Body required."
                                            ValidationGroup='<%# $"AnswerComment_{Item.Id}" %>'>
                                        </asp:RequiredFieldValidator>
                                    </div>
                                    <div class="col-2  my-auto">
                                        <asp:Button runat="server" ID="AnswerSubmitCommentButton" CssClass="btn btn-secondary col-12"
                                            Text="Send" CausesValidation="True" ValidationGroup='<%# $"AnswerComment_{Item.Id}" %>'
                                            OnClick="AnswerSubmitCommentButton_OnClick" CommandArgument="<%# Item.Id %>" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </ItemTemplate>
    </asp:ListView>
    <div class="jumbotron">
        <fieldset>
            <legend>Your Answer</legend>
            <div class="form-group">
                <asp:Label runat="server" ID="AnswerBodyLable" AssociatedControlID="AnswerBodyTextBox">Body</asp:Label>
                <asp:TextBox CssClass="form-control col-12" ID="AnswerBodyTextBox" TextMode="MultiLine" Rows="10" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator
                    runat="server"
                    ID="RequiredFieldValidator2"
                    CssClass="text-danger"
                    ControlToValidate="AnswerBodyTextBox"
                    Display="Dynamic"
                    EnableClientScript="True"
                    ErrorMessage="Please enter your answer."
                    ValidationGroup="SubmitAnswer">
                </asp:RequiredFieldValidator>
            </div>
        </fieldset>
        <asp:Button runat="server" ID="AnswerSubmitButton" CssClass="btn btn-primary btn-lg col-3"
            CausesValidation="True" ValidationGroup="SubmitAnswer"
            Text="Post Your Answer" OnClick="AnswerSubmitButton_OnClick" />
    </div>
</asp:Content>
