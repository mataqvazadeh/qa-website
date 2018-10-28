<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="QuestionDetail.aspx.cs" Inherits="qa_website.QuestionDetail" %>

<%@ Import Namespace="System.Globalization" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {
            $('#addComment').click(function () {
                $('#commentForm').fadeToggle();
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
                <div style="margin-left: 8%; padding: 1px 10px">
                <hr/>
                    <a href="#" id="addComment" class="card-link">add a comment</a>
                    <div class="card" id="commentForm" style="display: none">
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
                                        ErrorMessage="Comment's Body required.">
                                    </asp:RequiredFieldValidator>
                                </div>
                                <div class="col-2">
                                    <asp:Button runat="server" ID="QuestionSubmitCommentButton" CssClass="btn btn-secondary col-12" Text="Send" CausesValidation="True" OnClick="QuestionSubmitCommentButton_OnClick"/>
                                </div>
                            </div>
                        </div>
                    </div>                    
                </div>
            </div>

        </ItemTemplate>
    </asp:FormView>
</asp:Content>
