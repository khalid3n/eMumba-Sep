'use strict'

angular.module('app.map', [])

.controller('MapDemoCtrl', [
    '$scope', '$http', '$interval', '$log' ,'$rootScope','MapAddress', '$modal', '$location'
    ($scope, $http, $interval, $log, $rootScope, MapAddress, $modal, $location) ->
        $scope.isDrawing = MapAddress.getIsDrawing()
        $scope.brickColor = MapAddress.getColor()
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

          $scope.addBrick = (items) ->
              modalInstance = $modal.open(
                  templateUrl: "ModalMapContent.html"
                  controller: 'ModalMapInstanceCtrl'
                  resolve:
                      items: ->
                          items                                       
              )
              modalInstance.result.then ((items) ->                                  
                  if items
                    $location.path('/listing')
                  else
                    $scope.drawingManager.drawingMode google.maps.drawing.OverlayType.MARKER
              ), ->                
                  return


          google.maps.event.addListener $scope.drawingManager, 'overlaycomplete', (event) ->          
            if event.type == google.maps.drawing.OverlayType.POLYGON               
              $scope.items = MapAddress.getItem()
              $scope.items.loc = event.overlay.getPaths().getArray()[0].j
              $scope.addBrick($scope.items); 
              google.maps.event.addListener event.overlay, 'mouseup', (polygon) ->
                $scope.items = MapAddress.getItem()
                $scope.items.loc = event.overlay.getPaths().getArray()[0].j
                $scope.addBrick($scope.items);   
          
 
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
              
        $scope.polygonShape = new google.maps.Polygon(
          paths:MapAddress.getLoc()
          fillColor: MapAddress.getColor()
          strokeColor: MapAddress.getColor()
          strokeOpacity: .8
          strokeWeight: .5
          clickable: $scope.brickclickable
          editable: $scope.brickeditable
          draggable: $scope.brickdraggable
          zIndex: 1
        )

        $scope.polygonShape.setMap $scope.map


                 

 ])
