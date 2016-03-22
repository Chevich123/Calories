app.controller('RecordsIndexController', ['$scope', '$location', '$filter', 'Record', function ($scope, $location, $filter, Record) {
    $scope.records = [];
    $scope.filter = {};
    $scope.days_summary = {};

    var initFilter = function (convert) {
        if ($location.search().date_from) {
            $scope.filter.date_from = new Date($location.search().date_from);
        }
        if ($location.search().date_to) {
            $scope.filter.date_to = new Date($location.search().date_to);
        }
        if ($location.search().time_from) {
            $scope.filter.time_from = parseFloat($location.search().time_from);
            if (convert){
                $scope.filter.time_from = $scope.filter.time_from / 3600;
            }
        }
        if ($location.search().time_to) {
            $scope.filter.time_to = parseFloat($location.search().time_to);
            if (convert){
                $scope.filter.time_to = $scope.filter.time_to / 3600;
            }
        }
    };

    var calculateCalories = function(){
        $scope.days_summary = {};
        $scope.records.forEach(function(record){
            var name = record.user_id + '_' + record.date;
            if (!$scope.days_summary[name]){
                $scope.days_summary[name] = 0;
            }
            $scope.days_summary[name] += record.num_of_calories;
        });
        $scope.records.forEach(function(record){
            record.overflow = $scope.days_summary[record.user_id + '_' + record.date] > record.user.num_of_calories;
        });
    };

    $scope.load = function () {
        initFilter(false);
        var new_filter = $scope.filter;

        if (new_filter.time_from){new_filter.time_from = parseFloat($scope.filter.time_from) * 3600;}
        if (new_filter.time_to){new_filter.time_to = parseFloat($scope.filter.time_to) * 3600;}
        if (new_filter.date_from){ new_filter.date_from = $filter('only_date')(new_filter.date_from)}
        if (new_filter.date_to){ new_filter.date_to = $filter('only_date')(new_filter.date_to)}

        Record.query(new_filter, function (data) {
            var array = data;
            array.forEach(function(record) {
                record.display_date = new Date(record.date)
            });
            $scope.records = array;
            calculateCalories();
        });
        initFilter(false);
    };

    $scope.filter_records = function(){
        $location.search({date_from: $filter('only_date')($scope.filter.date_from), date_to: $filter('only_date')($scope.filter.date_to),   time_from: $scope.filter.time_from, time_to: $scope.filter.time_to});
    };

    $scope.load();
}]);
