<%@ Page Title="Expensa" Language="C#" MasterPageFile="~/Strap.Master" AutoEventWireup="true" CodeBehind="Expensa.aspx.cs" Inherits="AdminBoqueron.Expensa" %>

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
        <asp:DataPager ID="MainDataPager" runat="server" PagedControlID="ExpensaListView" PageSize="10">
            <Fields>
                <asp:NextPreviousPagerField ButtonCssClass="btn btn-default btn-sm" ButtonType="Button" ShowFirstPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False" FirstPageText="Primera" />
                <asp:NumericPagerField ButtonType="Button" CurrentPageLabelCssClass="btn btn-sm" NextPreviousButtonCssClass="btn btn-default btn-sm" NumericButtonCssClass="btn btn-default btn-sm" />
                <asp:NextPreviousPagerField ButtonCssClass="btn btn-default btn-sm" ButtonType="Button" ShowLastPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False" LastPageText="Última" />
            </Fields>
        </asp:DataPager>
        <asp:ListView ID="ExpensaListView"
            runat="server"
            DataSourceID="ExpensaDS"
            DataKeyNames="IdExpensa"
            OnItemCommand="ListView_ItemCommand">
            <LayoutTemplate>
                <div class="table responsive">
                    <table class="table table-striped table-condensed">
                        <thead>
                            <th>ID</th>
                            <th>Periodo</th>
                            <th>Categoria</th>
                            <th>Proveedor</th>
                            <th>Concepto</th>
                            <th>Fecha</th>
                            <th>Monto</th>
                            <th>Impuesto</th>


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
                        <asp:Label ID="lblIdExpensa" runat="server" Text='<%# Eval("IdExpensa") %>' /></td>
                    <td>
                        <asp:Label ID="lblIdPeriodo" runat="server" Text='<%# Eval("IdPeriodo") %>' /></td>
                    <td>
                        <asp:Label ID="lblIdCategoria" runat="server" Text='<%# Eval("Categoria") %>' /></td>
                    <td>
                        <asp:Label ID="lblIdProveedor" runat="server" Text='<%# Eval("Proveedor") %>' /></td>
                    <td>
                        <asp:Label ID="lblConcepto" runat="server" Text='<%# Eval("Concepto") %>' /></td>
                    <td>
                        <asp:Label ID="lblFecha" runat="server" Text='<%# String.Format("{0:dd/MM/yyyy}",Eval("Fecha")) %>' /></td>
                    <td>
                        <asp:Label ID="lblMonto" runat="server" Text='<%# string.Format("{0:N0}",Eval("Monto")) %>' /></td>
                    <td>
                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("Impuesto") %>' /></td>


                    <td>
                        <asp:LinkButton runat="server" ID="EditExpensaBtn" CommandName="Editar" CommandArgument='<%# Eval("IdExpensa")%>' ToolTip="Editar">
                            <i class="fa fa-keyboard fa-sm"></i>
                        </asp:LinkButton>
                    </td>

                    <td>

                        <asp:LinkButton runat="server" ID="DeleteExpensaBtn" CommandName="Eliminar" CommandArgument='<%# Eval("IdExpensa")%>' ToolTip="Eliminar">
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
                                <b id="addModalLabel">Agregar expensa.</b>
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                            </div>
                            <div class="modal-body">
                                <asp:FormView ID="InsertFormView" runat="server" DataSourceID="ExpensaDS" Width="100%"
                                    CellPadding="4" DataKeyNames="IdExpensa" ForeColor="#333333"
                                    DefaultMode="Insert"
                                    OnItemInserted="FormView1_ItemInserted">
                                    <EditItemTemplate>
                                    </EditItemTemplate>
                                    <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                                    <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                                    <InsertItemTemplate>
                                        <div class="container-fluid">
                                            <div class="row">
                                                <div class="col-3">IdExpensa</div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtIdExpensa" runat="server" Text="" CssClass="form-control" Enabled="false" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3">Periodo</div>
                                                <div class="col-9">
                                                    <asp:DropDownList ID="IdPeriodoDDL"
                                                        runat="server"
                                                        DataSourceID="PeriodoDS"
                                                        DataTextField="IdPeriodo"
                                                        DataValueField="IdPeriodo"
                                                        CssClass="form-control spacing"
                                                        SelectedValue='<%# Bind("IdPeriodo") %>'>
                                                    </asp:DropDownList>
                                                </div>
                                            </div>

                                            <div class="row">
                                                <div class="col-3">Proveedor</div>
                                                <div class="col-9">
                                                    <asp:DropDownList ID="IdProveedorDDL"
                                                        runat="server"
                                                        DataSourceID="ProveedorDS"
                                                        DataTextField="Proveedor"
                                                        DataValueField="IdProveedor"
                                                        CssClass="form-control spacing"
                                                        SelectedValue='<%# Bind("IdProveedor") %>'>
                                                    </asp:DropDownList>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3">Concepto</div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtConcepto" runat="server" Text='<%# Bind("Concepto") %>' CssClass="form-control" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3">Fecha</div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtFecha" runat="server" Text='<%# Bind("Fecha") %>' CssClass="form-control" TextMode="Date" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3">Monto</div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtMonto" runat="server" Text='<%# Bind("Monto") %>' CssClass="form-control" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3">Impuesto</div>
                                                <div class="col-9">
                                                    <asp:DropDownList ID="IdImpuestoDDL"
                                                        runat="server"
                                                        DataSourceID="ImpuestoDS"
                                                        DataTextField="Impuesto"
                                                        DataValueField="IdImpuesto"
                                                        CssClass="form-control spacing"
                                                        SelectedValue='<%# Bind("IdImpuesto") %>'>
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
                                <b id="editModalLabel">Modificar Expensa.</b>
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                            </div>
                            <div class="modal-body">
                                <asp:FormView ID="EditFormView" runat="server" Width="100%"
                                    CellPadding="4" DataKeyNames="IdExpensa" ForeColor="#333333"
                                    DefaultMode="Edit"
                                    OnModeChanging="EditFormView_ModeChanging" OnItemUpdating="EditFormView_ItemUpdating" OnItemUpdated="EditFormView_ItemUpdated">
                                    <EditItemTemplate>
                                        <div class="container-fluid">
                                            <div class="row">
                                                <div class="col-3">IdExpensa</div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtIdExpensa" runat="server" Text='<%# Bind("IdExpensa") %>' CssClass="form-control" Enabled="false" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3">Periodo</div>
                                                <div class="col-9">
                                                    <asp:DropDownList ID="IdPeriodoDDL"
                                                        runat="server"
                                                        DataSourceID="PeriodoDS"
                                                        DataTextField="IdPeriodo"
                                                        DataValueField="IdPeriodo"
                                                        CssClass="form-control spacing"
                                                        SelectedValue='<%# Bind("IdPeriodo") %>'>
                                                    </asp:DropDownList>
                                                </div>
                                            </div>

                                            <div class="row">
                                                <div class="col-3">Proveedor</div>
                                                <div class="col-9">
                                                    <asp:DropDownList ID="IdProveedorDDL"
                                                        runat="server"
                                                        DataSourceID="ProveedorDS"
                                                        DataTextField="Proveedor"
                                                        DataValueField="IdProveedor"
                                                        CssClass="form-control spacing"
                                                        SelectedValue='<%# Bind("IdProveedor") %>'>
                                                    </asp:DropDownList>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3">Concepto</div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtConcepto" runat="server" Text='<%# Bind("Concepto") %>' CssClass="form-control" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3">Fecha</div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtFecha" runat="server" Text='<%# Bind("Fecha") %>' CssClass="form-control" TextMode="Date" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3">Monto</div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtMonto" runat="server" Text='<%# Bind("Monto") %>' CssClass="form-control" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3">Impuesto</div>
                                                <div class="col-9">
                                                    <asp:DropDownList ID="IdImpuestoDDL"
                                                        runat="server"
                                                        DataSourceID="ImpuestoDS"
                                                        DataTextField="Impuesto"
                                                        DataValueField="IdImpuesto"
                                                        CssClass="form-control spacing"
                                                        SelectedValue='<%# Bind("IdImpuesto") %>'>
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
        <asp:SqlDataSource ID="ExpensaDS"
            runat="server" ConnectionString="<%$ ConnectionStrings:BoqueronConnectionString %>"
            InsertCommand="dbo.sp_Expensa_insert" InsertCommandType="StoredProcedure"
            SelectCommand="dbo.sp_Expensa_get_all" SelectCommandType="StoredProcedure">
            <DeleteParameters>
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="IdPeriodo" Type="String" />
                <asp:Parameter Name="IdProveedor" Type="Int32" />
                <asp:Parameter Name="Fecha" Type="DateTime" />
                <asp:Parameter Name="Monto" Type="Decimal" />
                <asp:Parameter Name="IdImpuesto" Type="Int16" />
                <asp:Parameter Name="Concepto" Type="String" />
            </InsertParameters>
            <UpdateParameters>
            </UpdateParameters>
        </asp:SqlDataSource>



        <asp:SqlDataSource ID="ProveedorDS" runat="server" ConnectionString="<%$ ConnectionStrings:BoqueronConnectionString %>"
            SelectCommand="select IdProveedor, Nombre as Proveedor from dbo.Proveedor order by 2" SelectCommandType="Text"></asp:SqlDataSource>

        <asp:SqlDataSource ID="PeriodoDS" runat="server" ConnectionString="<%$ ConnectionStrings:BoqueronConnectionString %>"
            SelectCommand="select IdPeriodo  from dbo.Periodo where IdPeriodo not in (select IdPeriodo from Liquidacion) order by 1" SelectCommandType="Text"></asp:SqlDataSource>

        <asp:SqlDataSource ID="ImpuestoDS" runat="server" ConnectionString="<%$ ConnectionStrings:BoqueronConnectionString %>"
            SelectCommand="select IdImpuesto , impuesto from impuesto order by 1" SelectCommandType="Text"></asp:SqlDataSource>


        <!-- #endregion -->




    </div>
</asp:Content>
