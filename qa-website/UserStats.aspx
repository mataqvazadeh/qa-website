<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="UserStats.aspx.cs" Inherits="qa_website.UserStats" %>

<%@ Import Namespace="System.Globalization" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:FormView runat="server" ID="UserDetail"
        ItemType="qa_website.Model.User" DataKeyNames="Id" SelectMethod="GetUser" CssClass="col-12">
        <ItemTemplate>
            <div class="card border-dark my-3">
                <h3 class="card-header"><%# Item.FullName %></h3>
                <div class="card-body">
                    <div class="row">
                        <div class="col-3">
                            <b>Email:</b>&nbsp;
                        <a href="mailto:<%# Item.Email %>"><%# Item.Email %></a>
                        </div>
                        <div class="col-5">
                            <b>Registered At</b>&nbsp;
                        <%# Item.RegisterDate.ToLongDateString() %>
                        </div>
                        <div class="col-2">
                            <b>Answers:</b>&nbsp;
                        <%# Item.Answers.Count %>
                        </div>
                        <div class="col-2">
                            <b>Questions:</b>&nbsp;
                        <%# Item.Questions.Count %>
                        </div>
                    </div>
                </div>
            </div>
        </ItemTemplate>
    </asp:FormView>
</asp:Content>
