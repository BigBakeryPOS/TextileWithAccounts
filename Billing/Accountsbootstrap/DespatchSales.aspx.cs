using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BusinessLayer;
using DataLayer;
using System.Data;
using System.Text;
using System.Web.UI.HtmlControls;


namespace Billing.Accountsbootstrap
{
    public partial class DespatchSales : System.Web.UI.Page
    {
        BSClass objBs = new BSClass();
        string sTableName = "";
        string IsSuperAdmin = "";

        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["User"] != null)
                sTableName = Session["User"].ToString();
            else
                Response.Redirect("login.aspx");

            lblUser.Text = Session["UserName"].ToString();
            lblUserID.Text = Session["UserID"].ToString();
            IsSuperAdmin = Session["IsSuperAdmin"].ToString();

            if (!IsPostBack)
            {
                DataSet ds = objBs.getSalesInvoiceNo();
                if (ds.Tables[0].Rows.Count > 0)
                {
                    ddlInvoiceno.DataSource = ds;
                    ddlInvoiceno.DataTextField = "FullInvoiceNo";
                    ddlInvoiceno.DataValueField = "BuyerOrderSalesId";
                    ddlInvoiceno.DataBind();
                    ddlInvoiceno.Items.Insert(0, "Select");
                }

               
            }
        }

        protected void Add_Click(object sender, EventArgs e)
        {
            DataSet ds = objBs.getSalesforgrid(Convert.ToInt32(ddlInvoiceno.SelectedValue));
            if (ds.Tables[0].Rows.Count > 0)
            {
                GVItem.DataSource = ds;
                GVItem.DataBind();
            }
            }
        protected void ddlInvoiceno_SelectedIndexChanged(object sender, EventArgs e)
        {
            DataSet ds = objBs.getSalesforgrid(Convert.ToInt32(ddlInvoiceno.SelectedValue));
            if (ds.Tables[0].Rows.Count > 0)
            {
                GVItem.DataSource = ds;
                GVItem.DataBind();
            }
        }
        protected void Save_Click(object sender, EventArgs e)
        {
            for (int i = 0; i < GVItem.Rows.Count; i++)
            {
                Label lblbuyerordersalesid = (Label)GVItem.Rows[i].FindControl("lblbuyerordersalesid");

                Label lblinvoiceno = (Label)GVItem.Rows[i].FindControl("lblinvoiceno");

                Label lblinvoicedate = (Label)GVItem.Rows[i].FindControl("lblinvoicedate");
                Label lblbuyername = (Label)GVItem.Rows[i].FindControl("lblbuyername");

                Label lblqty = (Label)GVItem.Rows[i].FindControl("lblqty");

                TextBox txtLRno = (TextBox)GVItem.Rows[i].FindControl("txtLRno");
                TextBox txtLRdate = (TextBox)GVItem.Rows[i].FindControl("txtLRdate");
                TextBox txtTransport = (TextBox)GVItem.Rows[i].FindControl("txtTransport");
                TextBox txtnoofpackage = (TextBox)GVItem.Rows[i].FindControl("txtnoofpackage");
                Label lblsqaFile_Path = (Label)GVItem.Rows[i].FindControl("lblsqaFile_Path");
                Label lblledgerid = (Label)GVItem.Rows[i].FindControl("lblledgerid");

                int iStatus = objBs.InsertDespatch(lblbuyerordersalesid.Text, lblinvoiceno.Text, lblinvoicedate.Text, lblbuyername.Text, lblqty.Text, txtLRno.Text, txtLRdate.Text, txtTransport.Text, lblledgerid.Text, txtnoofpackage.Text, lblsqaFile_Path.Text);

            }
        }
            protected void GVItem_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "edit")
            {
                if (e.CommandArgument.ToString() != "")
                {
                    Response.Redirect("BuyerOrderSales.aspx?BuyerOrderSalesId=" + e.CommandArgument.ToString());
                }
            }
          else  if (e.CommandName == "Print")
            {
                if (e.CommandArgument.ToString() != "")
                {
                    Response.Redirect("BuyerSalesOrderPrint.aspx?BuyerOrderSalesId=" + e.CommandArgument.ToString());
                }
            }
            else if (e.CommandName == "delete1")
            {
                if (IsSuperAdmin == "1")
                {
                    int iSucess = objBs.DeleteBuyerOrderSalesInv(Convert.ToInt32(e.CommandArgument.ToString()));
                    Response.Redirect("BuyerOrderSalesGrid.aspx");
                }
                else
                {
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), Guid.NewGuid().ToString(), "alert('Please Contact Admin.');", true);
                    return;
                }
            }
        }


    }
}


