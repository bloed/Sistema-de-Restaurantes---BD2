'use strict';

/* Controllers */
var App = angular.module('AppControllers', []);
App.controller('IndexCtrl', function ($scope, $http, $rootScope, $location, $route) {
  $scope.restaurantes;

  $http.get('http://localhost:3000/getRestaurantes').
        success(function(data) {
            $scope.restaurantes = data;
        });

});