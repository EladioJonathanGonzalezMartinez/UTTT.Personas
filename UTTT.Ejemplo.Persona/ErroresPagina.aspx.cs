using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using UTTT.Ejemplo.Persona.Control.Ctrl;

namespace UTTT.Ejemplo.Persona
{
    public partial class ErrorPagina : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            Email objetoLogic = new Email();
            string msg = objetoLogic.SendMail(txtEmail.Text, txtAsunto.Text, txtmsj.Text);
            ScriptManager.RegisterClientScriptBlock(this, typeof(string), "MsgAlert", "alert('" + msg + "');window.location ='ErrorPage.aspx';", true);
            this.Response.Redirect("~/PersonaPrincipal.aspx", false);
            
           
        }
    }
}