using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Mail;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using UTTT.Ejemplo.Linq.Data.Entity;

namespace UTTT.Ejemplo.Persona
{
    public partial class Recuperar : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        UTTT.Ejemplo.Linq.Data.Entity.Usuario usuario = new Linq.Data.Entity.Usuario();
        DcGeneralDataContext usa = new DcGeneralDataContext();
        protected void Button1_Click(object sender, EventArgs e)
        {
            try { 
            var em = usa.Persona.FirstOrDefault(p => p.strCorreoE == txtCorre.Text );
            if (em != null)
            {
                var tok = usa.Usuario.FirstOrDefault(P => P.token == null);

                    if(tok != null)
                    {
                        EncripMD5("124578");
                        string toke = GenerarToken();
                        string corre = txtCorre.Text;

                    }
                    else
                    {

                    }
            }
            }
            catch
            {

            }
        }
        public static string EncripMD5(string word)
        {
            MD5 md5 = MD5CryptoServiceProvider.Create();
            ASCIIEncoding encoding = new ASCIIEncoding();
            byte[] stream = null;
            StringBuilder sb = new StringBuilder();
            stream = md5.ComputeHash(encoding.GetBytes(word));
            for (int i = 0; i < stream.Length; i++) sb.AppendFormat("{0:x2}", stream[i]);
            return sb.ToString();
        }
        public void EnviarCorreo(string tokens, string correo)
        {
            string EmailOrigen = "eladio.jonathan.gonzalez.martinez@gmail.com";
            string EmailDestino = correo;
            string contra = "jonary12.";

            MailMessage oMailMessage = new MailMessage(EmailOrigen, EmailDestino, "Camcio de contraseña", "http://localhost:36683/RecuperarContra.aspx");
            oMailMessage.IsBodyHtml = true;
            SmtpClient oSmtpClient = new SmtpClient("smtp.gmail.com");
            oSmtpClient.EnableSsl = true;
            oSmtpClient.UseDefaultCredentials = false;
            oSmtpClient.Port = 587;
            oSmtpClient.Credentials = new System.Net.NetworkCredential(EmailOrigen, contra);
            oSmtpClient.Send(oMailMessage);

            oMailMessage.Dispose();
        }
        public static string GenerarToken()
        {
            long i = 1;
            foreach (byte b in Guid.NewGuid().ToByteArray()) i *= ((int)b + 1);
            return EncripMD5(string.Format("{0:x}", i - DateTime.Now.Ticks));
        }
    }
}