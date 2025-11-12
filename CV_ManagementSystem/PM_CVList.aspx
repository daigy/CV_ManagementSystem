<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PM_CVList.aspx.cs" Inherits="CV_ManagementSystem.PM_CVList" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <telerik:RadFormDecorator RenderMode="Lightweight" ID="RadFormDecorator1" runat="server" DecoratedControls="All" ControlsToSkip="H4H5H6" />
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <telerik:RadCodeBlock runat="server">
        <script>
        </script>
    </telerik:RadCodeBlock>
    <div id="loader" style="display: none;"></div>
    <div class="card1">
         <div class="card-header">
            <h3 class="text-center" style="color: white;">CV LOG  <strong style="color: aquamarine;"></strong></h3>
            <span style="position:absolute;left:73%;top:13%;display:flex;">
                <telerik:RadComboBox ID="Combo_Template" runat="server" RenderMode="Lightweight" CausesValidation="false" Filter="Contains" AllowCustomText="true" Width="150px"   Skin="Silk" CssClass="minfo">
                    <Items>
                        <telerik:RadComboBoxItem Text="Template 1" Value="1" Selected="true" />
                       <%-- <telerik:RadComboBoxItem Text="Template 2" Value="2" />
                        <telerik:RadComboBoxItem Text="Template 3" Value="3" />
                        <telerik:RadComboBoxItem Text="Template 4" Value="4" />--%>
                    </Items>
                </telerik:RadComboBox>
                <telerik:RadButton ID="btn_DownloadAllCV"  runat="server" Text="Download"  CssClass="btn btn-info ml-5" Width="30%" RenderMode="Lightweight" Skin="Silk" OnClick="btn_DownloadAllCV_Click">
                                        </telerik:RadButton>
       </span>
        </div>
        <div class="card-body">
            <div class="form-group row" style="overflow-x: scroll; overflow-y: scroll; height: 600px;">
                <div class="col-sm-12">
                    <telerik:RadGrid ID="RadGrid_CV" AutoGenerateColumns="false" runat="server" OnNeedDataSource="RadGrid_CV_NeedDataSource"
                        RenderMode="Lightweight" Skin="Silk"  OnItemCommand="RadGrid_CV_ItemCommand" OnItemDataBound="RadGrid_CV_ItemDataBound">
                        <MasterTableView DataKeyNames="CV_TranID,Epromis,Missing_Sections"
                            BorderWidth="1" HeaderStyle-Height="50" EditMode="InPlace"
                            HeaderStyle-Font-Size="12px" HeaderStyle-Font-Bold="true" AllowPaging="false">
                            <Columns>
                                <telerik:GridTemplateColumn HeaderText="Select All" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="5px" ItemStyle-Width="5px" ItemStyle-HorizontalAlign="Center">
                                    <HeaderTemplate>
                                        <asp:CheckBox ID="chkHeader" runat="server" AutoPostBack="true" CssClass="ml-2" OnCheckedChanged="chkHeader_CheckedChanged" OnClick="checkAll(this)" />
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chkSelect"  CssClass="ml-2" runat="server" AutoPostBack="true" OnCheckedChanged="chkHeader_CheckedChanged" OnClick="highlightRow(this)" />
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridTemplateColumn HeaderText="SL No" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="20px">
                                    <ItemTemplate>
                                        <%# Container.ItemIndex + 1 %>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridBoundColumn DataField="CV_TranID" HeaderText="CV_TranID" ReadOnly="true" ForceExtractValue="Always" Display="false" />
                                <telerik:GridBoundColumn DataField="Epromis" HeaderText="Epromis" ReadOnly="true" ForceExtractValue="Always" HeaderStyle-Width="50px"/>
                                 <telerik:GridBoundColumn DataField="EmployeeName" HeaderText="PM Name" ReadOnly="true" ForceExtractValue="Always" />  
                                <telerik:GridBoundColumn DataField="CurrentPosition" HeaderText="Designation" ReadOnly="true" ForceExtractValue="Always" />
                                <telerik:GridBoundColumn DataField="EntryDate" HeaderText="Updated Date" DataFormatString="{0:dd/MM/yyyy}" ReadOnly="true" ForceExtractValue="Always" ItemStyle-HorizontalAlign="Center" HeaderStyle-Width="50px" />
                             <telerik:GridTemplateColumn UniqueName="DownLoad" HeaderText="" HeaderStyle-Width="40px"  EnableHeaderContextMenu="false" Exportable="false">
                                    <ItemTemplate>
                                        <asp:Label ID="lb_pendingDetails" runat="server" Text='<%#Eval("Missing_Sections")%>' ForeColor="Red" ></asp:Label>
                                        <telerik:RadButton ID="btn_Download" runat="server" Text="DownLoad" CssClass="btn btn-info"
                                            Width="100px" RenderMode="Lightweight" Skin="Silk" CommandArgument='<%#Eval("CV_TranID")%>' CommandName="DownLoad">
                                        </telerik:RadButton>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                 <telerik:GridBoundColumn DataField="Missing_Sections" Display="false" />
                            </Columns>
                            <HeaderStyle Width="150px" />
                        </MasterTableView>
                        <GroupingSettings CaseSensitive="false" />
                    </telerik:RadGrid>
                </div>
            </div>
        </div>
    </div>
    <link href="Resources/sweetalert2/sweetalert2.min.css" rel="stylesheet" />
    <script src="Resources/sweetalert2/sweetalert2.min.js"></script>
  
    <script type="text/javascript">
        $(document).ready(function () {

        });
        //function showDownloadLoader() {
        //    debugger;
        //    $("#loader").show();
        //    Swal.fire({
        //        title: 'Generating PDF...',
        //        text: 'Please wait while we merge and download all CVs.',
        //        allowOutsideClick: false,
        //        allowEscapeKey: false,
        //        didOpen: () => {
        //            Swal.showLoading();
        //            $("#loader").hide();
        //        }
        //    });

        //    // return true to allow postback to continue
        //    return true;
        //}
        function checkAll(headerCheckbox) {
            var grid = $find('<%= RadGrid_CV.ClientID %>');
            var items = grid.get_masterTableView().get_dataItems();
            var isChecked = headerCheckbox.checked;

            for (var i = 0; i < items.length; i++) {
                var checkbox = items[i].findElement("chkSelect");
                checkbox.checked = isChecked;

                if (isChecked) {
                    items[i].get_element().style.backgroundColor = '#d1d1d1'; // Highlight row with yellow color
                } else {
                    items[i].get_element().style.backgroundColor = ''; // Reset row color
                }
            }
        }

        // Function to highlight row when a checkbox is clicked
        function highlightRow(rowCheckbox) {
            var row = rowCheckbox.closest("tr");

            if (rowCheckbox.checked) {
                row.style.backgroundColor = '#d1d1d1'; // Highlight with yellow color
            } else {
                row.style.backgroundColor = ''; // Reset row color
            }
        }
        function ValidationGrid() {
            swal.fire({
                title: 'Please check atleast one checkbox!!!',
                timer: 5000,
                icon: "warning",
                buttonsStyling: false,
                confirmButtonText: "OK",
                customClass: {
                    confirmButton: "btn btn-info"
                }
            });
        }
    </script>

</asp:Content>

