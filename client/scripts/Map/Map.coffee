'use strict'

angular.module('app.map', [])

.controller('MapDemoCtrl', [
    '$scope', '$http', '$interval', '$log' ,'$rootScope','MapAddress'
    ($scope, $http, $interval, $log, $rootScope, MapAddress) ->
        $scope.isDrawing = true
        $scope.brickColor = '#ff0000'
        $scope.brickeditable = true
        $scope.brickdraggable = true
        $scope.brickclickable = true
        
        if $scope.isDrawing
          $scope.drawingManager = new google.maps.drawing.DrawingManager(          
            drawingControl: true
            drawingControlOptions:
              position: google.maps.ControlPosition.TOP_CENTER
              drawingModes: [                            
                google.maps.drawing.OverlayType.POLYGON                            
              ]          
            polygonOptions:
              fillColor: $scope.brickColor
              strokeColor: $scope.brickColor
              strokeOpacity: .8
              strokeWeight: .5
              clickable: $scope.brickclickable
              editable: $scope.brickeditable
              draggable: $scope.brickdraggable
              zIndex: 1
          )
          $scope.drawingManager.setMap $scope.map
          google.maps.event.addListener $scope.drawingManager, 'overlaycomplete', (event) ->          
            if event.type == google.maps.drawing.OverlayType.POLYGON 
              $log.info event.overlay.getPaths().getArray()[0].j
              google.maps.event.addListener event.overlay, 'mouseup', (polygon) ->
                $log.info event.overlay.getPaths().getArray()[0].j
          
          
 
        $scope.codeAddress = (mapAdrs, mapzoom) ->        
          geocoder = new google.maps.Geocoder()
          geocoder.geocode
            address: mapAdrs
          , (results, status) ->
            if status is google.maps.GeocoderStatus.OK              
              $scope.map.setCenter results[0].geometry.location  
              $scope.map.setZoom mapzoom                     
            else
              $log.info "Geocode was not successful for the following reason: " + status
            return


        $scope.codeAddress(MapAddress.getMapAddress(), MapAddress.getMapZoom())
 ])
