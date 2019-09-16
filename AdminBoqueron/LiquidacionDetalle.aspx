<%@ Page Title="Detalle de liquidación" Language="C#" MasterPageFile="~/Enigma.Master" AutoEventWireup="true" CodeBehind="LiquidacionDetalle.aspx.cs" Inherits="AdminBoqueron.LiquidacionDetalle" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="page-header">
        <div class="container-fluid">
            <div class="row">
                <div class="col-10">
                    <div class="col-form-label-lg azul"><%: Page.Title %> </div>

                </div>

            </div>
            <div class="row">
                <asp:Label ID="ErrorLabel" runat="server" Visible="False" CssClass="form-control" />
            </div>
        </div>
    </div>

    <div class="container-fluid">

        <asp:ListView ID="LiquidacionListView"
            runat="server"
            DataSourceID="LiquidacionDS"
            DataKeyNames="IdDocumento"
            OnItemCommand="LiquidacionListView_ItemCommand">
            <LayoutTemplate>
                <div class="table responsive">
                    <table class="table table-striped table-condensed">
                        <thead>
                            <th>Factura</th>
                            <th>Nombre</th>
                            <th>Monto</th>
                            <th>Mora</th>
                            <th>Estado</th>
                            <th>Pagado</th>
                            <th>Fecha Pago</th>
                            <th>Recibo</th>
                            <th>CoPropiedad</th>
                            <th>Unidad</th>

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
                        <asp:Label ID="lblNroFactura" runat="server" Text='<%# Eval("NroFactura") %>' />
                        <asp:LinkButton runat="server" ID="FacturaBtn" CommandName="Facturar" CommandArgument='<%# Eval("IdDocumento") %>' ToolTip="Imprimir factura">
                            <i class="fa fa-file-invoice-dollar fa-sm"></i>
                        </asp:LinkButton>
                    </td>
                    <td>
                        <asp:Label ID="lblNombre" runat="server" Text='<%# Eval("Nombre") %>' /></td>
                    <td>
                        <asp:Label ID="lblMonto" runat="server" Text='<%# string.Format("{0:N0}",Eval("Monto")) %>' /></td>
                    <td>
                        <asp:Label ID="lblMora" runat="server" Text='<%# string.Format("{0:N0}", Eval("Mora")) %>' /></td>

                    <td>
                        <asp:Label ID="lblEstado" runat="server" Text='<%# Eval("Estado") %>' /></td>
                    <td>


                        <asp:Label ID="lblPagado" runat="server" Text='<%# Eval("Pagado") %>' /></td>
                    <td>
                        <asp:Label ID="lblFechaPago" runat="server" Text='<%#  String.Format("{0:dd/MM/yyyy}",Eval("FechaPago")) %>' /></td>
                    <td>
                        <asp:Label ID="lblNroRecibo" runat="server" Text='<%# Eval("NroRecibo") %>' /></td>

                    <td>
                        <asp:Label ID="lblPorcentCoPropiedad" runat="server" Text='<%# Eval("PorcentCoPropiedad") %>' /></td>
                    <td>
                        <asp:Label ID="lblUnidad" runat="server" Text='<%# Eval("Unidad") %>' /></td>



                    <td>
                        <asp:LinkButton runat="server" ID="EditLiquidacionBtn" CommandName="Edit" ToolTip="Editar">
                            <i class="fa fa-keyboard fa-sm"></i>
                        </asp:LinkButton>
                    </td>



                </tr>

            </ItemTemplate>
            <EditItemTemplate>
                <td>
                    <asp:Label ID="lblNroFactura" runat="server" Text='<%# Eval("NroFactura") %>' /></td>
                <td>
                    <asp:Label ID="lblNombre" runat="server" Text='<%# Eval("Nombre") %>' /></td>
                <td>
                    <asp:Label ID="lblMonto" runat="server" Text='<%# Eval("Monto") %>' /></td>
                <td>
                    <asp:Label ID="lblMora" runat="server" Text='<%# Eval("Mora") %>' /></td>

                <td>
                    <asp:Label ID="lblEstado" runat="server" Text='<%# Eval("Estado") %>' /></td>
                <td>

                    <asp:DropDownList ID="PagadoDDL"
                        runat="server"
                        CssClass="form-control spacing"
                        SelectedValue='<%# Bind("Pagado") %>'>
                        <asp:ListItem Text="SI" Value="SI"></asp:ListItem>
                        <asp:ListItem Text="NO" Value="NO"></asp:ListItem>
                    </asp:DropDownList>


                </td>
                <td>
                    <asp:Label ID="lblFechaPago" runat="server" Text='<%# Eval("FechaPago") %>' /></td>
                <td>
                    <asp:TextBox ID="lblNroRecibo" runat="server" Text='<%# Bind("NroRecibo") %>' /></td>

                <td>
                    <asp:Label ID="lblPorcentCoPropiedad" runat="server" Text='<%# Eval("PorcentCoPropiedad") %>' /></td>
                <td>
                    <asp:Label ID="lblUnidad" runat="server" Text='<%# Eval("Unidad") %>' /></td>

                <td>
                    <asp:LinkButton runat="server" ID="CancelBtn" CommandName="Cancel" ToolTip="Cancelar">
                            <i class="fa fa-undo fa-sm"></i>
                    </asp:LinkButton>
                </td>
                <td>
                    <asp:LinkButton runat="server" ID="AcceptBtn" CommandName="Update" ToolTip="Aplicar">
                            <i class="fa fa-check fa-sm"></i>
                    </asp:LinkButton>
                </td>
            </EditItemTemplate>
            <InsertItemTemplate>
            </InsertItemTemplate>
        </asp:ListView>






        <!-- #region DataSources -->
        <asp:SqlDataSource ID="LiquidacionDS"
            runat="server" ConnectionString="<%$ ConnectionStrings:BoqueronConnectionString %>"
            SelectCommand="dbo.sp_LiquidacionDetalle_get_all" SelectCommandType="StoredProcedure"
             UpdateCommand="dbo.sp_LiquidacionDetalle_update" UpdateCommandType="StoredProcedure">
            <DeleteParameters>
            </DeleteParameters>
            <InsertParameters>
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="IdDocumento" DbType="Int32" />
                <asp:Parameter Name="NroRecibo" DbType="String" />
                <asp:Parameter Name="Pagado" DbType="String" />
            </UpdateParameters>
            <SelectParameters>
                <asp:QueryStringParameter Name="IdLiquidacion" DbType="Int32" QueryStringField="IdLiquidacion" />
            </SelectParameters>
        </asp:SqlDataSource>

        <asp:SqlDataSource ID="FacturasDS" runat="server" ConnectionString="<%$ ConnectionStrings:BoqueronConnectionString %>"
            SelectCommand="select IdDocumento, NroFactura from Talonario where Estado = 'Pendiente' and IdTimbrado = @IdTimbrado order by NroFactura" SelectCommandType="Text"></asp:SqlDataSource>



        <!-- #endregion -->




    </div>
</asp:Content>

