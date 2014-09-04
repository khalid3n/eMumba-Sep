'use strict';

angular.module('app.controllers', [])

# overall control
.controller('AppCtrl', [
    '$scope', '$location'
    ($scope, $location) ->
        $scope.isSpecificPage = ->
            path = $location.path()
            return _.contains( [
                '/404'
                '/pages/500'
                '/pages/login'
                '/pages/signin'
                '/pages/signin1'
                '/pages/signin2'
                '/pages/signup'
                '/pages/signup1'
                '/pages/signup2'
                '/pages/forgot'
                '/pages/lock-screen'
            ], path )

        $scope.main =
            brand: 'Sanofi-WebTool'
            name: 'Administrator' # those which uses i18n can not be replaced for now.

])

.controller('NavCtrl', [
    '$scope', 'taskStorage', 'filterFilter'
    ($scope, taskStorage, filterFilter) ->
        # init
        tasks = $scope.tasks = taskStorage.get()
        $scope.taskRemainingCount = filterFilter(tasks, {completed: false}).length

        $scope.$on('taskRemaining:changed', (event, count) ->
            $scope.taskRemainingCount = count
        )
])

.controller('DashboardCtrl', [
    '$scope'
    ($scope) ->

])
