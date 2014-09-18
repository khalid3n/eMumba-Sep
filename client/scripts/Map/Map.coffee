'use strict'

angular.module('app.map', [])

.controller('MapDemoCtrl', [
    '$scope', '$http', '$interval'
    ($scope, $http, $interval) ->
 
        $scope.drawingManager = new google.maps.drawing.DrawingManager(          
          drawingControl: true
          drawingControlOptions:
            position: google.maps.ControlPosition.TOP_CENTER
            drawingModes: [              
              google.maps.drawing.OverlayType.CIRCLE
              google.maps.drawing.OverlayType.POLYGON              
              google.maps.drawing.OverlayType.RECTANGLE
            ]
        )
        $scope.drawingManager.setMap $scope.map


])
