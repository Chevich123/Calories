app.factory('Signup', ['$resource', function ($resource) {
    return $resource("/api/signup.json");
}]);