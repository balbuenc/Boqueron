﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AdminBoqueron
{
    public partial class Categoria : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void FormView1_ItemInserted(object sender, FormViewInsertedEventArgs e)
        {
            Response.Redirect("Categoria.aspx");
        }

        protected void CancelButton_Click(object sender, EventArgs e)
        {
            Response.Redirect("Categoria.aspx");
        }

        protected void GetRecordToUpdate(String ID)
        {

            SqlCommand cmd = new SqlCommand();
            SqlConnection con = new SqlConnection(CategoriaDS.ConnectionString);

            cmd = new SqlCommand("dbo.[sp_Categoria_get_Categoria]", con);
            cmd.Parameters.Add(new SqlParameter("@IdCategoria", ID));
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
            SqlConnection con = new SqlConnection(CategoriaDS.ConnectionString);

            cmd = new SqlCommand("dbo.[sp_Categoria_delete]", con);
            cmd.Parameters.Add(new SqlParameter("@IdCategoria", ID));



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
                CategoriaListView.DataBind();

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
                TextBox txtIdCategoria = (TextBox)EditFormView.FindControl("txtIdCategoria");
                TextBox txtCategoria = (TextBox)EditFormView.FindControl("txtCategoria");
                DropDownList IdCuentaDDL = (DropDownList)EditFormView.FindControl("IdCuentaDDL");

                //DateTime isoDateTime = DateTime.ParseExact(txtCalendar.Value, format, CultureInfo.InvariantCulture);

                SqlConnection conn = new SqlConnection(CategoriaDS.ConnectionString);

                cmd.Connection = conn;

                cmd.CommandText = "dbo.sp_Categoria_update";
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@IdCategoria", txtIdCategoria.Text);
                cmd.Parameters.AddWithValue("@Categoria", txtCategoria.Text);
                cmd.Parameters.AddWithValue("@IdCuenta", IdCuentaDDL.SelectedValue);

                conn.Open();
                cmd.ExecuteNonQuery();

                conn.Close();

                ScriptManager.RegisterStartupScript(this, this.GetType(), "",
                "$('#editModal').modal('hide');", true);

                Response.Redirect("Categoria.aspx");


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
            CategoriaListView.DataBind();

        }
    }
}