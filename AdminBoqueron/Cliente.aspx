<%@ Page Title="Clientes" Language="C#" MasterPageFile="~/Enigma.Master" AutoEventWireup="true" CodeBehind="Cliente.aspx.cs" Inherits="AdminBoqueron.Cliente" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="page-header">
        <div class="container-fluid">
            <div class="row">
                <div class="col-8">
                    <div class="col-form-label-lg azul"><%: Page.Title %> </div>

                </div>
                <div class="col-2">
                    <button class="btn btn-primary" type="button" runat="server" id="AddLicitacionBtn" data-toggle="modal" data-target="#addModal">
                        <i class="fas fa-plus"></i>
                    </button>
                </div>
                <div class="col-2">
                    <asp:LinkButton class="btn btn-primary"  runat="server" id="btnClientes"   OnClick="btnClientes_Click">
                        <i class="fas fa-file"></i>
                    </asp:LinkButton>
                </div>
            </div>
            <div class="row">
                <asp:Label ID="ErrorLabel" runat="server" Visible="False" CssClass="form-control" />
            </div>
        </div>
    </div>

    <div class="container-fluid">
         <asp:DataPager ID="MainDataPager" runat="server" PagedControlID="ClienteListView" PageSize="10">
            <Fields>
                <asp:NextPreviousPagerField ButtonCssClass="btn btn-default btn-sm" ButtonType="Button" ShowFirstPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False" FirstPageText="Primera" />
                <asp:NumericPagerField ButtonType="Button" CurrentPageLabelCssClass="btn btn-sm" NextPreviousButtonCssClass="btn btn-default btn-sm" NumericButtonCssClass="btn btn-default btn-sm" />
                <asp:NextPreviousPagerField ButtonCssClass="btn btn-default btn-sm" ButtonType="Button" ShowLastPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False" LastPageText="Última" />
            </Fields>
        </asp:DataPager>
        <asp:ListView ID="ClienteListView"
            runat="server"
            DataSourceID="ClienteDS"
            DataKeyNames="IdCliente"
            OnItemCommand="ListView_ItemCommand">
            <LayoutTemplate>
                <div class="table responsive">
                    <table class="table table-striped table-condensed">
                        <thead>
                            <th>IdCliente</th>
                            <th>Nombre</th>
                            <th>RUC</th>
                            <th>PorcentCoPropiedad</th>
                            <th>Unidad</th>
                            <th>Dirección</th>
                            <th>Telefono</th>
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
                        <asp:Label ID="lblIdCliente" runat="server" Text='<%# Eval("IdCliente") %>' /></td>
                    <td>
                        <asp:Label ID="lblNombre" runat="server" Text='<%# Eval("Nombre") %>' /></td>

                    <td>
                        <asp:Label ID="lblRUC" runat="server" Text='<%# Eval("RUC") %>' /></td>

                    <td>
                        <asp:Label ID="lblPorcentCoPropiedad" runat="server" Text='<%# Eval("PorcentCoPropiedad") %>' /></td>
                    <td>
                        <asp:Label ID="lblUnidad" runat="server" Text='<%# Eval("Unidad") %>' /></td>
                    <td>
                        <asp:Label ID="lblDireccion" runat="server" Text='<%# Eval("Direccion") %>' /></td>
                    <td>
                        <asp:Label ID="lblTelefono" runat="server" Text='<%# Eval("Telefono") %>' /></td>


                    <td>
                        <asp:LinkButton runat="server" ID="EditClienteBtn" CommandName="Editar" CommandArgument='<%# Eval("IdCliente")%>' ToolTip="Editar">
                            <i class="fa fa-keyboard fa-sm"></i>
                        </asp:LinkButton>
                    </td>

                    <td>

                        <asp:LinkButton runat="server" ID="DeleteClienteBtn" CommandName="Eliminar" CommandArgument='<%# Eval("IdCliente")%>' ToolTip="Eliminar">
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
                                <b id="addModalLabel">Agregar nueva Cliente.</b>
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                            </div>
                            <div class="modal-body">
                                <asp:FormView ID="InsertFormView" runat="server" DataSourceID="ClienteDS" Width="100%"
                                    CellPadding="4" DataKeyNames="IdCliente" ForeColor="#333333"
                                    DefaultMode="Insert"
                                    OnItemInserted="FormView1_ItemInserted">
                                    <EditItemTemplate>
                                    </EditItemTemplate>
                                    <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                                    <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                                    <InsertItemTemplate>
                                        <div class="container-fluid">
                                            <div class="row">
                                                <div class="col-3">IdCliente</div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtIdCliente" runat="server" Text="" CssClass="form-control" Enabled="false" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3">Nombre</div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtNombre" runat="server" Text='<%# Bind("Nombre") %>' CssClass="form-control" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3">RUC</div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtRUC" runat="server" Text='<%# Bind("RUC") %>' CssClass="form-control" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3">PorcentCoPropiedad</div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtPorcentCoPropiedad" runat="server" Text='<%# Bind("PorcentCoPropiedad") %>' CssClass="form-control" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3">Unidad</div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtUnidad" runat="server" Text='<%# Bind("Unidad") %>' CssClass="form-control" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3">Dirección</div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtDireccion" runat="server" Text='<%# Bind("Direccion") %>' CssClass="form-control" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3">Teléfono</div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtTelefono" runat="server" Text='<%# Bind("Telefono") %>' CssClass="form-control" />
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
                                <b id="editModalLabel">Modificar Cliente.</b>
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                            </div>
                            <div class="modal-body">
                                <asp:FormView ID="EditFormView" runat="server" Width="100%"
                                    CellPadding="4" DataKeyNames="IdCliente" ForeColor="#333333"
                                    DefaultMode="Edit"
                                    OnModeChanging="EditFormView_ModeChanging" OnItemUpdating="EditFormView_ItemUpdating" OnItemUpdated="EditFormView_ItemUpdated">
                                    <EditItemTemplate>
                                        <div class="container-fluid">
                                            <div class="row">
                                                <div class="col-3">IdCliente</div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtIdCliente" runat="server" Text='<%# Bind("IdCliente") %>' CssClass="form-control" Enabled="false" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3">Nombre</div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtNombre" runat="server" Text='<%# Bind("Nombre") %>' CssClass="form-control" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3">RUC</div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtRUC" runat="server" Text='<%# Bind("RUC") %>' CssClass="form-control" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3">PorcentCoPropiedad</div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtPorcentCoPropiedad" runat="server" Text='<%# Bind("PorcentCoPropiedad") %>' CssClass="form-control" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3">Unidad</div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtUnidad" runat="server" Text='<%# Bind("Unidad") %>' CssClass="form-control" />
                                                </div>
                                            </div>
                                             <div class="row">
                                                <div class="col-3">Dirección</div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtDireccion" runat="server" Text='<%# Bind("Direccion") %>' CssClass="form-control" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3">Teléfono</div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtTelefono" runat="server" Text='<%# Bind("Telefono") %>' CssClass="form-control" />
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
        <asp:SqlDataSource ID="ClienteDS"
            runat="server" ConnectionString="<%$ ConnectionStrings:BoqueronConnectionString %>"
            InsertCommand="dbo.sp_Cliente_insert" InsertCommandType="StoredProcedure"
            SelectCommand="dbo.sp_Cliente_get_all" SelectCommandType="StoredProcedure">
            <DeleteParameters>
            </DeleteParameters>
            <InsertParameters>
                
                <asp:Parameter Name="Nombre" Type="String" />

                <asp:Parameter Name="RUC" Type="String" />

                <asp:Parameter Name="PorcentCoPropiedad" Type="Decimal" />
                <asp:Parameter Name="Unidad" Type="String" />
                <asp:Parameter Name="Direccion" Type="String" />
                <asp:Parameter Name="Telefono" Type="String" />

            </InsertParameters>
            <UpdateParameters>
            </UpdateParameters>
        </asp:SqlDataSource>



        <!-- #endregion -->




    </div>
</asp:Content>
