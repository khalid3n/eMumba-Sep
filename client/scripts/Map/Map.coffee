'use strict'

angular.module('app.map', [])

.controller('MapDemoCtrl', [
    '$scope', '$http', '$interval', '$log' ,'$rootScope'
    ($scope, $http, $interval, $log, $rootScope) ->
        
        #$log.info $scope.map
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
            google.maps.event.addListener event.overlay, 'radius_changed', (circle) ->
              $log.info event.overlay.getRadius()
            google.maps.event.addListener event.overlay, 'dragend', (circle) ->
              $log.info event.overlay.getCenter()            
          
          if event.type == google.maps.drawing.OverlayType.POLYGON 
            $log.info event.overlay.getPaths().getArray()[0].j
            google.maps.event.addListener event.overlay, 'mouseup', (polygon) ->
              $log.info event.overlay.getPaths().getArray()[0].j
          
          if event.type == google.maps.drawing.OverlayType.RECTANGLE 
            $log.info event.overlay.getBounds()  
            google.maps.event.addListener event.overlay, 'dragend', (rectangle) ->
              $log.info event.overlay.getBounds()
 
        $scope.codeAddress = (territoryAdrs) ->                   
          geocoder = new google.maps.Geocoder()
          geocoder.geocode
            address: territoryAdrs
          , (results, status) ->
            if status is google.maps.GeocoderStatus.OK
              
              $scope.map.setCenter results[0].geometry.location
              $log.info results[0].geometry.location
              $log.info territoryAdrs
            else
              $log.info "Geocode was not successful for the following reason: " + status
            return


        $rootScope.$on "findAddress", (event, args) ->
           $scope.codeAddress(args)

        #$scope.codeAddress('Al Rigga')
 ])
