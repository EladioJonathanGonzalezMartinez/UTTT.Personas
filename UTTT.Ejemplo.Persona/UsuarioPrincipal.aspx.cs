using System;
using System.Collections;
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
    public partial class UsuarioPrincipal : System.Web.UI.Page
    {
        private SessionManager session = new SessionManager();

        protected void Page_Load(object sender, EventArgs e)
        {
            if(Session["id"] == null)
            {
                this.Response.Redirect("~/Login.aspx");
            }
            try
            {
                Response.Buffer = true;
                DataContext dcTemp = new DcGeneralDataContext();
                if (!this.IsPostBack)
                {
                    List<Estado> lista = dcTemp.GetTable<Estado>().ToList();
                    Estado catTemp = new Estado();
                    catTemp.id = -1;
                    catTemp.strValor = "Estado";
                    lista.Insert(0, catTemp);
                    this.ddlEstado.DataTextField = "strValor";
                    this.ddlEstado.DataValueField = "id";
                    this.ddlEstado.DataSource = lista;
                    this.ddlEstado.DataBind();
                }
            }
            catch (Exception _e)
            {
                this.showMessage("Ha ocurrido un problema al cargar la página");
            }
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
            try
            {
                this.DataSourceUsuario.RaiseViewChanged();
            }
            catch (Exception _e)
            {
                this.showMessage("Ha ocurrido un problema al buscar");
            }
        }

        protected void btnAgregar_Click(object sender, EventArgs e)
        {
            try
            {
                this.session.Pantalla = "~/UsuarioManager.aspx";
                Hashtable parametrosRagion = new Hashtable();
                parametrosRagion.Add("id", "0");
                this.session.Parametros = parametrosRagion;
                this.Session["SessionManager"] = this.session;
                this.Response.Redirect(this.session.Pantalla, false);
            }
            catch (Exception _e)
            {
                this.showMessage("Ha ocurrido un problema al agregar");
            }
        }

        protected void DataSourceUsuario_Selecting(object sender, LinqDataSourceSelectEventArgs e)
        {
            try
            {
                DataContext dcConsulta = new DcGeneralDataContext();
                bool usuarioBool = false;
                bool estadoBool = false;
                if (!this.txtusuario.Text.Equals(String.Empty))
                {
                    usuarioBool = true;
                }
                if (this.ddlEstado.Text != "-1")
                {
                    estadoBool = true;
                }


                Expression<Func<UTTT.Ejemplo.Linq.Data.Entity.Usuario, bool>>
                    predicate =
                    (c =>
                    ((estadoBool) ? c.idEstado == int.Parse(this.ddlEstado.Text) : true) &&
                    ((usuarioBool) ? (((usuarioBool) ? c.usuario1.Contains(this.txtusuario.Text.Trim()) : false)) : true)
                    );

                predicate.Compile();

                List<UTTT.Ejemplo.Linq.Data.Entity.Usuario> listaUsuario =
                    dcConsulta.GetTable<UTTT.Ejemplo.Linq.Data.Entity.Usuario>().Where(predicate).ToList();
                e.Result = listaUsuario;
            }
            catch (Exception _e)
            {
                throw _e;
            }
        }

        protected void dgvPersonas_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            try
            {
                int id = int.Parse(e.CommandArgument.ToString());
                switch (e.CommandName)
                {
                    case "Editar":
                        this.editar(id);
                        break;
                    case "Eliminar":
                        this.eliminar(id);
                        break;
                }
            }
            catch (Exception _e)
            {
                this.showMessage("Ha ocurrido un problema al seleccionar");
            }
        }

        private void editar(int _idUsuario)
            {
                try
                {
                Hashtable parametrosRagion = new Hashtable();
                parametrosRagion.Add("idPersona", _idUsuario.ToString());
                this.session.Parametros = parametrosRagion;
                this.Session["SessionManager"] = this.session;
                this.session.Pantalla = String.Empty;
                this.session.Pantalla = "~/UsuarioEdit.aspx";
                this.Response.Redirect(this.session.Pantalla, false);

            }
                catch (Exception _e)
                {
                    throw _e;
                }
            }

            private void eliminar(int _id)
            {
                try
                {
                    DataContext dcDelete = new DcGeneralDataContext();
                    UTTT.Ejemplo.Linq.Data.Entity.Usuario usuario = dcDelete.GetTable<UTTT.Ejemplo.Linq.Data.Entity.Usuario>().First(
                        c => c.id == _id);
                    dcDelete.GetTable<UTTT.Ejemplo.Linq.Data.Entity.Usuario>().DeleteOnSubmit(usuario);
                    dcDelete.SubmitChanges();
                    this.showMessage("El registro se elimino correctamente.");
                    this.DataSourceUsuario.RaiseViewChanged();
                }
                catch (Exception _e)
                {
                    throw _e;
                }
            }

        }
    }
