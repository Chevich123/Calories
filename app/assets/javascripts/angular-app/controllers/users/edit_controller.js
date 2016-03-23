app.controller('UserEditController', ['$scope', '$location', '$routeParams', 'User', function ($scope, $location, $routeParams, User) {
    $scope.user = {};
    $scope.roles = [];

    $scope.getRoles = function () {
        $scope.roles = [
            {
                value: 'regular',
                label: 'Regular'
            }, {
                value: 'manager',
                label: 'Manager'
            }
        ];
        if ($scope.current_user.role == 'admin') {
            $scope.roles.push({
                value: 'admin',
                label: 'Admin'
            });
        }
    };

    $scope.load = function () {
        User.get({id: $routeParams.id}, function (data) {
            $scope.user = data;
        }, function () {
            $location.path('/users');
        });
    };

    $scope.update = function () {
        $scope.busy = true;

        User.update({
            id: $scope.user.id
        }, {
            user: $scope.user
        }, function (data) {
            $location.path('/users');
        }, function (response) {
            $scope.busy = false;
            $scope.errors = response.data.errors;
        });

    };

    $scope.load();
    $scope.getRoles();
}]);
