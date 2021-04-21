using System;
using System.Collections.Generic;
using System.Data.Linq;
using System.Linq;
using System.Linq.Expressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using UTTT.Ejemplo.Linq.Data.Entity;
using UTTT.Ejemplo.Persona.Control;
using UTTT.Ejemplo.Persona.Control.Ctrl;

namespace UTTT.Ejemplo.Persona
{
    public partial class UsuarioEdit : System.Web.UI.Page
    {
        private SessionManager session = new SessionManager();
        private int idPersona = 0;
        private UTTT.Ejemplo.Linq.Data.Entity.Usuario baseEntity;
        private DataContext dcGlobal = new DcGeneralDataContext();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["id"] == null)
            {
                this.Response.Redirect("~/Login.aspx");
            }
            this.lblmsj.Text = "";
            try
            {
                this.Response.Buffer = true;
                this.session = (SessionManager)this.Session["SessionManager"];
                this.idPersona = this.session.Parametros["idPersona"] != null ?
                    int.Parse(this.session.Parametros["idPersona"].ToString()) : 0;
                if (this.idPersona == 0)
                {
                    this.baseEntity = new Linq.Data.Entity.Usuario();

                }
                else
                {
                    this.baseEntity = dcGlobal.GetTable<Linq.Data.Entity.Usuario>().First(c => c.id == this.idPersona);
                }

                if (!this.IsPostBack)
                {
                    if (this.session.Parametros["baseEntity"] == null)
                    {
                        this.session.Parametros.Add("baseEntity", this.baseEntity);
                    }
                    List<Estado> lista2 = dcGlobal.GetTable<Estado>().ToList();
                    Estado estTemp = new Estado();
                    lista2.Insert(0, estTemp);
                    this.ddlEstado.DataTextField = "strValor";
                    this.ddlEstado.DataValueField = "id";
                    this.ddlEstado.DataSource = lista2;
                    this.ddlEstado.DataBind();
                    this.ddlEstado.SelectedIndexChanged += new EventHandler(ddlEstado_SelectedIndexChanged);
                    this.ddlEstado.AutoPostBack = true;

                    if (this.idPersona == 0)
                    {
                    }
                    else
                    {
                        this.txtPersona.Text = this.baseEntity.Persona.strNombre;
                        this.txtuser.Text = this.baseEntity.usuario1;
                        var contra = EncriptarContra.DesEncriptar(this.baseEntity.passw);
                        this.txtcontra.Text = contra.ToString();
                        this.txtrecontra.Text = contra.ToString();
                        this.txtDate.Text =  this.baseEntity.fecha.ToString();
                        this.setItem(ref this.ddlEstado, baseEntity.Estado.strValor);
                    }
                }

            }
            catch (Exception _e)
            {
                this.showMessage("Ha ocurrido un problema al cargar la página" + _e.Message);
                this.showMessageException(_e.Message);

            }
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            try
            {
                Response.Redirect("~/UsuarioPrincipal.aspx", true);
            }
            catch (Exception ex)
            {
                this.showMessage("Ha ocurrido un error inesperado");
            }
        }

        protected void btnAceptar_Click(object sender, EventArgs e)
        {
            try
            {
                DataContext dcGuardar = new DcGeneralDataContext();
                UTTT.Ejemplo.Linq.Data.Entity.Usuario usuario = new Linq.Data.Entity.Usuario();
                if (this.idPersona > 0)
                {
                    if (txtcontra.Text != txtrecontra.Text)
                    {
                        this.lblmsj.Text = "los 2 campos de contraseña deben ser iguales";
                    }
                    else
                    {
                        usuario = dcGuardar.GetTable<UTTT.Ejemplo.Linq.Data.Entity.Usuario>().First(c => c.id == idPersona);
                        var contra = EncriptarContra.Encriptar(txtcontra.Text);
                        usuario.passw = contra.ToString().Trim();
                        usuario.fecha = DateTime.Parse(this.txtDate.Text);
                        usuario.idEstado = int.Parse(this.ddlEstado.Text);
                        dcGuardar.SubmitChanges();
                        this.showMessage("El registro se edito correctamente.");
                        this.Response.Redirect("~/UsuarioPrincipal.aspx", false);
                    }
                }
            }
            catch (Exception _e)
            {
                this.showMessageException(_e.Message);
                this.lblmsj.Text = _e.Message;
            }
            
        }

        protected void ddlEstado_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                int idSexo = int.Parse(this.ddlEstado.Text);
                Expression<Func<Estado, bool>> predicateSexo = c => c.id == idSexo;
                predicateSexo.Compile();
                List<Estado> lista = dcGlobal.GetTable<Estado>().Where(predicateSexo).ToList();
                CatSexo catTemp = new CatSexo();
                this.ddlEstado.DataTextField = "strValor";
                this.ddlEstado.DataValueField = "id";
                this.ddlEstado.DataSource = lista;
                this.ddlEstado.DataBind();
            }
            catch (Exception)
            {
                this.showMessage("Ha ocurrido un error inesperado");
            }
        }

        public void setItem(ref DropDownList _control, String _value)
        {
            foreach (ListItem item in _control.Items)
            {
                if (item.Value == _value)
                {
                    item.Selected = true;
                    break;
                }
            }
            _control.Items.FindByText(_value).Selected = true;
        }
    }
}