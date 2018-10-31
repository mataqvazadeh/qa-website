<%@ Page Title="Contact" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="qa_website.Contact" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="jumbotron">
        <h2 class="mb-5">Contact Me</h2>
        <div class="row">
            <div class="col-3">
                <img src="Content/me.png" alt="It's me!" class="border border-success" width="250" />
            </div>
            <div class="col-9" style="font-size: large">
                <p>Hi</p>
                <p>My name is Mohammad Ali and I developed this project.</p>
                <p>If have you any question about this project send email to me or send issue in GitHup.</p>
                <p>Best Regards</p>
                <address>
                    <strong>Email:</strong>   <a href="mailto:m.a.taghvazadeh@gmail.com">m.a.taghvazadeh@gmail.com</a><br />
                    <strong>GitHub:</strong>   <a href="https://github.com/mataqvazadeh/qa-website" target="_blank">qa-website Project</a><br />
                </address>
            </div>
        </div>
    </div>
</asp:Content>
