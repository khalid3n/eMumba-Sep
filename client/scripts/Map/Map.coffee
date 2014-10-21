'use strict'

angular.module('app.map', ['ngMap'])

.controller('MapDemoCtrl', [
    '$scope', '$http', '$interval', '$log' ,'$rootScope','MapAddress', '$modal', '$location'
    ($scope, $http, $interval, $log, $rootScope, MapAddress, $modal, $location) ->
        $scope.isDrawing = MapAddress.getIsDrawing()
        $scope.brickColor = MapAddress.getColor()
        $scope.brickeditable = true
        $scope.brickdraggable = true
        $scope.brickclickable = true

        $scope.iconToPath = (classText) ->
          if classText == 'color-success glyphicon glyphicon-plus'
            return fontawesome.markers.PLUS
          else if classText == 'color-info glyphicon glyphicon-star-empty'
            return fontawesome.markers.STAR_O
          else if classText == 'color-danger glyphicon glyphicon-heart'
            return fontawesome.markers.HEART
          else if classText == 'color-warning wi-day-sunny'
            return fontawesome.markers.SUN_O
          else if classText == 'color-primary wi-night-clear'
            return fontawesome.markers.MOON_O
          else if classText == 'color-info-alt glyphicon glyphicon-cloud'
            return fontawesome.markers.CLOUD
          else if classText == 'color-gray glyphicon glyphicon-shopping-cart'
            return fontawesome.markers.SHOPPING_CART
          else if classText == 'color-info glyphicon glyphicon-plane'
            return fontawesome.markers.PLANE
        
        if $scope.isDrawing
          $scope.drawingManager = new google.maps.drawing.DrawingManager(
            drawingControl: true
            drawingControlOptions:
              position: google.maps.ControlPosition.TOP_CENTER
              drawingModes: [
                google.maps.drawing.OverlayType.MARKER,                
                google.maps.drawing.OverlayType.POLYGON                            
              ] 
            markerOptions:              
              zIndex: 2      
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
                    $scope.drawingManager.setDrawingMode(null)
              ), ->                
                  return

          $scope.addLocation = (items) ->
              modalInstance = $modal.open(
                  templateUrl: "ModalMapLocationContent.html"
                  controller: 'ModalMapInstanceCtrl'
                  resolve:
                      items: ->
                          items                                       
              )
              modalInstance.result.then ((items) ->                                  
                  if items
                    $location.path('/listing')
                  else
                    $scope.drawingManager.setDrawingMode(null)
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
            if event.type == google.maps.drawing.OverlayType.MARKER
              $scope.items = MapAddress.getItem()
              $scope.items.locationLoc = event.overlay.getPosition()
              $scope.addLocation($scope.items);
              google.maps.event.addListener event.overlay, 'mouseup', (polygon) ->
                $scope.items = MapAddress.getItem()
                $scope.items.locationLoc = event.overlay.getPosition()
                $scope.addLocation($scope.items);    
          
 
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
        
        if MapAddress.getItem().modalName == 'location'
          $scope.brickeditable = false
          $scope.brickdraggable = false
          $scope.brickclickable = false          
          $scope.drawingManager.drawingControlOptions.drawingModes = [
            google.maps.drawing.OverlayType.MARKER
          ]
          $scope.drawingManager.markerOptions = (
            icon:
                path: $scope.iconToPath(MapAddress.getItem().category.icon)
                scale: 0.5
                strokeWeight: 0.2
                strokeColor: 'black'
                strokeOpacity: 1
                fillColor: '#f8ae5f'
                fillOpacity: 0.7
                clickable: $scope.isDrawing
                editable: $scope.isDrawing
                draggable: $scope.isDrawing
                zIndex: 2
                
          )
          $scope.markerShape = new google.maps.Marker(
            html: MapAddress.getItem().name
            position: MapAddress.getLocationLoc()
            icon:
              path: $scope.iconToPath(MapAddress.getItem().category.icon)
              scale: 0.5
              strokeWeight: 0.2
              strokeColor: 'black'
              strokeOpacity: 1
              fillColor: '#f8ae5f'
              fillOpacity: 0.7
              clickable: $scope.isDrawing
              editable: $scope.isDrawing
              draggable: $scope.isDrawing
              zIndex: 2          
          )
          $scope.markerShape.setMap $scope.map
          $scope.infowindow = new google.maps.InfoWindow();
          google.maps.event.addListener $scope.markerShape, "click", (evt) ->
            $scope.contentString = this.html  
            $scope.infowindow.setContent($scope.contentString)
            $scope.infowindow.setPosition(evt.latLng)
            $scope.infowindow.open($scope.map)
          google.maps.event.addListener $scope.markerShape, 'mouseup', (event) ->
                $scope.items = MapAddress.getItem()
                $scope.items.locationLoc = event.evt.latLng
                $scope.addLocation($scope.items);
          
        
        $scope.polygonShape = new google.maps.Polygon(
          html: MapAddress.getItem().name
          paths: MapAddress.getLoc()
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

        if MapAddress.getItem().modalName == 'brick' 
          $scope.drawingManager.drawingControlOptions.drawingModes = [
            google.maps.drawing.OverlayType.POLYGON
          ]
          $scope.infowindow = new google.maps.InfoWindow();

          google.maps.event.addListener $scope.polygonShape, "click", (evt) ->
            $scope.contentString = this.html  
            $scope.infowindow.setContent($scope.contentString)
            $scope.infowindow.setPosition(evt.latLng)
            $scope.infowindow.open($scope.map)
        
          google.maps.event.addListener $scope.polygonShape, 'mouseup', (evt) ->
            $scope.items = MapAddress.getItem()
            $scope.items.loc = $scope.polygonShape.getPaths().getArray()[0].j
            $scope.addBrick($scope.items); 
        

 ])
