<%@ Page Title="Liquidaciones" Language="C#" MasterPageFile="~/Enigma.Master" AutoEventWireup="true" CodeBehind="Liquidacion.aspx.cs" Inherits="AdminBoqueron.Liquidacion" %>

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
                    <asp:LinkButton class="btn btn-primary" runat="server" ID="ContabilidadBtn" OnClick="ContabilidadBtn_Click">
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
        <asp:DataPager ID="MainDataPager" runat="server" PagedControlID="LiquidacionListView" PageSize="10">
            <Fields>
                <asp:NextPreviousPagerField ButtonCssClass="btn btn-default btn-sm" ButtonType="Button" ShowFirstPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False" FirstPageText="Primera" />
                <asp:NumericPagerField ButtonType="Button" CurrentPageLabelCssClass="btn btn-sm" NextPreviousButtonCssClass="btn btn-default btn-sm" NumericButtonCssClass="btn btn-default btn-sm" />
                <asp:NextPreviousPagerField ButtonCssClass="btn btn-default btn-sm" ButtonType="Button" ShowLastPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False" LastPageText="Última" />
            </Fields>
        </asp:DataPager>
        <asp:ListView ID="LiquidacionListView"
            runat="server"
            DataSourceID="LiquidacionDS"
            DataKeyNames="IdLiquidacion"
            OnItemCommand="ListView_ItemCommand">
            <LayoutTemplate>
                <div class="table responsive">
                    <table class="table table-striped table-condensed">
                        <thead>
                            <th>ID</th>
                            <th>Periodo</th>
                            <th>Fecha Liquidacion</th>
                            <th>Ver</th>
                            <th>...</th>
                            <th>...</th>
                            <th>...</th>
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
                        <asp:Label ID="lblIdLiquidacion" runat="server" Text='<%# Eval("IdLiquidacion") %>' /></td>
                    <td>
                        <asp:Label ID="lblIdPeriodo" runat="server" Text='<%# Eval("IdPeriodo") %>' /></td>
                    <td>
                        <asp:Label ID="lblFechaLiquidacion" runat="server" Text='<%# String.Format("{0:dd/MM/yyyy}",Eval( "FechaLiquidacion") ) %>' /></td>

                    <td>
                        <asp:LinkButton runat="server" ID="VerLiquidacionBtn" CommandName="Ver" CommandArgument='<%# Eval("IdLiquidacion")%>' ToolTip="Ver liquidación">
                            <i class="fa fa-eye  fa-xs"></i>
                        </asp:LinkButton>
                    </td>
                    <td>
                        <asp:LinkButton runat="server" ID="EditLiquidacionBtn" CommandName="Editar" CommandArgument='<%# Eval("IdLiquidacion")%>' ToolTip="Editar">
                            <i class="fa fa-keyboard fa-sm"></i>
                        </asp:LinkButton>
                    </td>

                    <td>

                        <asp:LinkButton runat="server" ID="DeleteLiquidacionBtn" CommandName="Eliminar" CommandArgument='<%# Eval("IdLiquidacion")%>' ToolTip="Eliminar">
                            <i class="fas fa-trash-alt"></i>
                        </asp:LinkButton>

                    </td>

                    <td>

                        <asp:LinkButton runat="server" ID="LiquidarBtn" CommandName="Liquidar" CommandArgument='<%# Eval("IdLiquidacion")%>' ToolTip="Liquidar">
                            <i class="fas fa-calculator"></i>
                        </asp:LinkButton>

                    </td>
                    <td>

                        <asp:LinkButton runat="server" ID="ReportBtn" CommandName="Reporte" CommandArgument='<%# Eval("IdLiquidacion")%>' ToolTip="Reporte">
                            <i class="fas fa-bug"></i>
                        </asp:LinkButton>

                    </td>
                    <td>

                        <asp:LinkButton runat="server" ID="ResumenBtn" CommandName="Resumen" CommandArgument='<%# Eval("IdLiquidacion")%>' ToolTip="Resumen">
                            <i class="fas fa-search"></i>
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
                                <b id="addModalLabel">Agregar nueva Liquidacion.</b>
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                            </div>
                            <div class="modal-body">
                                <asp:FormView ID="InsertFormView" runat="server" DataSourceID="LiquidacionDS" Width="100%"
                                    CellPadding="4" DataKeyNames="IdLiquidacion" ForeColor="#333333"
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
                                                    <asp:TextBox ID="txtIdLiquidacion" runat="server" Text="" CssClass="form-control" Enabled="false" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3">Periodo</div>
                                                <div class="col-9">
                                                    <asp:DropDownList ID="IdPeriodoDDL"
                                                        runat="server"
                                                        DataSourceID="PeriodoDS"
                                                        DataTextField="IdPeriodo"
                                                        DataValueField="idPeriodo"
                                                        CssClass="form-control spacing"
                                                        SelectedValue='<%# Bind("IdPeriodo") %>'>
                                                    </asp:DropDownList>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3">Timbrado</div>
                                                <div class="col-9">
                                                    <asp:DropDownList ID="TimbradoDDL"
                                                        runat="server"
                                                        DataSourceID="TimbradoDS"
                                                        DataTextField="Timbrado"
                                                        DataValueField="IdTimbrado"
                                                        CssClass="form-control spacing"
                                                        SelectedValue='<%# Bind("IdTimbrado") %>'>
                                                    </asp:DropDownList>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3">Fecha Liquidacion</div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtFechaLiquidacion" runat="server" Text='<%# Bind("FechaLiquidacion") %>' CssClass="form-control" TextMode="Date" />
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
                                <b id="editModalLabel">Modificar Liquidacion.</b>
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                            </div>
                            <div class="modal-body">
                                <asp:FormView ID="EditFormView" runat="server" Width="100%"
                                    CellPadding="4" DataKeyNames="IdLiquidacion" ForeColor="#333333"
                                    DefaultMode="Edit"
                                    OnModeChanging="EditFormView_ModeChanging" OnItemUpdating="EditFormView_ItemUpdating" OnItemUpdated="EditFormView_ItemUpdated">
                                    <EditItemTemplate>
                                        <div class="container-fluid">
                                            <div class="row">
                                                <div class="col-3">ID</div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtIdLiquidacion" runat="server" Text='<%# Bind("IdLiquidacion") %>' CssClass="form-control" Enabled="false" />
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3">Periodo</div>
                                                <div class="col-9">
                                                    <asp:DropDownList ID="IdPeriodoDDL"
                                                        runat="server"
                                                        DataSourceID="PeriodoDS"
                                                        DataTextField="IdPeriodo"
                                                        DataValueField="idPeriodo"
                                                        CssClass="form-control spacing"
                                                        SelectedValue='<%# Bind("IdPeriodo") %>'>
                                                    </asp:DropDownList>
                                                </div>
                                                <div class="row">
                                                    <div class="col-3">Timbrado</div>
                                                    <div class="col-9">
                                                        <asp:DropDownList ID="TimbradoDDL"
                                                            runat="server"
                                                            DataSourceID="TimbradoDS"
                                                            DataTextField="Timbrado"
                                                            DataValueField="IdTimbrado"
                                                            CssClass="form-control spacing"
                                                            SelectedValue='<%# Bind("IdTimbrado") %>'>
                                                        </asp:DropDownList>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-3">Fecha Liquidacion</div>
                                                    <div class="col-9">
                                                        <asp:TextBox ID="txtFechaLiquidacion" runat="server" Text='<%# Bind("FechaLiquidacion") %>' CssClass="form-control" TextMode="Date" />
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
        <asp:SqlDataSource ID="LiquidacionDS"
            runat="server" ConnectionString="<%$ ConnectionStrings:BoqueronConnectionString %>"
            InsertCommand="dbo.sp_Liquidacion_insert" InsertCommandType="StoredProcedure"
            SelectCommand="dbo.sp_Liquidacion_get_all" SelectCommandType="StoredProcedure">
            <DeleteParameters>
            </DeleteParameters>
            <InsertParameters>


                <asp:Parameter Name="IdPeriodo" Type="String" />
                <asp:Parameter Name="FechaLiquidacion" Type="DateTime" />
                <asp:Parameter Name="IdTimbrado" Type="Int16" />
            </InsertParameters>
            <UpdateParameters>
            </UpdateParameters>
        </asp:SqlDataSource>

        <asp:SqlDataSource ID="PeriodoDS" runat="server" ConnectionString="<%$ ConnectionStrings:BoqueronConnectionString %>"
            SelectCommand="select IdPeriodo from dbo.Periodo where IdPeriodo not in (select idPeriodo from Liquidacion) order by 1" SelectCommandType="Text"></asp:SqlDataSource>

        <asp:SqlDataSource ID="TimbradoDS" runat="server" ConnectionString="<%$ ConnectionStrings:BoqueronConnectionString %>"
            SelectCommand="SELECT [IDTimbrado],[Timbrado]  FROM [Boqueron].[dbo].[Timbrado] order by 2" SelectCommandType="Text"></asp:SqlDataSource>

        <!-- #endregion -->




    </div>
</asp:Content>
