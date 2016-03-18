app.controller('UsersIndexController', ['$scope', 'User', function ($scope, User) {
    $scope.users = [];

    $scope.load = function () {
        User.query(function(data){
            $scope.users = data;
        });

    };

    $scope.load();
}]);
