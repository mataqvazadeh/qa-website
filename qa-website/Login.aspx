<%@ Page Title="Login" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="qa_website.Login" %>
<asp:Content ID="LoginForm" ContentPlaceHolderID="MainContent" runat="server">
    <asp:Login ID="Login1" runat="server" DestinationPageUrl="~/Default.aspx" DisplayRememberMe="False" OnAuthenticate="Login1_Authenticate" VisibleWhenLoggedIn="False">
    </asp:Login>
</asp:Content>
