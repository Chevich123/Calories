app.controller('RecordsIndexController', ['$scope', '$location', '$filter', 'Record', function ($scope, $location, $filter, Record) {
    $scope.records = [];
    $scope.filter = {};
    $scope.days_summary = {};

    var initFilter = function (convert) {
        if ($location.search().date_from) {
            $scope.filter.date_from = $location.search().date_from;
        }
        if ($location.search().date_to) {
            $scope.filter.date_to = $location.search().date_to;
        }
        if ($location.search().time_from) {
            $scope.filter.time_from = $location.search().time_from;
            if (convert) {
                $scope.filter.time_from = getSecondsSinceMidnightToTxt($scope.filter.time_from);
            }
        }
        if ($location.search().time_to) {
            $scope.filter.time_to = $location.search().time_to;
            if (convert) {
                $scope.filter.time_to = getSecondsSinceMidnightToTxt($scope.filter.time_to);
            }
        }
    };

    var calculateCalories = function () {
        $scope.days_summary = {};
        $scope.records.forEach(function (record) {
            var name = record.user_id + '_' + record.date;
            if (!$scope.days_summary[name]) {
                $scope.days_summary[name] = 0;
            }
            $scope.days_summary[name] += record.num_of_calories;
        });
        $scope.records.forEach(function (record) {
            record.overflow = $scope.days_summary[record.user_id + '_' + record.date] > record.user.num_of_calories;
        });
    };

    $scope.load = function () {
        initFilter(false);
        var new_filter = $scope.filter;

        if (new_filter.time_from) {
            new_filter.time_from = getTextToSecondsSinceMidnight($scope.filter.time_from)
        }
        if (new_filter.time_to) {
            new_filter.time_to = getTextToSecondsSinceMidnight($scope.filter.time_to)
        }

        Record.query(new_filter, function (data) {
            $scope.records = data;
            $scope.records.forEach(function (record) {
                record.time = getSecondsSinceMidnightToTxt(record.time);
            });
            calculateCalories();
        });
        initFilter(false);
    };

    $scope.filter_records = function () {
        $location.search({
            date_from: $scope.filter.date_from,
            date_to: $scope.filter.date_to,
            time_from: $scope.filter.time_from,
            time_to: $scope.filter.time_to
        });
    };

    $scope.load();
}]);
