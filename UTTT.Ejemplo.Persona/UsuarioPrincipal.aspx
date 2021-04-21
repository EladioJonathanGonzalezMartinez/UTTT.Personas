<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UsuarioPrincipal.aspx.cs" Inherits="UTTT.Ejemplo.Persona.UsuarioPrincipal" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Usuario</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous">
</head>
<body style="font-family: 'Century Gothic';">
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager2" runat="server"></asp:ScriptManager>

        <div class="mb-3 container-fluid" style="font-size: medium; font-weight: bold" align="center">
            <h1>Usuarios</h1>
        </div>
        <div class="d-grid gap-2 d-md-block" align="left">
           <a href="Inicio.aspx" class="btn btn-danger" Width="400" Height="40">Regresar</a>

        </div>

        <div class="container">
            <div class="container" style="float: left; width: auto;">
                <asp:Label ID="Label3" runat="server" Text="Usuario"></asp:Label>
                <asp:UpdatePanel ID="PtxtName" runat="server">
                    <ContentTemplate>
                        <input type="submit" name="btnTrick" id="btnTrick" style="display: none;" />
                    </ContentTemplate>
                </asp:UpdatePanel>
                <asp:TextBox ID="txtusuario" runat="server" CssClass="form-control" Width="253px" AutoPostBack="True" ViewStateMode="Disabled"></asp:TextBox>
            </div>
            <br />  
        <div class="container" style="float: left; width: auto;">
                <asp:Button ID="btnBuscar" runat="server" Text="Buscar usuario" OnClick="btnBuscar_Click" ViewStateMode="Disabled" class="btn btn-info" />
                <asp:Button ID="btnAgregar" runat="server" Text="Agregar usuario" OnClick="btnAgregar_Click" ViewStateMode="Disabled" class="btn btn-success" />
            </div>

        </div>
        <br />
         <br />
        <div class="container">
            <asp:Label ID="Label2" runat="server" Text="Estado:"></asp:Label>
            <asp:DropDownList ID="ddlEstado" runat="server" CssClass="form-control form-select" Height="35px" Width="253px" Style="margin-left: 0px"></asp:DropDownList>
        </div>

        <br />
        <br />
        <div class="container" align="center" style="font-size: medium; font-weight: bold">
            <asp:Label ID="Label1" runat="server" Text="Detalles"></asp:Label>
        </div>

        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div class="table-responsive">
                        <asp:UpdatePanel runat="server">
                            <ContentTemplate>
                                <asp:GridView ID="dgvUsuario" runat="server" class="table table-bordered table-condensed"
                                    AllowPaging="True" AutoGenerateColumns="False" DataSourceID="DataSourceUsuario"
                                    Width="1067px" CellPadding="4"
                                    OnRowCommand="dgvPersonas_RowCommand" BackColor="#CCCCCC"
                                    BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px"
                                    ViewStateMode="Disabled" CellSpacing="2" ForeColor="Black">
                                    <Columns>
                                        <asp:BoundField DataField="id" HeaderText="Id"
                                            ReadOnly="True" SortExpression="id" />
                                        <asp:BoundField DataField="usuario1" HeaderText="Usuario" ReadOnly="True"
                                            SortExpression="usuario" />
                                        <asp:BoundField DataField="fecha" HeaderText="Fecha de ingreso" ReadOnly="True"
                                            SortExpression="fecha" />
                                        <asp:BoundField DataField="idEstado" HeaderText="Estado" ReadOnly="True"
                                            SortExpression="idEstado" />
                                        <asp:TemplateField HeaderText="Editar">
                                            <ItemTemplate>
                                                <asp:ImageButton runat="server" ID="imgEditar" CommandName="Editar" CommandArgument='<%#Bind("id") %>' ImageUrl="~/Images/editrecord_16x16.png" />
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle HorizontalAlign="Center" Width="50px" />

                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Eliminar" Visible="True">
                                            <ItemTemplate>
                                                <asp:ImageButton runat="server" ID="imgEliminar" CommandName="Eliminar" CommandArgument='<%#Bind("id") %>' ImageUrl="~/Images/delrecord_16x16.png" OnClientClick="javascript:return confirm('¿Está seguro de querer eliminar el registro seleccionado?', 'Mensaje de sistema')" />
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle HorizontalAlign="Center" Width="50px" />
                                        </asp:TemplateField>
                                    </Columns>
                                    <FooterStyle BackColor="#CCCCCC" />
                                    <HeaderStyle BackColor="#04a53c" Font-Bold="True" ForeColor="White" />
                                    <PagerStyle BackColor="#CCCCCC" ForeColor="Black" HorizontalAlign="Left" />
                                    <RowStyle BackColor="White" />
                                    <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                                    <SortedAscendingCellStyle BackColor="#F1F1F1" />
                                    <SortedAscendingHeaderStyle BackColor="#808080" />
                                    <SortedDescendingCellStyle BackColor="#CAC9C9" />
                                    <SortedDescendingHeaderStyle BackColor="#383838" />
                                </asp:GridView>
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="btnBuscar" EventName="Click" />
                            </Triggers>
                        </asp:UpdatePanel>


                    </div>
                </div>
            </div>
        </div>
        <asp:LinqDataSource ID="DataSourceUsuario" runat="server"
            ContextTypeName="UTTT.Ejemplo.Linq.Data.Entity.DcGeneralDataContext"
            OnSelecting="DataSourceUsuario_Selecting"
            Select="new (id,usuario1,passw,fecha,token,idEstado,idPersona)"
            TableName="Usuario" EntityTypeName="">
        </asp:LinqDataSource>
    </form>
</body>
</html>
