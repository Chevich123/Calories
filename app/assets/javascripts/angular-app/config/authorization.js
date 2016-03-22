app.factory('MyAuthRequestInterceptor', [
      '$q', '$location', function ($q, $location) {
          return {
              request: function (config) {
                  config.headers['X-Auth-Secret'] = localStorage.getItem('authorization_token');
                  return config;
              },
              responseError: function (response) {
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
      '$httpProvider', function ($httpProvider) {
          return $httpProvider.interceptors.push('MyAuthRequestInterceptor');
      }
  ]);