<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="QuestionDetail.aspx.cs" Inherits="qa_website.QuestionDetail" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="jumbotron">
        <h2 runat="server" ID="QuestionTitle"></h2>
        <hr/>
        <p runat="server" ID="QuestionBody" class="col-12"></p>
    </div>
</asp:Content>
