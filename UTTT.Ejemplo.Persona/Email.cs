using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using EASendMail;

namespace UTTT.Ejemplo.Persona
{
    public class Email
    {
        public string SendMail(string CorreoD, string asunto, string msjCorreo)
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
                mensaje = "Error al enviar correo: " + ex.Message;
            }
            return mensaje;
        }
    }
}