app.directive('datez', function () {
    return {
        restrict: 'A',
        require: 'ngModel',
        link: function (scope, element, attrs, ngModelCtrl) {
            element.datetimepicker({
                format: 'YYYY-MM-DD'
            }).on('dp.change', function (e) {
                ngModelCtrl.$setViewValue(e.date.format('YYYY-MM-DD'));
                scope.$apply();
            });
        }
    };
}).directive('timez', function () {
    return {
        restrict: 'A',
        require: 'ngModel',
        link: function (scope, element, attrs, ngModelCtrl) {
            element.datetimepicker({
                timeZone: 'Etc/UTC',
                format: 'HH:mm'
            }).on('dp.change', function (e) {
                ngModelCtrl.$setViewValue(e.date.format('HH:mm'));
                scope.$apply();
            });
        }
    };
});