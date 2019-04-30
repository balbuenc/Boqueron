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
    public partial class Expensa : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void FormView1_ItemInserted(object sender, FormViewInsertedEventArgs e)
        {
            Response.Redirect("Expensa.aspx");
        }

        protected void CancelButton_Click(object sender, EventArgs e)
        {
            Response.Redirect("Expensa.aspx");
        }

        protected void GetRecordToUpdate(String ID)
        {

            SqlCommand cmd = new SqlCommand();
            SqlConnection con = new SqlConnection(ExpensaDS.ConnectionString);

            cmd = new SqlCommand("dbo.[sp_Expensa_get_Expensa]", con);
            cmd.Parameters.Add(new SqlParameter("@IdExpensa", ID));
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
            SqlConnection con = new SqlConnection(ExpensaDS.ConnectionString);

            cmd = new SqlCommand("dbo.[sp_Expensa_delete]", con);
            cmd.Parameters.Add(new SqlParameter("@IdExpensa", ID));



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
                ExpensaListView.DataBind();

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
                DropDownList IdPeriodoDDL = (DropDownList)EditFormView.FindControl("IdPeriodoDDL");
                DropDownList IdCategoriaDDL = (DropDownList)EditFormView.FindControl("IdCategoriaDDL");
                DropDownList IdProveedorDDL = (DropDownList)EditFormView.FindControl("IdProveedorDDL");
                TextBox txtFecha = (TextBox)EditFormView.FindControl("txtFecha");
                TextBox txtMonto = (TextBox)EditFormView.FindControl("txtMonto");
                TextBox txtIdExpensa = (TextBox)EditFormView.FindControl("txtIdExpensa");


                //DateTime isoDateTime = DateTime.ParseExact(txtCalendar.Value, format, CultureInfo.InvariantCulture);

                SqlConnection conn = new SqlConnection(ExpensaDS.ConnectionString);

                cmd.Connection = conn;

                cmd.CommandText = "dbo.sp_Expensa_update";
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@IdPeriodo", IdPeriodoDDL.SelectedValue.ToString());
                cmd.Parameters.AddWithValue("@IdCategoria", IdCategoriaDDL.SelectedValue.ToString());
                cmd.Parameters.AddWithValue("@IdProveedor", IdProveedorDDL.SelectedValue.ToString());
                cmd.Parameters.AddWithValue("@Fecha", txtFecha.Text);
                cmd.Parameters.AddWithValue("@Monto", txtMonto.Text);
                cmd.Parameters.AddWithValue("@IdExpensa", txtIdExpensa.Text);

                conn.Open();
                cmd.ExecuteNonQuery();

                conn.Close();

                ScriptManager.RegisterStartupScript(this, this.GetType(), "",
                "$('#editModal').modal('hide');", true);

                Response.Redirect("Expensa.aspx");


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
            ExpensaListView.DataBind();

        }
    }
}