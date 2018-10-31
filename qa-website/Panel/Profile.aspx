<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="qa_website.Panel.Profile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="alert alert-dismissible alert-danger mt-2" runat="server" id="ErrorDiv" visible="False">
        <button type="button" class="close" data-dismiss="alert">&times;</button>
        <span runat="server" id="ErrorMessage"></span>
    </div>
    <div class="alert alert-dismissible alert-success mt-2" runat="server" id="SuccssDiv" visible="False">
        <button type="button" class="close" data-dismiss="alert">&times;</button>
        Your Profile/Password updated successfully.
    </div>
    <div class="jumbotron">
        <h1><span runat="server" id="UserFullName" class="text-info"></span>&nbsp;Profile</h1>
        <div class="row mt-4">
            <div class="col-6">
                <fieldset>
                    <legend>Change Your Information</legend>
                    <div class="form-group">
                        <asp:Label runat="server" ID="FirstNameLabel" AssociatedControlID="FirstNameTextBox">First Name</asp:Label>
                        <asp:TextBox runat="server" ID="FirstNameTextBox" class="form-control" placeholder="Enter your first name" TextMode="SingleLine"></asp:TextBox>
                    </div>
                    <div class="form-group">
                        <asp:Label runat="server" ID="LastNameLabel" AssociatedControlID="LastNameTextBox">Last Name</asp:Label>
                        <asp:TextBox runat="server" ID="LastNameTextBox" class="form-control" placeholder="Enter your last name" TextMode="SingleLine"></asp:TextBox>
                    </div>
                    <asp:Button runat="server" CssClass="btn btn-primary w-100 btn-lg" Text="Update Profile" ID="InformationSubmitButton" OnClick="InformationSubmitButton_OnClick" />
                </fieldset>
            </div>
            <div class="col-6">
                <fieldset>
                    <legend>Change Your Password</legend>
                    <div class="form-group">
                        <asp:Label runat="server" ID="OldPasswordLabel" AssociatedControlID="OldPasswordTextBox">Your Old Password</asp:Label>
                        <asp:TextBox runat="server" ID="OldPasswordTextBox" class="form-control" placeholder="Enter your old password" TextMode="Password"></asp:TextBox>
                        <asp:RequiredFieldValidator
                            runat="server"
                            ID="RequiredFieldValidator1"
                            ControlToValidate="OldPasswordTextBox"
                            Display="Dynamic"
                            CssClass="text-danger"
                            ErrorMessage="You should enter your old password."
                            EnableClientScript="True"
                            ValidationGroup="PasswordValidationGroup">
                        </asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator
                            runat="server"
                            Display="Dynamic"
                            CssClass="text-danger"
                            ID="RegularExpressionValidator2"
                            ValidationExpression="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$"
                            ErrorMessage="Password must has minimum 8 characters, at least one uppercase letter, one lowercase letter and one number."
                            ControlToValidate="OldPasswordTextBox"
                            EnableClientScript="True"
                            ValidationGroup="PasswordValidationGroup">
                        </asp:RegularExpressionValidator>
                    </div>
                    <div class="form-group">
                        <asp:Label runat="server" ID="PasswordLabel" AssociatedControlID="PasswordTextBox">New Password</asp:Label>
                        <asp:TextBox runat="server" ID="PasswordTextBox" class="form-control" placeholder="Enter new password" TextMode="Password"></asp:TextBox>
                        <asp:RequiredFieldValidator
                            runat="server"
                            ID="RequiredFieldValidator2"
                            ControlToValidate="PasswordTextBox"
                            Display="Dynamic"
                            CssClass="text-danger"
                            ErrorMessage="Password field is required."
                            EnableClientScript="True"
                            ValidationGroup="PasswordValidationGroup">
                        </asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator
                            runat="server"
                            Display="Dynamic"
                            CssClass="text-danger"
                            ID="RegularExpressionValidator1"
                            ValidationExpression="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$"
                            ErrorMessage="Password must has minimum 8 characters, at least one uppercase letter, one lowercase letter and one number."
                            ControlToValidate="PasswordTextBox"
                            EnableClientScript="True"
                            ValidationGroup="PasswordValidationGroup">
                        </asp:RegularExpressionValidator>
                    </div>
                    <div class="form-group">
                        <asp:Label runat="server" ID="ConfirmPasswordLabel" AssociatedControlID="ConfirmPasswordTextBox">Confirm New Password</asp:Label>
                        <asp:TextBox runat="server" ID="ConfirmPasswordTextBox" class="form-control" placeholder="Enter new password again" TextMode="Password"></asp:TextBox>
                        <asp:RequiredFieldValidator
                            runat="server"
                            ID="RequiredFieldValidator3"
                            ControlToValidate="ConfirmPasswordTextBox"
                            Display="Dynamic"
                            CssClass="text-danger"
                            ErrorMessage="Confirm Password field is required."
                            EnableClientScript="True"
                            ValidationGroup="PasswordValidationGroup">
                        </asp:RequiredFieldValidator>
                        <asp:CompareValidator
                            runat="server"
                            ID="CompareValidator1"
                            ControlToCompare="PasswordTextBox"
                            ControlToValidate="ConfirmPasswordTextBox"
                            CssClass="text-danger"
                            Display="Dynamic"
                            ErrorMessage="The password and confirmation password do not match."
                            EnableClientScript="True"
                            ValidationGroup="PasswordValidationGroup">
                        </asp:CompareValidator>
                    </div>
                    <asp:Button runat="server" CssClass="btn btn-primary w-100 btn-lg" Text="Chaneg Password" ID="ChangePsswordButton" CausesValidation="true" OnClick="ChangePsswordButton_OnClick" ValidationGroup="PasswordValidationGroup" />
                </fieldset>
            </div>
        </div>
    </div>
</asp:Content>
