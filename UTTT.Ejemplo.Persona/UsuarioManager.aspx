<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UsuarioManager.aspx.cs" Inherits="UTTT.Ejemplo.Persona.UsuarioManager" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Registro Usuario</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous">
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" rel="stylesheet" />
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
</head>
<body style="font-family: 'Century Gothic';">

    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager2" runat="server"></asp:ScriptManager>
        <div align="center">
            <div class="mb-3 container-fluid" style="font-size: medium; font-weight: bold">
                <h1>Usuario manager</h1>
            </div>
            <br />
        </div>
        <br />
        <div class="container float-sm-none position-relative">
            <div align='left'>

                <div class="mb-3">
                    <asp:Label ID="Label3" runat="server" Text="Usuario: "></asp:Label>
                    <asp:TextBox ID="txtuser" runat="server" Width="450px" CssClass="form-control" Style="margin-left: 0px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"  ErrorMessage="*El campo usuario es obligatorio" ControlToValidate="txtuser" ForeColor="Red"></asp:RequiredFieldValidator>
                </div>

                <div class="mb-3">
                    <asp:Label ID="Label4" runat="server" Text="Contraseña: "></asp:Label>
                    <asp:TextBox ID="txtcontra" runat="server" Width="450px" CssClass="form-control" Style="margin-left: 0px" type="password"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*El campo es obligatorio" ControlToValidate="txtcontra" ForeColor="Red"></asp:RequiredFieldValidator>
                </div>

                <div class="mb-3">
                    <asp:Label ID="Label5" runat="server" Text="Repetir Contraseña: "></asp:Label>
                    <asp:TextBox ID="txtrecontra" runat="server" Width="450px" CssClass="form-control" Style="margin-left: 0px" type="password"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="*El campo es obligatorio" ControlToValidate="txtrecontra" ForeColor="Red"></asp:RequiredFieldValidator>
                </div>

                <div class="mb-3">
                    <div>
                        <asp:Label ID="Label6" runat="server" Text="Fecha de Registro: "></asp:Label>
                        <br />
                        <asp:TextBox ID="txtDate" runat="server" Style="margin-left: 0px" Width="450px"></asp:TextBox>
                        <asp:ImageButton ID="imgPopup" ImageUrl="Images/calendar.png" ImageAlign="Bottom" runat="server" />
                        <br />
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ErrorMessage="Debe ingresar solo fechas" ControlToValidate="txtDate" ValidationExpression="^([0-2][0-9]|3[0-1])(\/|-)(0[1-9]|1[0-2])\2(\d{4})$"></asp:RegularExpressionValidator>
                        <ajaxToolkit:CalendarExtender ID="Calendar1" PopupButtonID="imgPopup" runat="server" TargetControlID="txtDate" Format="dd/MM/yyyy" />
                    </div>
                </div>
                <div class="mb-3">
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate> 
                    <asp:Label ID="Label1" runat="server" Text="Persona"></asp:Label>  
                    <asp:DropDownList ID="ddlPersona" runat="server" CssClass="form-control form-select"  Width="474px"  DataSourceID="LinqDataSource1" DataTextField="strNombre" DataValueField="id" OnSelectedIndexChanged="ddlPersona_SelectedIndexChanged" ></asp:DropDownList>
                       <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ControlToValidate="ddlPersona" ErrorMessage="Selecione una persona" InitialValue="-1"></asp:RequiredFieldValidator>
                        </ContentTemplate>
                       <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="ddlPersona" EventName="SelectedIndexChanged" />
                    </Triggers>
                    </asp:UpdatePanel>
                    <asp:LinqDataSource ID="LinqDataSource1" runat="server" ContextTypeName="UTTT.Ejemplo.Linq.Data.Entity.DcGeneralDataContext" EntityTypeName="" Select="new (id, strNombre)" TableName="Persona" OnSelecting="LinqDataSource1_Selecting"></asp:LinqDataSource>
                    <asp:AccessDataSource ID="AccessDataSource1" runat="server"></asp:AccessDataSource>
                   
                </div>
            </div>
        </div>
        <div class="d-grid gap-2 d-md-block" align="center">
            <asp:Button ID="btnAceptar" runat="server" Text="Aceptar" OnClick="btnAceptar_Click" CssClass="btn btn-success" Width="300" Height="40" />
           <a href="UsuarioPrincipal.aspx" class="btn btn-danger" Width="300" Height="40">Cancelar</a>
        </div>

        <div class="container">
            <h3>
                <asp:Label ID="lblmsj" runat="server" Font-Bold="True" Height="25px" Width="142px"></asp:Label>
            </h3>
        </div>
    </form>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js" integrity="sha384-b5kHyXgcpbZJO/tY9Ul7kGkf1S0CWuKcCD38l8YkeH8z8QjE0GmW1gYU5S9FOnJ0" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.6.0/dist/umd/popper.min.js" integrity="sha384-KsvD1yqQ1/1+IA7gi3P0tyJcT3vR+NdBTt13hSJ2lnve8agRGXTTyNaBYmCR/Nwi" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.min.js" integrity="sha384-nsg8ua9HAw1y0W1btsyWgBklPnCUAFLuTMS2G72MMONqmOymq585AcH49TLBQObG" crossorigin="anonymous"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
</body>
<script type="text/javascript">
    function VerificarCantidad(sender, args) {
        args.IsValid = (args.Value.length >= 3);
    }
</script>

</html>

