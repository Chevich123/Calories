app.controller('UserAddController', ['$scope', '$location', '$routeParams', 'User', function ($scope, $location, $routeParams, User) {
    $scope.user = {'role': 'regular'};
    $scope.roles = [];

    $scope.getRoles = function () {
        $scope.roles = [
            {
                value: 'regular',
                label: 'Regular'
            }
        ];
        if ($scope.current_user.role == 'admin') {
            $scope.roles.push({
                value: 'manager',
                label: 'Manager'
            });
            $scope.roles.push({
                value: 'admin',
                label: 'Admin'
            });
        }
    };

    $scope.save = function () {
        $scope.busy = true;

        User.save({
            user: $scope.user
        }, function (data) {
            $location.path('/users');
        }, function (response) {
            $scope.busy = false;
            $scope.errors = response.data.errors;
        });

    };

    $scope.disabled = function() {
        return !$scope.add_user_form.$valid || $scope.busy;
    };

    $scope.getRoles();
}]);
