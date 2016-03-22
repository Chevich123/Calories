app.controller('RecordsDeleteController', ['$scope', 'Record', function ($scope, Record) {
    $scope.delete = function () {
        if (confirm("Are you sure?")) {
            Record.delete({id: $scope.record.id},
              function () {
                  $scope.$parent.load();
              })
        }
    };
}]);
