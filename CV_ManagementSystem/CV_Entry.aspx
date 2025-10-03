<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CV_Entry.aspx.cs" Inherits="CV_ManagementSystem.CV_Entry" %>
<%@ Register Assembly="GleamTech.DocumentUltimate" Namespace="GleamTech.DocumentUltimate.AspNet.WebForms" TagPrefix="GleamTech" %>
<%@ Register Assembly="Microsoft.ReportViewer.WebForms" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .photo-cv-container {
            display: flex;
            align-items: center;
            margin-bottom: 15px;
            margin-top: 10px;
            margin-left: 21px;
        }

            .photo-cv-container .img-placeholder {
                height: 109px;
                width: 109px;
                border: 2px dashed #ddd;
                border-radius: 6px;
                background-color: #fff;
                margin-right: 25px;
                display: flex;
                justify-content: center;
                align-items: center;
                overflow: hidden;
            }

                .photo-cv-container .img-placeholder .user-icon {
                    color: #2b2d2f;
                    font-size: 4rem;
                }

            .photo-cv-container .photo-uploader {
                color: #333;
                font-family: "Inter", sans-serif;
                font-size: 1.4rem;
                font-weight: 500;
            }

                .photo-cv-container .photo-uploader .img-title {
                    letter-spacing: 0.11px;
                    line-height: 2.1rem;
                    margin: 0 0 10px;
                }

                .photo-cv-container .photo-uploader .button-default {
                    height: 36px;
                    min-height: 36px;
                    width: auto;
                    font-size: 1.0rem;
                    letter-spacing: 0.11px;
                    line-height: 2.1rem;
                    padding: 0 30px;
                }

        .button-default {
            color: #2b2d2f;
            background-color: rgba(0, 0, 0, 0);
            border: 1px solid #d3d9de;
        }

        .myGridStyle {
            border: none !important;
        }

        .RadGrid, .RadGrid .rgMasterTable, .RadGrid .rgHeader, .RadGrid .rgFooter {
            border: none !important;
            outline: none !important;
        }

            .RadGrid, .RadGrid .rgMasterTable, .RadGrid .rgHeader, .RadGrid .rgFooter {
                border-color: transparent !important;
            }

        .myGridStyle ul {
            list-style-type: disc;
            margin-left: 20px;
        }

        .RadGrid_Default .rgAltRow {
            background: white !important;
        }

        #uploadModal .modal-dialog {
            width: 50% !important;
            margin: auto !important;
            height: auto !important;
        }

        /* Dropdown Styling */
        .dropdown-content {
            display: none;
            position: absolute;
            background-color: white;
            border: 1px solid #ccc;
            max-height: 200px;
            overflow-y: auto;
            width: 200px;
            z-index: 1000;
        }

            .dropdown-content ul {
                list-style: none;
                padding: 0;
                margin: 0;
            }

            .dropdown-content li {
                padding: 8px;
                cursor: pointer;
            }

                .dropdown-content li:hover {
                    background-color: #f1f1f1;
                }

        #rcMView_Jan, #rcMView_Feb, #rcMView_Mar, #rcMView_Apr, #rcMView_May, #rcMView_Jun,
        #rcMView_Jul, #rcMView_Aug, #rcMView_Sep, #rcMView_Oct, #rcMView_Nov, #rcMView_Dec {
            display: none;
        }

        .project-item {
            margin-left: 2%;
            margin-top: 1%;
            border-bottom: 1px dashed #ccc;
        }

            .project-item table tr:first-child td:first-child p::before {
                content: "▶"; /* Unicode arrow */
                color: #17a2b8; /* Blue color */
                font-weight: bold;
                margin-right: 5px;
                margin-left: -8%;
            }

            .project-item:last-child {
                border-bottom: none;
            }


        .RadForm_Silk .AllExperience_List fieldset, .RadForm_Silk .Edit_ProjectList fieldset, .Project_Section fieldset {
            background-color: #fff !important;
            margin-bottom: -3% !important;
            border-color: white !important;
        }

        .RadForm_Silk .AllExperience_List legend, .RadForm_Silk .Edit_ProjectList legend, .Project_Section legend {
            display: none !important;
        }

        .btn-custom::before {
            content: "\f044"; /* Unicode for FontAwesome pencil icon */
            font-family: FontAwesome;
            margin-right: 8px;
        }
        .custom-save-button{
           cursor:pointer!important;
        }
    </style>
    <link href="Resources/Custom/css/my_legend.css" rel="stylesheet" />
    <link href="Resources/Custom/css/profilePhoto.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <telerik:RadFormDecorator RenderMode="Lightweight" ID="RadFormDecorator1" runat="server" DecoratedControls="All" ControlsToSkip="H4H5H6" />
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <telerik:RadCodeBlock runat="server">
        <script>

            function loadershow() {
                if (Page_ClientValidate('SiteSave')) {
                    $("#loader").show();
                    return true;
                }
                else {
                    return false;
                }
            }
        </script>
    </telerik:RadCodeBlock>
    <div id="loader" style="display: none;"></div>

    <div class="card1">
        <div class="card-header">
            <h3 class="text-center" style="color: white;"><strong style="color: aquamarine;">Enter Your CV Details</strong></h3>
        </div>
        <div class="card-body">
            <div class="demo-container size-medium">
                <telerik:RadWizard RenderMode="Lightweight" ID="RadWizard1" runat="server">
                    <WizardSteps>
                        <telerik:RadWizardStep Title="Personal Info" CssClass="loginStep" >
                            <div class="photo-cv-container">
                                <div class="img-placeholder "><i class="fa fa-user-circle-o user-icon" runat="server" id="Profilephot0_Icon"></i>
                                    <asp:Image ID="img_ProfilePhoto"   runat="server" Height="100%" Width="100%" Visible="false" />
                                </div>
                                <div class="photo-uploader">
                                    <p class="img-title">Add a photo to your CV </p>
                                    <telerik:RadButton ID="btnOpenPhotoModal" runat="server" Text="Add photo" CssClass="button button-default" RenderMode="Lightweight" OnClick="btnOpenPhotoModal_Click"></telerik:RadButton>
                                </div>
                            </div>
                            <div class="card mb-4">
                                <div class="card-body">
                                    <div class="form-row">
                                        <div class="form-group  col-md-12">
                                            <label for="fullName">Full Name</label>
                                            <asp:TextBox ID="txt_FullName" runat="server" CssClass="form-control" Width="100%"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="form-row">
                                        <div class="form-group  col-md-12">
                                            <label for="position">Current Position</label>
                                            <asp:TextBox ID="txt_CurrentPosition" runat="server" CssClass="form-control" Width="100%"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="form-row">
                                        <div class="form-group col-md-4">
                                            <label for="telno">Tel. No.</label>
                                            <asp:TextBox ID="txt_TelNo" runat="server" CssClass="form-control" Width="100%"  ></asp:TextBox>
                                        </div>
                                        <div class="form-group col-md-4">
                                            <label for="faxno">Fax No.</label>
                                            <asp:TextBox ID="txt_FaxNo" runat="server" CssClass="form-control" Width="100%" ></asp:TextBox>
                                        </div>
                                        <div class="form-group col-md-4">
                                            <label for="pobox">P.O. Box</label>
                                            <asp:TextBox ID="txt_POBOx" runat="server" CssClass="form-control" Width="100%"></asp:TextBox>
                                        </div>
                                        <div class="form-group col-md-12" style="display:none;">
                                            <label for="Qualification">Qualification</label>
                                            <asp:TextBox ID="txt_Qualification" runat="server" CssClass="form-control" Width="100%"></asp:TextBox>
                                        </div>
                                        <div class="form-group col-md-12">
                                            <label for="Nationality">Nationality</label>
                                            <asp:TextBox ID="txt_Nationality" runat="server" CssClass="form-control" Width="100%"></asp:TextBox>
                                        </div>
                                        <div class="form-group col-md-12">
                                            <label for="Languages">Languages (Comma separated)
                                                <span>
                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="*" ForeColor="Red" ControlToValidate="txt_Languages" ValidationGroup="Validation4"></asp:RequiredFieldValidator>
                                                             </span>
                                            </label>
                                            <asp:TextBox ID="txt_Languages" runat="server" CssClass="form-control" Width="100%" placeholder="e.g. English, Arabic"></asp:TextBox>
                                        </div>
                                        <div class="form-group col-md-12">
                                             <asp:Button ID="btn_SavePersonalDetails"  ValidationGroup="Validation4" runat="server" Text="Update Personal Deatils" CssClass="fa btn input-group-text custom-save-button" Style="font-weight: bold;" OnClick="btn_SavePersonalDetails_Click" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </telerik:RadWizardStep>
                        <telerik:RadWizardStep Title="Qualification">
                                    <div class="card mb-4">
                                        <div class="card-body">
                                            <div class="form-row">
                                                <div class="form-group col-md-12">
                                                    <fieldset class="custom-fieldset">
                                                        <legend class="custom-legend">QUALIFICATIONS</legend>
                                                        <span style="color: #0d4fcd;">* Start with your latest completed graduation, then add previous ones in order.</span>
                                                        <div class="form-row mt-3">
                                                            <div class="form-group col-md-4">
                                                                <label for="lb_Qualification">Qualification</label>
                                                                <asp:TextBox ID="txt_QualificationEntry" runat="server" CssClass="form-control" Width="100%"></asp:TextBox>
                                                            </div>
                                                            <div class="form-group col-md-2">
                                                                <label for="faxno">Graduation Year</label>
                                                                <telerik:RadComboBox ID="cmb_GraduationYear" runat="server" RenderMode="Lightweight" CausesValidation="false" Filter="Contains" AllowCustomText="true" Width="100%" Skin="Silk" CssClass="minfo" EmptyMessage="Select Year">
                                                                </telerik:RadComboBox>
                                                            </div>
                                                            <div class="form-group col-md-3 mt-3">
                                                                <asp:Button ID="btn_Add_Qualification" runat="server" Text="ADD &#xf067;" CssClass="fa btn input-group-text " Style="font-weight: bold; border-radius: 8px; margin-right: -14px; background-color: #1f497d; color: white;" OnClick="btn_Add_Qualification_Click" />
                                                            </div>
                                                        </div>
                                                        <div class="form-row">
                                                            <div class="form-group col-md-12">
                                                                <telerik:RadGrid ID="RadGrid_Qualification" Skin="Default" CssClass="myGridStyle" AutoGenerateColumns="false" runat="server" OnItemCommand="RadGrid_Qualification_ItemCommand" HeaderStyle-BackColor="#1f497d" HeaderStyle-ForeColor="White" OnNeedDataSource="RadGrid_Qualification_NeedDataSource">
                                                                    <MasterTableView DataKeyNames="QualificationID,GraduationYear,QualificationName" ShowHeader="false" BorderWidth="1" HeaderStyle-Height="30" HeaderStyle-Font-Size="13px" HeaderStyle-Font-Bold="true" Font-Bold="false" Font-Size="15px">
                                                                        <Columns>
                                                                            <telerik:GridBoundColumn DataField="QualificationID" HeaderText="QualificationID" UniqueName="QualificationID" Display="false" />
                                                                            <telerik:GridTemplateColumn HeaderText="Qualification" UniqueName="QualificationName" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="75%">
                                                                                <ItemTemplate>
                                                                                    <div>
                                                                                        <ul>
                                                                                            <li>
                                                                                                <asp:TextBox ID="txt_QualificationName_Edit" CssClass="form-control" Text='<%#Eval("QualificationName") %>' runat="server" Width="100%"></asp:TextBox>
                                                                                            </li>
                                                                                        </ul>
                                                                                    </div>
                                                                                </ItemTemplate>
                                                                            </telerik:GridTemplateColumn>
                                                                            <telerik:GridTemplateColumn HeaderText="GraduationYear" UniqueName="GraduationYear" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="20%">
                                                                                <ItemTemplate>
                                                                                    <div>
                                                                                        <asp:TextBox ID="txt_GraduationYear_Edit" CssClass="form-control" Text='<%#Eval("GraduationYear") %>' runat="server" Width="100%"></asp:TextBox>
                                                                                    </div>
                                                                                </ItemTemplate>
                                                                            </telerik:GridTemplateColumn>
                                                                            <telerik:GridTemplateColumn HeaderText="Delete" HeaderStyle-Width="5%" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center">
                                                                                <ItemTemplate>
                                                                                    <div>
                                                                                        <telerik:RadImageButton ID="btn_Qualification" runat="server" Height="30px" Width="30px" Image-Url="~/Resources/Images/TrashBin.png"
                                                                                            CommandArgument='<%#Eval("QualificationName")%>' CommandName="Delete" ToolTip=" Delete " data-toggle="tooltip">
                                                                                        </telerik:RadImageButton>
                                                                                    </div>
                                                                                </ItemTemplate>
                                                                            </telerik:GridTemplateColumn>
                                                                        </Columns>
                                                                    </MasterTableView>
                                                                </telerik:RadGrid>
                                                            </div>
                                                        </div>
                                                        <div class="form-row">
                                                            <div class="form-group col-md-2">
                                                                <asp:Button ID="btn_SaveQualification" runat="server" Text="Save Qualifications" CssClass="fa btn input-group-text custom-save-button" Style="font-weight: bold;" OnClick="btn_SaveQualification_Click"   />
                                                            </div>
                                                        </div>
                                                    </fieldset>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </telerik:RadWizardStep>
                        <telerik:RadWizardStep Title="Skils">
                            <div class="card mb-4">
                                <div class="card-body">
                                    <div class="form-row">
                                        <div class="form-group col-md-12">
                                            <fieldset class="custom-fieldset">
                                                <legend class="custom-legend">COURSES / SEMINARS</legend>
                                                <div class="form-row">
                                                    <div class="form-group col-md-9">
                                                        <asp:TextBox ID="txt_Courses" CssClass="form-control custom-textbox" runat="server" Width="100%"></asp:TextBox>
                                                    </div>
                                                    <div class="form-group col-md-3">
                                                        <asp:Button ID="btn_AddCOURSES" runat="server" Text="ADD &#xf067;" CssClass="fa btn input-group-text " Style="font-weight: bold; border-radius: 8px; margin-right: -14px; background-color: #1f497d; color: white;" OnClick="btn_AddCOURSES_Click" /><!--Text="ADD &#xf067;"-->
                                                    </div>
                                                </div>
                                                <div class="form-row">
                                                    <div class="form-group col-md-12">
                                                        <telerik:RadGrid ID="SectionA_Courses" Skin="Default" CssClass="myGridStyle" AutoGenerateColumns="false" runat="server" OnItemCommand="SectionA_Courses_ItemCommand" HeaderStyle-BackColor="#1f497d" HeaderStyle-ForeColor="White" OnNeedDataSource="SectionA_Courses_NeedDataSource">
                                                            <MasterTableView DataKeyNames="SkillsTranID,Courses" ShowHeader="false" BorderWidth="1" HeaderStyle-Height="30" HeaderStyle-Font-Size="13px" HeaderStyle-Font-Bold="true" Font-Bold="false" Font-Size="15px">
                                                                <Columns>
                                                                   <telerik:GridBoundColumn DataField="SkillsTranID" HeaderText="SkillsTranID" UniqueName="SkillsTranID"  Display="false" />
                                                                    <telerik:GridTemplateColumn HeaderText="Courses" UniqueName="Courses" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="95%">
                                                                        <ItemTemplate>
                                                                            <div>
                                                                                <ul>
                                                                                    <li>
                                                                                        <asp:TextBox ID="txt_Courses_Edit" CssClass="form-control" Text='<%#Eval("Courses") %>' runat="server" Width="100%"></asp:TextBox>
                                                                                    </li>
                                                                                </ul>
                                                                            </div>
                                                                        </ItemTemplate>
                                                                    </telerik:GridTemplateColumn>
                                                                    <telerik:GridTemplateColumn HeaderText="Delete" HeaderStyle-Width="5%" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center">
                                                                        <ItemTemplate>
                                                                            <div>
                                                                                <telerik:RadImageButton ID="RadImageButton1" runat="server" Height="30px" Width="30px" Image-Url="~/Resources/Images/TrashBin.png"
                                                                                    CommandArgument='<%#Eval("Courses")%>' CommandName="Delete" ToolTip=" Delete " data-toggle="tooltip">
                                                                                </telerik:RadImageButton>
                                                                            </div>
                                                                        </ItemTemplate>
                                                                    </telerik:GridTemplateColumn>
                                                                </Columns>
                                                            </MasterTableView>
                                                        </telerik:RadGrid>
                                                    </div>
                                                </div>
                                                <div class="form-row">
                                                    <div class="form-group col-md-2">
                                                        <asp:Button ID="btn_SaveCourses" runat="server" Text="Save Courses" CssClass="fa btn input-group-text custom-save-button" Style="font-weight: bold;" OnClick="btn_SaveCourses_Click" />
                                                    </div>
                                                </div>
                                            </fieldset>
                                        </div>
                                    </div>
                                     <div class="form-row">
                                        <div class="form-group col-md-12">
                                            <fieldset class="custom-fieldset">
                                                <legend class="custom-legend">COMPUTER SKILLS</legend>
                                                <div class="form-row">
                                                    <div class="form-group col-md-9">
                                                          <asp:TextBox ID="txt_ComputerSkills" CssClass="form-control custom-textbox" runat="server" Width="100%"></asp:TextBox>
                                                    </div>
                                                    <div class="form-group col-md-3">
                                                        <asp:Button ID="btn_AddComputerSkills" runat="server" Text="ADD &#xf067;" CssClass="fa btn input-group-text " Style="font-weight: bold; border-radius: 8px; margin-right: -14px; background-color: #1f497d; color: white;" OnClick="btn_AddComputerSkills_Click" /><!--Text="ADD &#xf067;"-->
                                                    </div>
                                                </div>
                                                <div class="form-row">
                                                    <div class="form-group col-md-12">
                                            <telerik:RadGrid ID="SectionB_ComputerSkills" Skin="Default" CssClass="myGridStyle" AutoGenerateColumns="false" runat="server" OnItemCommand="SectionB_ComputerSkills_ItemCommand" HeaderStyle-BackColor="#1f497d" HeaderStyle-ForeColor="White" OnNeedDataSource="SectionB_ComputerSkills_NeedDataSource">
                                                <MasterTableView DataKeyNames="SkillsTranID,ComputerSkills" ShowHeader="false" BorderWidth="1" HeaderStyle-Height="30" HeaderStyle-Font-Size="13px" HeaderStyle-Font-Bold="true" Font-Bold="false" Font-Size="15px">
                                                    <Columns>
                                                        <telerik:GridBoundColumn DataField="SkillsTranID" HeaderText="SkillsTranID" UniqueName="SkillsTranID"  Display="false" />
                                                        <telerik:GridTemplateColumn HeaderText="ComputerSkills" UniqueName="ComputerSkills" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="95%">
                                                            <ItemTemplate>
                                                                <div>
                                                                    <ul>
                                                                        <li>
                                                                            <asp:TextBox ID="txt_ComputerSkills_Edit" CssClass="form-control" Text='<%#Eval("ComputerSkills") %>' runat="server" Width="100%"></asp:TextBox>
                                                                        </li>
                                                                    </ul>
                                                                </div>
                                                            </ItemTemplate>
                                                        </telerik:GridTemplateColumn>
                                                        <telerik:GridTemplateColumn HeaderText="Delete" HeaderStyle-Width="5%" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center">
                                                            <ItemTemplate>
                                                                <div>
                                                                    <telerik:RadImageButton ID="RadImageButton2" runat="server" Height="30px" Width="30px" Image-Url="~/Resources/Images/TrashBin.png"
                                                                        CommandArgument='<%#Eval("ComputerSkills")%>' CommandName="Delete" ToolTip=" Delete " data-toggle="tooltip">
                                                                    </telerik:RadImageButton>
                                                                </div>
                                                            </ItemTemplate>
                                                        </telerik:GridTemplateColumn>
                                                    </Columns>
                                                </MasterTableView>
                                            </telerik:RadGrid>
                                        </div>
                                    </div>
                                                   
                                                <div class="form-row">
                                                    <div class="form-group col-md-2">
                                                        <asp:Button ID="btn_SaveComputerSkills" runat="server" Text="Save Computer Skills" CssClass="fa btn input-group-text custom-save-button" Style="font-weight: bold;" OnClick="btn_SaveComputerSkills_Click" />
                                                    </div>
                                                </div>
                                            </fieldset>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </telerik:RadWizardStep >
                        <telerik:RadWizardStep Title="WORK EXPERIENCE" >
                            <div class="card mb-4">
                                <div class="card-body">
                                     <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                        <ContentTemplate>
                                     <div class="form-row" id="Btn_ForAddExperience" runat="server">
                                         <div class="form-group col-md-10"></div>
                                            <div class="form-group col-md-2 text-center">
                                                  <asp:Button ID="ShowMainExperienceEntry" runat="server" Text="Add New Work Experience" class="fa btn input-group-text custom-save-button" OnClick="ShowMainExperienceEntry_Click" style="background-color: #1f497d; color: white;" />
                                                <%--<button type="button" id="ShowMainExperienceEntry" class="fa btn input-group-text custom-save-button MainExperienceSection">Add New Work Experience</button>--%>
                                            </div>
                                        </div>
                                   <%-- <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                        <ContentTemplate>--%>
                                    <div id="MainExperience_Entry" class="MainExperience_Entry" runat="server" style="display:none;">
                                        <h5>Add Your <span style="color: #15b5cf">experience</span></h5>
                                        <div class="form-row">
                                            <div class="form-group  col-md-12">
                                                <label for="Employer">Employer</label>
                                                <asp:TextBox ID="txt_Employer" runat="server" CssClass="form-control" Width="100%"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="form-row">
                                            <div class="form-group  col-md-12">
                                                <label for="JobTitle">Job Title</label>
                                                <asp:TextBox ID="txt_JobTitle" runat="server" CssClass="form-control" Width="100%"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="form-row">
                                            <div class="form-group col-md-1">
                                                <label for="StartMonth">Start Month</label>
                                                <telerik:RadDropDownList runat="server" Skin="Silk" AutoPostBack="false" ID="ddl_StartMonth" RenderMode="Lightweight" DefaultMessage="select month">
                                                </telerik:RadDropDownList>
                                            </div>
                                            <div class="form-group col-md-1">
                                                <label for="StartYear">Start Year</label>
                                                <telerik:RadMonthYearPicker ID="txt_StartYear" Height="30px" runat="server" ShowPopupOnFocus="true" Skin="WebBlue">
                                                    <DateInput DateFormat="yyyy" EmptyMessage="choose year" Font-Size="15px" DisplayDateFormat="yyyy" runat="server">
                                                    </DateInput>
                                                </telerik:RadMonthYearPicker>
                                            </div>
                                            <div class="form-group col-md-1">
                                            </div>
                                            <div class="form-group col-md-1">
                                                <label for="EndMonth">End Month</label>
                                                <telerik:RadDropDownList runat="server" Skin="Silk" AutoPostBack="false" ID="ddl_EndMonth" RenderMode="Lightweight" DefaultMessage="select month">
                                                </telerik:RadDropDownList>
                                            </div>
                                            <div class="form-group col-md-1">
                                                <label for="EndYear">End Year</label>
                                                <telerik:RadMonthYearPicker ID="txt_EndYear" Height="30px" runat="server" ShowPopupOnFocus="true" Skin="WebBlue">
                                                    <DateInput DateFormat="yyyy" EmptyMessage="choose year" Font-Size="15px" DisplayDateFormat="yyyy" runat="server">
                                                    </DateInput>
                                                </telerik:RadMonthYearPicker>
                                            </div>
                                        </div>
                                        <div class="form-row">
                                            <div class="form-group col-md-12">
                                                <label for="JobDescription">Describe what you did in this position</label>
                                                <asp:TextBox ID="txt_JobDescription" TextMode="MultiLine" runat="server" CssClass="form-control" Width="100%"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="form-row">
                                            <div class="form-group col-md-12">
                                                <telerik:RadCheckBox ID="chk_CurrentlyWorking" runat="server" Text="I currently work here" />
                                            </div>
                                        </div>
                                        <div class="form-row">
                                            <div class="form-group col-md-2">
                                               <%-- <button type="button" id="SaveExperienceButton" class="fa btn input-group-text custom-save-button MainExperienceSection" style="background-color: #1f497d; color: white;" >Add Project Details</button>
                                                <asp:Button ID="btn_SaveMainExperience" runat="server" Style="visibility: hidden;" OnClick="btn_SaveMainExperience_Click" />--%>
                                                  <asp:Button ID="btn_SaveMainExperience" runat="server" Text="Add Project Details" CssClass="fa btn input-group-text custom-save-button" style="background-color: #1f497d; color: white;" OnClick="btn_SaveMainExperience_Click" />
                                            </div>
                                            <div class="form-group col-md-2">
                                                <asp:Button ID="btn_GoBack_FromAddExperiencePage" class="fa btn input-group-text custom-save-button MainExperienceSection" Text="Go Back" runat="server"   OnClick="btn_GoBack_FromAddExperiencePage_Click" />
                                            </div>
                                        </div>
                                    </div>
                                            <asp:HiddenField ID="CurrentInserted_hdnTranID" runat="server" />
                                            <div id="Project_Section" class="Project_Section" runat="server" style="display: none;">
                                                <div class="form-row">
                                                    <div class="form-group  col-md-12">
                                                        <telerik:RadListView ID="RadListView_Experience" runat="server" RenderMode="Lightweight" ItemPlaceholderID="DataGroupPlaceHolder3"
                                                            InsertItemPosition="BeforeDataGroups" AllowMultiFieldSorting="True"
                                                            AllowPaging="false" GroupAggregatesScope="AllItems" DataKeyNames="ExperienceTranID,Employer" OnItemDataBound="RadListView_Experience_ItemDataBound">
                                                            <ItemTemplate>
                                                                <div class="row">
                                                                    <div class="col-md-1"></div>
                                                                    <div class="col-md-10 page3">
                                                                        <div class="card  direct-chat direct-chat-primary shadow-none">
                                                                            <div class="card-body">
                                                                                <div class="row">
                                                                                    <div class="col-md-12">
                                                                                        <div class="rlvI_">
                                                                                            <div class="row d-flex justify-content-between" style="margin-left: -15px;">
                                                                                                <div class="col-md-4 text-left">
                                                                                                    <h5><span style="color: #17a2b8;"><%#Eval("Employer")%></span></h5>
                                                                                                </div>
                                                                                                <div class="col-md-4 text-left">
                                                                                                    <h6 class=""><span style="color: #17a2b8;"><%#Eval("S_MonthName")%></span>
                                                                                                        <span style="color: #17a2b8;"><%#Eval("StartYear")%> - 
                                                                                                            <%# Convert.ToBoolean(Eval("CurrentlyWorkStatus")) ? "Present": Eval("E_MonthName")+" "+ Eval("EndYear")   %> 
                                                                                                    </h6>
                                                                                                </div>
                                                                                                <div class="col-md-4"></div>
                                                                                            </div>

                                                                                            <table>
                                                                                                <tr>
                                                                                                    <td style="text-align: left!important; border-bottom-color: white!important; color: #aba3a3; font-weight: bold;">
                                                                                                        <%#Eval("JobTitle")%>
                                                                                                    </td>
                                                                                                </tr>
                                                                                                <tr>
                                                                                                    <td><%#Eval("JobDescription")%></td>
                                                                                                </tr>
                                                                                            </table>
                                                                                            <telerik:RadListView ID="RadListView_Project" runat="server">
                                                                                                <ItemTemplate>
                                                                                                    <div class="project-item">
                                                                                                        <table style="width: 100%;">
                                                                                                            <tr>
                                                                                                                <td style="width: 10%;">
                                                                                                                    <p><strong>Project </strong></p>
                                                                                                                </td>
                                                                                                                <td style="width: 1%;">
                                                                                                                    <p>:</p>
                                                                                                                </td>
                                                                                                                <td style="width: 60%;">
                                                                                                                    <p><%# Eval("ProjectName") %></p>
                                                                                                                </td>
                                                                                                            </tr>
                                                                                                            <tr runat="server" visible='<%# !string.IsNullOrEmpty(Eval("Position").ToString()) %>'>
                                                                                                                <td>
                                                                                                                    <p><strong>Position </strong></p>
                                                                                                                </td>
                                                                                                                <td style="width: 1%;">
                                                                                                                    <p>:</p>
                                                                                                                </td>
                                                                                                                <td>
                                                                                                                    <p><%# Eval("Position") %></p>
                                                                                                                </td>
                                                                                                            </tr>
                                                                                                             <tr runat="server" visible='<%# !string.IsNullOrEmpty(Eval("Description").ToString()) %>'>
                                                                                                                <td>
                                                                                                                    <p><strong>Description </strong></p>
                                                                                                                </td>
                                                                                                                <td style="width: 1%;">
                                                                                                                    <p>:</p>
                                                                                                                </td>
                                                                                                                <td>
                                                                                                                    <p><%# Eval("Description") %></p>
                                                                                                                </td>
                                                                                                            </tr>
                                                                                                            <tr>
                                                                                                                <td>
                                                                                                                    <p><strong>ScopeOfWork </strong></p>
                                                                                                                </td>
                                                                                                                <td style="width: 1%;">
                                                                                                                    <p>:</p>
                                                                                                                </td>
                                                                                                                <td>
                                                                                                                    <p><%# Eval("ScopeOfWork") %> </p>
                                                                                                                </td>
                                                                                                            </tr>
                                                                                                            <tr runat="server" visible='<%# !string.IsNullOrEmpty(Eval("Client").ToString()) %>'>
                                                                                                                <td>
                                                                                                                    <p><strong>Client </strong></p>
                                                                                                                </td>
                                                                                                                <td style="width: 1%;">
                                                                                                                    <p>:</p>
                                                                                                                </td>
                                                                                                                <td>
                                                                                                                    <p><%# Eval("Client") %></p>
                                                                                                                </td>
                                                                                                            </tr>
                                                                                                             <tr runat="server" visible='<%# !string.IsNullOrEmpty(Eval("ContractPrice").ToString()) %>'>
                                                                                                                <td>
                                                                                                                    <p><strong>Contract Price </strong></p>
                                                                                                                </td>
                                                                                                                <td style="width: 1%;">
                                                                                                                    <p>:</p>
                                                                                                                </td>
                                                                                                                <td>
                                                                                                                    <p><%# Eval("ContractPrice") %></p>
                                                                                                                </td>
                                                                                                            </tr>
                                                                                                            <tr runat="server" visible='<%# !string.IsNullOrEmpty(Eval("Consultant").ToString()) %>'>
                                                                                                                <td>
                                                                                                                    <p><strong>Consultant </strong></p>
                                                                                                                </td>
                                                                                                                <td style="width: 1%;">
                                                                                                                    <p>:</p>
                                                                                                                </td>
                                                                                                                <td>
                                                                                                                    <p><%# Eval("Consultant") %></p>
                                                                                                                </td>
                                                                                                            </tr>
                                                                                                        </table>
                                                                                                    </div>
                                                                                                </ItemTemplate>
                                                                                            </telerik:RadListView>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </ItemTemplate>
                                                            <LayoutTemplate>
                                                                <asp:Panel ID="DataGroup_Experience" runat="server">
                                                                </asp:Panel>
                                                                <telerik:RadDataPager RenderMode="Lightweight" ID="RadDataPager1" runat="server" PagedControlID="RadListView1" Visible="false"
                                                                    Skin="Silk" PageSize="15" class="clearfix">
                                                                    <Fields>
                                                                        <telerik:RadDataPagerButtonField FieldType="FirstPrev" FirstButtonText="First" PrevButtonText="Prev"></telerik:RadDataPagerButtonField>
                                                                        <telerik:RadDataPagerButtonField FieldType="Numeric" PageButtonCount="10"></telerik:RadDataPagerButtonField>
                                                                        <telerik:RadDataPagerButtonField FieldType="NextLast" NextButtonText="Next" LastButtonText="Last"></telerik:RadDataPagerButtonField>
                                                                    </Fields>
                                                                </telerik:RadDataPager>
                                                            </LayoutTemplate>
                                                            <GroupSeparatorTemplate>
                                                            </GroupSeparatorTemplate>
                                                            <DataGroups>
                                                                <telerik:ListViewDataGroup GroupField="ExperienceTranID" DataGroupPlaceholderID="DataGroup_Experience"
                                                                    SortOrder="Ascending">
                                                                    <DataGroupTemplate>
                                                                        <asp:Panel runat="server" ID="Panel3" CssClass="dataGroup" GroupingText='<%# (Container as RadListViewDataGroupItem).DataGroupKey %>'>
                                                                            <asp:PlaceHolder runat="server" ID="DataGroupPlaceHolder3"></asp:PlaceHolder>
                                                                        </asp:Panel>
                                                                    </DataGroupTemplate>
                                                                </telerik:ListViewDataGroup>
                                                            </DataGroups>
                                                        </telerik:RadListView>
                                                    </div>
                                                </div>
                                                <h5>Add Your <span style="color: #15b5cf">Projects at this company</span></h5>
                                                <div class="form-row">
                                                    <div class="form-group  col-md-6">
                                                        <label for="Project">Project List</label>
                                                        <telerik:RadComboBox ID="Combo_NewProject" runat="server" RenderMode="Lightweight" CausesValidation="false" Filter="Contains"
                                                            AllowCustomText="true" Width="100%" Skin="Silk" DataSourceID="SD_project" DataTextField="ProjectName" DataValueField="ProjectName" CssClass="minfo"
                                                            EmptyMessage="Select" AutoPostBack="true" OnSelectedIndexChanged="Combo_NewProject_SelectedIndexChanged">
                                                        </telerik:RadComboBox>
                                                    </div>
                                                    <div class="form-group  col-md-6" runat="server" style="display: none;" id="Other_newEntryProject">
                                                        <label for="Project">Project Name</label>
                                                        <asp:TextBox ID="txt_Project" runat="server" CssClass="form-control" Width="100%"></asp:TextBox>
                                                    </div>
                                                </div>
                                                 <div class="form-row">
                                                    <div class="form-group  col-md-12">
                                                        <label for="Position">Position 
                                                            <span>
                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*" ForeColor="Red" ControlToValidate="txt_PositionForEachPrjct" ValidationGroup="Validation1"></asp:RequiredFieldValidator>
                                                             </span></label>
                                                        <asp:TextBox ID="txt_PositionForEachPrjct" runat="server" CssClass="form-control" Width="100%"></asp:TextBox>
                                                    </div>
                                                </div>
                                                 <div class="form-row">
                                                    <div class="form-group  col-md-12">
                                                        <label for="Client">Describe what you did in this project</label>
                                                        <asp:TextBox ID="txt_DecriptionForProjct" runat="server" CssClass="form-control" Width="100%"></asp:TextBox>
                                                    </div>
                                                </div>
                                                <div class="form-row">
                                                    <div class="form-group  col-md-12">
                                                        <label for="Client">Client</label>
                                                        <asp:TextBox ID="txt_Client" runat="server" CssClass="form-control" Width="100%"></asp:TextBox>
                                                    </div>
                                                </div>
                                                <div class="form-row">
                                                    <div class="form-group col-md-12">
                                                        <label for="ContractPrice">Contract Price</label>
                                                        <asp:TextBox ID="txt_ContractPrice" runat="server" CssClass="form-control" Width="100%"></asp:TextBox>
                                                    </div>
                                                </div>
                                                <div class="form-row">
                                                    <div class="form-group col-md-12">
                                                        <label for="ScopeOfWork">Scope of Work</label>
                                                        <asp:TextBox ID="txt_ScopeOfWork" runat="server" CssClass="form-control" Width="100%"></asp:TextBox>
                                                    </div>
                                                </div>
                                                <div class="form-row">
                                                    <div class="form-group col-md-12">
                                                        <label for="ScopeOfWork">Consultant</label>
                                                        <asp:TextBox ID="txt_Consultant" runat="server" CssClass="form-control" Width="100%"></asp:TextBox>
                                                    </div>
                                                </div>
                                                <div class="form-row">
                                                    <div class="form-group col-md-2">
                                                        <asp:Button ID="btn_SaveProject" runat="server" Text="Save" ValidationGroup="Validation1" CssClass="fa btn input-group-text custom-save-button" Style="font-weight: bold;" OnClick="btn_SaveProject_Click" />
                                                    </div>
                                                    <div class="form-group col-md-3" style="margin-top: -2px; padding: 5px; border: 1px dashed #ccc;">
                                                        <div class="text-center">
                                                            <asp:LinkButton ID="ViewAllExperience_FromProjects" CssClass="b-b-primary text-primary" runat="server" OnClick="ViewAllExperience_FromProjects_Click">View All Experience</asp:LinkButton>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        <%--</ContentTemplate>
                                        <Triggers>
                                            <asp:PostBackTrigger ControlID="ViewAllExperience_FromProjects" />
                                             <asp:PostBackTrigger ControlID="btn_GoBack_FromAddExperiencePage" />
                                        </Triggers>
                                    </asp:UpdatePanel>--%>
                                    
                                            <div id="AllExperience_List" class="form-row AllExperience_List" runat="server" style="margin-top: -2%;">
                                                <div class="form-group col-md-12">
                                                    <div class="form-row">
                                                        <div class="form-group col-md-12">
                                                            <h5 style="text-decoration: underline;">WORK EXPERIENCE</h5>
                                                            <telerik:RadListView ID="AllExperience_RadListView" runat="server" RenderMode="Lightweight" ItemPlaceholderID="DataGroupPlaceHolder3"
                                                                InsertItemPosition="BeforeDataGroups" AllowMultiFieldSorting="True"
                                                                AllowPaging="false" GroupAggregatesScope="AllItems" DataKeyNames="ExperienceTranID,Employer" OnItemDataBound="AllExperience_RadListView_ItemDataBound"
                                                                OnItemCommand="AllExperience_RadListView_ItemCommand">
                                                                <ItemTemplate>
                                                                    <div class="row">
                                                                        <div class="col-md-12">
                                                                            <div class="card  direct-chat direct-chat-primary shadow-none">
                                                                                <div class="card-body">
                                                                                    <div class="row">
                                                                                        <div class="col-md-12">
                                                                                            <div class="rlvI_">
                                                                                                <div class="row d-flex justify-content-between" style="margin-left: -15px;">
                                                                                                    <div class="col-md-4 text-left">
                                                                                                        <h5><span style="color: #17a2b8;"><%#Eval("Employer")%></span></h5>
                                                                                                    </div>
                                                                                                    <div class="col-md-4 text-left">
                                                                                                        <h6 class=""><span style="color: #17a2b8;"><%#Eval("S_MonthName")%></span>
                                                                                                            <span style="color: #17a2b8;"><%#Eval("StartYear")%> - 
                                                                                                            <%# Convert.ToBoolean(Eval("CurrentlyWorkStatus")) ? "Present": Eval("E_MonthName")+" "+ Eval("EndYear")   %> 
                                                                                                        </h6>
                                                                                                    </div>
                                                                                                    <div class="col-md-1 text-right" style="margin-left: 16%;">
                                                                                                        <asp:LinkButton ID="btn_ExperienceEdit" runat="server" CssClass="btn btn-primary" CommandName="EditItem" CommandArgument='<%#Eval("ExperienceTranID")%>'>
                                                                                                            <i class="fa fa-pencil-square-o"></i> Edit
                                                                                                        </asp:LinkButton>

                                                                                                    </div>
                                                                                                    <div class="col-md-1 text-left">
                                                                                                        <asp:LinkButton ID="btn_ExperienceDelete" runat="server" CssClass="btn btn-danger" CommandName="DeleteItem" CommandArgument='<%#Eval("ExperienceTranID")%>'>
                                                                                                            <i class="fa fa-recycle"></i> Delete
                                                                                                        </asp:LinkButton>

                                                                                                    </div>
                                                                                                </div>

                                                                                                <table>
                                                                                                    <tr>
                                                                                                        <td style="text-align: left!important; border-bottom-color: white!important; color: #aba3a3; font-weight: bold;">
                                                                                                            <%#Eval("JobTitle")%>
                                                                                                        </td>
                                                                                                    </tr>
                                                                                                    <tr>
                                                                                                        <td><%#Eval("JobDescription")%></td>
                                                                                                    </tr>
                                                                                                </table>
                                                                                                <telerik:RadListView ID="lvProjects" runat="server" OnItemDataBound="lvProjects_ItemDataBound">
                                                                                                    <ItemTemplate>
                                                                                                        <div class="project-item">
                                                                                                            <table style="width: 100%;">
                                                                                                                <tr>
                                                                                                                    <td style="width: 10%;">
                                                                                                                        <p><strong>Project </strong></p>
                                                                                                                    </td>
                                                                                                                    <td style="width: 1%;">
                                                                                                                        <p>:</p>
                                                                                                                    </td>
                                                                                                                    <td style="width: 60%;">
                                                                                                                        <p><%# Eval("ProjectName") %></p>
                                                                                                                    </td>
                                                                                                                </tr>
                                                                                                                <tr runat="server" visible='<%# !string.IsNullOrEmpty(Eval("Position").ToString()) %>'>
                                                                                                                    <td>
                                                                                                                        <p><strong>Position </strong></p>
                                                                                                                    </td>
                                                                                                                    <td style="width: 1%;">
                                                                                                                        <p>:</p>
                                                                                                                    </td>
                                                                                                                    <td>
                                                                                                                        <p><%# Eval("Position") %></p>
                                                                                                                    </td>
                                                                                                                </tr>
                                                                                                                <tr runat="server" visible='<%# !string.IsNullOrEmpty(Eval("Description").ToString()) %>'>
                                                                                                                    <td>
                                                                                                                        <p><strong>Description </strong></p>
                                                                                                                    </td>
                                                                                                                    <td style="width: 1%;">
                                                                                                                        <p>:</p>
                                                                                                                    </td>
                                                                                                                    <td>
                                                                                                                        <p><%# Eval("Description") %></p>
                                                                                                                    </td>
                                                                                                                </tr>
                                                                                                                <tr>
                                                                                                                    <td>
                                                                                                                        <p><strong>ScopeOfWork </strong></p>
                                                                                                                    </td>
                                                                                                                    <td style="width: 1%;">
                                                                                                                        <p>:</p>
                                                                                                                    </td>
                                                                                                                    <td>
                                                                                                                        <p><%# Eval("ScopeOfWork") %> </p>
                                                                                                                    </td>
                                                                                                                </tr>
                                                                                                                <tr runat="server" visible='<%# !string.IsNullOrEmpty(Eval("Client").ToString()) %>'>
                                                                                                                    <td>
                                                                                                                        <p><strong>Client </strong></p>
                                                                                                                    </td>
                                                                                                                    <td style="width: 1%;">
                                                                                                                        <p>:</p>
                                                                                                                    </td>
                                                                                                                    <td>
                                                                                                                        <p><%# Eval("Client") %></p>
                                                                                                                    </td>
                                                                                                                </tr>
                                                                                                                <tr runat="server" visible='<%# !string.IsNullOrEmpty(Eval("ContractPrice").ToString()) %>'>
                                                                                                                    <td>
                                                                                                                        <p><strong>Contract Price </strong></p>
                                                                                                                    </td>
                                                                                                                    <td style="width: 1%;">
                                                                                                                        <p>:</p>
                                                                                                                    </td>
                                                                                                                    <td>
                                                                                                                        <p><%# Eval("ContractPrice") %></p>
                                                                                                                    </td>
                                                                                                                </tr>
                                                                                                                <tr runat="server" visible='<%# !string.IsNullOrEmpty(Eval("Consultant").ToString()) %>'>
                                                                                                                    <td>
                                                                                                                        <p><strong>Consultant </strong></p>
                                                                                                                    </td>
                                                                                                                    <td style="width: 1%;">
                                                                                                                        <p>:</p>
                                                                                                                    </td>
                                                                                                                    <td>
                                                                                                                        <p><%# Eval("Consultant") %></p>
                                                                                                                    </td>
                                                                                                                </tr>
                                                                                                            </table>
                                                                                                        </div>
                                                                                                    </ItemTemplate>
                                                                                                </telerik:RadListView>
                                                                                            </div>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </ItemTemplate>
                                                                <LayoutTemplate>
                                                                    <asp:Panel ID="DataGroup_AllExperience" runat="server">
                                                                    </asp:Panel>
                                                                    <telerik:RadDataPager RenderMode="Lightweight" ID="RadDataPager1" runat="server" PagedControlID="RadListView1" Visible="false"
                                                                        Skin="Silk" PageSize="15" class="clearfix">
                                                                        <Fields>
                                                                            <telerik:RadDataPagerButtonField FieldType="FirstPrev" FirstButtonText="First" PrevButtonText="Prev"></telerik:RadDataPagerButtonField>
                                                                            <telerik:RadDataPagerButtonField FieldType="Numeric" PageButtonCount="10"></telerik:RadDataPagerButtonField>
                                                                            <telerik:RadDataPagerButtonField FieldType="NextLast" NextButtonText="Next" LastButtonText="Last"></telerik:RadDataPagerButtonField>
                                                                        </Fields>
                                                                    </telerik:RadDataPager>
                                                                </LayoutTemplate>
                                                                <DataGroups>
                                                                    <telerik:ListViewDataGroup GroupField="Employer" DataGroupPlaceholderID="DataGroup_AllExperience" >
                                                                        <DataGroupTemplate>
                                                                            <asp:Panel runat="server" ID="Panel3" CssClass="dataGroup" GroupingText='<%# (Container as RadListViewDataGroupItem).DataGroupKey %>'>
                                                                                <asp:PlaceHolder runat="server" ID="DataGroupPlaceHolder3"></asp:PlaceHolder>
                                                                            </asp:Panel>
                                                                        </DataGroupTemplate>
                                                                    </telerik:ListViewDataGroup>
                                                                </DataGroups>
                                                                <SortExpressions>
                                                                    <telerik:RadListViewSortExpression FieldName="CurrentlyWorkStatus" SortOrder="Descending" />
                                                                    <telerik:RadListViewSortExpression FieldName="EndYear" SortOrder="Descending" />
                                                                </SortExpressions>
                                                            </telerik:RadListView>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                   <%-- <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                        <ContentTemplate>--%>
                                  <div id="EditWorkExperience" runat="server" style="display: none;">

                                      <div class="row" style="margin-top: -2%;">
                                          <div class="form-group col-md-11"></div>
                                          <div class="form-group col-md-1" style="margin-bottom: -3em;">
                                              <asp:Button ID="btn_EditGoBack_FromAddExperience" runat="server"  class="fa btn input-group-text custom-save-button MainExperienceSection" Text="Go Back" OnClick="btn_EditGoBack_FromAddExperience_Click" />
                                              <asp:HiddenField ID="edit_ExperienceTranID" runat="server" />
                                          </div>
                                      </div>
                                      <div class="form-row">
                                          <div class="form-group  col-md-12">
                                              <h5 style="text-decoration: underline;">Edit Your <span style="color: #15b5cf">Employer Details</span></h5>
                                          </div>
                                          <div class="form-group  col-md-12">
                                              <label for="Employer">Employer</label>
                                              <asp:TextBox ID="txt_EditEmployer" runat="server" CssClass="form-control" Width="100%"></asp:TextBox>
                                          </div>
                                      </div>
                                      <div class="form-row">
                                          <div class="form-group  col-md-12">
                                              <label for="JobTitle">Job Title</label>
                                              <asp:TextBox ID="txt_EditJobTitle" runat="server" CssClass="form-control" Width="100%"></asp:TextBox>
                                          </div>
                                      </div>
                                      <div class="form-row">
                                          <div class="form-group col-md-1">
                                              <label for="StartMonth">Start Month</label>
                                              <telerik:RadDropDownList runat="server" Skin="Silk" AutoPostBack="false" ID="ddl_EditStartMonth" RenderMode="Lightweight" DefaultMessage="select month">
                                              </telerik:RadDropDownList>
                                          </div>
                                          <div class="form-group col-md-1">
                                              <label for="StartYear">Start Year</label>
                                              <telerik:RadMonthYearPicker ID="txt_EditStartYear" Height="30px" runat="server" ShowPopupOnFocus="true" Skin="WebBlue">
                                                  <DateInput DateFormat="yyyy" EmptyMessage="choose year" Font-Size="15px" DisplayDateFormat="yyyy" runat="server">
                                                  </DateInput>
                                              </telerik:RadMonthYearPicker>
                                          </div>
                                          <div class="form-group col-md-1">
                                          </div>
                                          <div class="form-group col-md-1">
                                              <label for="EndMonth">End Month</label>
                                              <telerik:RadDropDownList runat="server" Skin="Silk" AutoPostBack="false" ID="ddl_EditEndMonth" RenderMode="Lightweight" DefaultMessage="select month">
                                              </telerik:RadDropDownList>
                                          </div>
                                          <div class="form-group col-md-1">
                                              <label for="EndYear">End Year</label>
                                              <telerik:RadMonthYearPicker ID="txt_EditEndYear" Height="30px" runat="server" ShowPopupOnFocus="true" Skin="WebBlue">
                                                  <DateInput DateFormat="yyyy" EmptyMessage="choose year" Font-Size="15px" DisplayDateFormat="yyyy" runat="server">
                                                  </DateInput>
                                              </telerik:RadMonthYearPicker>
                                          </div>
                                      </div>
                                      <div class="form-row">
                                          <div class="form-group col-md-12">
                                              <label for="JobDescription">Describe what you did in this position</label>
                                              <asp:TextBox ID="txt_EditJobDescription" TextMode="MultiLine" runat="server" CssClass="form-control" Width="100%"></asp:TextBox>
                                          </div>
                                      </div>
                                      <div class="form-row">
                                          <div class="form-group col-md-12">
                                              <telerik:RadCheckBox ID="chk_EditCurrentlyWorking" runat="server" Text="I currently work here" />
                                          </div>
                                      </div>
                                        
                                      <div id="Edit_ProjectList"  class="form-row Edit_ProjectList" runat="server" >
                                        <div class="form-group col-md-12">
                                                <div class="form-row">
                                                    <div class="form-group col-md-12">
                                                        <h5 style="text-decoration:underline;">Edit Your <span style="color: #15b5cf">Projects at this company</span></h5>
                                                        <telerik:RadListView ID="RadListView_EditProjects" runat="server" RenderMode="Lightweight" ItemPlaceholderID="DataGroupPlaceHolder3"
                                                            InsertItemPosition="BeforeDataGroups" AllowMultiFieldSorting="True"
                                                            AllowPaging="false" GroupAggregatesScope="AllItems" DataKeyNames="ExperienceTranID,ProjectTranID"  
                                                            OnItemCommand="RadListView_EditProjects_ItemCommand">
                                                            <ItemTemplate>
                                                                <div class="row">
                                                                    <div class="col-md-12">
                                                                        <div class="card  direct-chat direct-chat-primary shadow-none">
                                                                            <div class="card-body">
                                                                                <div class="row">
                                                                                    <div class="col-md-12">
                                                                                        <div class="rlvI_">
                                                                                        <div class="project-item">
                                                                                            <table style="width:100%;">
                                                                                                <tr>
                                                                                                    <td style="width:10%;"><p><strong>Project </strong></p> </td>
                                                                                                    <td style="width:1%;"><p>:</p> </td>
                                                                                                    <td style="width:60%;">
                                                                                                        <p>
                                                                                                            <asp:HiddenField ID="hdn_ExperienceTranID" Value='<%# Eval("ExperienceTranID") %>' runat="server" />
                                                                                                            <asp:HiddenField ID="hdn_ProjectTranID"  Value='<%# Eval("ProjectTranID") %>' runat="server" />
                                                                                                        <asp:TextBox ID="txt_EditProject" runat="server" Text='<%# Eval("ProjectName") %>' CssClass="form-control" Width="100%"></asp:TextBox>
                                                                                                       </p>
                                                                                                    </td>
                                                                                                </tr>
                                                                                                <tr>
                                                                                                    <td><p><strong>Position 
                                                                                                        <span>
                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="*" ControlToValidate="txt_Edit_PositionForEachPrjct" ForeColor="Red" ValidationGroup="Validation3"></asp:RequiredFieldValidator>
                                                             </span>
                                                                                                           </strong></p> </td>
                                                                                                        <td style="width:1%;"><p>:</p> </td>
                                                                                                    <td><p>
                                                                                                         <asp:TextBox ID="txt_Edit_PositionForEachPrjct" runat="server" Text='<%# Eval("Position") %>' CssClass="form-control" Width="100%"></asp:TextBox>
                                                                                                     </p> </td>
                                                                                                </tr>
                                                                                                <tr>
                                                                                                    <td><p><strong>Describe what you did in this project </strong></p> </td>
                                                                                                        <td style="width:1%;"><p>:</p> </td>
                                                                                                    <td><p>
                                                                                                         <asp:TextBox ID="txt_Edit_DescriptionForProjct" runat="server" Text='<%# Eval("Description") %>' CssClass="form-control" Width="100%"></asp:TextBox>
                                                                                                     </p> </td>
                                                                                                </tr>
                                                                                                 <tr>
                                                                                                    <td><p><strong>Client </strong></p> </td>
                                                                                                        <td style="width:1%;"><p>:</p> </td>
                                                                                                    <td><p>
                                                                                                         <asp:TextBox ID="txt_EditClient" runat="server" Text='<%# Eval("Client") %>' CssClass="form-control" Width="100%"></asp:TextBox>
                                                                                                     </p> </td>
                                                                                                </tr>
                                                                                                   
                                                                                                   
                                                                                                 <tr>
                                                                                                    <td><p><strong>Contract Price </strong></p> </td>
                                                                                                        <td style="width:1%;"><p>:</p> </td>
                                                                                                    <td><p><asp:TextBox ID="txt_EditContractPrice" runat="server" Text='<%# Eval("ContractPrice") %>' CssClass="form-control" Width="100%"></asp:TextBox>
                                                                                                       </p> </td>
                                                                                                </tr>
                                                                                                 <tr>
                                                                                                    <td><p><strong>ScopeOfWork </strong></p> </td>
                                                                                                    <td style="width:1%;"><p>:</p> </td>
                                                                                                    <td> <p>
                                                                                                        <asp:TextBox ID="txt_EditScopeOfWork" runat="server" Text='<%# Eval("ScopeOfWork") %>' CssClass="form-control" Width="100%"></asp:TextBox>
                                                                                                       </p>
                                                                                                      </td>
                                                                                                </tr>
                                                                                                <tr runat="server">
                                                                                                    <td><p><strong>Consultant </strong></p> </td>
                                                                                                        <td style="width:1%;"><p>:</p> </td>
                                                                                                    <td><p><asp:TextBox ID="txt_EditConsultant" runat="server" Text='<%# Eval("Consultant") %>' CssClass="form-control" Width="100%"></asp:TextBox>
                                                                                                   </p> </td>
                                                                                                </tr>
                                                                                                <tr>
                                                                                                    <td></td>
                                                                                                     <td></td>
                                                                                                    <td style="text-align:right;">
                                                                                                        <telerik:RadImageButton ID="btn_Project_Delete" runat="server" Height="30px" Width="30px" Image-Url="~/Resources/Images/TrashBin.png"
                                                                                    CommandArgument='<%#Eval("ProjectTranID")%>' CommandName="DeleteProject" ToolTip=" Delete " data-toggle="tooltip" >
                                                                                </telerik:RadImageButton>
                                                                                                    </td>
                                                                                                </tr>
                                                                                            </table>
                                                                                        </div>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </ItemTemplate>
                                                            <LayoutTemplate>
                                                                <asp:Panel ID="DataGroup_AllExperience_Edit" runat="server">
                                                                </asp:Panel>
                                                                <telerik:RadDataPager RenderMode="Lightweight" ID="RadDataPager1" runat="server" PagedControlID="RadListView1" Visible="false"
                                                                    Skin="Silk" PageSize="15" class="clearfix">
                                                                    <Fields>
                                                                        <telerik:RadDataPagerButtonField FieldType="FirstPrev" FirstButtonText="First" PrevButtonText="Prev"></telerik:RadDataPagerButtonField>
                                                                        <telerik:RadDataPagerButtonField FieldType="Numeric" PageButtonCount="10"></telerik:RadDataPagerButtonField>
                                                                        <telerik:RadDataPagerButtonField FieldType="NextLast" NextButtonText="Next" LastButtonText="Last"></telerik:RadDataPagerButtonField>
                                                                    </Fields>
                                                                </telerik:RadDataPager>
                                                            </LayoutTemplate>
                                                            <GroupSeparatorTemplate>
                                                            </GroupSeparatorTemplate>
                                                            <DataGroups>
                                                                <telerik:ListViewDataGroup GroupField="ExperienceTranID" DataGroupPlaceholderID="DataGroup_AllExperience_Edit"
                                                                    SortOrder="Ascending">
                                                                    <DataGroupTemplate>
                                                                        <asp:Panel runat="server" ID="Panel3" CssClass="dataGroup" GroupingText='<%# (Container as RadListViewDataGroupItem).DataGroupKey %>'>
                                                                            <asp:PlaceHolder runat="server" ID="DataGroupPlaceHolder3"></asp:PlaceHolder>
                                                                        </asp:Panel>
                                                                    </DataGroupTemplate>

                                                                </telerik:ListViewDataGroup>
                                                            </DataGroups>
                                                        </telerik:RadListView>
                                                    </div>
                                                </div>
                                        </div>
                                    </div>
                                      <div id="btn_Update_Main_And_Project_Section" class="form-row">
                                            <div class="form-group col-md-12">
                                                  <asp:Button ID="btn_SaveEditMainExperience" runat="server" Text="Update Details" ValidationGroup="Validation3" CssClass="fa btn input-group-text custom-save-button MainExperienceSection" Style="font-weight: bold;" OnClick="btn_SaveEditMainExperience_Click" />
                                              <%--  <button type="button" id="Save_Edit_MainExperienceButton" class="fa btn input-group-text custom-save-button MainExperienceSection">Update Details</button>
                                                <asp:Button ID="btn_SaveEditMainExperience" runat="server" Style="visibility: hidden;" OnClick="btn_SaveEditMainExperience_Click" />--%>
                                            </div>
                                           
                                        </div>
                                      <div id="Edit_AddNewProject" runat="server">
                                           <div class="form-row" style="margin-top: 0%;">
                                            <div class="form-group  col-md-12">
                                                  <h5 style="text-decoration: underline;">Add New Projects at this company</h5>
                                            </div>
                                        </div>
                                          <div class="form-row">
                                            <div class="form-group  col-md-6">
                                                <label for="Project">Project List</label>
                                               <telerik:RadComboBox ID="ComboProject" runat="server" RenderMode="Lightweight" CausesValidation="false" Filter="Contains" 
                                                  AllowCustomText="true"  Width="100%" Skin="Silk" DataSourceID="SD_project" DataTextField="ProjectName" DataValueField="ProjectName" CssClass="minfo" 
                                                   EmptyMessage="Select" AutoPostBack="true" OnSelectedIndexChanged="ComboProject_SelectedIndexChanged"> </telerik:RadComboBox>
                                               
                                            </div>
                                               <div class="form-group  col-md-6" runat="server" style="display:none;" id="Other_NewProject">
                                                    <label for="Project">Project Name</label>
                                                <asp:TextBox ID="txt_NewProject" runat="server" CssClass="form-control" Width="100%" ></asp:TextBox>
                                            </div>
                                        </div>
                                            <div class="form-row">
                                            <div class="form-group  col-md-12">
                                                <label for="Client">Position 
                                                     <span>
                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*" ForeColor="Red" ControlToValidate="txt_New_PositionForEachPrjct" ValidationGroup="Validation2"></asp:RequiredFieldValidator>
                                                             </span>
                                                </label>
                                                <asp:TextBox ID="txt_New_PositionForEachPrjct" runat="server" CssClass="form-control" Width="100%"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="form-row">
                                            <div class="form-group col-md-12">
                                                <label for="ContractPrice">Describe what you did in this project</label>
                                                <asp:TextBox ID="txt_New_DescriptionForProjct" runat="server" CssClass="form-control" Width="100%"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="form-row">
                                            <div class="form-group  col-md-12">
                                                <label for="Client">Client</label>
                                                <asp:TextBox ID="txt_NewClient" runat="server" CssClass="form-control" Width="100%"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="form-row">
                                            <div class="form-group col-md-12">
                                                <label for="ContractPrice">Contract Price</label>
                                                <asp:TextBox ID="txt_NewContractPrice" runat="server" CssClass="form-control" Width="100%"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="form-row">
                                            <div class="form-group col-md-12">
                                                <label for="ScopeOfWork">Scope of Work</label>
                                                <asp:TextBox ID="txt_NewScopeOfWork" runat="server" TextMode="MultiLine" CssClass="form-control" Width="100%"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="form-row">
                                            <div class="form-group col-md-12">
                                                <label for="ScopeOfWork">Consultant</label>
                                                <asp:TextBox ID="txt_NewConsultant" runat="server" CssClass="form-control" Width="100%"></asp:TextBox>
                                            </div>
                                        </div>
                                        <div class="form-row">
                                            <div class="form-group col-md-12">
                                                <asp:Button ID="btn_Edit_NewProject" ValidationGroup="Validation2" runat="server" Text="Save New Project Details" CssClass="fa btn input-group-text custom-save-button" Style="font-weight: bold;" OnClick="btn_Edit_NewProject_Click" />
                                            </div>
                                        </div>
                                      </div>
                                  </div>
                                             </ContentTemplate>
                                            </asp:UpdatePanel>
                                </div>
                            </div>
                        </telerik:RadWizardStep>
                         <telerik:RadWizardStep Title="Hobbies">
                                    <div class="card mb-4">
                                        <div class="card-body">
                                            <div class="form-row">
                                                <div class="form-group col-md-12">
                                                    <fieldset class="custom-fieldset">
                                                        <legend class="custom-legend">HOBBIES</legend>
                                                        <div class="form-row mt-3">
                                                            <div class="form-group col-md-8">
                                                                <label for="lb_Hobbies">Hobbies</label>
                                                                <asp:TextBox ID="txt_Hobbies" runat="server" CssClass="form-control" Width="100%"></asp:TextBox>
                                                            </div>
                                                            <div class="form-group col-md-3 mt-3">
                                                                <asp:Button ID="btn_Add_Hobbies" runat="server" Text="ADD &#xf067;" CssClass="fa btn input-group-text " Style="font-weight: bold; border-radius: 8px; margin-right: -14px; background-color: #1f497d; color: white;" OnClick="btn_Add_Hobbies_Click" />
                                                            </div>
                                                        </div>
                                                        <div class="form-row">
                                                            <div class="form-group col-md-12">
                                                                <telerik:RadGrid ID="RadGrid_Hobbies" Skin="Default" CssClass="myGridStyle" AutoGenerateColumns="false" runat="server" OnItemCommand="RadGrid_Hobbies_ItemCommand" HeaderStyle-BackColor="#1f497d" HeaderStyle-ForeColor="White" >
                                                                    <MasterTableView DataKeyNames="HobbiesID,Hobbies" ShowHeader="false" BorderWidth="1" HeaderStyle-Height="30" HeaderStyle-Font-Size="13px" HeaderStyle-Font-Bold="true" Font-Bold="false" Font-Size="15px">
                                                                        <Columns>
                                                                            <telerik:GridBoundColumn DataField="HobbiesID" HeaderText="HobbiesID" UniqueName="QualificationID" Display="false" />
                                                                            <telerik:GridTemplateColumn HeaderText="Hobbies" UniqueName="Hobbies" HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="75%">
                                                                                <ItemTemplate>
                                                                                    <div>
                                                                                        <ul>
                                                                                            <li>
                                                                                                <asp:TextBox ID="txt_Hobbies_Edit" CssClass="form-control" Text='<%#Eval("Hobbies") %>' runat="server" Width="100%"></asp:TextBox>
                                                                                            </li>
                                                                                        </ul>
                                                                                    </div>
                                                                                </ItemTemplate>
                                                                            </telerik:GridTemplateColumn>
                                                                            <telerik:GridTemplateColumn HeaderText="Delete" HeaderStyle-Width="5%" ItemStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center">
                                                                                <ItemTemplate>
                                                                                    <div>
                                                                                        <telerik:RadImageButton ID="btn_DeleteHobbies" runat="server" Height="30px" Width="30px" Image-Url="~/Resources/Images/TrashBin.png"
                                                                                            CommandArgument='<%#Eval("Hobbies")%>' CommandName="Delete" ToolTip=" Delete " data-toggle="tooltip">
                                                                                        </telerik:RadImageButton>
                                                                                    </div>
                                                                                </ItemTemplate>
                                                                            </telerik:GridTemplateColumn>
                                                                        </Columns>
                                                                    </MasterTableView>
                                                                </telerik:RadGrid>
                                                            </div>
                                                        </div>
                                                        <div class="form-row">
                                                            <div class="form-group col-md-2">
                                                                <asp:Button ID="btn_Save_Hobbies" runat="server" Text="Save Hobbies" CssClass="fa btn input-group-text custom-save-button" Style="font-weight: bold;" OnClick="btn_Save_Hobbies_Click" />
                                                            </div>
                                                        </div>
                                                    </fieldset>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </telerik:RadWizardStep>
                        <telerik:RadWizardStep Title="DOWNLOAD" >
                            <div class="card mb-4">
                                <div class="card-body">
                                     <div class="form-row" style="margin-top: -1%;">
                                          <div class="form-group col-md-3">
                                                <label for="ScopeOfWork">Choose Template</label>
                                               <telerik:RadComboBox ID="Combo_Template" runat="server" RenderMode="Lightweight" CausesValidation="false" Filter="Contains"
                                                AllowCustomText="true" Width="100%" Skin="Silk" CssClass="minfo"
                                                AutoPostBack="true" OnSelectedIndexChanged="Combo_Template_SelectedIndexChanged">
                                                <Items>
                                                    <telerik:RadComboBoxItem Text="Template 1" Value="1" Selected="true" />
                                                    <telerik:RadComboBoxItem Text="Template 2" Value="2" />
                                                    <telerik:RadComboBoxItem Text="Template 3" Value="3" />
                                                    <telerik:RadComboBoxItem Text="Template 4" Value="4" />
                                                </Items>
                                            </telerik:RadComboBox>
                                            </div>
                                         </div>
                                      <div class="form-row" style="margin-top: -1%;">
                                        <div class="form-group col-md-12">
                                            <hr />
                                            </div>
                                        </div>
                                    <div class="form-row">
                                        <div class="form-group col-md-12">
                                            <div id="ReportSection" style="height: 950px; overflow-x: auto; width: 100%; margin-top: -1%; margin-bottom: 0px;">
                                                <rsweb:ReportViewer ID="ReportViewer1" runat="server" Font-Names="Verdana" Font-Size="8pt" WaitMessageFont-Names="Verdana" WaitMessageFont-Size="14pt" Width="100%" Height="800px">
                                                </rsweb:ReportViewer>
                                                <GleamTech:DocumentViewerControl ID="DocumentViewerControl1" Width="1425px" Height="800px" runat="server"></GleamTech:DocumentViewerControl>
                                                <div id="NoData" runat="server" visible="false" style="margin-left: 40%; margin-top: 10%;">
                                                    <h5 style="color: #17a2b8">No records found.</h5>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </telerik:RadWizardStep>

                    </WizardSteps>
                </telerik:RadWizard>
            </div>
            
        </div>
    </div>
      <div id="uploadModal" class="modal fade modal-upload-photo" role="dialog">
    <div class="modal-dialog">
         <div class="modal-content" align-self: center">
             <div class="modal-header">
                 <h4 class="modal-title">Add a Photo</h4>
                 <button type="button" class="close" data-dismiss="modal" style="color: white; opacity: 1;">
                     &times;</button>
             </div>
             <div class="modal-body" style="overflow-x: scroll;" runat="server" id="Div1">
                 <div class="modal-body-div">
                     <div class="upload-wrapper">
                         <div class="upload-photo dz-clickable">
                             <i class="fa fa-user-circle-o user-icon fa-5x"></i>
                             <br />
                             <div class="filepicker dropzone"></div>
                             <label class="custom-file-upload">
                                 Browse from your device
                                   
                                 <asp:FileUpload ID="Profile_FileUpload" runat="server" CssClass="fileValid_Before button upload-btn fileUpload" />
                             </label>
                             <p class="acceptable-files">File types: JPEG, PNG, GIF. Size limited to 10MB</p>
                         </div>
                         <div id="previewContainer" style="display:none;">
                             <img id="previewImage">
                         </div>
                     </div>
                 </div>
                 <button type="button" id="cropButton" class="btn button-primary photosave" >Save</button>
                         <asp:Button ID="btnSave_ProfilePhoto" runat="server" Text="Save to Database" OnClick="btnSave_ProfilePhoto_Click" Style="visibility: hidden;" />
                         <!-- Hidden Field to Store Cropped Image -->
                         <asp:HiddenField ID="hiddenCroppedImage" runat="server" />
             </div>
        </div>
    </div>
</div>
     <asp:SqlDataSource ID="SD_project" runat="server" ConnectionString="<%$ ConnectionStrings:MyConnectionString %>" SelectCommandType="StoredProcedure" SelectCommand="USP_GetExistingProjects"></asp:SqlDataSource>
    <script type="text/javascript" src="Resources/Material/js/bootstrap/js/bootstrap.min.js "></script>
    <script type="text/javascript" src="Resources/Material/js/popper.js/popper.min.js"></script>
    <link href="Resources/sweetalert2/sweetalert2.min.css" rel="stylesheet" />
    <script src="Resources/sweetalert2/sweetalert2.min.js"></script>
    <!-- Cropper.js for image resizing -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/cropperjs/1.5.12/cropper.min.css" rel="stylesheet">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/cropperjs/1.5.12/cropper.min.js"></script>

    <script type="text/javascript">

        $(document).ready(function () {
           <%-- $("#SaveExperienceButton").click(function () {
                $('#<%=btn_SaveMainExperience.ClientID %>').click();
            });--%>
            <%--$("#GoBack_FromAddExperiencePage").click(function () {
                $('#<%=btn_GoBack_FromAddExperiencePage.ClientID %>').click();
            });--%>
            <%--$("#Edit_GoBack_FromAddExperiencePage").click(function () {
                $('#<%=btn_EditGoBack_FromAddExperience.ClientID %>').click();
            });--%>
           <%-- $("#Save_Edit_MainExperienceButton").click(function () {
                $('#<%=btn_SaveEditMainExperience.ClientID %>').click();
            });--%>
        });

        function Courses_Validation() {
            swal.fire({
                title: 'Please add the course details.',
                icon: "warning",
                buttonsStyling: false,
                confirmButtonText: "OK",
                customClass: {
                    confirmButton: "btn btn-info"
                }
            });
        }
        function Hobbies_Validation() {
            swal.fire({
                title: 'Please add the Hobbies details.',
                icon: "warning",
                buttonsStyling: false,
                confirmButtonText: "OK",
                customClass: {
                    confirmButton: "btn btn-info"
                }
            });
        }
        function ComputerSkills_Validation() {
            swal.fire({
                title: 'Please add the computer skills details.',
                icon: "warning",
                buttonsStyling: false,
                confirmButtonText: "OK",
                customClass: {
                    confirmButton: "btn btn-info"
                }
            });
        }
        function Qualification_Validation() {
            swal.fire({
                title: 'Please add the Qualification & year.',
                icon: "warning",
                buttonsStyling: false,
                confirmButtonText: "OK",
                customClass: {
                    confirmButton: "btn btn-info"
                }
            });
        }
        function SuccessAlert(val) {
            var titlemsg = "";
            if (val == 1 || val == 2 || val == 3 || val == 4 || val == 5 || val == 6) {
                if (val == "1") {
                    titlemsg = 'Your Personal information updated successfully!!!'
                }
                if (val == "2") {
                    titlemsg = 'Your Courses/Seminars Skills updated successfully!!!'
                }
                if (val == "3") {
                    titlemsg = 'Your Computer Skills updated successfully!!!'
                }
                if (val == "4") {
                    titlemsg = 'Profile photo uploaded successfully!!!'
                }
                if (val == "5") {
                    titlemsg = 'Graduation details updated successfully!!!'
                }
                if (val == "6") {
                    titlemsg = 'Hobbies details updated successfully!!!'
                }
                swal.fire({
                    title: titlemsg,
                    text: 'Redirecting...',
                    timer: 5000,
                    icon: "success",
                    buttonsStyling: false,
                    confirmButtonText: "OK",
                    customClass: {
                        confirmButton: "btn btn-info"
                    }
                });
            }

            else if (val == "0" || val == "10") {
                if (val == "0") {
                    titlemsg = "Submission Failed Please try again";
                }
                if (val == "10") {
                    titlemsg = "No image selected.";
                }
                swal.fire({
                    title: titlemsg,
                    timer: 5000,
                    icon: "warning",
                    buttonsStyling: false,
                    confirmButtonText: "OK",
                    customClass: {
                        confirmButton: "btn btn-info"
                    }
                });
            }
            $("#loader").hide();
        }
        function BulkDataUpdated() {
            $("#loader").hide();
            swal.fire({
                title: "Your Experience updated successfully!!!",
                text: 'Redirecting...',
                timer: 5000,
                icon: "success",
                buttonsStyling: false,
                confirmButtonText: "OK",
                customClass: {
                    confirmButton: "btn btn-info"
                }
            });
        }
        function DeleteAlert() {
            $("#loader").hide();
            swal.fire({
                title: 'Deleted successfully!!!',
                text: 'Redirecting...',
                timer: 2000,
                icon: "success",
                buttonsStyling: false,
                confirmButtonText: "OK",
                customClass: {
                    confirmButton: "btn btn-info"
                }
            });
        }
        function ProjectNameValidation_Others() {
            $("#loader").hide();
            swal.fire({
                title: 'Please enter Project Name',
                timer: 5000,
                icon: "warning",
                buttonsStyling: false,
                confirmButtonText: "OK",
                customClass: {
                    confirmButton: "btn btn-info"
                }
            });
        }
        function OpenPhotoModal() {
            $('#uploadModal').modal('show');
        }
        function FileTypeValidation() {
            swal.fire({
                title: '<span>Invalid file type! Please upload a PNG, JPEG, or GIF image.</span>',
                timer: 5000,
                icon: "warning",
                buttonsStyling: false,
                confirmButtonText: "OK",
                customClass: {
                    confirmButton: "btn btn-info"
                }
            });
        }
        function FileSizeValidation() {
            swal.fire({
                title: '<span>File size exceeds 10MB! Please upload a smaller file.</span>',
                timer: 5000,
                icon: "warning",
                buttonsStyling: false,
                confirmButtonText: "OK",
                customClass: {
                    confirmButton: "btn btn-info"
                }
            });
        }
        function Session_Expired() {
            swal.fire({
                title: '<span>Session expired. Please log in again..</span>',
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
     <script>
         var cropper;
         var canvas;

         // Image Preview & Cropper Initialization
         document.querySelector('.fileUpload').addEventListener('change', function (event) {
             debugger;
             var file = event.target.files[0];
             // Allowed file types
             var allowedTypes = ['image/png', 'image/jpeg', 'image/gif'];
             // File size limit (10MB)
             var maxSize = 10 * 1024 * 1024; // 10MB in bytes
             // Validate file type
             if (!allowedTypes.includes(file.type)) {
                 FileTypeValidation();
                 event.target.value = ''; // Clear file input
                 return;
             }
             // Validate file size
             else if (file.size > maxSize) {
                 FileSizeValidation();
                 event.target.value = ''; // Clear file input
                 return;
             }
             else if (file) {
                 var reader = new FileReader();
                 reader.onload = function (e) {
                     $("#previewContainer").show();
                     var image = document.getElementById('previewImage');
                     image.src = e.target.result;

                     // Destroy previous cropper instance if exists
                     if (window.cropper) {
                         window.cropper.destroy();
                     }

                     // Initialize Cropper.js
                     window.cropper = new Cropper(image, {
                         aspectRatio: 1,
                         viewMode: 2
                     });
                 };
                 reader.readAsDataURL(file);
             }
         });

         // Crop Image and Store in Hidden Field
         document.getElementById('cropButton').addEventListener('click', function () {
             if (cropper) {
                 canvas = cropper.getCroppedCanvas({
                     width: 200,
                     height: 200
                 });

                 // Convert canvas to base64
                 var croppedImageData = canvas.toDataURL("image/png");

                 // Store in hidden field
                 document.getElementById('<%= hiddenCroppedImage.ClientID %>').value = croppedImageData;

                 $('#<%=btnSave_ProfilePhoto.ClientID %>').click();
                 // Show Save Button


             }
         });
     </script>
</asp:Content>
