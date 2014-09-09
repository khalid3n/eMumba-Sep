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
                '/ui/typography'
                templateUrl: 'views/ui/typography.html'
            )
            .when(
                '/ui/buttons'
                templateUrl: 'views/ui/buttons.html'
            )
            .when(
                '/ui/icons'
                templateUrl: 'views/ui/icons.html'
            )
            .when(
                '/ui/grids'
                templateUrl: 'views/ui/grids.html'
            )
            .when(
                '/ui/widgets'
                templateUrl: 'views/ui/widgets.html'
            )
            .when(
                '/ui/components'
                templateUrl: 'views/ui/components.html'
            )
            .when(
                '/ui/timeline'
                templateUrl: 'views/ui/timeline.html'
            )
            .when(
                '/ui/nested-lists'
                templateUrl: 'views/ui/nested-lists.html'
            )
            .when(
                '/ui/pricing-tables'
                templateUrl: 'views/ui/pricing-tables.html'
            )

            # Forms
            .when(
                '/forms/elements'
                templateUrl: 'views/forms/elements.html'
            )
            .when(
                '/forms/layouts'
                templateUrl: 'views/forms/layouts.html'
            )
            .when(
                '/forms/validation'
                templateUrl: 'views/forms/validation.html'
            )
            .when(
                '/forms/wizard'
                templateUrl: 'views/forms/wizard.html'
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
]).factory "Session", ($http) ->
  Session =
    data: null
    saveSession: (data) ->
      Session.data = {} 
      Session.data = data
      return

    updateSession: (data) ->
      if Session.data isnt null
        Session.data = data
      else
        Session.data = {} 
        Session.data = data
      return

    invalidateSession: ->
      Session.data = ""
      return

    validSession: ->
      if Session.data isnt null
        true
      else
        false

  Session

# .run([
#     '$rootScope'
#     ($rootScope) ->

#         $rootScope.$on('$routeChangeStart', (event, next, current) ->
#             console.log 'routeChangeStart'
#         )

#         $rootScope.$on('$routeChangeSuccess', (event, current, previous, rejection) ->
#             console.log 'routeChangeSuccess'
#         )
# ])
