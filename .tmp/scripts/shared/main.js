(function() {
  'use strict';
  angular.module('app.controllers', []).controller('AppCtrl', [
    '$scope', '$location', function($scope, $location) {
      $scope.isSpecificPage = function() {
        var path;
        path = $location.path();
        return _.contains(['/404', '/pages/500', '/pages/login', '/pages/signin', '/pages/signin1', '/pages/signin2', '/pages/signup', '/pages/signup1', '/pages/signup2', '/pages/forgot', '/pages/lock-screen'], path);
      };
      return $scope.main = {
        brand: 'Sanofi-WebTool',
        name: 'Administrator'
      };
    }
  ]).controller('NavCtrl', [
    '$scope', 'taskStorage', 'filterFilter', '$location', '$log', function($scope, taskStorage, filterFilter, $location, $log) {
      var tasks;
      tasks = $scope.tasks = taskStorage.get();
      $scope.taskRemainingCount = filterFilter(tasks, {
        completed: false
      }).length;
      return $scope.$on('taskRemaining:changed', function(event, count) {
        return $scope.taskRemainingCount = count;
      });
    }
  ]).controller('DashboardCtrl', ['$scope', function($scope) {}]).controller('ActionCtrl', [
    '$scope', '$location', 'Session', function($scope, $location, Session) {
      $scope.logout = function() {
        Session.invalidateSession();
        return $location.path('/pages/signin');
      };
      return $scope.profile = function() {
        return $location.path('/pages/profile');
      };
    }
  ]);

}).call(this);
