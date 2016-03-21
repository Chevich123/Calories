app.controller('RecordsIndexController', ['$scope', '$location', 'Record', function ($scope, $location, Record) {
    $scope.records = [];
    $scope.filter = {};

    var initFilter = function () {
        if ($location.search().date_from) {
            $scope.filter.date_from = $location.search().date_from;
        }
        if ($location.search().date_to) {
            $scope.filter.date_to = $location.search().date_to;
        }
        if ($location.search().time_from) {
            $scope.filter.time_from = $location.search().time_from;
        }
        if ($location.search().time_to) {
            $scope.filter.time_to = $location.search().time_to;
        }
    };

    var calculateCalories = function(){

    };

    $scope.load = function () {
        initFilter();

        Record.query($scope.filter, function (data) {
            var array = data;
            array.forEach(function(record) {
                record.display_date = new Date(record.date)
            });
            $scope.records = array;
            calculateCalories();
        });

    };

    $scope.filter_records = function(){
        $location.search({date_from: $scope.filter.date_from, date_to: $scope.filter.date_to, time_from: $scope.filter.time_from, time_to: $scope.filter.time_to});
    };

    $scope.load();
}]);
