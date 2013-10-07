<%@ Control Language="C#" AutoEventWireup="True" CodeBehind="SingleAnswerQuestionPicture.ascx.cs" Inherits="Website.Layout.SubLayout.SingleAnswerQuestionPicture" %>
<div class="bs-docs-grid, wrapper">
    <div class="row-fluid show-grid">
        <div class="span12 question">
            <h1>
                <sc:FieldRenderer ID="FieldRenderer1" FieldName="Question" runat="server" />
            </h1>
        </div>
    </div>

    <div class="row" style="text-align: center">
        <asp:Repeater ID="AnswerRepeater" runat="server">
            <ItemTemplate>
                <div class="mwrapper">
                    <div class="mcol">
                        <input type="radio" class="maturity" name='<%# Sitecore.Context.Item.ID %>' id='<%# ((Sitecore.Data.Items.Item)(Container.DataItem)).ID %>' value='<%# ((Sitecore.Data.Items.Item)(Container.DataItem)).ID %>'/>
                        <label for='<%# ((Sitecore.Data.Items.Item)(Container.DataItem)).ID %>' style="background: <%# ((Sitecore.Data.Items.Item)(Container.DataItem)).Fields["color"] %>; height: <%# ((Sitecore.Data.Items.Item)(Container.DataItem)).Fields["height"] %>em;">
                            <div class="mcoltop"> <%# ((Sitecore.Data.Items.Item)(Container.DataItem))["AlternateHeading"] %></div>
                            <div class="mcolmiddle"> <%# ((Sitecore.Data.Items.Item)(Container.DataItem))["ModelText"] %></div>        
                            <div class="mcolbottom">&#10004;</div>
                        </label>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>

    <div class="row-fluid show-grid">
        <div class="span4">
            <asp:Button class="emailbutton" ID="Restart" Text="Restart" OnCommand="Restart_Click" runat="server" />
        </div>
        <div class="span4">
        </div>
        <div class="span4 text-right">
            <asp:Button class="emailbutton" ID="Next" Text="Next" OnCommand="Next_Click" runat="server" />
        </div>
    </div> 
</div>
