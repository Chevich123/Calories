app.filter('thousand_separator', function() {
    return function(input, scope) {
        return input.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    }
});