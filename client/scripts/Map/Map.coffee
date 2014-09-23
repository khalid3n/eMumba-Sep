'use strict'

angular.module('app.map', [])

.controller('MapDemoCtrl', [
    '$scope', '$http', '$interval', '$log'
    ($scope, $http, $interval, $log) ->
 
        $scope.drawingManager = new google.maps.drawing.DrawingManager(          
          drawingControl: true
          drawingControlOptions:
            position: google.maps.ControlPosition.TOP_CENTER
            drawingModes: [              
              google.maps.drawing.OverlayType.CIRCLE
              google.maps.drawing.OverlayType.POLYGON              
              google.maps.drawing.OverlayType.RECTANGLE
            ]
          circleOptions:
            fillColor: '#0000ff'
            strokeColor: '#0000ff'
            strokeOpacity: .8
            strokeWeight: .5
            clickable: true
            editable: true
            draggable: true
            zIndex: 1
          rectangleOptions:
            fillColor: '#00ff00'
            strokeColor: '#00ff00'
            strokeOpacity: .8
            strokeWeight: .5
            clickable: true
            editable: true
            draggable: true
            zIndex: 1
          polygonOptions:
            fillColor: '#ff0000'
            strokeColor: '#ff0000'
            strokeOpacity: .8
            strokeWeight: .5
            clickable: true
            editable: true
            draggable: true
            zIndex: 1

        )
        $scope.drawingManager.setMap $scope.map

        google.maps.event.addListener $scope.drawingManager, 'overlaycomplete', (event) ->
          if event.type == google.maps.drawing.OverlayType.CIRCLE 
            $log.info event.overlay.getCenter()
          if event.type == google.maps.drawing.OverlayType.POLYGON 
            $log.info event.overlay.getPaths()
          if event.type == google.maps.drawing.OverlayType.RECTANGLE 
            $log.info event.overlay.getBounds()  
        
])
