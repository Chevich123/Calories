app.controller('ApplicationController', ['$scope','$location','Session','Profile', function ($scope, $location, Session, Profile) {
    $scope.current_user = localStorage.getItem('current_user');
    $scope.loadProfile = function () {
        return Profile.get(function (data) {
            $scope.token = localStorage.getItem('authorization_token');
            $scope.current_user = data;
            console.log('data', data);
            return localStorage.setItem('current_user', $scope.current_user);
        });
    };
    $scope.sign_out = function () {
        return Session["delete"](function () {
            $scope.current_user = null;
            localStorage.removeItem('authorization_token');
            localStorage.removeItem('current_user');
            return $location.path('/session/new');
        });
    };
    if (localStorage.getItem('authorization_token')) {
        $scope.loadProfile();
    }
    return $scope.nothing = function () {
    };
}]);
