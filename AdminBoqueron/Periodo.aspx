<%@ Page Title="Periodo" Language="C#" MasterPageFile="~/Strap.Master" AutoEventWireup="true" CodeBehind="Periodo.aspx.cs" Inherits="AdminBoqueron.Periodo" %>

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
                                <b id="addModalLabel">Agregar nueva Periodo.</b>
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
                                                    <asp:TextBox ID="txtIdPeriodo" runat="server" Text='<%# Bind("IdPeriodo") %>' CssClass="form-control"  />
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
                                <b id="editModalLabel">Modificar Periodo.</b>
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
                                                    <asp:TextBox ID="txtIdPeriodo" runat="server" Text='<%# Bind("IdPeriodo") %>' CssClass="form-control" Enabled="false"/>
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
        </asp:SqlDataSource>



        <!-- #endregion -->




    </div>
</asp:Content>
