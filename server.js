/*var sql = require("mssql");

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

getEmp();  SQL SERVER CONECTION */ 

var express         =       require("express");
var multer          =       require('multer');
var app             =       express();
var server          =   app.listen(3000);
var io              =       require('socket.io').listen(server);
var sql = require("mssql");
var dbConfig = {
  server: "XELOP-PC",
  database: "RESTAURANTES",
  user: "admin",
  password: "admin",
  port: 1433
};

// send mail with defined transport object

io.on("connection", function(socket) {
    socket.on('getRestaurantes', function(product){
    });
});

app.get('/getRestaurantes', function (req, res) {
   var conn = new sql.Connection(dbConfig);
        var req = new sql.Request(conn);
        conn.connect(function(err){
          if(err){
            console.log(err);
            return;
          }
          req.execute('getRestaurantes', function(err, recordset){
            if(err){
              console.log(err);
              return;
            }
            else{
              console.log(recordset[0]);
              res.end(JSON.stringify(recordset[0]));
            }  
            conn.close();
          });
        });   
})

/*app.use(multer({ dest: './app/img/Products',
    rename: function (fieldname, filename) {
        return filename;
    },
    onFileUploadStart: function (file) {
        console.log(file.originalname + ' is starting ...');
    },
    onFileUploadComplete: function (file) {
        console.log(file.fieldname + ' uploaded to  ' + file.path)
    }
}));*/

app.get('/',function(req,res){
      res.sendFile(__dirname + "/main.html");
});


app.use(express.static(__dirname));

/*app.post('/',function(req,res){
    upload(req,res,function(err) {
        if(err) {
            return res.end("Error uploading file.");
        }

    });
});*/
