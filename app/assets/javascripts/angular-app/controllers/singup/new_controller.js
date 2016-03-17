app.controller('SignupNewController', [
    '$scope', '$location', 'Signup', 'Session', function($scope, $location, Signup, Session) {
        $scope.ready = true;
        $scope.signup = {};

        return $scope.sign_up = function() {
            $scope.busy = true;

            return Signup.save({
                signup: $scope.signup
            }, function(data) {
                return Session.save({session: $scope.signup}, function(data){
                    localStorage.setItem('authorization_token', data.authorization_token);
                    $scope.loadProfile();
                    return $location.path('/');
                });
            }, function(response) {
                $scope.errors = response.data.errors;
                return $scope.busy = false;
            });
        };
    }
]);
