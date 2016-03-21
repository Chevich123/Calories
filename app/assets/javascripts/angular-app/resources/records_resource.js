app.factory('Record', ['$resource', function ($resource) {
    return $resource(
      "/api/records/:id.json",
      null,
      {
          update: {method: 'PATCH'}
      }
    );
}]);