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
var io              =       require('socket.io').listen(server)

// send mail with defined transport object

io.on("connection", function(socket) {
    socket.on('email', function(msg, usr ){
        var mailOptions = {
            from: 'Mnemonic ✔ <mnemonicsalib@gmail.com>', // sender address
            to: usr, // list of receivers
            subject: 'Compra', // Subject line
            text: msg // plaintext body
        };
        transporter.sendMail(mailOptions, function(error, info){
            if(error){
                return console.log(error);
            }
            console.log('Message sent: ' + info.response);

        });
    });
    socket.on('varcompra', function(product){
        compra = compra + product +",";
        console.log(compra);    
    });
    socket.on('retcompra', function(){
        compra = compra;
        console.log(compra);
        io.to(socket.id).emit('compras', compra);  
    });
    socket.on('elimcompra', function(){
        compra = "";
        console.log(compra);  
    });
});

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

