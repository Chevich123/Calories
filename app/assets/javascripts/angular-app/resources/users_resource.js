app.factory('User', ['$resource', function ($resource) {
    return $resource("/api/users/:id.json",
      null,
      {
          update: {method: 'PATCH'}
      }
    );
}]);