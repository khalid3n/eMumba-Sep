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
                '/pages/setup-pass'
            ], path )

        $scope.main =
            brand: 'Sanofi'
            name: 'Administrator' # those which uses i18n can not be replaced for now.            
])

.controller('NavCtrl', [
    '$scope', 'taskStorage', 'filterFilter','$location', '$log'
    ($scope, taskStorage, filterFilter, $location, $log) ->
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

.controller('ActionCtrl', [
    '$scope', '$location', 'Session'
    ($scope, $location, Session) ->
        $scope.logout = ->
            Session.invalidateSession()
            $location.path('/pages/signin')
        $scope.profile = ->   
            $location.path('/pages/profile')
])
