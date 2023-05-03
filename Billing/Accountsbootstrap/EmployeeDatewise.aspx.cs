﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BusinessLayer;
using System.Data;
using System.Text;
using System.IO;

namespace Billing.Accountsbootstrap
{
    public partial class EmployeeDatewise : System.Web.UI.Page
    {
        string sTableName = "";
        BSClass objBs = new BSClass();
        double amount1 = 0;
        string brach = string.Empty;
        protected void Page_Load(object sender, EventArgs e)
        {
            lblUser.Text = Session["UserName"].ToString();
            lblUserID.Text = Session["UserID"].ToString();
            sTableName = Session["User"].ToString();
            ScriptManager scriptManager = ScriptManager.GetCurrent(this.Page);
            scriptManager.RegisterPostBackControl(this.btnExport);

            if (!IsPostBack)
            {

                DataSet drppEmp = objBs.SelectEmpName();
                if (drppEmp.Tables[0].Rows.Count > 0)
                {
                    drpemp.DataSource = drppEmp;
                    drpemp.DataTextField = "Name";
                    drpemp.DataValueField = "Employee_Id";
                    drpemp.DataBind();
                    drpemp.Items.Insert(0, "Select Employee Name");
                }

            }
        }

        protected void btnsearch_click(object sender, EventArgs e)
        {
            DataTable dt = new DataTable();
            DataSet dss = new DataSet();
            if (drpemp.SelectedValue == "Select Employee Name")
            {
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), Guid.NewGuid().ToString(), "alert('Please Select Employee!!!.Thanks you!!!')", true);
                return;
            }

            if (txtstartdate.Text == "")
            {
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), Guid.NewGuid().ToString(), "alert('Please Select Start Date!!!.Thanks you!!!')", true);
                return;
            }
            if (txtenddate.Text == "")
            {
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), Guid.NewGuid().ToString(), "alert('Please Select End date!!!.Thanks You!!!')", true);
                return;
            }

            DataSet ds = objBs.getdatewisesummaryforemployee(txtstartdate.Text, txtenddate.Text,drpemp.SelectedValue);
            if (ds.Tables[0].Rows.Count > 0)
            {
                if (ds != null)
                {
                    if (ds.Tables[0].Rows.Count > 0)
                    {

                        DataSet dcalculate = new DataSet();

                        dt.Columns.Add(new DataColumn("empid"));
                        dt.Columns.Add(new DataColumn("name"));
                        dt.Columns.Add(new DataColumn("qty"));
                        dt.Columns.Add(new DataColumn("rate"));

                        for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                        {
                            DataRow dr_final12 = dt.NewRow();
                            dr_final12["empid"] = ds.Tables[0].Rows[i]["empid"].ToString();
                            dr_final12["name"] = ds.Tables[0].Rows[i]["name"].ToString();
                            dr_final12["qty"] = ds.Tables[0].Rows[i]["qty"].ToString();
                            dr_final12["rate"] = ds.Tables[0].Rows[i]["rate"].ToString();

                            dt.Rows.Add(dr_final12);

                        }
                    }

                    DataTable dtt = new DataTable();
                    dtt.Columns.Add(new DataColumn("empid"));
                    dtt.Columns.Add(new DataColumn("name"));
                    dtt.Columns.Add(new DataColumn("qty"));
                    dtt.Columns.Add(new DataColumn("rate"));

                    var result = from r in dt.AsEnumerable()
                                 group r by new { empid = r["empid"], empname = r["name"] } into g
                                 select new
                                 {
                                     Group = g.Key.empid,
                                     namee = g.Key.empname,
                                     Sum = g.Sum(x => Convert.ToDouble(x["rate"])),
                                     Sum1 = g.Sum(y => Convert.ToDouble(y["qty"])),
                                     //s totpri =g.Sum(y=>item.Sum *Convert.ToDouble(x["Price"]))
                                 };

                    foreach (var item in result)
                    {
                        DataRow dr = dtt.NewRow();
                        dr["empid"] = item.Group;
                        dr["name"] = item.namee;
                        dr["qty"] = item.Sum1;
                        dr["rate"] = item.Sum;
                        dtt.Rows.Add(dr);
                    }

                    IEnumerable<DataRow> rows = dtt.Rows.Cast<DataRow>().Where(r => r["Qty"].ToString() == "0");
                    rows.ToList().ForEach(r => r.Delete());
                    dtt.AcceptChanges();

                    dss.Tables.Add(dtt);
                    gridshirt.DataSource = dss;
                    gridshirt.DataBind();

                }


                //gridshirt.DataSource = ds;
                //gridshirt.DataBind();
            }
            else
            {
                gridshirt.DataSource = null;
                gridshirt.DataBind();
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), Guid.NewGuid().ToString(), "alert('No Record Found.Thanks You!!!')", true);
                return;
            }

            //DataSet dshirtall = objBs.getLotNoReportGenerate(Convert.ToInt32(drpsample.SelectedValue));
            //lblLot.Text = drpsample.SelectedItem.Text;
            //if (dshirtall.Tables[0].Rows.Count > 0)
            //{
            //    Gridoverall.DataSource = dshirtall;
            //    Gridoverall.DataBind();
            //}
            //else
            //{
            //    Gridoverall.DataSource = null;
            //    Gridoverall.DataBind();
            //}
        }



        protected void btnall_Click(object sender, EventArgs e)
        {


        }

        protected void btnViewAll_Click(object sender, EventArgs e)
        {

        }

        protected void btnExport_Click(object sender, EventArgs e)
        {

        }

        protected void Page_Change(object sender, GridViewPageEventArgs e)
        {

        }

        public void gvCustsales_RowDataBound(object sender, GridViewRowEventArgs e)
        {


            if (e.Row.RowType == DataControlRowType.DataRow)
            {

            }



            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                GridView gv = e.Row.FindControl("gvLiaLedger") as GridView;
                GridView gvGroup = (GridView)sender;
                if (gvGroup.DataKeys[e.Row.RowIndex].Value != "")
                {
                    string groupID = Convert.ToString(gvGroup.DataKeys[e.Row.RowIndex].Value);
                    DataSet ds = objBs.getdatewisedetailedreport(txtstartdate.Text, txtenddate.Text, groupID);
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        gv.DataSource = ds;
                        //double amount = Convert.ToDouble(ds.Tables[0].Rows[0]["NetAmount"]);
                        //   amount1 = amount1 + amount;
                        gv.DataBind();
                    }
                }

            }

            if (e.Row.RowType == DataControlRowType.Footer)
            {
                //e.Row.Cells[0].HorizontalAlign = HorizontalAlign.Left;
                //e.Row.Cells[1].HorizontalAlign = HorizontalAlign.Right;
                //e.Row.Cells[2].HorizontalAlign = HorizontalAlign.Right;
                //e.Row.Cells[3].HorizontalAlign = HorizontalAlign.Right;
                //e.Row.Cells[7].HorizontalAlign = HorizontalAlign.Center;

                //e.Row.Cells[0].Text = "Total";
                ////e.Row.Cells[1].Text = HorizontalAlign.Right;
                //e.Row.Cells[7].Text = amount1.ToString("N2");


            }

        }
    }
}