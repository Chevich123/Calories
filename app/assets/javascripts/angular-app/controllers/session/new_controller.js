app.controller('SessionNewController', ['$scope', '$location', 'Session', function ($scope, $location, Session) {
    $scope.ready = true;
    $scope.session = {};

    return $scope.log_in = function () {
        $scope.busy = true;

        Session.save({
            session: $scope.session
        }, function (data) {
            localStorage.setItem('authorization_token', data.authorization_token);
            $scope.loadProfile();
            $location.path('/');
        }, function (data) {
            $scope.auth_error = true;
            $scope.busy = false;
        });
    };
}]);
