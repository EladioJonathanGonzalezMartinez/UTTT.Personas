<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Recuperar.aspx.cs" Inherits="UTTT.Ejemplo.Persona.Recuperar" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Recuperar</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">
    <link href="css/estilo.css" rel="stylesheet" />
</head>
<body style="font-family: 'Century Gothic';">
    <div style=" width: 400px;
    margin: 50px auto;
    background-color: #eceee7;
    border: 1px solid #000000;
    height: 400px;
    border-radius: 8px;
    padding: 0px 9px 0px 9px;">
    <form id="form1" runat="server">
        <br />
        <div align="center">
            <div class="mb-3 container-fluid" style="font-size: medium; font-weight: bold">
                <h1>Ingresa tu correo electronico</h1>
            </div>
            <br />
            <br />
            <div class="mb-3">
                    <asp:Label ID="Label4" runat="server" Text="Correo electronico"></asp:Label>
                    <asp:TextBox ID="txtCorre" runat="server" Width="370px" CssClass="form-control" type="email"></asp:TextBox>
                </div>
            <br />
            <br />
            <div>

                <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Solicitar" Width="196px" CssClass="btn btn-success"/>

            </div>
            </div>
    </form>
        </div>
</body>
</html>
