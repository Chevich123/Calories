app.controller('SessionNewController', [
    '$scope', '$location', 'Session', function($scope, $location, Session) {
        $scope.ready = true;
        $scope.session = {};

        return $scope.sign_in = function() {
            $scope.busy = true;

            return Session.save({
                session: $scope.session
            }, function(data) {
                localStorage.setItem('authorization_token', data.authorization_token);
                $scope.loadProfile();
                return $location.path('/');
            }, function(data) {
                $scope.auth_error = true;
                return $scope.busy = false;
            });
        };
    }
]);
