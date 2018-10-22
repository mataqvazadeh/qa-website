<%@ Page Title="Ask" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AskQuestion.aspx.cs" Inherits="qa_website.Panel.AskQuestion" %>

<asp:Content ID="AskContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="jumbotron">
        <div class="alert alert-dismissible alert-danger" runat="server" ID="AlertDiv" Visible="False">
            <button type="button" class="close" data-dismiss="alert">&times;</button>
            There was a problem. Please try again.
        </div>
        <fieldset>
            <legend>Ask Your Question</legend>
            <div class="form-group">
                <asp:Label runat="server" ID="TitleLable" AssociatedControlID="TitleTextBox">Title</asp:Label>
                <asp:TextBox CssClass="form-control col-6" ID="TitleTextBox" placeholder="Enter Question Title" type="text" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator
                    runat="server"
                    ID="RequiredFieldValidator1"
                    CssClass="text-danger"
                    ControlToValidate="TitleTextBox"
                    Display="Dynamic"
                    EnableClientScript="True"
                    ErrorMessage="Please enter Question Title.">
                </asp:RequiredFieldValidator>
            </div>
            <div class="form-group">
                <asp:Label runat="server" ID="BodyLable" AssociatedControlID="BodyTextBox">Body</asp:Label>
                <asp:TextBox CssClass="form-control col-12" ID="BodyTextBox" TextMode="MultiLine" Rows="10" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator
                    runat="server"
                    ID="RequiredFieldValidator2"
                    CssClass="text-danger"
                    ControlToValidate="BodyTextBox"
                    Display="Dynamic"
                    EnableClientScript="True"
                    ErrorMessage="Please enter Question Body.">
                </asp:RequiredFieldValidator>
            </div>
        </fieldset>
        <asp:Button runat="server" ID="SubmitButton" CssClass="btn btn-primary btn-lg col-3" CausesValidation="True" Text="Ask" OnClick="SubmitButton_OnClick" />
    </div>
</asp:Content>
