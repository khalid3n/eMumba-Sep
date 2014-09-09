(function() {
  'use strict';
  angular.module('app.controllers', []).controller('AppCtrl', [
    '$scope', '$location', 'Session', function($scope, $location, Session) {
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
    '$scope', 'taskStorage', 'filterFilter', '$location', '$log', 'Session', function($scope, taskStorage, filterFilter, $location, $log, Session) {
      var tasks;
      $log.info(Session.validSession());
      if (!Session.validSession()) {
        $location.path('/pages/signin');
      }
      tasks = $scope.tasks = taskStorage.get();
      $scope.taskRemainingCount = filterFilter(tasks, {
        completed: false
      }).length;
      return $scope.$on('taskRemaining:changed', function(event, count) {
        return $scope.taskRemainingCount = count;
      });
    }
  ]).controller('DashboardCtrl', ['$scope', function($scope) {}]);

}).call(this);
