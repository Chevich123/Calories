app.controller('UserDeleteController', ['$scope', '$location', 'User', function ($scope, $location, User) {
    $scope.delete = function(){
        if (confirm("Are you sure?")){
            User.delete({id: $scope.user.id},
              function(){
                $scope.$parent.load();
            },
            function(data){
                console.log('error', data, $scope.delete_error, $scope.$parent.delete_error);
                $scope.$parent.set_delete_error();
            })
        }
    };
}]);
