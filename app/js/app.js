var App = angular.module('App', [
  'ngRoute',

  'AppControllers'
]);
App.config(['$httpProvider', function($httpProvider) {
        $httpProvider.defaults.useXDomain = true;
        delete $httpProvider.defaults.headers.common['X-Requested-With'];
    }
]);
App.config(['$routeProvider',
  function($routeProvider) {
    $routeProvider.
      when('/index', {
        /*resolve:{
          "check":function($rootScope,$cookies){
            if($cookies.get('login')!='')
            {
              if($cookies.get('login')=='Admin'){
                  $rootScope.isAdmin=true;
              }
              if($cookies.get('isFrecuente')=='true'){
                $rootScope.isFrecuente=true;
              }
              $rootScope.isLogged=true;
            }
          }
        },*/
        templateUrl: 'app/Html/index.html',
        controller: 'IndexCtrl'
      }).
      when('/register', {
        templateUrl: 'app/Html/register.html',
        controller: 'RegisterCtrl'
      }).
      when('/login', {
        templateUrl: 'app/Html/login.html',
        controller: 'loginCtrl'
      }).
      when('/about', {
        templateUrl: 'app/Html/about.html',
        controller: 'aboutCtrl'
      }).
      when('/adminlogged', {
        templateUrl: 'app/Html/adminlogged.html',
        controller: 'adminloggedCtrl'
      }).
      when('/adminuser', {
        templateUrl: 'app/Html/adminUser.html',
        controller: 'adminuserCtrl'
      }).
      when('/adminingr', {
        templateUrl: 'app/Html/adminIngr.html',
        controller: 'adminingrCtrl'
      }).
      when('/adminfactura', {
        templateUrl: 'app/Html/adminfactura.html',
        controller: 'adminfacturaCtrl'
      }).
      when('/adminconsultas', {
        templateUrl: 'app/Html/adminconsultas.html',
        controller: 'adminconsultasCtrl'
      }).
      when('/logout', {
        templateUrl: 'app/Html/index.html',
        controller: 'logoutCtrl'
      }).
      /*when('/newLogin', {
        templateUrl: 'app/partials/newLogin.html',
        controller: 'newLoginCtrl'
      }).
      when('/books', {
        resolve:{
          "check":function($rootScope,$cookies){
            if($cookies.get('login')!='')
            {
              if($cookies.get('login')=='Admin'){
                  $rootScope.isAdmin=true;
              }
              if($cookies.get('isFrecuente')=='true'){
                $rootScope.isFrecuente=true;
              }
              $rootScope.isLogged=true;
            }
          }
        },
        templateUrl: 'app/partials/products.html',
        controller: 'booksCtrl'
      }).
      when('/music', {
        resolve:{
          "check":function($rootScope,$cookies){
            if($cookies.get('login')!='')
            {
              if($cookies.get('login')=='Admin'){
                  $rootScope.isAdmin=true;
              }
              if($cookies.get('isFrecuente')=='true'){
                $rootScope.isFrecuente=true;
              }
              $rootScope.isLogged=true;
            }
          }
        },
        templateUrl: 'app/partials/products.html',
        controller: 'musicCtrl'
      }).
      when('/comics', {
        resolve:{
          "check":function($rootScope,$cookies){
            if($cookies.get('login')!='')
            {
              if($cookies.get('login')=='Admin'){
                  $rootScope.isAdmin=true;
              }
              if($cookies.get('isFrecuente')=='true'){
                $rootScope.isFrecuente=true;
              }
              $rootScope.isLogged=true;
            }
          }
        },
        templateUrl: 'app/partials/products.html',
        controller: 'comicsCtrl'
      }).
      when('/severalArticles', {
        resolve:{
          "check":function($rootScope,$cookies){
            if($cookies.get('login')!='')
            {
              if($cookies.get('login')=='Admin'){
                  $rootScope.isAdmin=true;
              }
              if($cookies.get('isFrecuente')=='true'){
                $rootScope.isFrecuente=true;
              }
              $rootScope.isLogged=true;
            }
          }
        },
        templateUrl: 'app/partials/products.html',
        controller: 'severalArticlesCtrl'
      }).
      when('/movies', {
        resolve:{
          "check":function($rootScope,$cookies){
            if($cookies.get('login')!='')
            {
              if($cookies.get('login')=='Admin'){
                  $rootScope.isAdmin=true;
              }
              if($cookies.get('isFrecuente')=='true'){
                $rootScope.isFrecuente=true;
              }
              $rootScope.isLogged=true;
            }
          }
        },
        templateUrl: 'app/partials/products.html',
        controller: 'moviesCtrl'
      }).
      when('/productDetails/:products', {
        resolve:{
          "check":function($rootScope,$cookies){
            if($cookies.get('login')!='')
            {
              if($cookies.get('login')=='Admin'){
                  $rootScope.isAdmin=true;
              }
              if($cookies.get('isFrecuente')=='true'){
                $rootScope.isFrecuente=true;
              }
              $rootScope.isLogged=true;
            }
          }
        },
        templateUrl: 'app/partials/productDetails.html',
        controller: 'detailsCtrl'
      }).
      when('/shoppingCart', {
        resolve:{
          "check":function($location,$rootScope,$cookies){
            if($cookies.get('login')=='')
            {
              $location.path('/login');
            }
          }
        },
        templateUrl: 'app/partials/shoppingCart.html',
        controller: 'shoppingCartCtrl'
      }).
      when('/compra', {
        resolve: {
          "check":function($rootScope,$cookies){
            if($cookies.get('login')!='')
            {
              if($cookies.get('login')=='Admin'){
                  $rootScope.isAdmin=true;
              }
              if($cookies.get('isFrecuente')=='true'){
                $rootScope.isFrecuente=true;
              }
              $rootScope.isLogged=true;
            }
          }
        },

        templateUrl: 'app/partials/compra.html',
        controller: 'compraCtrl'
      }).
      when('/addProduct', {
        resolve:{
          "check":function($location,$rootScope,$cookies){
            if($cookies.get('login') !=''  ){
              if(!$rootScope.isAdmin){
                alert('Esta opcion solo esta disponible para administradores')
                $location.path('/login');
              }
            }
          }
        },
        templateUrl: 'app/partials/addProduct.html',
        controller: 'addProductCtrl'
      }).
      when('/editProduct/:products', {
        resolve:{
          "check":function($location,$rootScope,$cookies){
            if($cookies.get('login') !=''){
              if(!$rootScope.isAdmin){
                alert('Esta opcion solo esta disponible para administradores')
                $location.path('/login');
              }
            }
          }
        },
        templateUrl: 'app/partials/editProduct.html',
        controller: 'editProductCtrl'
      }).
      when('/specifyDiscount', {
        resolve:{
          "check":function($location,$rootScope,$cookies){
            if($cookies.get('login') !=''){
              if(!$rootScope.isAdmin){
                alert('Esta opcion solo esta disponible para administradores')
                $location.path('/login');
              }
            }
          }
        },
        templateUrl: 'app/partials/specifyDiscount.html',
        controller: 'specifyDiscountCtrl'
      }).*/
      otherwise({
        redirectTo: '/index'
      });
  }]);
