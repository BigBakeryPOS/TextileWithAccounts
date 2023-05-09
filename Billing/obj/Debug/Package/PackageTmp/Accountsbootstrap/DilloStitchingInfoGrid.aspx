﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DilloStitchingInfoGrid.aspx.cs" Inherits="Billing.Accountsbootstrap.DilloStitchingInfoGrid" %>

<%@ Register TagPrefix="usc" TagName="Header" Src="~/HeaderMaster/Header.ascx" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="en">
<head>
    <style type="text/css">
        a img
        {
            border: none;
        }
        ol li
        {
            list-style: decimal outside;
        }
        div#container
        {
            width: 780px;
            margin: 0 auto;
            padding: 1em 0;
        }
        div.side-by-side
        {
            width: 100%;
            margin-bottom: 1em;
        }
        div.side-by-side > div
        {
            float: left;
            width: 50%;
        }
        div.side-by-side > div > em
        {
            margin-bottom: 10px;
            display: block;
        }
        .clearfix:after
        {
            content: "\0020";
            display: block;
            height: 0;
            clear: both;
            overflow: hidden;
            visibility: hidden;
        }
    </style>
    <meta content="" charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <title>Cutting Info Grid</title>
    <!-- Bootstrap Core CSS -->
    <link rel="stylesheet" href="../Styles/chosen.css" />
    <link href="../css/bootstrap.min.css" rel="stylesheet" />
    <!-- MetisMenu CSS -->
    <link href="../css/plugins/metisMenu/metisMenu.min.css" rel="stylesheet" />
    <!-- Custom CSS -->
    <link href="../css/sb-admin-2.css" rel="stylesheet" />
    <!-- Custom Fonts -->
    <link href="../font-awesome-4.1.0/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
    <link href="../Styles/style1.css" rel="stylesheet" />
    <link rel="Stylesheet" type="text/css" href="../Styles/AjaxPopUp.css" />
    <script language="javascript" type="text/javascript">
        function pageLoad() {
            ShowPopup();
            setTimeout(HidePopup, 2000);
        }

        function ShowPopup() {
            $find('modalpopup').show();
            //$get('Button1').click();
        }

        function HidePopup() {
            $find('modalpopup').hide();
            //$get('btnCancel').click();
        }
    </script>
    <script type="text/javascript">
        function Search_Gridview(strKey, strGV) {


            var strData = strKey.value.toLowerCase().split(" ");

            var tblData = document.getElementById(strGV);

            var rowData;
            for (var i = 1; i < tblData.rows.length; i++) {
                rowData = tblData.rows[i].innerHTML;
                var styleDisplay = 'none';
                for (var j = 0; j < strData.length; j++) {
                    if (rowData.toLowerCase().indexOf(strData[j]) >= 0)

                        styleDisplay = '';
                    else {
                        styleDisplay = 'none';
                        break;
                    }
                }
                tblData.rows[i].style.display = styleDisplay;
            }
        }    
    </script>
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    <script type="text/javascript">
        function alertMessage() {
            alert('Are You Sure, You want to delete This Customer!');
        }
    </script>
</head>
<body>
<usc:Header ID="Header" runat="server" />
    <asp:Label runat="server" ID="lblWelcome" ForeColor="White" CssClass="label">Welcome : </asp:Label>
    <asp:Label runat="server" ID="lblUser" ForeColor="White" CssClass="label">Welcome: </asp:Label>
    <asp:Label runat="server" ID="lblUserID" ForeColor="White" CssClass="label" Visible="false"> </asp:Label>
    <form id="form1" runat="server">
    <asp:ValidationSummary runat="server" HeaderText="Validation Messages" ValidationGroup="val1"
        ID="val1" ShowMessageBox="true" ShowSummary="false" />
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div class="row">
        <div class="col-lg-12" style="margin-top: 6px">
            <h1 class="page-header" style="text-align: center; color: #fe0002;font-size:16px; font-weight:bold">
                Customer Info</h1>
        </div>
        <!-- /.col-lg-12 -->
    </div>

    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-default">
                <div class="panel-body">
                    <div class="row">
                        <div class="col-lg-12" align="center">
                            <div class="col-lg-1">
                            </div>
                            <%--<div id="Div1" runat="server" visible="false" class="col-lg-16">
                                <asp:Label runat="server" ID="Label1"></asp:Label>
                                <asp:CompareValidator ID="CompareValidator1" runat="server" ValidationGroup="val1"
                                    Style="color: White" InitialValue="0" ControlToValidate="ddlfilter" ValueToCompare="0"
                                    Text="*" Operator="NotEqual" Type="String" ErrorMessage="Please Select Search By"></asp:CompareValidator>
                                <asp:DropDownList CssClass="form-control" ID="ddlfilter" Width="150px" style="margin-top:-20px" runat="server">
                                    <asp:ListItem Text="Search By" Value="0"></asp:ListItem>
                                    <asp:ListItem Text="Contact Name" Value="1"></asp:ListItem>
                                    <asp:ListItem Text="MobileNo" Value="2"></asp:ListItem>
                                    <asp:ListItem Text="Email" Value="3"></asp:ListItem>
                                </asp:DropDownList>
                            </div>--%>
                            <%--<div class="col-lg-16">
                                <asp:RequiredFieldValidator runat="server" ValidationGroup="val1" ID="phono" ControlToValidate="txtsearch"
                                    ErrorMessage="Please enter your searching Data!" Text="*" Style="color: White" />
                                <asp:TextBox CssClass="form-control" Enabled="true" onkeyup="Search_Gridview(this, 'gvcust')"  ID="txtsearch" runat="server" style="margin-top:-20px"
                                    placeholder="Enter Text to Search" Width="250px"></asp:TextBox>
                                <ajaxToolkit:FilteredTextBoxExtender ID="FilteredTextBoxExtender4" runat="server"
                                    FilterType="LowercaseLetters, UppercaseLetters,Numbers,Custom" ValidChars=" -.@"
                                    TargetControlID="txtsearch" />
                            </div>--%>
                            <%--<div id="Div2" runat="server" visible="false" class="col-lg-17">
                                <asp:Label ID="lblerror" runat="server" Style="color: Red"></asp:Label>
                                <asp:Button ID="btnsearch" runat="server" ValidationGroup="val1" class="btn btn-success"
                                    Text="Search" OnClick="Search_Click" Width="130px" />
                            </div>--%>
                            <%--<div id="Div3" runat="server" visible="false" class="col-lg-17">
                                <asp:Button ID="btnrefresh" runat="server" class="btn btn-primary" Text="Reset" OnClick="refresh_Click"
                                    Width="130px" />
                            </div>--%>
                           <%-- <div class="col-lg-4">
                                &nbsp;&nbsp;&nbsp;&nbsp;
                            </div>--%>
                            <div class="col-lg-16">
                            <asp:TextBox ID="txtAutoName" onkeyup="Search_Gridview(this, 'gvcustinfo')" runat="server"
                                            CssClass="form-control" placeholder="Search Text" Style="width: 170px; margin-bottom: 26px;"></asp:TextBox>
                                        <ajaxToolkit:FilteredTextBoxExtender ID="FilteredTextBoxExtender4" runat="server"
                                            FilterType="LowercaseLetters, UppercaseLetters,Numbers,Custom" ValidChars=" -/.,"
                                            TargetControlID="txtAutoName" />
                                            </div>

                            <div class="col-lg-17">
                                <asp:Button ID="btnadd" runat="server" class="btn btn-danger" Text="Add New" Width="130px" OnClick="btnAddNew_entry" />
                            </div>
                            <%--<div class="col-lg-17">
                                <asp:Button ID="btnexcel" runat="server" class="btn btn-info" Text="Export-To-Excel"
                                    Width="130px" Height="32px" OnClick="btnExcel_Click" />
                            </div>--%>
                        </div>
                    </div>
                    <div style="height:392px; overflow:auto" class="table-responsive">
                        <table class="table table-bordered table-striped">
                            <tr>
                                <td>
                                    <asp:GridView ID="gvcustinfo" runat="server" CssClass="myGridStyle" EmptyDataText="No records Found"
                                        AllowPaging="true" PageSize="100000" OnPageIndexChanging="Page_Change" AutoGenerateColumns="false"
                                        OnRowCommand="gvcustinfo_RowCommand" OnRowDataBound="gvcustinfo_RowDataBound">
                                        <HeaderStyle BackColor="#3366FF" />
                                        <EmptyDataRowStyle HorizontalAlign="Center" BackColor="#59d3b4" ForeColor="Black" />
                                        <PagerSettings FirstPageText="First" LastPageText="Last" Mode="NumericFirstLast"
                                            NextPageText="Next" PreviousPageText="Previous" />
                                        <Columns>
                                            <asp:BoundField HeaderText="Employee Code" Visible="false" DataField="Emp_code" />
                                            <asp:BoundField HeaderText="Design Number" Visible="true" DataField="DesignNumber" />
                                            <asp:BoundField HeaderText="Design Number 1" Visible="false" DataField="DesignNumber1" />
                                            <asp:BoundField HeaderText="Design Number 2" Visible="false" DataField="DesignNumber2" />
                                            <asp:BoundField HeaderText="Design Number 3" Visible="false" DataField="DesignNumber3" />
                                            <asp:BoundField HeaderText="Design Number 4" Visible="false" DataField="DesignNumber4" />
                                            <asp:BoundField HeaderText="Employee Name" DataField="Name" />
                                            <asp:BoundField HeaderText="Size" DataField="Item" />
                                            <asp:BoundField HeaderText="Range" DataField="Range" />
                                            <asp:BoundField HeaderText="Quantity" DataField="Quantity" />
                                            <asp:BoundField HeaderText="Pending Quantity" DataField="PendingQuantity" />
                                            <asp:BoundField HeaderText="StitchingDate" DataField="StitchingDate" />
                                            <asp:BoundField HeaderText="DueDate" DataField="DueDate" />
                                            <asp:BoundField HeaderText="Shirt" DataField="Shirt" />
                                            <asp:BoundField HeaderText="Pant" Visible="false" DataField="Pant" />
                                            <asp:BoundField HeaderText="Coat" Visible="false" DataField="Coat" />
                                            <asp:BoundField HeaderText="T-Shirt" Visible="false" DataField="Tshirt" />
                                            <asp:BoundField HeaderText="ReceivedDate" DataField="ReceivedDate" />
                                            <asp:BoundField HeaderText="Rate Per Quantity" DataField="Rate" DataFormatString="{0:0.00}" />
                                            <asp:BoundField HeaderText="Selling Price Per Quantity" Visible="false" DataField="SellingPrice" DataFormatString="{0:0.00}" />
                                            <asp:BoundField HeaderText="Sample Price Per Quantity" Visible="false" DataField="SamplePrice" DataFormatString="{0:0.00}" />
                                            <asp:BoundField HeaderText="Total" DataField="Total" DataFormatString="{0:0.00}" />
                                            <asp:BoundField HeaderText="Selling Total" Visible="false" DataField="SellingTotal" DataFormatString="{0:0.00}" />
                                            <asp:BoundField HeaderText="Sample Total" Visible="false" DataField="SampleTotal" DataFormatString="{0:0.00}" />
                                            <asp:BoundField HeaderText="Status" DataField="Status" />
                                            <asp:BoundField HeaderText="Operator Name" Visible="false" DataField="OperatorName" />
                                            
                                            <asp:TemplateField HeaderText="Edit" ItemStyle-HorizontalAlign="Center">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="btnedit" runat="server" CommandArgument='<%#Eval("CuttingInformationID") %>'
                                                        CommandName="edit">
                                                        <asp:Image ID="img" runat="server" ImageUrl="~/images/pen-checkbox-128.png" /></asp:LinkButton>
                                                    <asp:ImageButton ID="imgdisable" ImageUrl="~/images/edit.png" runat="server" Visible="false"
                                                        Enabled="false" ToolTip="Not Allow To Delete" />
                                                    <asp:HiddenField ID="csinfoID" runat="server" Value='<%# Bind("CuttingInformationID") %>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Delete" ItemStyle-HorizontalAlign="Center">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="btndelete" runat="server" CommandArgument='<%#Eval("CuttingInformationID") %>'
                                                        CommandName="delete" OnClientClick="alertMessage()">
                                                        <asp:Image ID="dlt" runat="server" ImageAlign="Middle" ImageUrl="~/images/DeleteIcon_btn.png" /></asp:LinkButton>
                                                    <asp:ImageButton ID="imgdisable1" ImageUrl="~/images/delete.png" runat="server" Visible="false"
                                                        Enabled="false" ToolTip="Not Allow To Delete" />
                                                    <ajaxToolkit:ModalPopupExtender ID="lnkDelete_ModalPopupExtender" runat="server"
                                                        CancelControlID="ButtonDeleteCancel" OkControlID="ButtonDeleleOkay" TargetControlID="btndelete"
                                                        PopupControlID="DivDeleteConfirmation" BackgroundCssClass="ModalPopupBG">
                                                    </ajaxToolkit:ModalPopupExtender>
                                                    <ajaxToolkit:ConfirmButtonExtender ID="lnkDelete_ConfirmButtonExtender" runat="server"
                                                        TargetControlID="btndelete" Enabled="True" DisplayModalPopupID="lnkDelete_ModalPopupExtender">
                                                    </ajaxToolkit:ConfirmButtonExtender>
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Copy" ItemStyle-HorizontalAlign="Center">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="btncopy" runat="server" CommandArgument='<%#Eval("CuttingInformationID") %>'
                                                        CommandName="copy">
                                                        <asp:Image ID="imgcpy" runat="server" style="height:23px;width:18px" ImageUrl="~/images/copy.png"/></asp:LinkButton>
                                                    <asp:HiddenField ID="csinfocopyID" runat="server" Value='<%# Bind("CuttingInformationID") %>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                        </Columns>
                                        <FooterStyle BackColor="#336699" Font-Bold="True" ForeColor="White" HorizontalAlign="Left" />
                                        <HeaderStyle BackColor="#336699" Font-Bold="True" ForeColor="White" HorizontalAlign="Left" />
                                    </asp:GridView>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <!-- /.col-lg-6 (nested) -->
                </div>
                <!-- /.row (nested) -->
            </div>
        <!-- /.panel-body -->
    </div>
    <!-- /.panel -->
    </div>
    <!-- /.col-lg-12 -->


    <script src="../Scripts/jquery.min.js" type="text/javascript"></script>
    <script src="../Scripts/chosen.jquery.js" type="text/javascript"></script>
    <script type="text/javascript">        $(".chzn-select").chosen(); $(".chzn-select-deselect").chosen({ allow_single_deselect: true }); </script>
    <asp:Panel class="popupConfirmation" ID="DivDeleteConfirmation" Style="display: none"
        runat="server">
        <div class="popup_Container">
            <div class="popup_Titlebar" id="PopupHeader">
                <div class="TitlebarLeft">
                    Customer List</div>
                <div class="TitlebarRight" onclick="$get('ButtonDeleteCancel').click();">
                </div>
            </div>
            <div class="popup_Body">
                <p>
                    Are you sure want to delete?
                </p>
            </div>
            <div class="popup_Buttons">
                <input id="ButtonDeleleOkay" type="button" value="Yes" />
                <input id="ButtonDeleteCancel" type="button" value="No" />
            </div>
        </div>
    </asp:Panel>

    </form>
</body>
</html>