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
var bodyParser     =         require("body-parser");
var server          =   app.listen(3000);
var io              =       require('socket.io').listen(server);
app.use(bodyParser.urlencoded({ extended: false }));


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

///Obtener restaurantes

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

///Obtener platillos

app.get('/getPlatillosRest', function (req, res) {
        var conn = new sql.Connection(dbConfig);
        var request = new sql.Request(conn);
        var restname = req.param('rest');
        conn.connect(function(err){
          if(err){
            console.log(err);
            return;
          }
          request.input('restaurante', sql.VarChar(25), restname);
          request.execute('getPlatillosRestaurante', function(err, recordset){
            if(err){
              console.log(err);
              return;
            }
            else{
              var obj = {restaurante: restname, platillos:[]};
              obj.platillos = recordset[0];
              res.end(JSON.stringify(obj));
              console.log(obj);
            }  
            conn.close();
          });
        });        
})

///Registrar usuario

app.post('/newregister',function(req,res){
        var conn = new sql.Connection(dbConfig);
        var request = new sql.Request(conn);
        var name=req.param('nombre');
        var phone=req.param('telefono');
        var email=req.param('correo');
        var pass=req.param('contrasena');
        conn.connect(function(err){
          if(err){
            console.log(err);
            return;
          }
          request.input('correoElectronico', sql.VarChar(100), email);
          request.input('nombre', sql.VarChar(50), name);
          request.input('numeroTel', sql.Int, phone);
          request.input('cedula', sql.Int, 2); //por el momento siempre iserta dos
          request.input('password', sql.VarChar(25), pass);
          request.execute('createCliente', function(err, recordset){
            if(err){
              console.log(err);
              return;
            }
            else{
              console.log("Usuario registrado");
              res.end("logged");
            }  
            conn.close();
          });
        });        

})

//Login de un cliente

app.get('/loginCliente',function(req,res){
        var conn = new sql.Connection(dbConfig);
        var request = new sql.Request(conn);
        var email=req.param('correo');
        var pass=req.param('pass');
        conn.connect(function(err){
          if(err){
            console.log(err);
            return;
          }
          request.input('correo', sql.VarChar(100), email);
          //request.input('password', sql.VarChar(25), pass);
          request.execute('findCliente', function(err, recordset, returnValue){ //modificar proc de cliente
      
            if(err){
              console.log(err);
              return;
            }
            else{
              console.log(returnValue);
              if(returnValue == 1){
                console.log("Cliente ingresado");
                res.end("logged");
              }else{
                res.end("notcliente");
              }
            }  
          });
        });        
})

//Login de un admin

app.get('/loginAdmin',function(req,res){
        var conn = new sql.Connection(dbConfig);
        var request = new sql.Request(conn);
        var email=req.param('correo');
        var pass=req.param('pass');
        conn.connect(function(err){
          if(err){
            console.log(err);
            return;
          }
          request.input('correo', sql.VarChar(100), email); ///creo que seria nombre
          request.input('password', sql.VarChar(25), pass);
          request.execute('findAdmin', function(err, recordset, returnValue){ //modificar proc de admin y nombre aca
            
            if(err){
              console.log(err);
              return;
            }
            else{
              if(returnValue == 1){
                console.log("Admin ingresado");
                res.end("logged");
              }else{
                res.end("notAdmin");
              }
            }  
          });
        });        

})

//getinfo cliente FALTA!!!!

app.get('/clienteinfo',function(req,res){
        var conn = new sql.Connection(dbConfig);
        var request = new sql.Request(conn);
        var email = req.param('correo');
        console.log(tel);
        console.log(pass);
        conn.connect(function(err){
          if(err){
            console.log(err);
            return;
          }
          request.input('correoElectronico', sql.VarChar(100), email);
          request.execute('updateCliente', function(err, recordset, returnValue){ //cambiar el nombre del proc
            if(err){
              console.log(err);
              return;
            }
            else{
              console.log(recordset[0]);
              res.end(JSON.stringify(recordset[0]));
              }  
          });
        });        

})

//update de informacion

app.post('/updateinfo',function(req,res){
        var conn = new sql.Connection(dbConfig);
        var request = new sql.Request(conn);
        var nameP= req.param('nombre');
        var telP = req.param('telefono')
        var passP=req.param('contrasena');
        var email = req.param('correo');

        var name = (nameP != "") ? nameP : null;
        var tel = (telP != "") ? telP : null;
        var pass = (passP != "") ? passP : null;

        console.log(tel);
        console.log(pass);
        conn.connect(function(err){
          if(err){
            console.log(err);
            return;
          }
          request.input('correoElectronico', sql.VarChar(100), email);
          request.input('nombre', sql.VarChar(25), name);
          request.input('password', sql.VarChar(25), pass);
          request.input('numeroTel', sql.Int, tel);
          request.execute('updateCliente', function(err, recordset, returnValue){
            if(err){
              console.log(err);
              return;
            }
            else{
              console.log(returnValue);
              if(returnValue == 0){
                res.end("changed");
              }
            }  
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
