app.controller('RecordsEditController', ['$scope', '$location', '$routeParams', '$filter', 'Record', 'User', function ($scope, $location, $routeParams, $filter, Record, User) {
    $scope.record = {};
    $scope.busy = false;

    $scope.update = function () {
        $scope.busy = true;

        if ($scope.record.display_time) {
            $scope.record.time = getTextToSecondsSinceMidnight($scope.record.display_time);
        }

        Record.update({
            id: $scope.record.id
        }, {
            record: $scope.record
        }, function (data) {
            $location.path('/');
        }, function (response) {
            console.log('eeror');
            $scope.busy = false;
            $scope.errors = response.data.errors;
        });
    };

    $scope.loadRecord = function () {
        Record.get({id: $routeParams.id}, function (data) {
            $scope.record = data;
            $scope.record.display_time = getSecondsSinceMidnightToTxt($scope.record.time);
        }, function () {
            $location.path('/');
        });
    };

    $scope.disabled = function() {
        return !$scope.edit_record_form.$valid || $scope.busy;
    };

    $scope.loadRecord();
}]);
