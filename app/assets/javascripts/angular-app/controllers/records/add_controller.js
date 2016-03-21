app.controller('RecordsAddController', ['$scope', '$location', '$routeParams', '$filter', 'Record', 'User', function ($scope, $location, $routeParams, $filter, Record, User) {
    $scope.record = {user_id: $scope.current_user.id, display_time: 1.01, display_date: new Date()};
    $scope.users = [];


    $scope.save = function () {
        $scope.busy = true;
        if ($scope.record.display_time) {
            $scope.record.time =  $scope.record.display_time * 3600;
        }

        if ($scope.record.display_date) {
            $scope.record.date =  $filter('date')($scope.record.display_date, 'yyyy-MM-dd');
        }

        Record.save({
            record: $scope.record
        }, function (data) {
            $location.path('/');
        }, function (response) {
            $scope.busy = false;
            $scope.errors = response.data.errors;
        });

    };

    $scope.loadUsers = function(){
        User.query(function(data){
            $scope.users = data;
        });
    };

    $scope.disabled = function () {
        return !$scope.add_record_form.$valid || $scope.busy;
    };

    $scope.loadUsers();
}]);
