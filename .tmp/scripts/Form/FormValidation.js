(function() {
  'use strict';
  angular.module('app.form.validation', []).controller('wizardFormCtrl', [
    '$scope', function($scope) {
      $scope.wizard = {
        firstName: 'some name',
        lastName: '',
        email: '',
        password: '',
        age: '',
        address: ''
      };
      $scope.isValidateStep1 = function() {
        console.log($scope.wizard_step1);
        console.log($scope.wizard.firstName !== '');
        console.log($scope.wizard.lastName === '');
        return console.log($scope.wizard.firstName !== '' && $scope.wizard.lastName !== '');
      };
      return $scope.finishedWizard = function() {
        return console.log('yoo');
      };
    }
  ]).controller('formConstraintsCtrl', [
    '$scope', function($scope) {
      var original;
      $scope.form = {
        required: '',
        minlength: '',
        maxlength: '',
        length_rage: '',
        type_something: '',
        confirm_type: '',
        foo: '',
        email: '',
        url: '',
        num: '',
        minVal: '',
        maxVal: '',
        valRange: '',
        pattern: ''
      };
      original = angular.copy($scope.form);
      $scope.revert = function() {
        $scope.form = angular.copy(original);
        return $scope.form_constraints.$setPristine();
      };
      $scope.canRevert = function() {
        return !angular.equals($scope.form, original) || !$scope.form_constraints.$pristine;
      };
      return $scope.canSubmit = function() {
        return $scope.form_constraints.$valid && !angular.equals($scope.form, original);
      };
    }
  ]).controller('forgotCtrl', [
    '$scope', '$location', '$http', 'Session', '$log', 'ServerUrl', function($scope, $location, $http, Session, $log, ServerUrl) {
      var original;
      $scope.user = {
        email: ''
      };
      $scope.showInfoOnSubmit = false;
      original = angular.copy($scope.user);
      $scope.revert = function() {
        $scope.user = angular.copy(original);
        return $scope.form_forgot.$setPristine();
      };
      $scope.canRevert = function() {
        return !angular.equals($scope.user, original) || !$scope.form_forgot.$pristine;
      };
      $scope.canSubmit = function() {
        return $scope.form_forgot.$valid && !angular.equals($scope.user, original);
      };
      return $scope.submitForm = function() {
        if ($scope.canSubmit()) {
          return $http({
            method: "post",
            url: ServerUrl.getUrl() + "forgot",
            headers: {
              "Content-Type": "application/json"
            },
            data: {
              email: $scope.user.email
            }
          }).success(function(data, status, headers, config) {
            Session.invalidateSession();
            return $location.path('/pages/signin');
          }).error(function(data, status, headers, config) {
            return $scope.showInfoOnSubmit = true;
          });
        }
      };
    }
  ]).controller('signinCtrl', [
    '$scope', '$location', '$http', 'Session', '$log', 'ServerUrl', function($scope, $location, $http, Session, $log, ServerUrl) {
      var original;
      if (Session.validSession()) {
        $location.path('/listing');
      }
      $scope.user = {
        email: '',
        password: ''
      };
      $scope.showInfoOnSubmit = false;
      original = angular.copy($scope.user);
      $scope.revert = function() {
        $scope.user = angular.copy(original);
        return $scope.form_signin.$setPristine();
      };
      $scope.canRevert = function() {
        return !angular.equals($scope.user, original) || !$scope.form_signin.$pristine;
      };
      $scope.canSubmit = function() {
        return $scope.form_signin.$valid && !angular.equals($scope.user, original);
      };
      return $scope.submitForm = function() {
        if ($scope.canSubmit()) {
          return $http({
            method: "post",
            url: ServerUrl.getUrl() + "login",
            headers: {
              "Content-Type": "application/json"
            },
            data: {
              email: $scope.user.email,
              password: $scope.user.password
            }
          }).success(function(data, status, headers, config) {
            Session.saveSession(data);
            return $location.path('/listing');
          }).error(function(data, status, headers, config) {
            return $scope.showInfoOnSubmit = true;
          });
        }
      };
    }
  ]).controller('signupCtrl', [
    '$scope', '$location', '$http', 'Session', '$log', 'ServerUrl', function($scope, $location, $http, Session, $log, ServerUrl) {
      var original;
      $scope.user = {
        name: '',
        email: '',
        password: '',
        confirmPassword: ''
      };
      $scope.showInfoOnSubmit = false;
      original = angular.copy($scope.user);
      $scope.revert = function() {
        $scope.user = angular.copy(original);
        $scope.form_signup.$setPristine();
        return $scope.form_signup.confirmPassword.$setPristine();
      };
      $scope.canRevert = function() {
        return !angular.equals($scope.user, original) || !$scope.form_signup.$pristine;
      };
      $scope.canSubmit = function() {
        return $scope.form_signup.$valid && !angular.equals($scope.user, original);
      };
      return $scope.submitForm = function() {
        if ($scope.canSubmit()) {
          return $http({
            method: "post",
            url: ServerUrl.getUrl() + "signup",
            headers: {
              "Content-Type": "application/json"
            },
            data: {
              name: $scope.user.name,
              email: $scope.user.email,
              password: $scope.user.password
            }
          }).success(function(data, status, headers, config) {
            Session.invalidateSession();
            return $location.path('/pages/signin');
          }).error(function(data, status, headers, config) {
            return $scope.showInfoOnSubmit = true;
          });
        }
      };
    }
  ]).directive('validateEquals', [
    function() {
      return {
        require: 'ngModel',
        link: function(scope, ele, attrs, ngModelCtrl) {
          var validateEqual;
          validateEqual = function(value) {
            var valid;
            valid = value === scope.$eval(attrs.validateEquals);
            ngModelCtrl.$setValidity('equal', valid);
            return typeof valid === "function" ? valid({
              value: void 0
            }) : void 0;
          };
          ngModelCtrl.$parsers.push(validateEqual);
          ngModelCtrl.$formatters.push(validateEqual);
          return scope.$watch(attrs.validateEquals, function(newValue, oldValue) {
            if (newValue !== oldValue) {
              return ngModelCtrl.$setViewValue(ngModelCtrl.$ViewValue);
            }
          });
        }
      };
    }
  ]);

}).call(this);
