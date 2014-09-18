'use strict';

angular.module('app', [
    # Angular modules
    'ngRoute'
    'ngAnimate'    

    # 3rd Party Modules
    'ui.bootstrap'
    'easypiechart'
    'mgo-angular-wizard'
    'textAngular'
    'ui.tree'
    'ngMap'
    'ngTagsInput'

    # Custom modules
    'app.ui.ctrls'
    'app.ui.directives'
    'app.ui.services'
    'app.controllers'
    'app.directives'
    'app.form.validation'
    'app.ui.form.ctrls'
    'app.ui.form.directives'
    'app.tables'
    'app.map'
    'app.task'
    'app.localization'    
    'app.page.ctrls'
])
     
.config([
    '$routeProvider'
    ($routeProvider) ->
        $routeProvider
            # dashboard
            .when(
                '/'
                redirectTo: '/pages/signin'
            )            

            # UI Kit
            .when(
                '/people'
                templateUrl: 'views/ui/user.html'
            )
            

            # Categories
            .when(
                '/categories'
                templateUrl: 'views/forms/Categories.html'
            )
            

            # Maps
            .when(
                '/maps/gmap'
                templateUrl: 'views/maps/gmap.html'
            )
            

            # Tables            
            .when(
                '/listing'
                templateUrl: 'views/listing/list.html'
            )


            # Pages
            
            .when(
                '/pages/signin'
                templateUrl: 'views/pages/signin.html'
            )
            .when(
                '/pages/signup'
                templateUrl: 'views/pages/signup.html'
            )
            .when(
                '/pages/forgot'
                templateUrl: 'views/pages/forgot-password.html'
            )
            .when(
                '/pages/lock-screen'
                templateUrl: 'views/pages/lock-screen.html'
            )
            .when(
                '/pages/profile'
                templateUrl: 'views/pages/profile.html'
            )
            .when(
                '/404'
                templateUrl: 'views/pages/404.html'
            )
            .when(
                '/pages/500'
                templateUrl: 'views/pages/500.html'
            ) 

            .otherwise(
                redirectTo: '/404'
            )
])

.run([
     '$rootScope', 'Session', '$location'
     ($rootScope, Session, $location) ->

         $rootScope.$on('$routeChangeStart', (event, next, current) ->
             if !Session.isValidSession()
                if next.templateUrl == "views/pages/signin.html"
                else if next.templateUrl == "views/pages/signup.html"
                else if next.templateUrl == "views/pages/forgot-password.html"
                else if next.templateUrl == "views/pages/404.html"
                else if next.templateUrl == "views/pages/500.html"
                else
                    $location.path('/pages/signin')
         )

])


.factory "Session", ($window) ->
  Session =
    data: null
    saveSession: (data) ->
      Session.data = '' 
      Session.data = data
      $window.sessionStorage.token = data
      return

    updateSession: (data) ->
      if Session.data isnt null
        Session.data = data
        $window.sessionStorage.token = data
      else
        Session.data = ''
        Session.data = data
        $window.sessionStorage.token = data
      return

    invalidateSession: ->
      delete Session.data
      delete $window.sessionStorage.token
      return

    isValidSession: ->
      if !Session.data && !$window.sessionStorage.token        
        false
      else        
        true

  Session

.factory "ServerUrl", ->
  ServerUrl =
    url: "http://192.168.20.130:3001/"
    getUrl: ->
      ServerUrl.url

  ServerUrl


