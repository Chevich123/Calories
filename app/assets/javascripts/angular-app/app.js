var app = angular.module('Calories', ['ngResource', 'ngRoute'])
.factory('MyAuthRequestInterceptor', [
    '$q', '$location', function($q, $location) {
        return {
            request: function(config) {
                config.headers['X-Auth-Secret'] = localStorage.getItem('authorization_token');
                return config;
            },
            responseError: function(response) {
                if (response.status === 401) {
                    localStorage.removeItem('authorization_token');
                    localStorage.removeItem('current_user');
                    $location.path('/session/new');
                }
                return $q.reject(response);
            }
        };
    }
])
.config([
    '$httpProvider', function($httpProvider) {
        return $httpProvider.interceptors.push('MyAuthRequestInterceptor');
    }
]).filter('capitalize', function() {
    return function(input, scope) {
        return input ? input.substring(0,1).toUpperCase()+input.substring(1).toLowerCase() : "";
    }
}).filter('thousand_separator', function() {
    return function(input, scope) {
        return input.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    }
}).filter('only_date', function() {
    return function(input, scope) {
        if (!input){
            return input;
        }
        var date = new Date(input);
        return date.getFullYear() + '-' + ('0' + (date.getMonth() + 1)).slice(-2) + '-' + ('0' + date.getDate()).slice(-2);
    }
}).directive('datetimez', function() {
      return {
          restrict: 'A',
          require : 'ngModel',
          link: function(scope, element, attrs, ngModelCtrl) {
              element.datetimepicker({
                  format:'YYYY-MM-DD'
              }).on('dp.change', function(e) {
                  ngModelCtrl.$setViewValue(e.date.format('YYYY-MM-DD'));
                  scope.$apply();
              });
          }
      };
  });