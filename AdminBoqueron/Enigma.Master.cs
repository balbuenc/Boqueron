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
    public partial class Enigma : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
          
                GetMenuData();
           
                
           
        }



        private void GetMenuData()
        {
            DataTable table = new DataTable();
            string strCon = System.Configuration.ConfigurationManager.ConnectionStrings
            ["BoqueronConnectionString"].ConnectionString;
            SqlConnection conn = new SqlConnection(strCon);
            string sql = "select menu_id, menu_name, menu_parent_id, menu_url from menuMaster";
            SqlCommand cmd = new SqlCommand(sql, conn);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(table);
            DataView view = new DataView(table);
            view.RowFilter = "menu_parent_id is NULL";
            foreach (DataRowView row in view)
            {
                MenuItem menuItem = new MenuItem(row["menu_name"].ToString(),
                row["menu_id"].ToString());
                menuItem.NavigateUrl = row["menu_url"].ToString();
                menuBar.Items.Add(menuItem);
                AddChildItems(table, menuItem);
            }
        }

        private void AddChildItems(DataTable table, MenuItem menuItem)
        {
            DataView viewItem = new DataView(table);
            viewItem.RowFilter = "menu_parent_id=" + menuItem.Value;
            foreach (DataRowView childView in viewItem)
            {
                MenuItem childItem = new MenuItem(childView["menu_name"].ToString(),
                childView["menu_id"].ToString());
                childItem.NavigateUrl = childView["menu_url"].ToString();
                menuItem.ChildItems.Add(childItem);
                AddChildItems(table, childItem);
            }
        }
    }
}