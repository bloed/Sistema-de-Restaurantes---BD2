var sql = require("mssql");

var dbConfig = {
  server: "XELOP-PC",
  database: "Sistemas de Restaurantes",
  user: "admin",
  password: "admin",
  port: 1433
};

function getEmp(){
  var conn = new sql.Connection(dbConfig);
  var req = new sql.Request(conn);

  conn.connect(function(err){
    if(err){
      console.log(err);
      return;
    }
    req.query("Select * from Ingredientes", function(err, recordset){
      if(err){
      console.log(err);
      return;
      }
      else{
        console.log(recordset);
      }
      conn.close();
    });
  });
}

getEmp();