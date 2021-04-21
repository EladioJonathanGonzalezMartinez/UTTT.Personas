<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Inicio.aspx.cs" Inherits="UTTT.Ejemplo.Persona.Inicio" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Inicio</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">
    <link href="css/estilo.css" rel="stylesheet" />
</head>
<body style="font-family: 'Century Gothic';">
    <form id="form1" runat="server">
        <br />
        <div class="mb-3 container-fluid" style="font-size: medium; font-weight: bold" align="center">
            <h1>Inicio</h1>
        </div>
        <div style="border-top: 1px solid green;
                height: 2px;
                padding: 0;
                margin: 20px auto 0 auto;"></div>
        <div align="center" style="font-size: small; font-weight: bold">
            <h4>Selecciona la imagen a donde desear ir:</h4>
        </div>
        <div align="center">
            <asp:ImageButton ID="ImageButton1" runat="server" Height="342px" ImageUrl="~/Images/personas.png" Width="334px" OnClick="ImageButton1_Click" />
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:ImageButton ID="ImageButton3" runat="server" Height="283px" ImageUrl="~/Images/usuario.png" Width="292px" OnClick="ImageButton3_Click" />
        </div>
        <div align="center" style="font-size: small; font-weight: bold">
            <h4>Persona principal&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Usuario principal</h4>
        </div>

        <div  align="center" style="font-size: small; font-weight: bold">
            
            <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Cerrar sesion" Width="139px" CssClass="btn btn-danger"/>
            
        </div>
        
        
    </form>
</body>
</html>
