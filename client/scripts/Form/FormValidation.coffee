'use strict'

angular.module('app.form.validation', [])

.controller('forgotCtrl', [
    '$scope', '$location', '$http', 'Session', '$log', 'ServerUrl'
    ($scope, $location, $http, Session, $log, ServerUrl) ->
       
        $scope.user =
            email: ''          

        $scope.showInfoOnSubmit = false

        original = angular.copy($scope.user)        
        
        $scope.revert = ->
            $scope.user = angular.copy(original)
            $scope.form_forgot.$setPristine()

        $scope.canRevert = ->
            return !angular.equals($scope.user, original) || !$scope.form_forgot.$pristine

        $scope.canSubmit = ->
            return $scope.form_forgot.$valid && !angular.equals($scope.user, original)

        $scope.submitForm = ->             
            if $scope.canSubmit()
                $http(
                  method: "post"
                  url: ServerUrl.getUrl() + "forgot"
                  headers:
                    "Content-Type": "application/json"
                  data:
                    email: $scope.user.email                   
                ).success((data, status, headers, config) ->
                    Session.invalidateSession()
                    $location.path('/pages/signin')
                ).error (data, status, headers, config) ->
                    $scope.showInfoOnSubmit = true
                                
])
.controller('signinCtrl', [
    '$scope', '$location', '$http', 'Session', '$log', 'ServerUrl'
    ($scope, $location, $http, Session, $log , ServerUrl) ->
                
        if Session.isValidSession()
            $location.path('/listing')
        
        $scope.user =
            email: ''
            password: ''

        $scope.showInfoOnSubmit = false

        original = angular.copy($scope.user)
        
        
        $scope.revert = ->
            $scope.user = angular.copy(original)
            $scope.form_signin.$setPristine()

        $scope.canRevert = ->
            return !angular.equals($scope.user, original) || !$scope.form_signin.$pristine

        $scope.canSubmit = ->
            return $scope.form_signin.$valid && !angular.equals($scope.user, original)

        $scope.submitForm = ->             
            if $scope.canSubmit()
                $http(
                  method: "post"
                  url: ServerUrl.getUrl() + "login"
                  headers:
                    "Content-Type": "application/json"
                  data:
                    email: $scope.user.email
                    password: $scope.user.password                  
                ).success((data, status, headers, config) ->
                    Session.saveSession(data)
                    $location.path('/listing') 
                ).error (data, status, headers, config) ->
                    $scope.showInfoOnSubmit = true
                                
])

.controller('signupCtrl', [
    '$scope', '$location', '$http', 'Session', '$log', 'ServerUrl'
    ($scope, $location, $http, Session, $log , ServerUrl) ->
        $scope.user = 
            name: ''
            email: ''
            password: ''
            confirmPassword: ''
            
        $scope.showInfoOnSubmit = false

        original = angular.copy($scope.user)

        $scope.revert = ->
            $scope.user = angular.copy(original)
            $scope.form_signup.$setPristine()
            $scope.form_signup.confirmPassword.$setPristine()

        $scope.canRevert = ->
            return !angular.equals($scope.user, original) || !$scope.form_signup.$pristine

        $scope.canSubmit = ->
            return $scope.form_signup.$valid && !angular.equals($scope.user, original)

        $scope.submitForm = ->
             if $scope.canSubmit()
                $http(
                  method: "post"
                  url: ServerUrl.getUrl() + "signup"
                  headers:
                    "Content-Type": "application/json"
                  data:
                    name: $scope.user.name
                    email: $scope.user.email
                    password: $scope.user.password 
                    passwordConfirmation: $scope.user.password 
                ).success((data, status, headers, config) ->
                    Session.invalidateSession()
                    $location.path('/pages/signin')
                ).error (data, status, headers, config) ->
                    $scope.showInfoOnSubmit = true
                       

])

# used for confirm password
# Note: if you modify the "confirm" input box, and then update the target input box to match it, it'll still show invalid style though the values are the same now
# Note2: also remember to use " ng-trim='false' " to disable the trim
.directive('validateEquals', [ () ->
    return {
        require: 'ngModel'
        link: (scope, ele, attrs, ngModelCtrl) ->
            validateEqual = (value) ->
                valid = ( value is scope.$eval(attrs.validateEquals) )
                ngModelCtrl.$setValidity('equal', valid)
                return valid? value : undefined

            ngModelCtrl.$parsers.push(validateEqual)
            ngModelCtrl.$formatters.push(validateEqual)

            scope.$watch(attrs.validateEquals, (newValue, oldValue) ->
                if newValue isnt oldValue # so that watch only fire after change, otherwise watch will fire on load and add invalid style to "confirm" input box
                    ngModelCtrl.$setViewValue(ngModelCtrl.$ViewValue)
            )
    }
])

