﻿<%@ Page Title="Periodo" Language="C#" MasterPageFile="~/Strap.Master" AutoEventWireup="true" CodeBehind="Periodo.aspx.cs" Inherits="AdminBoqueron.Periodo" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="page-header">
        <div class="container-fluid">
            <div class="row">
                <div class="col">
                    <h3><%:Page.Title%></h3>
                </div>
            </div>
            <div class="row">
                <div class="col-5">
                    Palabra clave
                </div>
                <div class="col-2">
                    Criterio
                </div>
                <div class="col-2">
                    Páginas
                </div>
                <div class="col-3">
                    Comandos
                </div>
            </div>
            <asp:Panel runat="server" DefaultButton="SearchBtn">
                <div class="row">
                    <div class="col-5">
                        <asp:TextBox ID="txtSearchKey" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="col-2">
                        
                            <asp:DropDownList ID="searchParameterDDL" runat="server" CssClass="form-control">
                                <asp:ListItem Text="ID" Value="ID"></asp:ListItem>
                            </asp:DropDownList>
                    
                    </div>
                    <div class="col-2">

                        <asp:DropDownList ID="PageSizeDDL" runat="server" CssClass="custom-select" AutoPostBack="true">
                            <asp:ListItem Text="10" Value="10"></asp:ListItem>
                            <asp:ListItem Text="20" Value="20"></asp:ListItem>
                            <asp:ListItem Text="30" Value="30"></asp:ListItem>
                            <asp:ListItem Text="40" Value="40"></asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="col-3">
                        <div class="btn-group">
                            <asp:LinkButton runat="server" ID="SearchBtn" onserverclick="SearchBtn_ServerClick" CssClass="btn btn-outline-primary">
                                Bucar 
                                <span><i class="fa fa-search" ></i></span>
                            </asp:LinkButton>
                            <button class="btn btn-outline-primary" type="button" runat="server" id="AddLicitacionBtn" data-toggle="modal" data-target="#addModal">
                                Agregar periodo 
                                <span><i class="fas fa-plus"></i></span>
                            </button>

                        </div>
                    </div>


                </div>
            </asp:Panel>
            <div class="row">
                <asp:Label ID="ErrorLabel" runat="server" Visible="False" CssClass="form-control  alert-warning" />
            </div>
        </div>


    </div>

    <div class="container-fluid">
        <asp:DataPager ID="MainDataPager" runat="server" PagedControlID="PeriodoListView" PageSize="10">
            <Fields>
                <asp:NextPreviousPagerField ButtonCssClass="btn btn-default btn-sm" ButtonType="Button" ShowFirstPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False" FirstPageText="Primera" />
                <asp:NumericPagerField ButtonType="Button" CurrentPageLabelCssClass="btn btn-sm" NextPreviousButtonCssClass="btn btn-default btn-sm" NumericButtonCssClass="btn btn-default btn-sm" />
                <asp:NextPreviousPagerField ButtonCssClass="btn btn-default btn-sm" ButtonType="Button" ShowLastPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False" LastPageText="Última" />
            </Fields>
        </asp:DataPager>
        <asp:ListView ID="PeriodoListView"
            runat="server"
            DataSourceID="PeriodoDS"
            DataKeyNames="IdPeriodo"
            OnItemCommand="ListView_ItemCommand">
            <LayoutTemplate>
                <div class="table responsive">
                    <table class="table table-striped table-condensed">
                        <thead>
                            <th>ID</th>
                            <th>Inicio</th>
                            <th>Final</th>

                            <th>...</th>
                            <th>...</th>
                        </thead>
                        <tbody>
                            <tr runat="server" id="itemPlaceholder" />
                        </tbody>
                    </table>
                </div>
            </LayoutTemplate>
            <ItemTemplate>

                <tr>

                    <td>
                        <asp:Label ID="lblIdPeriodo" runat="server" Text='<%# Eval("IdPeriodo") %>' /></td>
                    <td>
                        <asp:Label ID="lblInicio" runat="server" Text='<%# String.Format("{0:dd/MM/yyyy}",Eval( "Inicio") ) %>' /></td>
                    <td>
                        <asp:Label ID="lblFinal" runat="server" Text='<%# String.Format("{0:dd/MM/yyyy}",Eval( "Final") ) %>' /></td>


                    <td>
                        <asp:LinkButton runat="server" ID="EditPeriodoBtn" CommandName="Editar" CommandArgument='<%# Eval("IdPeriodo")%>' ToolTip="Editar">
                            <i class="fa fa-keyboard fa-sm"></i>
                        </asp:LinkButton>
                    </td>

                    <td>

                        <asp:LinkButton runat="server" ID="DeletePeriodoBtn" CommandName="Eliminar" CommandArgument='<%# Eval("IdPeriodo")%>' ToolTip="Eliminar">
                            <i class="fas fa-trash-alt"></i>
                        </asp:LinkButton>

                    </td>

                </tr>

            </ItemTemplate>
            <EditItemTemplate>
            </EditItemTemplate>
            <InsertItemTemplate>
            </InsertItemTemplate>
        </asp:ListView>

        <!-- #region Modals -->
        <div id="addModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="addModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <div class="modal-content">
                            <div class="modal-header">
                                <b id="addModalLabel">Agregar periodo.</b>
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                            </div>
                            <div class="modal-body">
                                <asp:FormView ID="InsertFormView" runat="server" DataSourceID="PeriodoDS" Width="100%"
                                    CellPadding="4" DataKeyNames="IdPeriodo" ForeColor="#333333"
                                    DefaultMode="Insert"
                                    OnItemInserted="FormView1_ItemInserted">
                                    <EditItemTemplate>
                                    </EditItemTemplate>
                                    <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                                    <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                                    <InsertItemTemplate>
                                        <div class="container-fluid">
                                            <div class="row">
                                                <div class="col-3">ID</div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtIdPeriodo" runat="server" Text='<%# Bind("IdPeriodo") %>' CssClass="form-control" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3">Inicio</div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtInicio" runat="server" Text='<%# Bind("Inicio")  %>' CssClass="form-control" TextMode="Date" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3">Final</div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtFinal" runat="server" Text='<%# Bind("Final") %>' CssClass="form-control" TextMode="Date" />
                                                </div>
                                            </div>


                                        </div>

                                        <hr />

                                        <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Aceptar" CssClass="btn btn-success" />
                                        <asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancelar" Text="Cancelar" CssClass="btn btn-danger" OnClick="CancelButton_Click" />
                                    </InsertItemTemplate>
                                    <ItemTemplate>
                                    </ItemTemplate>



                                </asp:FormView>
                            </div>
                            <div class="modal-footer">
                            </div>
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>


        </div>


        <div id="editModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="addModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">


                <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                    <ContentTemplate>
                        <div class="modal-content">
                            <div class="modal-header">
                                <b id="editModalLabel">Modificar periodo.</b>
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                            </div>
                            <div class="modal-body">
                                <asp:FormView ID="EditFormView" runat="server" Width="100%"
                                    CellPadding="4" DataKeyNames="IdPeriodo" ForeColor="#333333"
                                    DefaultMode="Edit"
                                    OnModeChanging="EditFormView_ModeChanging" OnItemUpdating="EditFormView_ItemUpdating" OnItemUpdated="EditFormView_ItemUpdated">
                                    <EditItemTemplate>
                                        <div class="container-fluid">
                                            <div class="row">
                                                <div class="col-3">ID</div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtIdPeriodo" runat="server" Text='<%# Bind("IdPeriodo") %>' CssClass="form-control" Enabled="false" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3">Inicio</div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtInicio" runat="server" Text='<%# Bind("Inicio") %>' CssClass="form-control" TextMode="Date" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3">Final</div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtFinal" runat="server" Text='<%# Bind("Final") %>' CssClass="form-control" TextMode="Date" />
                                                </div>
                                            </div>

                                        </div>
                                        <hr />


                                        <asp:LinkButton ID="AcceptButton" runat="server" CausesValidation="False" CommandName="Update" Text="Aceptar" CssClass="btn btn-success" />
                                        <asp:LinkButton ID="CancelButton" runat="server" CausesValidation="False" CommandName="Cancelar" Text="Cancelar" CssClass="btn btn-danger" OnClick="CancelButton_Click" />
                                    </EditItemTemplate>
                                    <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                                    <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                                    <InsertItemTemplate>
                                    </InsertItemTemplate>
                                    <ItemTemplate>
                                    </ItemTemplate>



                                </asp:FormView>
                            </div>
                            <div class="modal-footer">
                            </div>
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>


        </div>

        <!-- #endregion -->




        <!-- #region DataSources -->
        <asp:SqlDataSource ID="PeriodoDS"
            runat="server" ConnectionString="<%$ ConnectionStrings:BoqueronConnectionString %>"
            InsertCommand="dbo.sp_Periodo_insert" InsertCommandType="StoredProcedure"
            SelectCommand="dbo.sp_Periodo_get_all" SelectCommandType="StoredProcedure">
            <DeleteParameters>
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="IdPeriodo" Type="String" />

                <asp:Parameter Name="Inicio" Type="DateTime" />
                <asp:Parameter Name="Final" Type="DateTime" />
            </InsertParameters>
            <UpdateParameters>
            </UpdateParameters>
            <SelectParameters>
                <asp:ControlParameter ControlID="txtSearchKey" PropertyName="Text" Name="key" DefaultValue="*" />
                <asp:ControlParameter ControlID="searchParameterDDL" PropertyName="SelectedValue" Name="parameter" />
            </SelectParameters>
        </asp:SqlDataSource>



        <!-- #endregion -->




    </div>
</asp:Content>
