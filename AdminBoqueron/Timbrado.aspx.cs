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
    public partial class Timbrado : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void FormView1_ItemInserted(object sender, FormViewInsertedEventArgs e)
        {
            Response.Redirect("Timbrado.aspx");
        }

        protected void CancelButton_Click(object sender, EventArgs e)
        {
            Response.Redirect("Timbrado.aspx");
        }

        protected void GetRecordToUpdate(String ID)
        {

            SqlCommand cmd = new SqlCommand();
            SqlConnection con = new SqlConnection(TimbradoDS.ConnectionString);

            cmd = new SqlCommand("dbo.[sp_Timbrado_get_Timbrado]", con);
            cmd.Parameters.Add(new SqlParameter("@IdTimbrado", ID));
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
            SqlConnection con = new SqlConnection(TimbradoDS.ConnectionString);

            cmd = new SqlCommand("dbo.[sp_Timbrado_delete]", con);
            cmd.Parameters.Add(new SqlParameter("@IdTimbrado", ID));



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
                TimbradoListView.DataBind();

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
                TextBox txtIDTimbrado = (TextBox)EditFormView.FindControl("txtIDTimbrado");
                TextBox txtTimbrado = (TextBox)EditFormView.FindControl("txtTimbrado");
                TextBox txtEmision = (TextBox)EditFormView.FindControl("txtEmision");
                TextBox txtVencimiento = (TextBox)EditFormView.FindControl("txtVencimiento");
                TextBox txtInicioSerie = (TextBox)EditFormView.FindControl("txtInicioSerie");
                TextBox txtFinalSerie = (TextBox)EditFormView.FindControl("txtFinalSerie");


                //DateTime isoDateTime = DateTime.ParseExact(txtCalendar.Value, format, CultureInfo.InvariantCulture);

                SqlConnection conn = new SqlConnection(TimbradoDS.ConnectionString);

                cmd.Connection = conn;

                cmd.CommandText = "dbo.sp_Timbrado_update";
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@IDTimbrado", txtIDTimbrado.Text);
                cmd.Parameters.AddWithValue("@Timbrado", txtTimbrado.Text);
                cmd.Parameters.AddWithValue("@Emision", txtEmision.Text);
                cmd.Parameters.AddWithValue("@Vencimiento", txtVencimiento.Text);
                cmd.Parameters.AddWithValue("@InicioSerie", txtInicioSerie.Text);
                cmd.Parameters.AddWithValue("@FinalSerie", txtFinalSerie.Text);

                conn.Open();
                cmd.ExecuteNonQuery();

                conn.Close();

                ScriptManager.RegisterStartupScript(this, this.GetType(), "",
                "$('#editModal').modal('hide');", true);

                Response.Redirect("Timbrado.aspx");


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
            TimbradoListView.DataBind();

        }
    }
}