<%@ Page Title="Plan Cuentas" Language="C#" MasterPageFile="~/Enigma.Master" AutoEventWireup="true" CodeBehind="PlanCuenta.aspx.cs" Inherits="AdminBoqueron.PlanCuenta" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="page-header">
        <div class="container-fluid">
            <div class="row">
                <div class="col-10">
                    <div class="col-form-label-lg azul"><%: Page.Title %> </div>

                </div>
                <div class="col-2">
                    <button class="btn btn-primary" type="button" runat="server" id="AddLicitacionBtn" data-toggle="modal" data-target="#addModal">
                        <i class="fas fa-plus"></i>
                    </button>
                </div>
            </div>
            <div class="row">
                <asp:Label ID="ErrorLabel" runat="server" Visible="False" CssClass="form-control" />
            </div>
        </div>
    </div>

    <div class="container-fluid">
         <asp:DataPager ID="MainDataPager" runat="server" PagedControlID="PlanCuentaListView" PageSize="10">
            <Fields>
                <asp:NextPreviousPagerField ButtonCssClass="btn btn-default btn-sm" ButtonType="Button" ShowFirstPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False" FirstPageText="Primera" />
                <asp:NumericPagerField ButtonType="Button" CurrentPageLabelCssClass="btn btn-sm" NextPreviousButtonCssClass="btn btn-default btn-sm" NumericButtonCssClass="btn btn-default btn-sm" />
                <asp:NextPreviousPagerField ButtonCssClass="btn btn-default btn-sm" ButtonType="Button" ShowLastPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False" LastPageText="Última" />
            </Fields>
        </asp:DataPager>
        <asp:ListView ID="PlanCuentaListView"
            runat="server"
            DataSourceID="PlanCuentaDS"
            DataKeyNames="IdCuenta"
            OnItemCommand="ListView_ItemCommand">
            <LayoutTemplate>
                <div class="table responsive">
                    <table class="table table-striped table-condensed">
                        <thead>
                            <th>ID</th>
                            <th>Nro. Cuenta</th>
                            <th>Cuenta</th>


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
                        <asp:Label ID="lblIdCuenta" runat="server" Text='<%# Eval("IdCuenta") %>' /></td>
                    <td>
                        <asp:Label ID="lblNroCuenta" runat="server" Text='<%# Eval("NroCuenta") %>' /></td>
                    <td>
                        <asp:Label ID="lblCuenta" runat="server" Text='<%# Eval("Cuenta") %>' /></td>



                    <td>
                        <asp:LinkButton runat="server" ID="EditPlanCuentaBtn" CommandName="Editar" CommandArgument='<%# Eval("IdCuenta")%>' ToolTip="Editar">
                            <i class="fa fa-keyboard fa-sm"></i>
                        </asp:LinkButton>
                    </td>

                    <td>

                        <asp:LinkButton runat="server" ID="DeletePlanCuentaBtn" CommandName="Eliminar" CommandArgument='<%# Eval("IdCuenta")%>' ToolTip="Eliminar">
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
                                <b id="addModalLabel">Agregar Plan de Cuenta.</b>
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                            </div>
                            <div class="modal-body">
                                <asp:FormView ID="InsertFormView" runat="server" DataSourceID="PlanCuentaDS" Width="100%"
                                    CellPadding="4" DataKeyNames="IdCuenta" ForeColor="#333333"
                                    DefaultMode="Insert"
                                    OnItemInserted="FormView1_ItemInserted">
                                    <EditItemTemplate>
                                    </EditItemTemplate>
                                    <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                                    <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                                    <InsertItemTemplate>
                                        <div class="container-fluid">
                                            <div class="row">
                                                <div class="col-3">IdCuenta</div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtIdCuenta" runat="server" Text="" CssClass="form-control" Enabled="false" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3">NroCuenta</div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtNroCuenta" runat="server" Text='<%# Bind("NroCuenta") %>' CssClass="form-control" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3">Cuenta</div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtCuenta" runat="server" Text='<%# Bind("Cuenta") %>' CssClass="form-control" />
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
                                <b id="editModalLabel">Modificar PlanCuenta.</b>
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                            </div>
                            <div class="modal-body">
                                <asp:FormView ID="EditFormView" runat="server" Width="100%"
                                    CellPadding="4" DataKeyNames="IdCuenta" ForeColor="#333333"
                                    DefaultMode="Edit"
                                    OnModeChanging="EditFormView_ModeChanging" OnItemUpdating="EditFormView_ItemUpdating" OnItemUpdated="EditFormView_ItemUpdated">
                                    <EditItemTemplate>
                                        <div class="container-fluid">
                                            <div class="row">
                                                <div class="col-3">IdCuenta</div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtIdCuenta" runat="server" Text='<%# Bind("IdCuenta") %>' CssClass="form-control" Enabled="false" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3">NroCuenta</div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtNroCuenta" runat="server" Text='<%# Bind("NroCuenta") %>' CssClass="form-control" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3">Cuenta</div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtCuenta" runat="server" Text='<%# Bind("Cuenta") %>' CssClass="form-control" />
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
        <asp:SqlDataSource ID="PlanCuentaDS"
            runat="server" ConnectionString="<%$ ConnectionStrings:BoqueronConnectionString %>"
            InsertCommand="dbo.sp_PlanCuenta_insert" InsertCommandType="StoredProcedure"
            SelectCommand="dbo.sp_PlanCuenta_get_all" SelectCommandType="StoredProcedure">
            <DeleteParameters>
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="NroCuenta" Type="String" />
                <asp:Parameter Name="Cuenta" Type="String" />
              
            </InsertParameters>
            <UpdateParameters>
            </UpdateParameters>
        </asp:SqlDataSource>



        <!-- #endregion -->




    </div>
</asp:Content>
