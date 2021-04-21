<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PersonaManager.aspx.cs" Inherits="UTTT.Ejemplo.Persona.PersonaManager" debug=false%>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Registro</title>
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
                <h1>Persona manager</h1>
            </div>
            <br />
            <div class="container">
                <h3>
                    <asp:Label ID="lblAccion" runat="server" Text="Accion" Font-Bold="True" Height="25px" Width="142px"></asp:Label>
                </h3>
            </div>
        </div>
        <br />
        <div class="container float-sm-none position-relative">
            <div align='left'>
                <div class="mb-3">

                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <asp:Label ID="Label1" runat="server" Text="Sexo"></asp:Label>
                            <asp:DropDownList ID="ddlSexo" CssClass="form-control form-select" Width="450px" runat="server" Style="margin-left: 0px"></asp:DropDownList>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ControlToValidate="ddlSexo" ErrorMessage="Selecione un sexo" InitialValue="-1"></asp:RequiredFieldValidator>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="ddlSexo" EventName="SelectedIndexChanged" />
                        </Triggers>
                    </asp:UpdatePanel>
                </div>

                <div class="mb-3">
                    <asp:Label ID="Label2" runat="server" Text="Clave unica"></asp:Label>
                    <asp:TextBox ID="txtClaveUnica" runat="server" Width="450px" CssClass="form-control" type="number" Style="margin-left: 0px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="El campo clave unica es obligatorio" ControlToValidate="txtClaveUnica" ForeColor="Red"></asp:RequiredFieldValidator>
                    <asp:RangeValidator ID="RangeValidator1" runat="server" ControlToValidate="txtClaveUnica" ErrorMessage="Solo se pueden ingresar valores de 1 a 1000" MaximumValue="1000" MinimumValue="1" Type="Integer"></asp:RangeValidator>
                </div>

                <div class="mb-3">
                    <asp:Label ID="Label3" runat="server" Text="Nombre"></asp:Label>
                    <asp:TextBox ID="txtNombre" runat="server" Width="450px" CssClass="form-control" Style="margin-left: 0px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*El campo nombre es obligatorio" ControlToValidate="txtNombre" ForeColor="Red"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Debe ingresar solo letras." ControlToValidate="txtNombre" ValidationExpression="^[a-zA-ZÀ-ÿ\u00f1\u00d1]+(\s*[a-zA-ZÀ-ÿ\u00f1\u00d1]*)*[a-zA-ZÀ-ÿ\u00f1\u00d1]+$"></asp:RegularExpressionValidator>
                    <asp:CustomValidator ID="CustomValidator3" runat="server" ErrorMessage="Ingrese mas de 3 caracteres" ControlToValidate="txtNombre" ClientValidationFunction="VerificarCantidad"></asp:CustomValidator>
                </div>

                <div class="mb-3">
                    <asp:Label ID="Label4" runat="server" Text="Apellido paterno"></asp:Label>
                    <asp:TextBox ID="txtAPaterno" runat="server" Width="450px" CssClass="form-control" Style="margin-left: 0px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="*El campo Apellido paterno es obligatorio" ControlToValidate="txtAPaterno" ForeColor="Red"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ErrorMessage="Debe ingresar solo letras." ControlToValidate="txtAPaterno" ValidationExpression="^[a-zA-ZÀ-ÿ\u00f1\u00d1]+(\s*[a-zA-ZÀ-ÿ\u00f1\u00d1]*)*[a-zA-ZÀ-ÿ\u00f1\u00d1]+$"></asp:RegularExpressionValidator>
                    <asp:CustomValidator ID="CustomValidator2" runat="server" ErrorMessage="Ingrese mas de 3 caracteres" ControlToValidate="txtAPaterno" ClientValidationFunction="VerificarCantidad"></asp:CustomValidator>
                </div>

                <div class="mb-3">
                    <asp:Label ID="Label5" runat="server" Text="Apellido materno"></asp:Label>
                    <asp:TextBox ID="txtAMaterno" runat="server" Width="450px" CssClass="form-control" Style="margin-left: 0px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="*El campo Apellido materno es obligatorio" ControlToValidate="txtAMaterno" ForeColor="Red"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ErrorMessage="Debe ingresar solo letras borre o los espacios porfavor." ControlToValidate="txtAMaterno" ValidationExpression="^[a-zA-ZÀ-ÿ\u00f1\u00d1]+(\s*[a-zA-ZÀ-ÿ\u00f1\u00d1]*)*[a-zA-ZÀ-ÿ\u00f1\u00d1]+$"></asp:RegularExpressionValidator>
                    <asp:CustomValidator ID="CustomValidator1" runat="server" ErrorMessage="Ingrese mas de 3 caracteres" ControlToValidate="txtAMaterno" ClientValidationFunction="VerificarCantidad"></asp:CustomValidator>
                </div>

                <div class="mb-3">
                    <div>

                        <asp:Label ID="Label6" runat="server" Text="Fecha de nacimiento"></asp:Label>
                        <br />
                        <asp:TextBox ID="txtDate" runat="server" Style="margin-left: 0px" Width="450px"></asp:TextBox>
                        <asp:ImageButton ID="imgPopup" ImageUrl="Images/calendar.png" ImageAlign="Bottom" runat="server" />
                        <br />
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ErrorMessage="Debe ingresar solo fechas" ControlToValidate="txtDate" ValidationExpression="^([0-2][0-9]|3[0-1])(\/|-)(0[1-9]|1[0-2])\2(\d{4})$"></asp:RegularExpressionValidator>
                        <ajaxToolkit:CalendarExtender ID="Calendar1" PopupButtonID="imgPopup" runat="server" TargetControlID="txtDate" Format="dd/MM/yyyy" />
                    </div>
                </div>

                <div class="mb-3">
                    <asp:Label ID="Label7" runat="server" Text="Correo electronico"></asp:Label>
                    <asp:TextBox ID="txtCorreoE" runat="server" Width="450px" CssClass="form-control" Style="margin-left: 0px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="*El campo Correo electronico es obligatorio" ControlToValidate="txtCorreoE" ForeColor="Red"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator6" runat="server" ControlToValidate="txtCorreoE" ErrorMessage="Ingresa un Correo electronico valido" ValidationExpression="^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$"></asp:RegularExpressionValidator>
                </div>

                <div class="mb-3">
                    <asp:Label ID="Label8" runat="server" Text="Codigo postal"></asp:Label>
                    <asp:TextBox ID="txtCodP" runat="server" Width="450px" CssClass="form-control" Style="margin-left: 0px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="*El campo Codigo postal es obligatorio" ControlToValidate="txtCodP" ForeColor="Red"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator7" runat="server" ControlToValidate="txtCodP" ErrorMessage="Ingresa un codigo postal valido" ValidationExpression="^[0-9]{5}$"></asp:RegularExpressionValidator>
                </div>

                <div class="mb-3">
                    <asp:Label ID="Label9" runat="server" Text="RFC"></asp:Label>
                    <asp:TextBox ID="txtRFC" runat="server" Width="450px" CssClass="form-control" Style="margin-left: 0px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ErrorMessage="*El campo Rfc es obligatorio" ControlToValidate="txtRFC" ForeColor="Red"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator8" runat="server" ControlToValidate="txtRFC" ErrorMessage="Ingresa un RFC valido" ValidationExpression="^(([A-Z]|[a-z]|\s){1})(([A-Z]|[a-z]){3})([0-9]{6})((([A-Z]|[a-z]|[0-9]){3}))"></asp:RegularExpressionValidator>
                </div>
                <div class="mb-3">
                    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                        <ContentTemplate> 
                    <asp:Label ID="Label10" runat="server" Text="Estado civil"></asp:Label>  
                    <asp:DropDownList ID="ddlEstadoCivil" runat="server" CssClass="form-control form-select"  Width="474px" OnSelectedIndexChanged="ddlEstadoCivil_SelectedIndexChanged" ></asp:DropDownList>
                       </ContentTemplate>
                       <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="ddlSexo" EventName="SelectedIndexChanged" />
                    </Triggers>
                    </asp:UpdatePanel>
                     <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="ddlEstadoCivil" ErrorMessage="Selecione un estado civil" InitialValue="-1"></asp:RequiredFieldValidator>
                </div>
            </div>
        </div>
        <div class="d-grid gap-2 d-md-block" align="center">
            <asp:Button ID="btnAceptar" runat="server" Text="Aceptar" OnClick="btnAceptar_Click" CssClass="btn btn-success" Width="300" Height="40" />
           <a href="PersonaPrincipal.aspx" class="btn btn-danger" Width="300" Height="40">Cancelar</a>
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
