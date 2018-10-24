<%@ Page Title="Register" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="qa_website.Register" %>

<asp:Content ID="RegisterContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="jumbotron">
        <div class="row">
            <div class="col-8">
                <fieldset class="">
                    <legend>Registeration Form</legend>
                    <div class="form-group">
                        <asp:Label runat="server" ID="EmailLabel" AssociatedControlID="EmailTextBox">Email (Username)</asp:Label>
                        <asp:TextBox runat="server" ID="EmailTextBox" CssClass="form-control" placeholder="Enter email" TextMode="Email" ></asp:TextBox>
                        <asp:RequiredFieldValidator
                            runat="server"
                            ID="RequiredFieldValidator1"
                            ControlToValidate="EmailTextBox"
                            Display="Dynamic"
                            CssClass="text-danger"
                            ErrorMessage="Email field is required."
                            EnableClientScript="True">
                        </asp:RequiredFieldValidator>
                    </div>
                    <div class="form-group">
                        <asp:Label runat="server" ID="PasswordLabel" AssociatedControlID="PasswordTextBox">Password</asp:Label>
                        <asp:TextBox runat="server" ID="PasswordTextBox" class="form-control" placeholder="Enter password" TextMode="Password"></asp:TextBox>
                        <asp:RequiredFieldValidator
                            runat="server"
                            ID="RequiredFieldValidator2"
                            ControlToValidate="PasswordTextBox"
                            Display="Dynamic"
                            CssClass="text-danger"
                            ErrorMessage="Password field is required."
                            EnableClientScript="True">
                        </asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator
                            runat="server"
                            Display="Dynamic"
                            CssClass="text-danger"
                            ID="RegularExpressionValidator1"
                            ValidationExpression="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$"
                            ErrorMessage="Password must has minimum 8 characters, at least one uppercase letter, one lowercase letter and one number."
                            ControlToValidate="PasswordTextBox"
                            EnableClientScript="True">
                        </asp:RegularExpressionValidator>
                    </div>
                    <div class="form-group">
                        <asp:Label runat="server" ID="ConfirmPasswordLabel" AssociatedControlID="ConfirmPasswordTextBox">Confirm Password</asp:Label>
                        <asp:TextBox runat="server" ID="ConfirmPasswordTextBox" class="form-control" placeholder="Enter password again" TextMode="Password"></asp:TextBox>
                        <asp:RequiredFieldValidator
                            runat="server"
                            ID="RequiredFieldValidator3"
                            ControlToValidate="ConfirmPasswordTextBox"
                            Display="Dynamic"
                            CssClass="text-danger"
                            ErrorMessage="Confirm Password field is required."
                            EnableClientScript="True">
                        </asp:RequiredFieldValidator>
                        <asp:CompareValidator
                            runat="server"
                            ID="CompareValidator1"
                            ControlToCompare="PasswordTextBox"
                            ControlToValidate="ConfirmPasswordTextBox"
                            CssClass="text-danger"
                            Display="Dynamic"
                            ErrorMessage="The password and confirmation password do not match."
                            EnableClientScript="True">
                        </asp:CompareValidator>
                    </div>
                    <div class="form-group">
                        <asp:Label runat="server" ID="FirstNameLabel" AssociatedControlID="FirstNameTextBox">First Name</asp:Label>
                        <asp:TextBox runat="server" ID="FirstNameTextBox" class="form-control" placeholder="Enter your first name" TextMode="SingleLine"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <asp:Label runat="server" ID="LastNameLabel" AssociatedControlID="LastNameTextBox">Last Name</asp:Label>
                        <asp:TextBox runat="server" ID="LastNameTextBox" class="form-control" placeholder="Enter your last name"  TextMode="SingleLine"></asp:TextBox>
                    </div>
                    <asp:Button runat="server" CssClass="btn btn-primary w-100 btn-lg" Text="Submit" ID="SubmitButton" CausesValidation="true" OnClick="SubmitButton_Click" />
                </fieldset>
            </div>
            <div class="col-4">
                <div class="alert alert-dismissible alert-danger" runat="server" id="AlertDiv" visible="False">
                    <button type="button" class="close" data-dismiss="alert">&times;</button>
                    <span runat="server" ID="ErrorMessage"></span>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
