using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace AdminBoqueron
{
    public partial class LiquidacionDetalle : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void LiquidacionListView_ItemCommand(object sender, ListViewCommandEventArgs e)
        {
            if (e.CommandName == "Facturar")
            {

                string popupScript = "<script language=javascript> window.open('http://localhost/ReportServer/Pages/ReportViewer.aspx?%2fBoqueronSSRS%2fFactura&rs:Command=Render&IdDocumento=" + e.CommandArgument.ToString() + "') </script>";
                ClientScript.RegisterStartupScript(this.GetType(), "callpopup", popupScript);

            }
        }
    }
}