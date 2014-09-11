(function() {
  'use strict';
  angular.module('app', ['ngRoute', 'ngAnimate', 'ui.bootstrap', 'easypiechart', 'mgo-angular-wizard', 'textAngular', 'ui.tree', 'ngMap', 'ngTagsInput', 'app.ui.ctrls', 'app.ui.directives', 'app.ui.services', 'app.controllers', 'app.directives', 'app.form.validation', 'app.ui.form.ctrls', 'app.ui.form.directives', 'app.tables', 'app.map', 'app.task', 'app.localization', 'app.page.ctrls']).config([
    '$routeProvider', function($routeProvider) {
      return $routeProvider.when('/', {
        redirectTo: '/pages/signin'
      }).when('/people', {
        templateUrl: 'views/ui/user.html'
      }).when('/categories', {
        templateUrl: 'views/forms/Categories.html'
      }).when('/maps/gmap', {
        templateUrl: 'views/maps/gmap.html'
      }).when('/listing', {
        templateUrl: 'views/listing/list.html'
      }).when('/pages/signin', {
        templateUrl: 'views/pages/signin.html'
      }).when('/pages/signup', {
        templateUrl: 'views/pages/signup.html'
      }).when('/pages/forgot', {
        templateUrl: 'views/pages/forgot-password.html'
      }).when('/pages/lock-screen', {
        templateUrl: 'views/pages/lock-screen.html'
      }).when('/pages/profile', {
        templateUrl: 'views/pages/profile.html'
      }).when('/404', {
        templateUrl: 'views/pages/404.html'
      }).when('/pages/500', {
        templateUrl: 'views/pages/500.html'
      }).otherwise({
        redirectTo: '/404'
      });
    }
  ]).factory("Session", function($http) {
    var Session;
    Session = {
      data: null,
      saveSession: function(data) {
        Session.data = '';
        Session.data = data;
      },
      updateSession: function(data) {
        if (Session.data !== null) {
          Session.data = data;
        } else {
          Session.data = '';
          Session.data = data;
        }
      },
      invalidateSession: function() {
        Session.data = null;
      },
      isValidSession: function() {
        if (Session.data === null) {
          return false;
        } else {
          return true;
        }
      }
    };
    return Session;
  }).factory("ServerUrl", function($http) {
    var ServerUrl;
    return ServerUrl = {
      url: 'http://192.168.20.130:3001/',
      getUrl: function() {
        return ServerUrl.url;
      }
    };
  });

  ServerUrl;

}).call(this);
