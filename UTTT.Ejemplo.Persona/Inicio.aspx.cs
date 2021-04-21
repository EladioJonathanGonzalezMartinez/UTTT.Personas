using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UTTT.Ejemplo.Persona
{
    public partial class Inicio : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["id"] == null)
            {
                this.Response.Redirect("~/Login.aspx");
            }
        }

        protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
        {
            this.Response.Redirect("~/PersonaPrincipal.aspx");
        }

        protected void ImageButton3_Click(object sender, ImageClickEventArgs e)
        {
            this.Response.Redirect("~/UsuarioPrincipal.aspx");
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            FormsAuthentication.SignOut();
            Session.Abandon();
            this.Response.Redirect("~/Login.aspx");
        }
    }
}