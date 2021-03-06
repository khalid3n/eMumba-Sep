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
    'ngTagsInput'

    # Custom modules    
    'app.controllers'
    'app.directives'
    'app.form.validation'
    'app.ui.form.ctrls'
    'app.ui.form.directives'
    'app.tables'
    'app.map'
    'app.ui.ctrls'
    'app.ui.directives'
    'app.ui.services'
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
                '/pages/setup-pass'
                templateUrl: 'views/pages/setup-pass.html'
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
                else if next.templateUrl == "views/pages/setup-pass.html"
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

.factory "MapAddress", ->
  MapAddress =
    address: "SHARJAH"
    zoom: 11
    item: ''
    loc: []
    locationLoc: ''
    color: '#ff0000'
    isDrawing: false
    setMapAddress: (address) ->
      MapAddress.address = address
    getMapAddress: ->
      MapAddress.address
    setMapZoom: (zoom) ->
      MapAddress.zoom = zoom
    getMapZoom: ->
      MapAddress.zoom
    setItem: (item) ->
      MapAddress.item = item
    getItem: ->
      MapAddress.item
    setLoc: (locArray) ->
      if locArray
        i = 0
        while i < locArray.length
          MapAddress.loc[i] = new google.maps.LatLng(locArray[i].k, locArray[i].B)
          i++    
        
      else
          MapAddress.loc = [
              new google.maps.LatLng(25.774252, -80.190262)
              new google.maps.LatLng(18.466465, -66.118292)
              new google.maps.LatLng(32.321384, -64.75737)
              new google.maps.LatLng(25.774252, -80.190262)
          ]
      return MapAddress.loc
    getLoc: ->
      MapAddress.loc
    setLocationLoc: (locArray) ->
      if locArray
        MapAddress.locationLoc = new google.maps.LatLng(locArray.k, locArray.B)
      else
        MapAddress.locationLoc = new google.maps.LatLng(25.774252, -80.190262)
    getLocationLoc: ->
      MapAddress.locationLoc
    setColor: (color) ->
      MapAddress.color = color
    getColor: ->
      MapAddress.color
    setIsDrawing: (isDrawing) ->
      MapAddress.isDrawing = isDrawing
    getIsDrawing: ->
      MapAddress.isDrawing

  MapAddress

.filter 'capitalize', -> 
    (input, $scope) -> 
        return input.substring(0,1).toUpperCase()+input.substring(1)


