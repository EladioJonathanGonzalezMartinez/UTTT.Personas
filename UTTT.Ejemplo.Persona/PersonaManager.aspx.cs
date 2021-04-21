#region Using

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using UTTT.Ejemplo.Linq.Data.Entity;
using System.Data.Linq;
using System.Linq.Expressions;
using System.Collections;
using UTTT.Ejemplo.Persona.Control;
using UTTT.Ejemplo.Persona.Control.Ctrl;
using EASendMail;

#endregion

namespace UTTT.Ejemplo.Persona
{
    public partial class PersonaManager : System.Web.UI.Page
    {
        #region Variables

        private SessionManager session = new SessionManager();
        private int idPersona = 0;
        private UTTT.Ejemplo.Linq.Data.Entity.Persona baseEntity;
        private DataContext dcGlobal = new DcGeneralDataContext();
        private int tipoAccion = 0;

        #endregion

        #region Eventos

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                this.Response.Buffer = true;
                this.session = (SessionManager)this.Session["SessionManager"];
                this.idPersona = this.session.Parametros["idPersona"] != null ?
                    int.Parse(this.session.Parametros["idPersona"].ToString()) : 0;
                if (this.idPersona == 0)
                {
                    this.baseEntity = new Linq.Data.Entity.Persona();
                    this.tipoAccion = 1;
                }
                else
                {
                    this.baseEntity = dcGlobal.GetTable<Linq.Data.Entity.Persona>().First(c => c.id == this.idPersona);
                    this.tipoAccion = 2;
                }

                if (!this.IsPostBack)
                {
                    if (this.session.Parametros["baseEntity"] == null)
                    {
                        this.session.Parametros.Add("baseEntity", this.baseEntity);
                    }
                    List<CatSexo> lista = dcGlobal.GetTable<CatSexo>().ToList();
                    CatSexo catTemp = new CatSexo();
                    catTemp.id = -1;
                    catTemp.strValor = "Seleccionar";
                    lista.Insert(0, catTemp);
                    this.ddlSexo.DataTextField = "strValor";
                    this.ddlSexo.DataValueField = "id";
                    this.ddlSexo.DataSource = lista;
                    this.ddlSexo.DataBind();

                    this.ddlSexo.SelectedIndexChanged += new EventHandler(ddlSexo_SelectedIndexChanged);
                    this.ddlSexo.AutoPostBack = true;

                    List<CatEstadoCivil> listaEstadoCivil = dcGlobal.GetTable<CatEstadoCivil>().ToList();
                    CatEstadoCivil catEstadoCivilTemp = new CatEstadoCivil();
                    catEstadoCivilTemp.id = -1;
                    catEstadoCivilTemp.strValor = "Seleccionar";
                    listaEstadoCivil.Insert(0, catEstadoCivilTemp);
                    this.ddlEstadoCivil.DataTextField = "strValor";
                    this.ddlEstadoCivil.DataValueField = "id";
                    this.ddlEstadoCivil.DataSource = listaEstadoCivil;
                    this.ddlEstadoCivil.DataBind();

                    this.ddlEstadoCivil.SelectedIndexChanged += new EventHandler(ddlEstadoCivil_SelectedIndexChanged);
                    this.ddlEstadoCivil.AutoPostBack = true;

                    if (this.idPersona == 0)
                    {
                        this.lblAccion.Text = "Agregar";
                    }
                    else
                    {
                        this.lblAccion.Text = "Editar";
                        this.txtNombre.Text = this.baseEntity.strNombre;
                        this.txtAPaterno.Text = this.baseEntity.strAPaterno;
                        this.txtAMaterno.Text = this.baseEntity.strAMaterno;
                        this.txtClaveUnica.Text = this.baseEntity.strClaveUnica;
                        this.setItem(ref this.ddlSexo, baseEntity.CatSexo.strValor);
                        this.setItem(ref this.ddlEstadoCivil, baseEntity.CatEstadoCivil.strValor);
                        DateTime? fn = this.baseEntity.dteFecha;
                        this.txtDate.Text = fn.ToString();
                        this.Calendar1.SelectedDate = (DateTime)fn;
                        this.txtCorreoE.Text = this.baseEntity.strCorreoE;
                        this.txtCodP.Text = this.baseEntity.strCodigoP;
                        this.txtRFC.Text = this.baseEntity.strRFC;
                        this.setItemEditar(ref this.ddlSexo, baseEntity.CatSexo.strValor);
                    }                
                }

            }
            catch (Exception _e)
            {
                this.showMessage("Ha ocurrido un problema al cargar la página");
                this.Response.Redirect("~/PersonaPrincipal.aspx", false);
            }

        }

        protected void btnAceptar_Click(object sender, EventArgs e)
        {
            try
            {
                if (ValidacionFecha() == true)
                {
                    DataContext dcGuardar = new DcGeneralDataContext();
                    UTTT.Ejemplo.Linq.Data.Entity.Persona persona = new Linq.Data.Entity.Persona();
                    if (this.idPersona == 0)
                    {
                        persona.strClaveUnica = this.txtClaveUnica.Text.Trim();
                        persona.strNombre = this.txtNombre.Text.Trim();
                        persona.strAMaterno = this.txtAMaterno.Text.Trim();
                        persona.strAPaterno = this.txtAPaterno.Text.Trim();
                        persona.idCatSexo = int.Parse(this.ddlSexo.Text);
                        persona.idCatEstadoCivil = int.Parse(this.ddlEstadoCivil.Text);
                        persona.dteFecha = DateTime.Parse(this.txtDate.Text);
                        persona.strCorreoE = this.txtCorreoE.Text.Trim();
                        persona.strCodigoP = this.txtCodP.Text.Trim();
                        persona.strRFC = this.txtRFC.Text.Trim();
                        String mensaje = String.Empty;
                        if (!this.Validaciones(persona, ref mensaje))
                        {
                            this.lblmsj.Text = mensaje;
                            this.lblmsj.Visible = true;
                            return;
                        }
                        if (!this.InyecValidSql(ref mensaje))
                        {
                            this.lblmsj.Text = mensaje;
                            this.lblmsj.Visible = true;
                            return;
                        }
                        if (!this.InyecValidHTML(ref mensaje))
                        {
                            this.lblmsj.Text = mensaje;
                            this.lblmsj.Visible = true;
                            return;
                        }
                        dcGuardar.GetTable<UTTT.Ejemplo.Linq.Data.Entity.Persona>().InsertOnSubmit(persona);
                        dcGuardar.SubmitChanges();
                        this.showMessage("El registro se agrego correctamente.");
                        this.Response.Redirect("~/PersonaPrincipal.aspx", false);

                    }
                    if (this.idPersona > 0)
                    {
                        persona = dcGuardar.GetTable<UTTT.Ejemplo.Linq.Data.Entity.Persona>().First(c => c.id == idPersona);
                        persona.strClaveUnica = this.txtClaveUnica.Text.Trim();
                        persona.strNombre = this.txtNombre.Text.Trim();
                        persona.strAMaterno = this.txtAMaterno.Text.Trim();
                        persona.strAPaterno = this.txtAPaterno.Text.Trim();
                        persona.idCatSexo = int.Parse(this.ddlSexo.Text);
                        persona.idCatEstadoCivil = int.Parse(this.ddlEstadoCivil.Text);
                        persona.dteFecha = DateTime.Parse(this.txtDate.Text);
                        persona.strCorreoE = this.txtCorreoE.Text.Trim();
                        persona.strCodigoP = this.txtCodP.Text.Trim();
                        persona.strRFC = this.txtRFC.Text.Trim();
                        dcGuardar.SubmitChanges();
                        this.showMessage("El registro se edito correctamente.");
                        this.Response.Redirect("~/PersonaPrincipal.aspx", false);
                    }
                }
                else if (ValidacionFecha() == true)
                {
                    
                    this.showMessage("Eres menor de edad, no puedes ingresar tus datos");
                }
            }
            catch (Exception _e)
            {
                this.showMessageException(_e.Message);
                var msj = "Mensaje de error " + _e.Message;
                if (_e.InnerException != null)
                {
                    msj = msj + " Inner exception: " + _e.InnerException.Message;
                }
                msj = msj + " Stack trace: " + _e.StackTrace;
                this.Response.Redirect("~/ErroresPagina.aspx", false);
                this.SendMail("eladio.jonathan.gonzalez.martinez@gmail.com", "ERRORES", msj);
            }
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            try
            {              
                this.Response.Redirect("~/PersonaPrincipal.aspx", true);
            }
            catch (Exception _e)
            {
                this.showMessage("Ha ocurrido un error inesperado");
            }
        }

        protected void ddlSexo_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {

                int idSexo = int.Parse(this.ddlSexo.Text);
                Expression<Func<CatSexo, bool>> predicateSexo = c => c.id == idSexo;
                predicateSexo.Compile();
                List<CatSexo> lista = dcGlobal.GetTable<CatSexo>().Where(predicateSexo).ToList();
                CatSexo catTemp = new CatSexo();
                this.ddlSexo.DataTextField = "strValor";
                this.ddlSexo.DataValueField = "id";
                this.ddlSexo.DataSource = lista;
                this.ddlSexo.DataBind();
            }
            catch (Exception)
            {
                this.showMessage("Ha ocurrido un error inesperado");
            }
        }

        #endregion

        #region Metodos

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

        public bool Validaciones(UTTT.Ejemplo.Linq.Data.Entity.Persona perso, ref String msj)
        {

            if (perso.idCatSexo == -1)
            {
                msj = "Seleccione una opcion, masculino o femenino";
                return false;
            }

            int i = 0;
            if (int.TryParse(perso.strClaveUnica, out i) == false)
            {
                msj = "Solo se aceptan numeros";
                return false;
            }

            if (int.Parse(perso.strClaveUnica) < 1 || int.Parse(perso.strClaveUnica) > 999)
            {
                msj = "La clave solo tiene un rango de 1 a 1000";
                return false;
            }

            string nombre = perso.strNombre.Trim();
            if (nombre.Length < 3)
            {
                msj = "Ingresa mas de 3 caracteres";
                return false;
            }
            if (perso.strNombre.Equals(String.Empty))
            {
                msj = "El campo es obligatorio";
                return false;
            }
            if (perso.strNombre.Length > 50)
            {
                msj = "El numero de caracteres excede de 50";
                return false;
            }

            string APaterno = perso.strAPaterno.Trim();
            if (APaterno.Length < 3)
            {
                msj = "Ingresa mas de 3 caracteres";
                return false;
            }

            if (perso.strAPaterno.Equals(String.Empty))
            {
                msj = "El campo es obligatorio";
                return false;
            }
            if (perso.strAPaterno.Length > 50)
            {
                msj = "El numero de caracteres excede de 50";
                return false;
            }

            string AMaterno = perso.strAMaterno.Trim();
            if (AMaterno.Length < 3)
            {
                msj = "Ingresa mas de 3 caracteres";
                return false;
            }
            if (perso.strAMaterno.Equals(String.Empty))
            {
                msj = "El campo es obligatorio";
                return false;
            }
            if (perso.strAMaterno.Length > 50)
            {
                msj = "El numero de caracteres excede de 50";
                return false;
            }

            if (perso.strCorreoE.Equals(String.Empty))
            {
                msj = "El campo es obligatorio";
                return false;
            }
            if (perso.strCorreoE.Length > 50)
            {
                msj = "El numero de caracteres excede de 50";
                return false;
            }

            int p = 0;
            if (int.TryParse(perso.strCodigoP.ToString(), out p) == false)
            {
                msj = "Solo puedes ingresar numeros";
                return false;
            }
            if (perso.strCodigoP.Equals(String.Empty))
            {
                msj = "El campo es obligatorio";
                return false;
            }
            if (perso.strCodigoP.Length > 50)
            {
                msj = "El numero de caracteres excede de 50";
                return false;
            }

            if (perso.strRFC.Equals(String.Empty))
            {
                msj = "El campo es obligatorio";
                return false;
            }
            if (perso.strRFC.Length > 50)
            {
                msj = "El numero de caracteres excede de 50";
                return false;
            }
            if (perso.idCatEstadoCivil == -1)
            {
                msj = "Seleccione un estado civil";
                return false;
            }

            return true;
        }

        private bool InyecValidSql(ref String msj)
        {
            Ctrliyeccion valida = new Ctrliyeccion();
            string mensajeFuncion = string.Empty;


            if (valida.SqlInyectionValida(this.txtNombre.Text.Trim(), ref mensajeFuncion, "Nombre", ref this.txtNombre))
            {
                msj = mensajeFuncion;
                return false;
            }
            if (valida.SqlInyectionValida(this.txtAPaterno.Text.Trim(), ref mensajeFuncion, "APaterno", ref this.txtAPaterno))
            {
                msj = mensajeFuncion;
                return false;
            }
            if (valida.SqlInyectionValida(this.txtAMaterno.Text.Trim(), ref mensajeFuncion, "AMaterno", ref this.txtAMaterno))
            {
                msj = mensajeFuncion;
                return false;
            }
            if (valida.SqlInyectionValida(this.txtCorreoE.Text.Trim(), ref mensajeFuncion, "Correo electronico", ref this.txtCorreoE))
            {
                msj = mensajeFuncion;
                return false;
            }
            if (valida.SqlInyectionValida(this.txtCodP.Text.Trim(), ref mensajeFuncion, "Codigo postal", ref this.txtCodP))
            {
                msj = mensajeFuncion;
                return false;
            }
            if (valida.SqlInyectionValida(this.txtRFC.Text.Trim(), ref mensajeFuncion, "RFC", ref this.txtRFC))
            {
                msj = mensajeFuncion;
                return false;
            }

            return true;
        }

        private bool InyecValidHTML(ref String _mensaje)

        {
            Ctrliyeccion valida = new Ctrliyeccion();
            string mensajeFuncion = string.Empty;
            if (valida.htmlInyectionValida(this.txtClaveUnica.Text.Trim(), ref mensajeFuncion, "Clave unica", ref this.txtClaveUnica))
            {
                _mensaje = mensajeFuncion;
                return false;
            }
            if (valida.htmlInyectionValida(this.txtNombre.Text.Trim(), ref mensajeFuncion, "Nombre", ref this.txtNombre))
            {
                _mensaje = mensajeFuncion;
                return false;
            }
            if (valida.htmlInyectionValida(this.txtAPaterno.Text.Trim(), ref mensajeFuncion, "APaterno", ref this.txtAPaterno))
            {
                _mensaje = mensajeFuncion;
                return false;
            }
            if (valida.htmlInyectionValida(this.txtAMaterno.Text.Trim(), ref mensajeFuncion, "AMaterno", ref this.txtAMaterno))
            {
                _mensaje = mensajeFuncion;
                return false;
            }
            if (valida.htmlInyectionValida(this.txtCorreoE.Text.Trim(), ref mensajeFuncion, "Correo electronico", ref this.txtCorreoE))
            {
                _mensaje = mensajeFuncion;
                return false;
            }
            if (valida.htmlInyectionValida(this.txtCodP.Text.Trim(), ref mensajeFuncion, "Codigo postal", ref this.txtCodP))
            {
                _mensaje = mensajeFuncion;
                return false;
            }
            if (valida.htmlInyectionValida(this.txtRFC.Text.Trim(), ref mensajeFuncion, "RFC", ref this.txtRFC))
            {
                _mensaje = mensajeFuncion;
                return false;
            }
            return true;

        }

        public void SendMail(string CorreoD, string asunto, string msjCorreo)
        {
            string mensaje = "¡¡Ocurrio un error al enviar el correo!!";

            try
            {
                SmtpMail objetoCorreo = new SmtpMail("TryIt");

                objetoCorreo.From = "eladio.jonathan.gonzalez.martinez@gmail.com";
                objetoCorreo.To = CorreoD;
                objetoCorreo.Subject = asunto;
                objetoCorreo.TextBody = msjCorreo;

                SmtpServer objetoServidor = new SmtpServer("smtp.gmail.com");

                objetoServidor.User = "eladio.jonathan.gonzalez.martinez@gmail.com";
                objetoServidor.Password = "jonary12.";
                objetoServidor.Port = 587;
                objetoServidor.ConnectType = SmtpConnectType.ConnectSSLAuto;


                SmtpClient objetoCliente = new SmtpClient();
                objetoCliente.SendMail(objetoServidor, objetoCorreo);
                mensaje = "El correo se envio";


            }
            catch (Exception ex)
            {
                mensaje = "Error al enviar correo." + ex.Message;
            }
        }

        

        #endregion

        protected bool ValidacionFecha()
        {
            bool respuesta = false;
            try
            {
                DateTime fechaing = DateTime.Parse(this.txtDate.Text);
                DateTime fechaHoy = DateTime.Today;
                int edad = fechaHoy.Year - fechaing.Year;
                if (fechaHoy < fechaing.AddYears(edad)) edad--;

                if (edad > 18)
                {
                    
                    return respuesta = true;
                }
                else
                {
                    this.showMessage("Eres menor de edad, no puedes ingresar tus datos");
                    return respuesta = false;
                }
            }
            catch (Exception E)
            {
                string msj = E.ToString();
            }
            return respuesta;
        }

        protected void ddlEstadoCivil_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                int idEstadoCivil = int.Parse(this.ddlEstadoCivil.Text);
                Expression<Func<CatEstadoCivil, bool>> predicateEstadoCivil = c => c.id == idEstadoCivil;
                predicateEstadoCivil.Compile();
                List<CatEstadoCivil> lista = dcGlobal.GetTable<CatEstadoCivil>().Where(predicateEstadoCivil).ToList();
                CatEstadoCivil catEstadoCivilTemp = new CatEstadoCivil();
                this.ddlEstadoCivil.DataTextField = "strValor";
                this.ddlEstadoCivil.DataValueField = "id";
                this.ddlEstadoCivil.DataSource = lista;
                this.ddlEstadoCivil.DataBind();
            }
            catch (Exception)
            {
                this.showMessage("Ha ocurrido un error inesperado");
            }
        }

        public void setItemEditar(ref DropDownList _control, String _value)
        {
            foreach (ListItem item in _control.Items)
            {
                if (item.Value != _value)
                {
                    item.Enabled = false;

                    break;
                }
            }
            _control.Items.FindByText(_value).Selected = true;
        }
    }
}