'use strict';

/* Controllers */
var App = angular.module('AppControllers', []);
App.controller('IndexCtrl', function ($scope, $http, $rootScope, $location, $route) {
  $scope.restaurantes;
  $scope.platillos = [];

  if($rootScope.isAdmin){
  }else{
    $rootScope.isAdmin = false;
  }

  $http.get('http://localhost:3000/getRestaurantes').
        success(function(data) {
            $scope.restaurantes = data;
            for (var i = 0; i < $scope.restaurantes.length; i++) { 
              $http.get('http://localhost:3000/getPlatillosRest?rest='+$scope.restaurantes[i].nombre).
                success(function(dat) {
                  var platillos = dat.platillos;
                  for (var i = 0; i < $scope.restaurantes.length; i++) {
                    if ($scope.restaurantes[i].nombre == dat.restaurante) {
                      $scope.restaurantes[i]["platillos"] = dat.platillos;
                    }
                  }
                  for(var i = 0; i< platillos.length; i++){
                    $http.get('http://localhost:3000/getingrplatillos?plat='+platillos[i].nombre).
                    success(function(dat2){
                      var ingredientes = dat2;
                      for(var i = 0; i< $scope.restaurantes.length; i++){
                        if($scope.restaurantes[i]["platillos"]){
                        for(var j = 0; j < $scope.restaurantes[i]["platillos"].length; j++){
                          
                          if($scope.restaurantes[i]["platillos"][j].nombre == dat2.platillo){
                            $scope.restaurantes[i]["platillos"][j]["ingredientes"] = dat2.ingredientes;
                       
                          }
                        }
                      }
                      }
                    });
                  }
              });
            }
        });
});

App.controller('RegisterCtrl', function ($scope, $http, $location, $rootScope) {
  $scope.register=function(){
    $http.post("http://localhost:3000/newregister?nombre="+$scope.nombre+"&telefono="+$scope.telefono
      +"&correo="+$scope.correo+"&contrasena="+$scope.contrasena).
    success(function(data){
            if(data=='logged')
              {
                alert("Usuario registrado");
                $rootScope.correoLogged = $scope.correo;
                $rootScope.admin = false;
                $rootScope.islogin = true;
                $location.path('#/index');
              }

    });
  }
});

App.controller('loginCtrl', function ($scope, $http, $location, $rootScope) {
  var failed = 0;
  $scope.register=function(){
    $http.get("http://localhost:3000/loginCliente?correo="+$scope.correo+"&pass="+$scope.pass).
    success(function(data){
            if(data=='logged')
              {
                alert("Usuario ingresado");
                $rootScope.correoLogged = $scope.correo;
                $rootScope.admin = false;
                $rootScope.islogin = true;
                $location.path('#/index');
              }
            else{
              failed = 1;
            }

    });

    $http.get("http://localhost:3000/loginAdmin?correo="+$scope.correo+"&pass="+$scope.pass).
    success(function(data){
            if(data=='logged')
              {
                alert("Admin ingresado");
                $rootScope.correoLogged = $scope.correo;
                $rootScope.isAdmin = true;
                $rootScope.islogin = true;
                $location.path('/adminlogged');
              }
            else{
              if(failed == 1){
                alert("Datos incorrectos");
              }
              failed = 0;
            }

    });
  }


});

App.controller('aboutCtrl', function ($scope, $http, $location, $route, $rootScope) { //revisar si se debe modificar correo!!!!!!
    //FALTA cargar la informacion del usuario al inicio en los campos respectivos
   $http.get("http://localhost:3000/clienteinfo?correo="+$rootScope.correoLogged).
    success(function(data){
           var info = data[0];
           $scope.nombre = info.nombre;
           $scope.telefono = info.numeroTelefonico;
           $scope.contrasena = info.password;
           $scope.correo = $rootScope.correoLogged;
    });

  $scope.updateinfo=function(){
    $http.post("http://localhost:3000/updateinfo?nombre="+$scope.nombre+"&telefono="+$scope.telefono
      +"&contrasena="+$scope.contrasena+"&correo="+$rootScope.correoLogged).
    success(function(data){
            if(data=='changed')
              {
                alert("Informacion modificada");
                $route.reload();
              }
            else{
              alert("sucedio un problema con su cambio");
            }

    });

  }
})
App.controller('adminloggedCtrl', function ($scope, $http, $location, $route, $rootScope) {
  $http.get('http://localhost:3000/getRestaurantes').
        success(function(data) {
            $scope.restaurantes = data;
          });
  $scope.setRes= function(){
    $rootScope.rest = $scope.radioValue;
    alert($scope.radioValue);
    for(var i = 0 ; i< $scope.restaurantes.length ; i++){
      if($scope.restaurantes[i].nombre == $scope.radioValue){
        $rootScope.restCat = $scope.restaurantes[i].categoria;

      }
    }
    $location.path('#/index');
  }
  $scope.radioValue = "";
})

App.controller('adminuserCtrl', function ($scope, $http, $location, $route) {
   $scope.nombreC = "";
   $scope.telefonoC = "";
   $scope.contrasenaC = "";
   $scope.correoC = "";

  $scope.addUser=function(){
    $http.post("http://localhost:3000/newregister?nombre="+$scope.nombre+"&telefono="+$scope.telefono
      +"&correo="+$scope.correo+"&contrasena="+$scope.contrasena).
    success(function(data){
            if(data=='logged')
              {
                alert("Nuevo Usuario registrado");
                $route.reload();
              }

    });
  }

  $scope.updateinfo=function(){
    alert($scope.telefonoC);
    $http.post("http://localhost:3000/updateinfo?nombre="+$scope.nombreC+"&telefono="+$scope.telefonoC
      +"&contrasena="+$scope.contrasenaC+"&correo="+$scope.correoC).
    success(function(data){
            if(data=='changed')
              {
                alert("Informacion modificada");
                $route.reload();
              }
            else{
              alert("sucedio un problema con su cambio");
            }

    });

  }

  $scope.consultClient = function(){
    $http.get("http://localhost:3000/clienteinfo?correo="+$scope.correoCon).
    success(function(data){
           var info = data[0];
           var str = "Nombre: "+info.nombre + " Telefono: " + info.numeroTelefonico +
           " Contraseña: " + info.password;
           $scope.info = str;
    });
  }
  $scope.info = "";
})


App.controller('adminingrCtrl', function ($scope, $http, $location, $route) {
  $scope.categorias;
  $scope.ingredientes;

  $scope.addIngr = function(){
    $http.get("http://localhost:3000/newingr?nombre=" + $scope.nombre +"&precio="+$scope.precio+
    "&categoria="+$scope.categoria+"&imagen="+$scope.image).
    success(function(data){
           if(data =="added"){
            alert("Producto agregado");
           }else{
            alert("error");
           }
    });
  }

  $scope.modifyIngr = function(){
    $http.get("http://localhost:3000/newingr?nombre=" + $scope.nombre +"&precio="+$scope.precio+
    "&categoria="+$scope.categoria+"&imagen="+$scope.image).
    success(function(data){
           if(data =="added"){
            alert("Producto agregado");
           }else{
            alert("error");
           }
    });
  }

})

App.controller('adminfacturaCtrl', function ($scope, $http, $location, $route, $rootScope) {
  $http.get('http://localhost:3000/getPlatillosRest?rest='+$rootScope.rest).
                success(function(dat) {


      $scope.platillos = dat.platillos;  
  });

  $scope.toggleSelection = function(dishname) {
    var idx = $scope.selection.indexOf(dishname);

    // is currently selected
    if (idx > -1) {
      $scope.selection.splice(idx, 1);
    }

    // is newly selected
    else {
      $scope.selection.push(dishname);
    }
  };

  $scope.payment = function(){

    var platillos = "";

    for(var i = 0; i < $scope.selection.length; i++){
      platillos += $scope.selection[i] +",";
    }
    alert(platillos);
    alert($scope.correo);
    alert($scope.radioValue);
    alert($rootScope.rest);

    $http.post("http://localhost:3000/payment?correo="+$scope.correo+"&formaPago="+$scope.radioValue
      +"&listaPlatillos="+platillos+"&restaurante="+$rootScope.rest).
    success(function(data){
            if(data=='done')
              {
                alert("Compra realizada");
                $route.reload();
              }
            else{
              alert("sucedio un problema con su cambio");
            }

    });
  }

  $scope.selection = [];

})

App.controller('adminconsultasCtrl', function ($scope, $http, $location, $route, $rootScope) {
   $http.get('http://localhost:3000/categoriasRestaurante').
                success(function(dat) {


      $scope.categorias = dat;  
  });

  $scope.rest2 = "";
  $scope.fechainit1 = "";
  $scope.fechafin1 = "";
  $scope.info1= [];
  $scope.info2= [];
  $scope.info3= [];


  $scope.consulta1=function(){
     $http.get('http://localhost:3000/getGanancias?fecha='+$scope.fecha1+'&nombre='+$scope.nombre1).
                success(function(dat) {
      $scope.info1 = dat;  
  });
  }
  $scope.consulta2 = function(){
     $http.post('http://localhost:3000/newdish?nombre='+$rootScope.restCat).
                success(function(dat) {
       if(dat=='done')
              {
                alert("Nevos platillos");
                $location.path('#/index');
              }
            else{
              alert("sucedio un problema con su cambio");
            }  
  });

  }
  $scope.consulta3 = function(){
    $http.post('http://localhost:3000/newrest?nombre='+$scope.nombreR+"&hora="+$scope.horaR
     + "&numero=" + $scope.numeroR+"&direccion=" + $scope.dirR +"&categoria=" + $scope.radioValue).
                success(function(dat) {
       if(dat=='done')
              {
                alert("Nevos restaurante");
                $location.path('#/index');
              }
            else{
              alert("sucedio un problema con su cambio");
            }  
  });
  }
  $scope.consulta4 = function(){
    $http.get('http://localhost:3000/getventasingr?rest='+$scope.rest2+'&ingr='+$scope.ingrediente+'&fechai='+$scope.fechainit1+'&fechaf='+$scope.fechafin1).
                success(function(dat) {
      $scope.info2 = dat;  
  });
  }
  $scope.consulta5 = function(){
    $http.get('http://localhost:3000/getcomparacion?fechai='+$scope.fechainit2+'&fechaf='+$scope.fechafin2).
                success(function(dat) {
      $scope.info3 = dat;  
  });
  }
})

App.controller('logoutCtrl', function ($scope, $http, $location, $route, $rootScope) {
  $rootScope.correoLogged = "";
  $rootScope.isAdmin = false;
  $rootScope.islogin = false;
})
