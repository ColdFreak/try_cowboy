angular.module("rpnApp", [])
  .controller("rpnCtrl", function($scope, $log, $http) {
    $scope.calcrpn = function() {
        var request =  { 
          method: "POST",
          url: "/process_rpn",
          transformRequest: function(obj) {
            var str = [];
            for(var p in obj)
              str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
            return str.join("&");
          },
          data: {rpnInput: $scope.formula}
        };
        $http(request)
        .success(function(data) {
            $scope.rpnResult = data;
            $log.info("rpnResult ="+ data);
        });
    }
  });
