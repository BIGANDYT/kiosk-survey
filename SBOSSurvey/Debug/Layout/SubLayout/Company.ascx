<%@ Control Language="C#" AutoEventWireup="True" CodeBehind="Company.ascx.cs" Inherits="Website.Layout.SubLayout.Company" %>
<div class="bs-docs-grid, wrapper">
    <div class="row-fluid show-grid">
        <div class="span12 question">
            <h1><sc:FieldRenderer ID="FieldRenderer1" FieldName="Question" runat="server" /></h1>
        </div>
    </div>
    <div class="row-fluid show-grid" style="text-align:center">
        <asp:DataList ID="AnswerRepeater" RepeatColumns="2" RepeatDirection="Horizontal" runat="server">
            <ItemTemplate>
                <div class="span1">
                    <input type="radio" name='<%# ((Sitecore.Data.Items.Item)(Container.DataItem)).Parent.ID %>' id='<%# ((Sitecore.Data.Items.Item)(Container.DataItem)).ID %>' value='<%# ((Sitecore.Data.Items.Item)(Container.DataItem)).ID %>' class="radio" />
                    <label for='<%# ((Sitecore.Data.Items.Item)(Container.DataItem)).ID %>'>
                        <asp:Literal ID="Literal1" Text='<%# ((Sitecore.Data.Items.Item)(Container.DataItem))["Answer"] %>' runat="server" />
                    </label>
                </div>
            </ItemTemplate>
        </asp:DataList>
    </div>
    <div class="row-fluid show-grid">
        <div class="span12">
            <asp:Button ID="Buttonlink" class="emailbutton" Text="Submit" OnCommand="GreetingBtn_Click" runat="server" />
        </div>
    </div>
</div>
