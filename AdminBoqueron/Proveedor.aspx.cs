using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AdminBoqueron
{
    public partial class Proveedor : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            MainDataPager.PageSize = Convert.ToInt16(PageSizeDDL.SelectedValue);
        }

        protected void SearchBtn_ServerClick(object sender, EventArgs e)
        {
            ProveedorListView.DataBind();
        }

        protected void FormView1_ItemInserted(object sender, FormViewInsertedEventArgs e)
        {
            Response.Redirect("Proveedor.aspx");
        }

        protected void CancelButton_Click(object sender, EventArgs e)
        {
            Response.Redirect("Proveedor.aspx");
        }

        protected void GetRecordToUpdate(String ID)
        {

            SqlCommand cmd = new SqlCommand();
            SqlConnection con = new SqlConnection(ProveedorDS.ConnectionString);

            cmd = new SqlCommand("dbo.[sp_Proveedor_get_Proveedor]", con);
            cmd.Parameters.Add(new SqlParameter("@IdProveedor", ID));
            cmd.CommandType = CommandType.StoredProcedure;

            SqlDataAdapter adp = new SqlDataAdapter();

            con.Open();

            adp.SelectCommand = cmd;
            DataSet ds = new DataSet();
            adp.Fill(ds);

            EditFormView.DataSource = ds;
            EditFormView.DataBind();

            con.Close();
        }


        protected void DeleteRecord(String ID)
        {

            SqlCommand cmd = new SqlCommand();
            SqlConnection con = new SqlConnection(ProveedorDS.ConnectionString);

            cmd = new SqlCommand("dbo.[sp_Proveedor_delete]", con);
            cmd.Parameters.Add(new SqlParameter("@IdProveedor", ID));



            cmd.CommandType = CommandType.StoredProcedure;

            con.Open();
            cmd.ExecuteNonQuery();



            con.Close();
        }


        protected void ListView_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            if (e.CommandName == "Editar")
            {
                GetRecordToUpdate(e.CommandArgument.ToString());

                ScriptManager.RegisterStartupScript(this, this.GetType(), "",
               "$('#editModal').modal('show');", true);



            }
            else if (e.CommandName == "Eliminar")
            {
                DeleteRecord(e.CommandArgument.ToString());
                ProveedorListView.DataBind();

                ErrorLabel.Text = "El registro se eliminó correctamente.";
                ErrorLabel.Visible = true;
                FadeOut(ErrorLabel.ClientID, 3000);
            }
        }


        protected void FadeOut(string ClientID, int Time)
        {
            ScriptManager.RegisterClientScriptBlock(this.Page, this.GetType(), "script", "window.setTimeout(function() { document.getElementById('" + ClientID + "').style.display = 'none' }," + Time.ToString() + ");", true);
        }



        protected void EditFormView_ModeChanging(object sender, FormViewModeEventArgs e)
        {
            EditFormView.ChangeMode(e.NewMode);
        }

        protected void EditFormView_ItemUpdating(object sender, FormViewUpdateEventArgs e)
        {
            SqlCommand cmd = new SqlCommand();
            DataKey key = EditFormView.DataKey;



            try
            {
                //Obtengo los valores de los campos a editar
                TextBox txtIdProveedor = (TextBox)EditFormView.FindControl("txtIdProveedor");
                TextBox txtNombre = (TextBox)EditFormView.FindControl("txtNombre");
                TextBox txtDirección = (TextBox)EditFormView.FindControl("txtDirección");
                TextBox txtTeléfono = (TextBox)EditFormView.FindControl("txtTeléfono");
                TextBox txtFax = (TextBox)EditFormView.FindControl("txtFax");
                TextBox txtRUC = (TextBox)EditFormView.FindControl("txtRUC");
                TextBox txtObservación = (TextBox)EditFormView.FindControl("txtObservación");
                TextBox txtPersonaContacto = (TextBox)EditFormView.FindControl("txtPersonaContacto");
                TextBox txtSaldoIni = (TextBox)EditFormView.FindControl("txtSaldoIni");
                DropDownList IdCategoriaDDL = (DropDownList)EditFormView.FindControl("IdCategoriaDDL");


                //DateTime isoDateTime = DateTime.ParseExact(txtCalendar.Value, format, CultureInfo.InvariantCulture);

                SqlConnection conn = new SqlConnection(ProveedorDS.ConnectionString);

                cmd.Connection = conn;

                cmd.CommandText = "dbo.sp_Proveedor_update";
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@IdProveedor", txtIdProveedor.Text);
                cmd.Parameters.AddWithValue("@Nombre", txtNombre.Text);
                cmd.Parameters.AddWithValue("@Dirección", txtDirección.Text);
                cmd.Parameters.AddWithValue("@Teléfono", txtTeléfono.Text);
                cmd.Parameters.AddWithValue("@Fax", txtFax.Text);
                cmd.Parameters.AddWithValue("@RUC", txtRUC.Text);
                cmd.Parameters.AddWithValue("@Observación", txtObservación.Text);
                cmd.Parameters.AddWithValue("@PersonaContacto", txtPersonaContacto.Text);
                cmd.Parameters.AddWithValue("@SaldoIni", txtSaldoIni.Text);
                cmd.Parameters.AddWithValue("@IdCategoria", IdCategoriaDDL.SelectedValue.ToString());

                conn.Open();
                cmd.ExecuteNonQuery();

                conn.Close();

                ScriptManager.RegisterStartupScript(this, this.GetType(), "",
                "$('#editModal').modal('hide');", true);

                Response.Redirect("Proveedor.aspx");


            }
            catch (Exception ex)
            {
                ErrorLabel.Text = ex.Message;
                ErrorLabel.Visible = true;
                FadeOut(ErrorLabel.ClientID, 5000);
            }
        }


        protected void EditFormView_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
        {
            EditFormView.ChangeMode(FormViewMode.ReadOnly);
            ErrorLabel.Text = "El Registro de actualizò correctamente";
            ErrorLabel.Visible = true;
            FadeOut(ErrorLabel.ClientID, 5000);
            ProveedorListView.DataBind();

        }

      
    }
}