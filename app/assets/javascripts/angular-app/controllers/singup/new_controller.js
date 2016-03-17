app.controller('SignupNewController', ['$scope', '$location', 'Signup', 'Session', function ($scope, $location, Signup, Session) {
    $scope.ready = true;
    $scope.signup = {};

    return $scope.sign_up = function () {
        $scope.busy = true;

        Signup.save({
            signup: $scope.signup
        }, function (data) {
            Session.save({session: $scope.signup}, function (data) {
                localStorage.setItem('authorization_token', data.authorization_token);
                $scope.loadProfile();
                $location.path('/');
            });
        }, function (response) {
            $scope.errors = response.data.errors;
            $scope.busy = false;
        });
    };
}]);
