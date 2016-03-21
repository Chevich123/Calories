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
    };

    $scope.load = function () {
        initFilter();
        Record.query(function (data) {
            var array = data;
            array.forEach(function(record) {
                record.display_date = new Date(record.date)
            });
            $scope.records = array;
        });

    };

    $scope.load();
}]);
