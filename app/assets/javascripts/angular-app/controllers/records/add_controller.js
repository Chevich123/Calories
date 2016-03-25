app.controller('RecordsAddController', ['$scope', '$location', '$routeParams', '$filter', 'Record', 'User', function ($scope, $location, $routeParams, $filter, Record, User) {
    $scope.record = {user_id: $scope.current_user.id};
    $scope.users = [];


    $scope.save = function () {
        $scope.busy = true;

        $scope.record.time = getTextToSecondsSinceMidnight($scope.record.display_time);

        Record.save({
            record: $scope.record
        }, function (data) {
            $location.path('/');
        }, function (response) {
            $scope.busy = false;
            $scope.errors = response.data.errors;
        });

    };

    $scope.loadUsers = function () {
        User.query(function (data) {
            $scope.users = data;
        });
    };

    $scope.disabled = function() {
        return !$scope.add_record_form.$valid || $scope.busy;
    };

    $scope.loadUsers();
}]);
