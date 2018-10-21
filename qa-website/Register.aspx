<%@ Page Title="Register" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="qa_website.Register" %>
<asp:Content ID="RegisterContent" ContentPlaceHolderID="MainContent" runat="server">
    <fieldset class="">
        <legend>Registeration Form</legend>
        <div class="form-group">
            <asp:Label runat="server" ID="EmailLabel" AssociatedControlID="EmailTextBox">Email address</asp:Label>
            <asp:TextBox runat="server" ID="EmailTextBox" class="form-control" placeholder="Enter email" type="email"></asp:TextBox>
            <asp:RequiredFieldValidator 
                runat="server"
                ID="RequiredFieldValidator1"
                ControlToValidate="EmailTextBox" 
                Display="Dynamic"
                CssClass="text-danger"
                ErrorMessage="Email field is required.">
            </asp:RequiredFieldValidator>
        </div>
        <div class="form-group">
            <asp:Label runat="server" ID="PasswordLabel" AssociatedControlID="PasswordTextBox">Password</asp:Label>
            <asp:TextBox runat="server" ID="PasswordTextBox" class="form-control" placeholder="Enter password" type="password"></asp:TextBox>
            <asp:RequiredFieldValidator
                runat="server" 
                ID="RequiredFieldValidator2" 
                ControlToValidate="PasswordTextBox"
                Display="Dynamic"
                CssClass="text-danger"
                ErrorMessage="Password field is required.">
            </asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator
                runat="server"
                Display ="Dynamic"
                CssClass="text-danger"
                ID="RegularExpressionValidator1"
                ValidationExpression="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$"
                ErrorMessage="Password must has minimum 8 characters, at least one uppercase letter, one lowercase letter and one number."
                ControlToValidate="PasswordTextBox">
            </asp:RegularExpressionValidator>
        </div>
        <div class="form-group">
            <asp:Label runat="server" ID="ConfirmPasswordLabel" AssociatedControlID="ConfirmPasswordTextBox">Confirm Password</asp:Label>
            <asp:TextBox runat="server" ID="ConfirmPasswordTextBox"  class="form-control" placeholder="Enter password" type="password"></asp:TextBox>
            <asp:CompareValidator
                runat="server"
                ID="CompareValidator1"
                ControlToCompare="PasswordTextBox"
                ControlToValidate="ConfirmPasswordTextBox"
                CssClass="text-danger"
                Display="Dynamic"
                Type="String"
                ErrorMessage="The password and confirmation password do not match.">
            </asp:CompareValidator>
        </div>
        <div class="form-group">
            <asp:Label runat="server" ID="FirstNameLabel" AssociatedControlID="FirstNameTextBox">First Name</asp:Label>
            <asp:TextBox runat="server" ID="FirstNameTextBox" class="form-control" placeholder="Enter your first name" type="text"></asp:TextBox>
        </div>
        <div class="form-group">
            <asp:Label runat="server" ID="LastNameLabel" AssociatedControlID="LastNameTextBox">Last Name</asp:Label>
            <asp:TextBox runat="server" ID="LastNameTextBox" class="form-control" placeholder="Enter your last name" type="text"></asp:TextBox>
        </div>
        <asp:Button runat="server" CssClass="btn btn-primary" Text="Submit" ID="SubmitButton" CausesValidation="true" OnClick="SubmitButton_Click" />
    </fieldset>
</asp:Content>