<%@ Page Title="" Language="C#" MasterPageFile="~/Strap.Master" AutoEventWireup="true" CodeBehind="Proveedor.aspx.cs" Inherits="AdminBoqueron.Proveedor" %>

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
        <asp:ListView ID="ProveedorListView"
            runat="server"
            DataSourceID="ProveedorDS"
            DataKeyNames="IdProveedor"
            OnItemCommand="ListView_ItemCommand">
            <LayoutTemplate>
                <div class="table responsive">
                    <table class="table table-striped table-condensed">
                        <thead>
                            <th>ID</th>
                            <th>Nombre</th>
                            <th>Dirección</th>
                            <th>Teléfono</th>
                            <th>Fax</th>
                            <th>RUC</th>

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
                        <asp:Label ID="lblIdProveedor" runat="server" Text='<%# Eval("IdProveedor") %>' /></td>
                    <td>
                        <asp:Label ID="lblNombre" runat="server" Text='<%# Eval("Nombre") %>' /></td>
                    <td>
                        <asp:Label ID="lblDirección" runat="server" Text='<%# Eval("Dirección") %>' /></td>
                    <td>
                        <asp:Label ID="lblTeléfono" runat="server" Text='<%# Eval("Teléfono") %>' /></td>
                    <td>
                        <asp:Label ID="lblFax" runat="server" Text='<%# Eval("Fax") %>' /></td>
                    <td>
                        <asp:Label ID="lblRUC" runat="server" Text='<%# Eval("RUC") %>' /></td>


                    <td>
                        <asp:LinkButton runat="server" ID="EditProveedorBtn" CommandName="Editar" CommandArgument='<%# Eval("IdProveedor")%>' ToolTip="Editar">
                            <i class="fa fa-keyboard fa-sm"></i>
                        </asp:LinkButton>
                    </td>

                    <td>

                        <asp:LinkButton runat="server" ID="DeleteProveedorBtn" CommandName="Eliminar" CommandArgument='<%# Eval("IdProveedor")%>' ToolTip="Eliminar">
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
                                <b id="addModalLabel">Agregar nuevo Depósito.</b>
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                            </div>
                            <div class="modal-body">
                                <asp:FormView ID="InsertFormView" runat="server" DataSourceID="ProveedorDS" Width="100%"
                                    CellPadding="4" DataKeyNames="IdProveedor" ForeColor="#333333"
                                    DefaultMode="Insert"
                                    OnItemInserted="FormView1_ItemInserted">
                                    <EditItemTemplate>
                                    </EditItemTemplate>
                                    <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                                    <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                                    <InsertItemTemplate>
                                        <div class="container-fluid">
                                            <div class="row">
                                                <div class="col-3">IdProveedor</div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtIdProveedor" runat="server" Text="" CssClass="form-control" Enabled="false" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3">Nombre</div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtNombre" runat="server" Text='<%# Bind("Nombre") %>' CssClass="form-control" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3">Dirección</div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtDirección" runat="server" Text='<%# Bind("Dirección") %>' CssClass="form-control" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3">Teléfono</div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtTeléfono" runat="server" Text='<%# Bind("Teléfono") %>' CssClass="form-control" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3">Fax</div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtFax" runat="server" Text='<%# Bind("Fax") %>' CssClass="form-control" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3">RUC</div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtRUC" runat="server" Text='<%# Bind("RUC") %>' CssClass="form-control" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3">Observación</div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtObservación" runat="server" Text='<%# Bind("Observación") %>' CssClass="form-control" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3">PersonaContacto</div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtPersonaContacto" runat="server" Text='<%# Bind("PersonaContacto") %>' CssClass="form-control" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3">SaldoIni</div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtSaldoIni" runat="server" Text='<%# Bind("SaldoIni") %>' CssClass="form-control" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3">Categoría</div>
                                                <div class="col-9">
                                                    <asp:DropDownList ID="IdCategoriaDDL"
                                                        runat="server"
                                                        DataSourceID="CategoriaDS"
                                                        DataTextField="Categoria"
                                                        DataValueField="IdCategoria"
                                                        CssClass="form-control spacing"
                                                        SelectedValue='<%# Bind("IdCategoria") %>'>
                                                    </asp:DropDownList>
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
                                <b id="editModalLabel">Modificar Depósito.</b>
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                            </div>
                            <div class="modal-body">
                                <asp:FormView ID="EditFormView" runat="server" Width="100%"
                                    CellPadding="4" DataKeyNames="IdProveedor" ForeColor="#333333"
                                    DefaultMode="Edit"
                                    OnModeChanging="EditFormView_ModeChanging" OnItemUpdating="EditFormView_ItemUpdating" OnItemUpdated="EditFormView_ItemUpdated">
                                    <EditItemTemplate>
                                        <div class="container-fluid">
                                            <div class="row">
                                                <div class="col-3">IdProveedor</div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtIdProveedor" runat="server" Text='<%# Bind("IdProveedor") %>' CssClass="form-control" Enabled="false" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3">Nombre</div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtNombre" runat="server" Text='<%# Bind("Nombre") %>' CssClass="form-control" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3">Dirección</div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtDirección" runat="server" Text='<%# Bind("Dirección") %>' CssClass="form-control" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3">Teléfono</div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtTeléfono" runat="server" Text='<%# Bind("Teléfono") %>' CssClass="form-control" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3">Fax</div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtFax" runat="server" Text='<%# Bind("Fax") %>' CssClass="form-control" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3">RUC</div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtRUC" runat="server" Text='<%# Bind("RUC") %>' CssClass="form-control" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3">Observación</div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtObservación" runat="server" Text='<%# Bind("Observación") %>' CssClass="form-control" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3">PersonaContacto</div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtPersonaContacto" runat="server" Text='<%# Bind("PersonaContacto") %>' CssClass="form-control" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3">SaldoIni</div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtSaldoIni" runat="server" Text='<%# Bind("SaldoIni") %>' CssClass="form-control" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3">Categoría</div>
                                                <div class="col-9">
                                                    <asp:DropDownList ID="IdCategoriaDDL"
                                                        runat="server"
                                                        DataSourceID="CategoriaDS"
                                                        DataTextField="Categoria"
                                                        DataValueField="IdCategoria"
                                                        CssClass="form-control spacing"
                                                        SelectedValue='<%# Bind("IdCategoria") %>'>
                                                    </asp:DropDownList>
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
        <asp:SqlDataSource ID="ProveedorDS"
            runat="server" ConnectionString="<%$ ConnectionStrings:BoqueronConnectionString %>"
            InsertCommand="dbo.sp_Proveedor_insert" InsertCommandType="StoredProcedure"
            SelectCommand="dbo.sp_Proveedor_get_all" SelectCommandType="StoredProcedure">
            <DeleteParameters>
            </DeleteParameters>
            <InsertParameters>

                <asp:Parameter Name="Nombre" Type="String" />
                <asp:Parameter Name="Dirección" Type="String" />
                <asp:Parameter Name="Teléfono" Type="String" />
                <asp:Parameter Name="Fax" Type="String" />
                <asp:Parameter Name="RUC" Type="String" />
                <asp:Parameter Name="Observación" Type="String" />
                <asp:Parameter Name="PersonaContacto" Type="String" />
                <asp:Parameter Name="SaldoIni" Type="String" />
                <asp:Parameter Name="Categoría" Type="String" />
            </InsertParameters>
            <UpdateParameters>
            </UpdateParameters>
        </asp:SqlDataSource>

        <asp:SqlDataSource ID="CategoriaDS" runat="server" ConnectionString="<%$ ConnectionStrings:BoqueronConnectionString %>"
            SelectCommand="select IdCategoria, Categoria from dbo.categoria order by 2" SelectCommandType="Text"></asp:SqlDataSource>


        <!-- #endregion -->




    </div>
</asp:Content>
