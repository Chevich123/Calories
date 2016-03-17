app.controller('UsersIndexController', ['$scope', 'User', function ($scope, User) {
    $scope.users = [];
    $scope.delete_error = false;

    $scope.load = function () {
        User.query(function(data){
            $scope.users = data;
            $scope.delete_error = false;
        });

    };

    $scope.set_delete_error = function () {
        console.log('FIRE');
        $scope.delete_error = true;
    };

    $scope.load();
}]);
