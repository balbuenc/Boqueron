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
    public partial class Cliente : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void FormView1_ItemInserted(object sender, FormViewInsertedEventArgs e)
        {
            Response.Redirect("Cliente.aspx");
        }

        protected void CancelButton_Click(object sender, EventArgs e)
        {
            Response.Redirect("Cliente.aspx");
        }

        protected void GetRecordToUpdate(String ID)
        {

            SqlCommand cmd = new SqlCommand();
            SqlConnection con = new SqlConnection(ClienteDS.ConnectionString);

            cmd = new SqlCommand("dbo.[sp_Cliente_get_Cliente]", con);
            cmd.Parameters.Add(new SqlParameter("@IdCliente", ID));
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
            SqlConnection con = new SqlConnection(ClienteDS.ConnectionString);

            cmd = new SqlCommand("dbo.[sp_Cliente_delete]", con);
            cmd.Parameters.Add(new SqlParameter("@IdCliente", ID));



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
                ClienteListView.DataBind();

                ErrorLabel.Text = "El Registro se eliminó correctamente.";
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
                TextBox txtIdCliente = (TextBox)EditFormView.FindControl("txtIdCliente");
                TextBox txtNombre = (TextBox)EditFormView.FindControl("txtNombre");

                TextBox txtRUC = (TextBox)EditFormView.FindControl("txtRUC");

                TextBox txtPorcentCoPropiedad = (TextBox)EditFormView.FindControl("txtPorcentCoPropiedad");
                TextBox txtUnidad = (TextBox)EditFormView.FindControl("txtUnidad");
                TextBox txtDireccion = (TextBox)EditFormView.FindControl("txtDireccion");
                TextBox txtTelefono = (TextBox)EditFormView.FindControl("txtTelefono");
                //DateTime isoDateTime = DateTime.ParseExact(txtCalendar.Value, format, CultureInfo.InvariantCulture);

                SqlConnection conn = new SqlConnection(ClienteDS.ConnectionString);

                cmd.Connection = conn;

                cmd.CommandText = "dbo.sp_Cliente_update";
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@IdCliente", txtIdCliente.Text);
                cmd.Parameters.AddWithValue("@Nombre", txtNombre.Text);

                cmd.Parameters.AddWithValue("@RUC", txtRUC.Text);

                cmd.Parameters.AddWithValue("@PorcentCoPropiedad", txtPorcentCoPropiedad.Text);
                cmd.Parameters.AddWithValue("@Unidad", txtUnidad.Text);
                cmd.Parameters.AddWithValue("@Direccion", txtDireccion.Text);
                cmd.Parameters.AddWithValue("@Telefono", txtTelefono.Text);

                conn.Open();
                cmd.ExecuteNonQuery();

                conn.Close();

                ScriptManager.RegisterStartupScript(this, this.GetType(), "",
                "$('#editModal').modal('hide');", true);

                Response.Redirect("Cliente.aspx");


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
            ClienteListView.DataBind();

        }

        protected void btnClientes_Click(object sender, EventArgs e)
        {
            string popupScript = "<script language=javascript> window.open('http://localhost/ReportServer/Pages/ReportViewer.aspx?%2fBoqueronSSRS%2fClientes&rs:Command=Render') </script>";
            ClientScript.RegisterStartupScript(this.GetType(), "callpopup", popupScript);
        }
    }
}