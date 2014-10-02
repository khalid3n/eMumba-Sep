'use strict';

angular.module('app.ui.ctrls', [])


.controller('AlertDemoCtrl', [
    '$scope'
    ($scope) ->
        $scope.alerts = [
            { type: 'success', msg: 'Well done! You successfully read this important alert message.' }
            { type: 'info', msg: 'Heads up! This alert needs your attention, but it is not super important.' }
            { type: 'warning', msg: "Warning! Best check yo self, you're not looking too good." }
            { type: 'danger', msg: 'Oh snap! Change a few things up and try submitting again.' }
        ]

        $scope.addAlert = ->
            num = Math.ceil(Math.random() * 4)
            type = undefined
            switch num
                when 0 then type = 'info'
                when 1 then type = 'success'
                when 2 then type = 'info'
                when 3 then type = 'warning'
                when 4 then type = 'danger'
            $scope.alerts.push({type: type, msg: "Another alert!"})

        $scope.closeAlert = (index)->
            $scope.alerts.splice(index, 1)
])


.controller('ModalInstanceCtrl', [
    '$scope', '$modalInstance', 'items', 'data', '$http' , 'ServerUrl', '$log', 'MapAddress','$location'
    ($scope, $modalInstance, items, data, $http, ServerUrl, $log, MapAddress, $location) ->
        $scope.items = items
        
        $scope.isRegion = false
        $scope.isArea = false
        $scope.isTeritory = false
        $scope.isBrick = false
        $scope.isLocation = false

        $scope.getData  = (urlString) ->
            $http(             
              url: ServerUrl.getUrl() + urlString           
            ).success((data, status, headers, config) ->            
                $scope.data = data
                data
            ).error (data, status, headers, config) ->
                null
        $scope.getCategoryData  = ->
            $http(             
              url: ServerUrl.getUrl() + 'category'           
            ).success((data, status, headers, config) ->            
                $scope.items.category = data
                data
            ).error (data, status, headers, config) ->
                null
        
        if $scope.items.modalName == 'region'
            $scope.isRegion = true
            $scope.isArea = false
            $scope.isTeritory = false
            $scope.isBrick = false
            $scope.isLocation = false
        else if $scope.items.modalName == 'area'
            $scope.getData('region')
            $scope.isRegion = false
            $scope.isArea = true
            $scope.isTeritory = false
            $scope.isBrick = false
            $scope.isLocation = false
        else if $scope.items.modalName == 'territory'
            $scope.getData('area')
            $scope.isRegion = false
            $scope.isArea = false
            $scope.isTeritory = true
            $scope.isBrick = false
            $scope.isLocation = false
        else if $scope.items.modalName == 'brick'
            $scope.getData('territory')
            $scope.isRegion = false
            $scope.isArea = false
            $scope.isTeritory = false
            $scope.isBrick = true
            $scope.isLocation = false
        else if $scope.items.modalName == 'location'
            $scope.getData('brick')
            $scope.getCategoryData()
            $scope.isRegion = false
            $scope.isArea = false
            $scope.isTeritory = false
            $scope.isBrick = false
            $scope.isLocation = true
        
        $scope.ok = -> 
            modalname = $scope.items.modalName
            methodtype = (if ($scope.items.id is "") then "post" else "put")
            data = {}
            data[modalname] =
              _id: $scope.items.id
              name: $scope.items.name
              code: $scope.items.code
              _ref: $scope.items.region
            $log.info data
            $http(
              method: methodtype              
              url: ServerUrl.getUrl() + modalname
              headers:
                "Content-Type": "application/json"
              data: data                
            ).success((data, status, headers, config) ->                
                $modalInstance.close data
                return 
            ).error (data, status, headers, config) ->
                $modalInstance.dismiss "cancel"


        $scope.showMap = (modalName)->
            $scope.items.modalName = modalName            
            MapAddress.setMapZoom(17)
            MapAddress.setLoc($scope.items.loc)
            MapAddress.setColor($scope.items.color)
            MapAddress.setMapAddress($scope.items.region.name)
            MapAddress.setItem($scope.items)                  
            $location.path('/maps/gmap') 
            $modalInstance.dismiss "cancel"

        $scope.cancel = ->
            $scope.isRegion = false
            $scope.isArea = false
            $scope.isTeritory = false
            $scope.isBrick = false
            $scope.isLocation = false
            $modalInstance.dismiss "cancel"
            return

        return
])

.controller('ModalCategoryInstanceCtrl', [
    '$scope', '$modalInstance', 'items', '$http' , 'ServerUrl', '$log'
    ($scope, $modalInstance, items, $http, ServerUrl, $log) ->
        $scope.items = items     
        
        $scope.ok = -> 
            modalname = $scope.items.modalName
            methodtype = (if ($scope.items.id is "") then "post" else "put")
            data = {}
            data[modalname] =
              _id: $scope.items.id
              name: $scope.items.name
              description: $scope.items.desc
              icon: $scope.items.icon
            
            $http(
              method: methodtype              
              url: ServerUrl.getUrl() + modalname
              headers:
                "Content-Type": "application/json"
              data: data                
            ).success((data, status, headers, config) ->                
                $modalInstance.close data
                return 
            ).error (data, status, headers, config) ->
                $modalInstance.dismiss "cancel"
        $scope.cancel = ->            
            $modalInstance.dismiss "cancel"
            return

        return
])

.controller('ModalUserInstanceCtrl', [
    '$scope', '$modalInstance', 'items', '$http' , 'ServerUrl', '$log'
    ($scope, $modalInstance, items, $http, ServerUrl, $log) ->
        $scope.items = items     
        
        $scope.ok = -> 
            modalname = $scope.items.modalName
            methodtype = (if ($scope.items.id is "") then "post" else "put")
            data = {}
            data[modalname] =
              _id: $scope.items.id
              name: $scope.items.name
              designation: $scope.items.designation
              email: $scope.items.email
              is_authorized: $scope.items.is_authorized
              is_admin: $scope.items.is_admin
            
            $http(
              method: methodtype              
              url: ServerUrl.getUrl() + modalname
              headers:
                "Content-Type": "application/json"
              data: data                
            ).success((data, status, headers, config) ->                
                $modalInstance.close data
                return 
            ).error (data, status, headers, config) ->
                $modalInstance.dismiss "cancel"
        $scope.cancel = ->            
            $modalInstance.dismiss "cancel"
            return

        return
])

.controller('ModalDeleteInstanceCtrl', [
    '$scope', '$modalInstance', 'items', 'data', '$http', 'ServerUrl'
    ($scope, $modalInstance, items, data, $http, ServerUrl) ->
        $scope.items = items       
        
        $scope.confirm = ->            
            $http(
                  method: "delete"
                  url: ServerUrl.getUrl() + $scope.items.modalName + "/" + $scope.items.id                                 
                ).success((data, status, headers, config) ->
                    $modalInstance.close $scope.items
                ).error (data, status, headers, config) ->
                     $modalInstance.dismiss "cancel"                 

        $scope.cancel = ->
            $modalInstance.dismiss "cancel"
            return

        return
])

.controller('ModalMapInstanceCtrl', [
    '$scope', '$modalInstance', 'items', '$log', '$http', 'ServerUrl'
    ($scope, $modalInstance, items, $log, $http, ServerUrl) ->
        $scope.items = items       
        
        $scope.confirm = ->            
            modalname = $scope.items.modalName
            methodtype = (if ($scope.items.id is "") then "post" else "put")
            data = {}
            data[modalname] =
              _id: $scope.items.id
              name: $scope.items.name              
              loc: $scope.items.loc
              color: $scope.items.color
              _ref: $scope.items.region
            $log.info data
            $http(
              method: methodtype              
              url: ServerUrl.getUrl() + modalname
              headers:
                "Content-Type": "application/json"
              data: data                
            ).success((data, status, headers, config) ->                
                $modalInstance.close data
                return 
            ).error (data, status, headers, config) ->
                $modalInstance.dismiss false              

        $scope.cancel = ->
            $modalInstance.dismiss false
            return

        return
])



.controller('PaginationDemoCtrl', [
    '$scope'
    ($scope) ->
        $scope.totalItems = 64
        $scope.currentPage = 4
        $scope.maxSize = 5

        $scope.setPage = (pageNo) ->
            $scope.currentPage = pageNo

        $scope.bigTotalItems = 175
        $scope.bigCurrentPage = 1
])

# .controller('CarouselDemoCtrl', [
#     '$scope'
#     ($scope) ->
#         $scope.myInterval = 5000
#         $scope.slides = [
#             {image: 'images/slides/1.jpg', text: 'Content goes here'}
#             {image: 'images/slides/4.jpg', text: 'More content'}
#             {image: 'images/slides/3.jpg', text: 'Extra content'}
#         ]
# ])

.controller('TabsDemoCtrl', [
    '$scope','$location', '$log'
    ($scope, $location, $log) ->

        $scope.tabs = [
          {
            title: "Dynamic Title 1"
            content: "Dynamic content 1.  Consectetur adipisicing elit. Nihil, quidem, officiis, et ex laudantium sed cupiditate voluptatum libero nobis sit illum voluptates beatae ab. Ad, repellendus non sequi et at."
          }
          {
            title: "Disabled"
            content: "Dynamic content 2.  Lorem ipsum dolor sit amet, consectetur adipisicing elit. Nihil, quidem, officiis, et ex laudantium sed cupiditate voluptatum libero nobis sit illum voluptates beatae ab. Ad, repellendus non sequi et at."
            disabled: true
          }
        ]

        $scope.navType = "pills"
])










