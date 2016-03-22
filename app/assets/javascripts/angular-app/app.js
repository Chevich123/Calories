var app = angular.module('Calories', ['ngResource', 'ngRoute']);

var getTextToSecondsSinceMidnight = function (txt) {
    var dat = new Date('2016', 0, 1, 0, 0, 0, 0);
    var time = txt.split(/\:|\-/g);

    dat.setHours(time[0], time[1], 0, 0);

    var e = new Date(dat);
    return (dat - e.setHours(0, 0, 0, 0)) / 1000;
};

var getSecondsSinceMidnightToTxt = function (num) {
    var dat = new Date('2016', 0, 1, 0, 0, 0, 0);
    dat.setSeconds(num);

    return moment(dat).format('HH:mm');
};
