<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="QuestionSubLayout.ascx.cs" Inherits="Website.Layout.SubLayout.QuestionSubLayout" %>
<div class="bs-docs-grid, wrapper">
    <div class="row-fluid show-grid">
        <div class="span12, fancyInput" style="text-align: center; width: 100%;">
            <sc:FieldRenderer ID="FieldRenderer1" FieldName="Question" runat="server" />
            <input type='text' />
        </div>
    </div>

    <asp:Repeater ID="AnswerRepeater" runat="server">
        <ItemTemplate>
            <div class="row-fluid show-grid" style="text-align: center">
                <div class="span12  ">
                    <input id='<%# ((Sitecore.Data.Items.Item)(Container.DataItem)).ID %>' type="radio" name='<%# ((Sitecore.Data.Items.Item)(Container.DataItem)).Parent.ID %>' value='<%# ((Sitecore.Data.Items.Item)(Container.DataItem)).ID %>' class="radio" />
                    <label style="margin: 1px; font-size: 20px; width:100%;" for='<%# ((Sitecore.Data.Items.Item)(Container.DataItem)).ID %>'>
                        <asp:Literal ID="Literal1" Text='<%# ((Sitecore.Data.Items.Item)(Container.DataItem))["Answer"] %>' runat="server" />
                    </label>
                </div>
            </div>
        </ItemTemplate>
    </asp:Repeater>
</div>
<div class="row-fluid show-grid">
    <div class="span12">
        <asp:Button class="fancyInput" Style="text-align: center" ID="Buttonlink" Text="Submit" OnCommand="GreetingBtn_Click" runat="server" />
    </div>
</div>
</div>

