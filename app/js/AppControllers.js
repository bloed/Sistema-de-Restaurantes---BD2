'use strict';

/* Controllers */
var App = angular.module('AppControllers', []);
App.controller('IndexCtrl', function ($scope, $http, $rootScope, $location, $route) {
  $scope.restaurantes;
  $scope.platillos = [];

  $rootScope.isAdmin = false;


  if($rootScope.isAdmin){
    $rootScope.isAdmin = false;
  }

  $http.get('http://localhost:3000/getRestaurantes').
        success(function(data) {
            $scope.restaurantes = data;
            for (var i = 0; i < $scope.restaurantes.length; i++) { 
              $http.get('http://localhost:3000/getPlatillosRest?rest='+$scope.restaurantes[i].nombre).
                success(function(dat) {
                  $scope.platillos.push(dat);
                  for (var i = 0; i < $scope.restaurantes.length; i++) {
                    if ($scope.restaurantes[i].nombre == dat.restaurante) {
                      $scope.restaurantes[i]["platillos"] = dat.platillos;
                    }
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
                $location.path('#/index');
              }
            else{
              failed = 1;
            }

    });

    $http.get("http://localhost:3000/loginAdmin?correo="+$scope.correo+"&pass="+$scope.pass).
    success(function(data){
            if(data=='user')
              {
                alert("Usuario ingresado");
                $rootScope.correoLogged = $scope.correo;
                $rootScope.admin = true;
                $location.path('#/index');
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

App.controller('aboutCtrl', function ($scope, $http, $location, $route) { //revisar si se debe modificar correo!!!!!!
    //FALTA cargar la informacion del usuario al inicio en los campos respectivos


  $scope.updateinfo=function(){
    $http.post("http://localhost:3000/updateinfo?nombre="+$scope.nombre+"&telefono="+$scope.telefono
      +"&contrasena="+$scope.contrasena+"&correo="+$scope.correo).
    success(function(data){
            if(data=='changed')
              {
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
    alert($scope.radioValue);
    $rootScope.rest = $scope.radioValue;
    $location.path('#/index');
  }
  $scope.radioValue = "";
})

App.controller('adminuserCtrl', function ($scope, $http, $location, $route) {
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

  $scope.modifyClient = function(){
    $http.post("http://localhost:3000/updateinfo?nombre="+$scope.nombre+"&telefono="+$scope.telefono
      +"&contrasena="+$scope.contrasena+"&correo="+$scope.correo).
    success(function(data){
            if(data=='changed')
              {
                alert("Se modifico el usuario con el correo: " + $scope.correo);
                $route.reload();
              }
            else{
              alert("sucedio un problema con su cambio");
            }

    });
  }

  $scope.consultClient = function(){
    //FALTA!! falta proc de conseguir informacion
    $http.post("http://localhost:3000/updateinfo?nombre="+$scope.nombre+"&telefono="+$scope.telefono
      +"&contrasena="+$scope.contrasena+"&correo="+$scope.correo).
    success(function(data){
            if(data=='changed')
              {
                alert("Se modifico el usuario con el correo: " + $scope.correo);
                //agregar formato a scope.info
              }
            else{
              alert("sucedio un problema con su cambio");
            }

    });
  }
  $scope.info = "";
})


App.controller('adminingrCtrl', function ($scope, $http, $location, $route) {
  $scope.categorias;
  $scope.ingredientes;

})

App.controller('adminfacturaCtrl', function ($scope, $http, $location, $route) {

})

App.controller('adminconsultasCtrl', function ($scope, $http, $location, $route) {

})

App.controller('logoutCtrl', function ($scope, $http, $location, $route) {

})