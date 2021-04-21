<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PersonaPrincipal.aspx.cs" Inherits="UTTT.Ejemplo.Persona.PersonaPrincipal"  debug=false%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Persona</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl" crossorigin="anonymous">
</head>
<body style="font-family: 'Century Gothic';">
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager2" runat="server"></asp:ScriptManager>

        <div class="mb-3 container-fluid" style="font-size: medium; font-weight: bold" align="center">
            <h1>Persona</h1>
        </div>


        <div class="container">
            <div class="container" style="float: left; width: auto;">
                <asp:Label ID="Label3" runat="server" Text="Nombre"></asp:Label>
                <asp:UpdatePanel ID="PtxtName" runat="server">
                    <ContentTemplate>
                        <input type="submit" name="btnTrick" id="btnTrick" style="display: none;" />
                    </ContentTemplate>
                </asp:UpdatePanel>
                <asp:TextBox ID="txtnom" runat="server" CssClass="form-control" Width="253px" AutoPostBack="True" OnTextChanged="txtNombre_TextChanged"
                    ViewStateMode="Disabled"></asp:TextBox>
            </div>
            <br />
            <div class="container" style="float: left; width: auto;">
                <asp:Button ID="btnBuscar" runat="server" Text="Buscar persona" OnClick="btnBuscar_Click" ViewStateMode="Disabled" class="btn btn-info" />
                <asp:Button ID="btnAgregar" runat="server" Text="Agregar persona" OnClick="btnAgregar_Click" ViewStateMode="Disabled" class="btn btn-success" />
            </div>
            <br />
        </div>
        <br />
        <br />
        <div class="container">
            <asp:Label ID="Label2" runat="server" Text="Sexo:"></asp:Label>
            <asp:DropDownList ID="ddlSexo" runat="server" CssClass="form-control form-select" Height="35px" Width="253px" Style="margin-left: 0px"></asp:DropDownList>
        </div>
        <br />
        <div class="container">
            <asp:Label ID="Label4" runat="server" Text="Estado civil:"></asp:Label>
            <asp:DropDownList ID="ddlEstadoCivil" runat="server" CssClass="form-control form-select" Height="35px" Width="253px"></asp:DropDownList>
        </div>
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
                                <asp:GridView ID="dgvPersonas" runat="server" class="table table-bordered table-condensed"
                                    AllowPaging="True" AutoGenerateColumns="False" DataSourceID="DataSourcePersona"
                                    Width="1067px" CellPadding="4"
                                    OnRowCommand="dgvPersonas_RowCommand" BackColor="#CCCCCC"
                                    BorderColor="#999999" BorderStyle="Solid" BorderWidth="3px"
                                    ViewStateMode="Disabled" CellSpacing="2" ForeColor="Black">
                                    <Columns>
                                        <asp:BoundField DataField="strClaveUnica" HeaderText="Clave Unica"
                                            ReadOnly="True" SortExpression="strClaveUnica" />
                                        <asp:BoundField DataField="strNombre" HeaderText="Nombre" ReadOnly="True"
                                            SortExpression="strNombre" />
                                        <asp:BoundField DataField="strAPaterno" HeaderText="APaterno" ReadOnly="True"
                                            SortExpression="strAPaterno" />
                                        <asp:BoundField DataField="strAMaterno" HeaderText="AMaterno" ReadOnly="True"
                                            SortExpression="strAMaterno" />
                                        <asp:BoundField DataField="CatSexo" HeaderText="Sexo"
                                            SortExpression="CatSexo" />
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

                                        <asp:TemplateField HeaderText="Direccion">
                                            <ItemTemplate>
                                                <asp:ImageButton runat="server" ID="imgDireccion" CommandName="Direccion" CommandArgument='<%#Bind("id") %>' ImageUrl="~/Images/editrecord_16x16.png" />
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
        <div class="d-grid gap-2 d-md-block" align="left">
           <a href="Inicio.aspx" class="btn btn-danger" Width="400" Height="40">Regresar</a>

        </div>
        <asp:LinqDataSource ID="DataSourcePersona" runat="server"
            ContextTypeName="UTTT.Ejemplo.Linq.Data.Entity.DcGeneralDataContext"
            OnSelecting="DataSourcePersona_Selecting"
            Select="new (strNombre, strAPaterno, strAMaterno, CatSexo, strClaveUnica,id,dteFecha,strCorreoE,strCodigoP,strRFC)"
            TableName="Persona" EntityTypeName="">
        </asp:LinqDataSource>
    </form>
</body>
    <script type="text/javascript">
            var nombre = document.getElementById("txtnom").value;
            document.querySelector('#txtnom').addEventListener('keyup', function () {
                const btnTrick = document.querySelector('#btnTrick');
                btnTrick.click();
            });
        </script>
</html>
