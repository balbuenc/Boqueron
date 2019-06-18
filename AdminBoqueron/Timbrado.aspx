<%@ Page Title="Talonarios" Language="C#" MasterPageFile="~/Strap.Master" AutoEventWireup="true" CodeBehind="Timbrado.aspx.cs" Inherits="AdminBoqueron.Timbrado" %>

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
          <asp:DataPager ID="MainDataPager" runat="server" PagedControlID="TimbradoListView" PageSize="10">
            <Fields>
                <asp:NextPreviousPagerField ButtonCssClass="btn btn-default btn-sm" ButtonType="Button" ShowFirstPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False" FirstPageText="Primera" />
                <asp:NumericPagerField ButtonType="Button" CurrentPageLabelCssClass="btn btn-sm" NextPreviousButtonCssClass="btn btn-default btn-sm" NumericButtonCssClass="btn btn-default btn-sm" />
                <asp:NextPreviousPagerField ButtonCssClass="btn btn-default btn-sm" ButtonType="Button" ShowLastPageButton="True" ShowNextPageButton="False" ShowPreviousPageButton="False" LastPageText="Última" />
            </Fields>
        </asp:DataPager>
        <asp:ListView ID="TimbradoListView"
            runat="server"
            DataSourceID="TimbradoDS"
            DataKeyNames="IdTimbrado"
            OnItemCommand="ListView_ItemCommand">
            <LayoutTemplate>
                <div class="table responsive">
                    <table class="table table-striped table-condensed">
                        <thead>
                            <th>ID</th>
                            <th>Timbrado</th>
                            <th>Emisión</th>
                            <th>Vencimiento</th>
                            <th>Inicio Serie</th>
                            <th>Final Serie</th>

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
                        <asp:Label ID="lblIDTimbrado" runat="server" Text='<%# Eval("IDTimbrado") %>' /></td>
                    <td>
                        <asp:Label ID="lblTimbrado" runat="server" Text='<%# Eval("Timbrado") %>' /></td>
                    <td>
                        <asp:Label ID="lblEmision" runat="server" Text='<%# String.Format("{0:dd/MM/yyyy}",Eval("Emision")) %>' /></td>
                    <td>
                        <asp:Label ID="lblVencimiento" runat="server" Text='<%# String.Format("{0:dd/MM/yyyy}",Eval("Vencimiento")) %>' /></td>
                    <td>
                        <asp:Label ID="lblInicioSerie" runat="server" Text='<%# Eval("InicioSerie") %>' /></td>
                    <td>
                        <asp:Label ID="lblFinalSerie" runat="server" Text='<%# Eval("FinalSerie") %>' /></td>



                    <td>
                        <asp:LinkButton runat="server" ID="EditTimbradoBtn" CommandName="Editar" CommandArgument='<%# Eval("IdTimbrado")%>' ToolTip="Editar">
                            <i class="fa fa-keyboard fa-sm"></i>
                        </asp:LinkButton>
                    </td>

                    <td>

                        <asp:LinkButton runat="server" ID="DeleteTimbradoBtn" CommandName="Eliminar" CommandArgument='<%# Eval("IdTimbrado")%>' ToolTip="Eliminar">
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
                                <b id="addModalLabel">Agregar nueva Timbrado.</b>
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                            </div>
                            <div class="modal-body">
                                <asp:FormView ID="InsertFormView" runat="server" DataSourceID="TimbradoDS" Width="100%"
                                    CellPadding="4" DataKeyNames="IdTimbrado" ForeColor="#333333"
                                    DefaultMode="Insert"
                                    OnItemInserted="FormView1_ItemInserted">
                                    <EditItemTemplate>
                                    </EditItemTemplate>
                                    <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                                    <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                                    <InsertItemTemplate>
                                        <div class="container-fluid">
                                            <div class="row">
                                                <div class="col-3">IDTimbrado</div>
                                                <div class="col-9">
                                                    <asp:Label ID="txtIDTimbrado" runat="server" Text="" CssClass="form-control mitad" Enabled="false" /></div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3">Timbrado</div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtTimbrado" runat="server" Text='<%# Bind("Timbrado") %>' CssClass="form-control" /></div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3">Emision</div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtEmision" runat="server" Text='<%# Bind("Emision") %>' CssClass="form-control" TextMode="Date"  /></div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3">Vencimiento</div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtVencimiento" runat="server" Text='<%# Bind("Vencimiento") %>' CssClass="form-control" TextMode="Date" /></div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3">InicioSerie</div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtInicioSerie" runat="server" Text='<%# Bind("InicioSerie") %>' CssClass="form-control" /></div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3">FinalSerie</div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtFinalSerie" runat="server" Text='<%# Bind("FinalSerie") %>' CssClass="form-control" /></div>
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
                                <b id="editModalLabel">Modificar Timbrado.</b>
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                            </div>
                            <div class="modal-body">
                                <asp:FormView ID="EditFormView" runat="server" Width="100%"
                                    CellPadding="4" DataKeyNames="IdTimbrado" ForeColor="#333333"
                                    DefaultMode="Edit"
                                    OnModeChanging="EditFormView_ModeChanging" OnItemUpdating="EditFormView_ItemUpdating" OnItemUpdated="EditFormView_ItemUpdated">
                                    <EditItemTemplate>
                                        <div class="container-fluid">
                                            <div class="row">
                                                <div class="col-3">IDTimbrado</div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtIDTimbrado" runat="server" Text='<%# Bind("IDTimbrado") %>' CssClass="form-control mitad" Enabled="false" /></div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3">Timbrado</div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtTimbrado" runat="server" Text='<%# Bind("Timbrado") %>' CssClass="form-control" /></div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3">Emision</div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtEmision" runat="server" Text='<%#  Bind("Emision") %>' CssClass="form-control" TextMode="Date"  /></div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3">Vencimiento</div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtVencimiento" runat="server" Text='<%# Bind("Vencimiento") %>' CssClass="form-control" TextMode="Date" /></div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3">InicioSerie</div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtInicioSerie" runat="server" Text='<%# Bind("InicioSerie") %>' CssClass="form-control" /></div>
                                            </div>
                                            <div class="row">
                                                <div class="col-3">FinalSerie</div>
                                                <div class="col-9">
                                                    <asp:TextBox ID="txtFinalSerie" runat="server" Text='<%# Bind("FinalSerie") %>' CssClass="form-control" /></div>
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
        <asp:SqlDataSource ID="TimbradoDS"
            runat="server" ConnectionString="<%$ ConnectionStrings:BoqueronConnectionString %>"
            InsertCommand="dbo.sp_Timbrado_insert" InsertCommandType="StoredProcedure"
            SelectCommand="dbo.sp_Timbrado_get_all" SelectCommandType="StoredProcedure">
            <DeleteParameters>
            </DeleteParameters>
            <InsertParameters>
               
                <asp:Parameter Name="Timbrado" Type="String" />
                <asp:Parameter Name="Emision" Type="DateTime" />
                <asp:Parameter Name="Vencimiento" Type="DateTime" />
                <asp:Parameter Name="InicioSerie" Type="Int32" />
                <asp:Parameter Name="FinalSerie" Type="Int32" />
            </InsertParameters>
            <UpdateParameters>
            </UpdateParameters>
        </asp:SqlDataSource>



        <!-- #endregion -->




    </div>
</asp:Content>
