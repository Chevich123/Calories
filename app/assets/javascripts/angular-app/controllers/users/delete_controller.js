app.controller('UserDeleteController', ['$scope', 'User', function ($scope, User) {
    $scope.delete = function () {
        if (confirm("Are you sure?")) {
            User.delete({id: $scope.user.id},
              function () {
                  $scope.$parent.load();
              })
        }
    };
}]);
