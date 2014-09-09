(function() {
  'use strict';
  angular.module('app', ['ngRoute', 'ngAnimate', 'ui.bootstrap', 'easypiechart', 'mgo-angular-wizard', 'textAngular', 'ui.tree', 'ngMap', 'ngTagsInput', 'app.ui.ctrls', 'app.ui.directives', 'app.ui.services', 'app.controllers', 'app.directives', 'app.form.validation', 'app.ui.form.ctrls', 'app.ui.form.directives', 'app.tables', 'app.map', 'app.task', 'app.localization', 'app.page.ctrls']).config([
    '$routeProvider', function($routeProvider) {
      return $routeProvider.when('/', {
        redirectTo: '/pages/signin'
      }).when('/ui/typography', {
        templateUrl: 'views/ui/typography.html'
      }).when('/ui/buttons', {
        templateUrl: 'views/ui/buttons.html'
      }).when('/ui/icons', {
        templateUrl: 'views/ui/icons.html'
      }).when('/ui/grids', {
        templateUrl: 'views/ui/grids.html'
      }).when('/ui/widgets', {
        templateUrl: 'views/ui/widgets.html'
      }).when('/ui/components', {
        templateUrl: 'views/ui/components.html'
      }).when('/ui/timeline', {
        templateUrl: 'views/ui/timeline.html'
      }).when('/ui/nested-lists', {
        templateUrl: 'views/ui/nested-lists.html'
      }).when('/ui/pricing-tables', {
        templateUrl: 'views/ui/pricing-tables.html'
      }).when('/forms/elements', {
        templateUrl: 'views/forms/elements.html'
      }).when('/forms/layouts', {
        templateUrl: 'views/forms/layouts.html'
      }).when('/forms/validation', {
        templateUrl: 'views/forms/validation.html'
      }).when('/forms/wizard', {
        templateUrl: 'views/forms/wizard.html'
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
      data: {},
      saveSession: function(data) {
        Session.data = data;
      },
      updateSession: function(data) {
        Session.data = data;
      },
      invalidateSession: function() {
        Session.data = "";
      },
      validSession: function() {
        if (Session.data !== "") {
          return true;
        } else {
          return false;
        }
      }
    };
    return Session;
  });

}).call(this);
