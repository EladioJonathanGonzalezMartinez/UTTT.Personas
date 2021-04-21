using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.SqlClient;

namespace UTTT.Ejemplo.Persona.Control.Ctrl
{
    public class Conexion
    {
        #region Variables
     
        #endregion

        #region Constructores
        public Conexion()
        {
        }
        #endregion


        public SqlConnection sqlConnection()
        {
            try
            {
                SqlConnection conexion = new SqlConnection("Data Source=PersonaUT.mssql.somee.com;Initial Catalog=PersonaUT;User ID=Jonary12_SQLLogin_1;Password=x6iderz6g8");
                return conexion;
            }
            catch (Exception _e)
            {

            }
            return null;
        }
    }
}
