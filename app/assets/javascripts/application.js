// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require twitter/bootstrap
//= require moment
//= require bootstrap-datetimepicker
//= require angular
//= require angular-route
//= require angular-resource
//= require angular-app/app
//= require_tree ./angular-app/controllers
//= require_tree ./angular-app/resources
//= require_tree ./angular-app/routes
//= require_tree .

var getSecondsSinceMidnight = function(d) {
    var e = new Date(d);
    return (d - e.setHours(0,0,0,0)) / 1000;
};
