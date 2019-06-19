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
    public partial class Liquidacion : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void FormView1_ItemInserted(object sender, FormViewInsertedEventArgs e)
        {
            Response.Redirect("Liquidacion.aspx");
        }

        protected void CancelButton_Click(object sender, EventArgs e)
        {
            Response.Redirect("Liquidacion.aspx");
        }

        protected void GetRecordToUpdate(String ID)
        {

            SqlCommand cmd = new SqlCommand();
            SqlConnection con = new SqlConnection(LiquidacionDS.ConnectionString);

            cmd = new SqlCommand("dbo.[sp_Liquidacion_get_Liquidacion]", con);
            cmd.Parameters.Add(new SqlParameter("@IdLiquidacion", ID));
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
            SqlConnection con = new SqlConnection(LiquidacionDS.ConnectionString);

            cmd = new SqlCommand("dbo.[sp_Liquidacion_delete]", con);
            cmd.Parameters.Add(new SqlParameter("@IdLiquidacion", ID));



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
                LiquidacionListView.DataBind();

                ErrorLabel.Text = "El Registro se eliminó correctamente.";
                ErrorLabel.Visible = true;
                FadeOut(ErrorLabel.ClientID, 3000);
            }
            else if (e.CommandName == "Liquidar")
            {
                LiquidarPeriodo(e.CommandArgument.ToString());
                LiquidacionListView.DataBind();

               
            }
            else if (e.CommandName == "Reporte")
            {

                string popupScript = "<script language=javascript> window.open('http://app.enigmatech.biz/ReportServer/Pages/ReportViewer.aspx?%2fBoqueronSSRS%2fLiquidacionDetalle&rs:Command=Render&IdLiquidacion=" + e.CommandArgument.ToString() + "') </script>";
                ClientScript.RegisterStartupScript(this.GetType(), "callpopup", popupScript);

            }
            else if (e.CommandName == "Resumen")
            {

                string popupScript = "<script language=javascript> window.open('http://app.enigmatech.biz/ReportServer/Pages/ReportViewer.aspx?%2fBoqueronSSRS%2fGastos&rs:Command=Render&IdLiquidacion=" + e.CommandArgument.ToString() + "') </script>";
                ClientScript.RegisterStartupScript(this.GetType(), "callpopup", popupScript);

            }
            else if (e.CommandName == "Ver")
            {

                Response.Redirect("LiquidacionDetalle.aspx?IdLiquidacion=" + e.CommandArgument.ToString());

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

        protected void LiquidarPeriodo(String IdLiquidacion)
        {
            SqlCommand cmd = new SqlCommand();
            SqlConnection conn = new SqlConnection(LiquidacionDS.ConnectionString);

            cmd.Connection = conn;

            cmd.CommandText = "dbo.sp_generar_liquidacion";
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.AddWithValue("@IdLiquidacion", IdLiquidacion);
            
            conn.Open();
            cmd.ExecuteNonQuery();

            conn.Close();
        }

        protected void EditFormView_ItemUpdating(object sender, FormViewUpdateEventArgs e)
        {
            SqlCommand cmd = new SqlCommand();
            DataKey key = EditFormView.DataKey;



            try
            {
                //Obtengo los valores de los campos a editar
                TextBox txtIdLiquidacion = (TextBox)EditFormView.FindControl("txtIdLiquidacion");
                DropDownList IdPeriodoDDL = (DropDownList)EditFormView.FindControl("IdPeriodoDDL");
                DropDownList IdTimbradoDDL = (DropDownList)EditFormView.FindControl("IdTimbradoDDL");
                TextBox txtFechaLiquidacion = (TextBox)EditFormView.FindControl("txtFechaLiquidacion");

                //DateTime isoDateTime = DateTime.ParseExact(txtCalendar.Value, format, CultureInfo.InvariantCulture);

                SqlConnection conn = new SqlConnection(LiquidacionDS.ConnectionString);

                cmd.Connection = conn;

                cmd.CommandText = "dbo.sp_Liquidacion_update";
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@IdLiquidacion", txtIdLiquidacion.Text);
                cmd.Parameters.AddWithValue("@IdPeriodo", IdPeriodoDDL.SelectedValue);
                cmd.Parameters.AddWithValue("@IdTimbrado", IdTimbradoDDL.SelectedValue);
                cmd.Parameters.AddWithValue("@FechaLiquidacion", txtFechaLiquidacion.Text);

                conn.Open();
                cmd.ExecuteNonQuery();

                conn.Close();

                ScriptManager.RegisterStartupScript(this, this.GetType(), "",
                "$('#editModal').modal('hide');", true);

                Response.Redirect("Liquidacion.aspx");


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
            LiquidacionListView.DataBind();

        }

        protected void ContabilidadBtn_Click(object sender, EventArgs e)
        {
            string popupScript = "<script language=javascript> window.open('http://app.enigmatech.biz/ReportServer/Pages/ReportViewer.aspx?%2fBoqueronSSRS%2fContabilidad&rs:Command=Render') </script>";
            ClientScript.RegisterStartupScript(this.GetType(), "callpopup", popupScript);
        }
    }
}