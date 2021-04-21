<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ErroresPagina.aspx.cs" Inherits="UTTT.Ejemplo.Persona.ErrorPagina" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div style=" width:100%; text-align:center; ">
            <div>
                <asp:Label ID="Label2" runat="server" Text="Escribe tus dudas"></asp:Label>
            <br />
                <asp:TextBox ID="txtmsj" runat="server" Visible="True" Height="70px" Width="291px" ></asp:TextBox>
            <br />
            </div>
            <br />
            <div>
                <asp:Label ID="Label3" runat="server" Text="Asunto"></asp:Label>
            <br />
                <asp:TextBox ID="txtAsunto" runat="server" Visible="True" Width="206px"></asp:TextBox>
            <br />
            <br />
            </div>
            <div>
                <asp:Label ID="Label4" runat="server" Text="Correo electronico"></asp:Label>
                <br />
                <asp:TextBox ID="txtEmail" runat="server" type="email" placeholder="Correo destinatario" Visible="True" Width="288px"></asp:TextBox>
            <br />
            <br />
                <asp:Label ID="Label1" runat="server" Text="Error insesperado" BackColor="Red"></asp:Label>
            <br />
            <br />
            </div>
                <asp:Button ID="Button1" runat="server" Text="Enviar correo" OnClick="Button1_Click" Visible="True"/>
            <br />
            <br />
            <h2> Contacto por correo electronico: eladio.jonathan.gonzalez.martinez@gmail.com</h2>
            <h3> Contacto por Facebook: Jonathan Martinez</h3

        </div>
    </form>
</body>
</html>