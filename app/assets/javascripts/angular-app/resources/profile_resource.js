app.factory('Profile', ['$resource', function ($resource) {
    return $resource("/api/profile.json");
}]);