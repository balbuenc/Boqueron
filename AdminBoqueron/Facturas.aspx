<%@ Page Title="Facturación" Language="C#" MasterPageFile="~/Enigma.Master" AutoEventWireup="true" CodeBehind="Facturas.aspx.cs" Inherits="AdminBoqueron.Facturas" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="page-header">
        <div class="container-fluid">
            <div class="row">
                <div class="col-8">
                    <div class="col-form-label-lg azul"><%: Page.Title %> </div>

                </div>

            </div>
            <div class="row">
                <asp:Label ID="ErrorLabel" runat="server" Visible="False" CssClass="form-control" />
            </div>
        </div>
    </div>

    <div class="container-fluid">
        <asp:DataPager ID="MainDataPager" runat="server" PagedControlID="FacturaListView" PageSize="30">
            <Fields>
                <asp:NextPreviousPagerField ButtonCssClass="btn btn-default btn-sm" ButtonType="Button" ShowFirstPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False" FirstPageText="Primera" />
                <asp:NumericPagerField ButtonType="Button" CurrentPageLabelCssClass="btn btn-sm" NextPreviousButtonCssClass="btn btn-default btn-sm" NumericButtonCssClass="btn btn-default btn-sm" />
                <asp:NextPreviousPagerField ButtonCssClass="btn btn-default btn-sm" ButtonType="Button" ShowLastPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False" LastPageText="Última" />
            </Fields>
        </asp:DataPager>
        <asp:ListView ID="FacturaListView"
            runat="server"
            DataSourceID="FacturasDS"
            DataKeyNames="IdDocumento">
            <LayoutTemplate>
                <div class="table responsive">
                    <table class="table table-striped table-condensed">
                        <thead>

                         
                            <th>Nro. Factura</th>
                            <th>Cliente</th>
                            <th>Fecha Emisión</th>
                            <th>Monto</th>
                            <th>Estado</th>
                            <th>Pagado</th>
                            <th>Fecha Pago</th>
                            <th>Nro. Recibo</th>
                            <th>Periodo</th>

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
                        <asp:Label ID="lblIdDocumento" runat="server" Text='<%# Eval("IdDocumento") %>' Visible="false" />
                        <asp:Label ID="lblNroFactura" runat="server" Text='<%# Eval("NroFactura") %>' /></td>
                    <td>
                        <asp:Label ID="lblCliente" runat="server" Text='<%# Eval("Cliente") %>' /></td>
                    <td>
                        <asp:Label ID="lblFechaEmision" runat="server" Text='<%#String.Format("{0:dd/MM/yyyy}", Eval("FechaEmision")) %>' /></td>
                    <td>
                        <asp:Label ID="Label1" runat="server" Text='<%# string.Format("{0:N0}", Eval("Monto")) %>' /></td>
                    <td>
                        <asp:Label ID="lblEstado" runat="server" Text='<%# Eval("Estado") %>' /></td>
                    <td>
                        <asp:Label ID="lblPagado" runat="server" Text='<%# Eval("Pagado") %>' /></td>
                    <td>
                        <asp:Label ID="lblFechaPago" runat="server" Text='<%# Eval("FechaPago") %>' /></td>
                    <td>
                        <asp:Label ID="lblNroRecibo" runat="server" Text='<%# Eval("NroRecibo") %>' /></td>
                    <td>
                        <asp:Label ID="lblIdPeriodo" runat="server" Text='<%# Eval("IdPeriodo") %>' /></td>



                    <td>
                        <asp:LinkButton runat="server" ID="EditFacturaBtn" CommandName="Edit" CommandArgument='<%# Eval("IdDocumento")%>' ToolTip="Editar">
                            <i class="fa fa-keyboard fa-sm"></i>
                        </asp:LinkButton>
                    </td>
                    <td></td>


                </tr>

            </ItemTemplate>
            <EditItemTemplate>
              
                <td>
                     <asp:Label ID="lblIdDocumento" runat="server" Text='<%# Eval("IdDocumento") %>' Visible="false" />
                    <asp:Label ID="lblNroFactura" runat="server" Text='<%# Eval("NroFactura") %>' /></td>
               

                <td>
                    <asp:DropDownList ID="IdClienteDDL"
                        runat="server"
                        DataSourceID="ClientesDS"
                        DataTextField="Cliente"
                        DataValueField="IdCliente"
                        CssClass="form-control spacing"
                        SelectedValue='<%# Bind("IdCliente") %>'>
                    </asp:DropDownList></td>
                <td>
                    <asp:Label ID="lblFechaEmision" runat="server" Text='<%#String.Format("{0:dd/MM/yyyy}", Eval("FechaEmision")) %>' /></td>
                <td>
                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("Monto") %>' /></td>
                <td>
                    
                    <asp:DropDownList ID="EstadoDDL" runat="server" CssClass="form-control spacing" SelectedValue='<%# Bind("Estado") %>'  >
                        <asp:ListItem Text="Pendiente" Value="Pendiente"></asp:ListItem>
                        <asp:ListItem Text="Facturado" Value="Facturado"></asp:ListItem>
                        <asp:ListItem Text="Anulado" Value="Anulado"></asp:ListItem>

                    </asp:DropDownList>
                </td>
                <td>
                    <asp:Label ID="lblPagado" runat="server" Text='<%# Eval("Pagado") %>' /></td>
                <td>
                    <asp:Label ID="lblFechaPago" runat="server" Text='<%# Eval("FechaPago") %>' /></td>
                <td>
                    <asp:Label ID="lblNroRecibo" runat="server" Text='<%# Eval("NroRecibo") %>' /></td>
                <td>
                    <asp:Label ID="lblIdPeriodo" runat="server" Text='<%# Eval("IdPeriodo") %>' /></td>



                <td>
                    <asp:LinkButton runat="server" ID="UpdateBtn" CommandName="Update" ToolTip="Aceptar">
                            <i class="fa fa-check fa-sm"></i>
                    </asp:LinkButton>
                </td>
                <td>
                    <asp:LinkButton runat="server" ID="CancelBtn" CommandName="Cancel" ToolTip="Cancelar">
                            <i class="fa fa-undo fa-sm"></i>
                    </asp:LinkButton>
                </td>
            </EditItemTemplate>
            <InsertItemTemplate>
            </InsertItemTemplate>
        </asp:ListView>






        <!-- #region DataSources -->
        <asp:SqlDataSource ID="FacturasDS"
            runat="server" ConnectionString="<%$ ConnectionStrings:BoqueronConnectionString %>"
            SelectCommand="dbo.sp_get_Facturas_all" SelectCommandType="StoredProcedure"
            UpdateCommand="dbo.sp_Facturas_update" UpdateCommandType="StoredProcedure">
            <DeleteParameters>
            </DeleteParameters>
            <InsertParameters>
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="IdDocumento" DbType="Int32" />
                <asp:Parameter Name="IdCliente" DbType="Int16" />
                <asp:Parameter Name="Estado" DbType="String" />
            </UpdateParameters>
        </asp:SqlDataSource>

         <asp:SqlDataSource ID="ClientesDS" runat="server" ConnectionString="<%$ ConnectionStrings:BoqueronConnectionString %>"
            SelectCommand="select IdCliente, Nombre + ' [' + Unidad+']' as Cliente , Nombre
from dbo.Cliente 
union
select null as IdCLiente, 'NINGUNO' as Cliente , 'AAA' as Nombre
order by 3" SelectCommandType="Text"></asp:SqlDataSource>

        <!-- #endregion -->




    </div>
</asp:Content>

