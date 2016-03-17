app.controller('ProfileEditController', ['$scope', '$location', 'Profile', function ($scope, $location, Profile) {
    $scope.profile = {};

    $scope.load = function () {
        Profile.update(function (data) {
            $scope.profile = data;
        });
    };

    $scope.update = function () {
        $scope.busy = true;

        Profile.update({
            profile: $scope.profile
        }, function (data) {
            $scope.profile = data;
            $scope.$parent.current_user = data;
            $location.path('/');
        }, function (response) {
            $scope.busy = false;
            $scope.errors = response.data.errors;
        });

    };

    $scope.disabled = function () {
        return !$scope.edit_profile_form.$valid || $scope.busy;
    };
    $scope.load();
}]);
