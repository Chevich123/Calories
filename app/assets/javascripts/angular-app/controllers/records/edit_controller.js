app.controller('RecordsEditController', ['$scope', '$location', '$routeParams', '$filter', 'Record', 'User', function ($scope, $location, $routeParams, $filter, Record, User) {
    $scope.record = {};
    $scope.busy = false;

    $scope.update = function () {
        $scope.busy = true;

        if ($scope.record.display_time) {
            $scope.record.time =  $scope.record.display_time * 3600;
        }

        if ($scope.record.display_date) {
            $scope.record.date =  $filter('date')($scope.record.display_date, 'yyyy-MM-dd');
        }

        Record.update({
            id: $scope.record.id
        },{
            record: $scope.record
        }, function (data) {
            $location.path('/');
        }, function (response) {
            $scope.busy = false;
            $scope.errors = response.data.errors;
        });

    };

    $scope.loadRecord = function(){
        Record.get({id: $routeParams.id}, function (data) {
            $scope.record = data;
            $scope.record.display_date = new Date($scope.record.date);
            $scope.record.display_time = $scope.record.time / 3600;
        }, function(){
            $location.path('/');
        });
    };



    $scope.disabled123 = function () {
        return !$scope.edit_record_form.$valid || $scope.busy;
    };

    $scope.loadRecord();
}]);
