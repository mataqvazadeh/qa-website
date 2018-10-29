<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="QuestionDetail.aspx.cs" Inherits="qa_website.QuestionDetail" %>

<%@ Import Namespace="System.Globalization" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {
            $('a.addComment').click(function () {
                $(this).parent().find('div.commentForm').fadeToggle();
                //$('#commentForm').fadeToggle();
                return false;
            });
        });
    </script>
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
                        <asp:LinkButton runat="server" ID="QuestionVoteUp" OnClick="QuestionVote_OnClick" CausesValidation="False"><i class="fa fa-4x fa-caret-up"></i></asp:LinkButton>
                        <br />
                        <asp:Label runat="server" ID="QuestionVotes" CssClass="fa-2x"><%# Item.Votes.Sum(v => v.VoteValue) %></asp:Label>
                        <br />
                        <asp:LinkButton runat="server" ID="QuestionVoteDown" OnClick="QuestionVote_OnClick" CausesValidation="False"><i class="fa fa-4x fa-caret-down"></i></asp:LinkButton>
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
                                        Text="Send" CausesValidation="True" ValidationGroup="QuestionComment"
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
                        <div class="btn-group btn-group-toggle" data-toggle="buttons">
                            <%-- todo: Dont Forget Sorting --%>
                            <label class="btn btn-primary active">
                                <input type="radio" name="options" id="option1" autocomplete="off" checked="">
                                Vote
                            </label>
                            <label class="btn btn-primary">
                                <input type="radio" name="options" id="option3" autocomplete="off">
                                Oldest
                            </label>
                        </div>
                    </div>
                </div>
            </asp:PlaceHolder>
            <asp:ListView runat="server" ID="AnswersList" DataSource="<%# Item.Answers.OrderByDescending(a => a.IsAccepted).ThenByDescending(a => a.Votes.Sum(v => v.VoteValue)).ThenBy(a => a.CreateDate) %>"
                ItemType="qa_website.Model.Answer" DataKeyNames="Id">
                <ItemTemplate>
                    <div class="card <%#: Item.IsAccepted ? "border-success" : "border-primary" %> mb-3" style="border-width: 3px;">
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
        </ItemTemplate>
    </asp:FormView>
</asp:Content>
