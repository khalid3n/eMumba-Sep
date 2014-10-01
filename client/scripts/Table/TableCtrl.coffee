'use strict'

angular.module('app.tables', ['app.map'])

#Region
.controller('tableRegionCtrl', [
    '$scope', '$filter', '$http', 'ServerUrl', '$log','$modal'
    ($scope, $filter, $http, ServerUrl, $log, $modal) ->
        # filter

        $scope.regions = []
        $http(          
          url: ServerUrl.getUrl() + "region"                           
        ).success((data, status, headers, config) ->               
            $scope.regions = data
            init()
        ).error (data, status, headers, config) ->
           

        $scope.searchKeywords = ''
        $scope.filteredRegions = []
        $scope.row = ''

        $scope.select = (page) ->
            start = (page - 1) * $scope.numPerPage
            end = start + $scope.numPerPage
            $scope.currentPageRegions = $scope.filteredRegions.slice(start, end)
            # console.log start
            # console.log end
            # console.log $scope.currentPageStores

        # on page change: change numPerPage, filtering string
        $scope.onFilterChange = ->
            $scope.select(1)
            $scope.currentPage = 1
            $scope.row = ''

        $scope.onNumPerPageChange = ->
            $scope.select(1)
            $scope.currentPage = 1

        $scope.onOrderChange = ->
            $scope.select(1)
            $scope.currentPage = 1            


        $scope.search = ->
            $scope.filteredRegions = $filter('filter')($scope.regions, $scope.searchKeywords)
            $scope.onFilterChange()

        # orderBy
        $scope.order = (rowName)->
            if $scope.row == rowName
                return
            $scope.row = rowName
            $scope.filteredRegions = $filter('orderBy')($scope.regions, rowName)
            # console.log $scope.filteredRegions
            $scope.onOrderChange()

        # pagination
        $scope.numPerPageOpt = [3, 5, 10, 20]
        $scope.numPerPage = $scope.numPerPageOpt[2]
        $scope.currentPage = 1
        $scope.currentPageRegions = []

        # init
        init = ->
            $scope.search()
            $scope.select($scope.currentPage)
        
        #delete
        $scope.deleteAction = [
            id: ""            
            modalName : ""
        ]
        
        $scope.delete = (modalName,id)->
            $scope.deleteAction.modalName = modalName 
            $scope.deleteAction.id = id                   
            modalInstance = $modal.open(
                templateUrl: "ModalDeleteContent.html"
                controller: 'ModalDeleteInstanceCtrl'
                resolve:
                    items: ->
                        $scope.deleteAction      
                    data: ->
                        $scope.data                
            )
            modalInstance.result.then ((items) ->
                
                i = 0
                while i < $scope.regions.length
                  if $scope.regions[i]._id is items.id
                    delete $scope.regions[i]
                    break
                  i++
                
                init()               
                return
            ), ->                
                return

            return

        $scope.items = [
            id: ''
            code: ''
            name: ''
            modalType : ''
            modalName : ''
        ]
        $scope.open = (modalName)->
            $scope.items.modalName = modalName  
            $scope.items.id = ''  
            $log.info "here"               
            modalInstance = $modal.open(
                templateUrl: "myModalContent.html"
                controller: 'ModalInstanceCtrl'
                resolve:
                    items: ->
                        $scope.items 
                    data: -> 
                        $scope.data                 
            )
            modalInstance.result.then ((items) ->                                
                $scope.regions.push items
                init()                  
                return
            ), ->                
                return

            return

        

        #edit
        $scope.edit = (modalName, id, code, name)->
            $scope.items.modalName = modalName  
            $scope.items.id = id
            $scope.items.code = code
            $scope.items.name = name                 
            modalInstance = $modal.open(
                templateUrl: "myModalContent.html"
                controller: 'ModalInstanceCtrl'
                resolve:
                    items: ->
                        $scope.items
                    data: -> 
                        $scope.data                    
            )
            modalInstance.result.then ((items) ->                
                i = 0
                while i < $scope.regions.length
                  if $scope.regions[i]._id is items._id
                    $scope.regions[i] = items
                    break
                  i++
                init()                
                return
            ), ->
                return

            return

        return

])

#Area
.controller('tableAreaCtrl', [
    '$scope', '$filter', '$http', 'ServerUrl', '$log','$modal'
    ($scope, $filter, $http, ServerUrl, $log, $modal) ->
        # filter

        $scope.areas = []
        $http(          
          url: ServerUrl.getUrl() + "area"                           
        ).success((data, status, headers, config) ->               
            $scope.areas = data
            init()
        ).error (data, status, headers, config) ->
           

        $scope.searchKeywords = ''
        $scope.filteredAreas = []
        $scope.row = ''

        $scope.select = (page) ->
            start = (page - 1) * $scope.numPerPage
            end = start + $scope.numPerPage
            $scope.currentPageAreas = $scope.filteredAreas.slice(start, end)
            # console.log start
            # console.log end
            # console.log $scope.currentPageStores

        # on page change: change numPerPage, filtering string
        $scope.onFilterChange = ->
            $scope.select(1)
            $scope.currentPage = 1
            $scope.row = ''

        $scope.onNumPerPageChange = ->
            $scope.select(1)
            $scope.currentPage = 1

        $scope.onOrderChange = ->
            $scope.select(1)
            $scope.currentPage = 1            


        $scope.search = ->
            $scope.filteredAreas = $filter('filter')($scope.areas, $scope.searchKeywords)
            $scope.onFilterChange()

        # orderBy
        $scope.order = (rowName)->
            if $scope.row == rowName
                return
            $scope.row = rowName
            $scope.filteredAreas = $filter('orderBy')($scope.areas, rowName)
            # console.log $scope.filteredRegions
            $scope.onOrderChange()

        # pagination
        $scope.numPerPageOpt = [3, 5, 10, 20]
        $scope.numPerPage = $scope.numPerPageOpt[2]
        $scope.currentPage = 1
        $scope.currentPageAreas = []

        # init
        init = ->
            $scope.search()
            $scope.select($scope.currentPage)
        
        #delete
        $scope.deleteAction = [
            id: ""            
            modalName : ""
        ]
        
        $scope.delete = (modalName,id)->
            $scope.deleteAction.modalName = modalName 
            $scope.deleteAction.id = id                   
            modalInstance = $modal.open(
                templateUrl: "ModalDeleteContent.html"
                controller: 'ModalDeleteInstanceCtrl'
                resolve:
                    items: ->
                        $scope.deleteAction 
                    data: ->
                        $scope.data                 
            )
            modalInstance.result.then ((items) ->
                
                i = 0
                while i < $scope.areas.length
                  if $scope.areas[i]._id is items.id
                    delete $scope.areas[i]
                    break
                  i++
                
                init()               
                return
            ), ->                
                return

            return

        



        $scope.items = [
            id: ''
            code: ''
            name: ''
            modalType : ''
            modalName : ''
        ]
        $scope.open = (modalName)->
            $scope.items.modalName = modalName  
            $scope.items.id = ''                 
            modalInstance = $modal.open(
                templateUrl: "myModalContent.html"
                controller: 'ModalInstanceCtrl'
                resolve:
                    items: ->
                        $scope.items 
                    data: ->
                        $scope.data                 
            )
            modalInstance.result.then ((items) -> 
                $log.info items                         
                $scope.areas.push items
                init()                  
                return
            ), ->                
                return

            return

        

        #edit
        $scope.edit = (modalName, id, code, name, region)->
            $scope.items.modalName = modalName  
            $scope.items.id = id
            $scope.items.code = code
            $scope.items.name = name
            $scope.items.region = region 
            $log.info $scope.items.region            
            modalInstance = $modal.open(
                templateUrl: "myModalContent.html"
                controller: 'ModalInstanceCtrl'
                resolve:
                    items: ->
                        $scope.items
                    data: ->
                        $scope.data                 
            )
            modalInstance.result.then ((items) ->
               # $log.info items                
                i = 0
                while i < $scope.areas.length
                  if $scope.areas[i]._id is items._id
                    $scope.areas[i] = items
                    break
                  i++
               # $log.info $scope.regions
                init()                
                return
            ), ->
                return

            return

        return

])

#Territory
.controller('tableTerritoryCtrl', [
    '$scope', '$filter', '$http', 'ServerUrl', '$log','$modal','$location', '$interval' , 'MapAddress'
    ($scope, $filter, $http, ServerUrl, $log, $modal, $location, $interval, MapAddress) ->
        # filter

        $scope.territorys = []
        $http(          
          url: ServerUrl.getUrl() + "territory"                           
        ).success((data, status, headers, config) ->               
            $scope.territorys = data
            init()
        ).error (data, status, headers, config) ->
           

        $scope.searchKeywords = ''
        $scope.filteredTerritorys = []
        $scope.row = ''

        $scope.select = (page) ->
            start = (page - 1) * $scope.numPerPage
            end = start + $scope.numPerPage
            $scope.currentPageTerritorys = $scope.filteredTerritorys.slice(start, end)
            # console.log start
            # console.log end
            # console.log $scope.currentPageStores

        # on page change: change numPerPage, filtering string
        $scope.onFilterChange = ->
            $scope.select(1)
            $scope.currentPage = 1
            $scope.row = ''

        $scope.onNumPerPageChange = ->
            $scope.select(1)
            $scope.currentPage = 1

        $scope.onOrderChange = ->
            $scope.select(1)
            $scope.currentPage = 1            


        $scope.search = ->
            $scope.filteredTerritorys = $filter('filter')($scope.territorys, $scope.searchKeywords)
            $scope.onFilterChange()

        # orderBy
        $scope.order = (rowName)->
            if $scope.row == rowName
                return
            $scope.row = rowName
            $scope.filteredTerritorys = $filter('orderBy')($scope.territorys, rowName)
            # console.log $scope.filteredRegions
            $scope.onOrderChange()

        # pagination
        $scope.numPerPageOpt = [3, 5, 10, 20]
        $scope.numPerPage = $scope.numPerPageOpt[2]
        $scope.currentPage = 1
        $scope.currentPageTerritorys = []

        # init
        init = ->
            $scope.search()
            $scope.select($scope.currentPage)
        
        #delete
        $scope.deleteAction = [
            id: ""            
            modalName : ""
        ]
        
        $scope.delete = (modalName,id)->
            $scope.deleteAction.modalName = modalName 
            $scope.deleteAction.id = id                   
            modalInstance = $modal.open(
                templateUrl: "ModalDeleteContent.html"
                controller: 'ModalDeleteInstanceCtrl'
                resolve:
                    items: ->
                        $scope.deleteAction
                    data: ->
                        $scope.data                 
            )
            modalInstance.result.then ((items) ->
                
                i = 0
                while i < $scope.territorys.length
                  if $scope.territorys[i]._id is items.id
                    delete $scope.territorys[i]
                    break
                  i++
                
                init()               
                return
            ), ->                
                return

            return

        



        $scope.items = [
            id: ''
            code: ''
            name: ''
            modalType : ''
            modalName : ''
        ]
        $scope.open = (modalName)->
            $scope.items.modalName = modalName  
            $scope.items.id = ''                 
            modalInstance = $modal.open(
                templateUrl: "myModalContent.html"
                controller: 'ModalInstanceCtrl'
                resolve:
                    items: ->
                        $scope.items 
                    data: -> 
                        $scope.data                 
            )
            modalInstance.result.then ((items) ->                
                #$log.info items                
                $scope.territorys.push items
                #$log.info $scope.regions
                init()                  
                return
            ), ->                
                return

            return

        

        #edit
        $scope.edit = (modalName,id,code,name)->
            $scope.items.modalName = modalName  
            $scope.items.id = id
            $scope.items.code = code
            $scope.items.name = name                 
            modalInstance = $modal.open(
                templateUrl: "myModalContent.html"
                controller: 'ModalInstanceCtrl'
                resolve:
                    items: ->
                        $scope.items
                    data: ->
                        $scope.data                  
            )
            modalInstance.result.then ((items) ->
               # $log.info items                
                i = 0
                while i < $scope.territorys.length
                  if $scope.territorys[i]._id is items._id
                    $scope.territorys[i] = items
                    break
                  i++
               # $log.info $scope.regions
                init()                
                return
            ), ->
                return

            return

        #map
        $scope.mapView = (territoryAdrs)->            
            MapAddress.setMapAddress(territoryAdrs)            
            $location.path('/maps/gmap') 
            
        return

])



#Category

.controller('tableCategoriesCtrl', [
    '$scope', '$filter', '$http', 'ServerUrl', '$log','$modal'
    ($scope, $filter, $http, ServerUrl, $log, $modal) ->
        # filter

        $scope.categories = []
        $http(          
          url: ServerUrl.getUrl() + "category"                           
        ).success((data, status, headers, config) ->               
            $scope.categories = data
            init()
        ).error (data, status, headers, config) ->
           

        $scope.searchKeywords = ''
        $scope.filteredCategories = []
        $scope.row = ''

        $scope.select = (page) ->
            start = (page - 1) * $scope.numPerPage
            end = start + $scope.numPerPage
            $scope.currentPageCategories = $scope.filteredCategories.slice(start, end)
            # console.log start
            # console.log end
            # console.log $scope.currentPageStores

        # on page change: change numPerPage, filtering string
        $scope.onFilterChange = ->
            $scope.select(1)
            $scope.currentPage = 1
            $scope.row = ''

        $scope.onNumPerPageChange = ->
            $scope.select(1)
            $scope.currentPage = 1

        $scope.onOrderChange = ->
            $scope.select(1)
            $scope.currentPage = 1            


        $scope.search = ->
            $scope.filteredCategories = $filter('filter')($scope.categories, $scope.searchKeywords)
            $scope.onFilterChange()

        # orderBy
        $scope.order = (rowName)->
            if $scope.row == rowName
                return
            $scope.row = rowName
            $scope.filteredCategories = $filter('orderBy')($scope.categories, rowName)
            # console.log $scope.filteredRegions
            $scope.onOrderChange()

        # pagination
        $scope.numPerPageOpt = [3, 5, 10, 20]
        $scope.numPerPage = $scope.numPerPageOpt[2]
        $scope.currentPage = 1
        $scope.currentPageCategories = []

        # init
        init = ->
            $scope.search()
            $scope.select($scope.currentPage)
        
        #delete
        $scope.deleteAction = [
            id: ""            
            modalName : ""
        ]
        
        $scope.delete = (modalName,id)->
            $scope.deleteAction.modalName = modalName 
            $scope.deleteAction.id = id                   
            modalInstance = $modal.open(
                templateUrl: "ModalDeleteContent.html"
                controller: 'ModalDeleteInstanceCtrl'
                resolve:
                    items: ->
                        $scope.deleteAction 
                    data: ->
                        $scope.data                 
            )
            modalInstance.result.then ((items) ->
                
                i = 0
                while i < $scope.categories.length
                  if $scope.categories[i]._id is items.id
                    delete $scope.categories[i]
                    break
                  i++
                
                init()               
                return
            ), ->                
                return

            return

        



        $scope.items = [
            id: ''
            desc: ''
            name: ''
            icon: ''
            modalType : ''
            modalName : ''
        ]
        $scope.open = (modalName)->
            $scope.items.modalName = modalName  
            $scope.items.id = ''                 
            modalInstance = $modal.open(
                templateUrl: "categoryModalContent.html"
                controller: 'ModalCategoryInstanceCtrl'
                resolve:
                    items: ->
                        $scope.items                  
            )
            modalInstance.result.then ((items) ->                
                #$log.info items                
                $scope.categories.push items
                #$log.info $scope.regions
                init()                  
                return
            ), ->                
                return

            return

        

        #edit
        $scope.edit = (modalName,id,name,desc,icon)->
            $scope.items.modalName = modalName  
            $scope.items.id = id
            $scope.items.desc = desc
            $scope.items.name = name 
            $scope.items.icon = icon                 
            modalInstance = $modal.open(
                templateUrl: "categoryModalContent.html"
                controller: 'ModalCategoryInstanceCtrl'
                resolve:
                    items: ->
                        $scope.items
                    data: -> 
                        $scope.data                
            )
            modalInstance.result.then ((items) ->
               # $log.info items                
                i = 0
                while i < $scope.categories.length
                  if $scope.categories[i]._id is items._id
                    $scope.categories[i] = items
                    break
                  i++
               # $log.info $scope.regions
                init()                
                return
            ), ->
                return

            return

        return

])

#Bricks
.controller('tableBrickCtrl', [
    '$scope', '$filter', '$http', 'ServerUrl', '$log','$modal'
    ($scope, $filter, $http, ServerUrl, $log, $modal) ->

        $scope.bricks = []
        $http(          
          url: ServerUrl.getUrl() + "brick"                           
        ).success((data, status, headers, config) ->               
            $scope.bricks = data
            init()
        ).error (data, status, headers, config) ->
           

        $scope.searchKeywords = ''
        $scope.filteredBricks = []
        $scope.row = ''

        $scope.select = (page) ->
            start = (page - 1) * $scope.numPerPage
            end = start + $scope.numPerPage
            $scope.currentPageBricks = $scope.filteredBricks.slice(start, end)
            # console.log start
            # console.log end
            # console.log $scope.currentPageStores

        # on page change: change numPerPage, filtering string
        $scope.onFilterChange = ->
            $scope.select(1)
            $scope.currentPage = 1
            $scope.row = ''

        $scope.onNumPerPageChange = ->
            $scope.select(1)
            $scope.currentPage = 1

        $scope.onOrderChange = ->
            $scope.select(1)
            $scope.currentPage = 1            


        $scope.search = ->
            $scope.filteredBricks = $filter('filter')($scope.bricks, $scope.searchKeywords)
            $scope.onFilterChange()

        # orderBy
        $scope.order = (rowName)->
            if $scope.row == rowName
                return
            $scope.row = rowName
            $scope.filteredBricks = $filter('orderBy')($scope.bricks, rowName)
            # console.log $scope.filteredRegions
            $scope.onOrderChange()

        # pagination
        $scope.numPerPageOpt = [3, 5, 10, 20]
        $scope.numPerPage = $scope.numPerPageOpt[2]
        $scope.currentPage = 1
        $scope.currentPageBricks = []

        # init
        init = ->
            $scope.search()
            $scope.select($scope.currentPage)
        
        #delete
        $scope.deleteAction = [
            id: ""            
            modalName : ""
        ]
        
        $scope.delete = (modalName,id)->
            $scope.deleteAction.modalName = modalName 
            $scope.deleteAction.id = id                   
            modalInstance = $modal.open(
                templateUrl: "ModalDeleteContent.html"
                controller: 'ModalDeleteInstanceCtrl'
                resolve:
                    items: ->
                        $scope.deleteAction 
                    data: -> 
                        $scope.data                
            )
            modalInstance.result.then ((items) ->
                
                i = 0
                while i < $scope.bricks.length
                  if $scope.bricks[i]._id is items.id
                    delete $scope.bricks[i]
                    break
                  i++
                
                init()               
                return
            ), ->                
                return

            return

        



        $scope.items = [
            id: ''
            code: ''
            name: ''
            modalType : ''
            modalName : ''
        ]
        $scope.open = (modalName)->
            $scope.items.modalName = modalName  
            $scope.items.id = ''                 
            modalInstance = $modal.open(
                templateUrl: "myModalContent.html"
                controller: 'ModalInstanceCtrl'
                resolve:
                    items: ->
                        $scope.items 
                    data: -> 
                        $scope.data                 
            )
            modalInstance.result.then ((items) ->                
                #$log.info items                
                $scope.bricks.push items
                #$log.info $scope.regions
                init()                  
                return
            ), ->                
                return

            return

        

        #edit
        $scope.edit = (modalName,id,code,name)->
            $scope.items.modalName = modalName  
            $scope.items.id = id
            $scope.items.code = code
            $scope.items.name = name                 
            modalInstance = $modal.open(
                templateUrl: "myModalContent.html"
                controller: 'ModalInstanceCtrl'
                resolve:
                    items: ->
                        $scope.items
                    data: -> 
                        $scope.data                  
            )
            modalInstance.result.then ((items) ->
               # $log.info items                
                i = 0
                while i < $scope.bricks.length
                  if $scope.bricks[i]._id is items._id
                    $scope.bricks[i] = items
                    break
                  i++
               # $log.info $scope.regions
                init()                
                return
            ), ->
                return

            return

        return

])

#Locations
.controller('tableLocationCtrl', [
    '$scope', '$filter', '$http', 'ServerUrl', '$log','$modal'
    ($scope, $filter, $http, ServerUrl, $log, $modal) ->

        $scope.locations = []
        $http(          
          url: ServerUrl.getUrl() + "location"                           
        ).success((data, status, headers, config) ->               
            $scope.locations = data
            init()
        ).error (data, status, headers, config) ->
           

        $scope.searchKeywords = ''
        $scope.filteredLocations = []
        $scope.row = ''

        $scope.select = (page) ->
            start = (page - 1) * $scope.numPerPage
            end = start + $scope.numPerPage
            $scope.currentPageLocations = $scope.filteredLocations.slice(start, end)
            # console.log start
            # console.log end
            # console.log $scope.currentPageStores

        # on page change: change numPerPage, filtering string
        $scope.onFilterChange = ->
            $scope.select(1)
            $scope.currentPage = 1
            $scope.row = ''

        $scope.onNumPerPageChange = ->
            $scope.select(1)
            $scope.currentPage = 1

        $scope.onOrderChange = ->
            $scope.select(1)
            $scope.currentPage = 1            


        $scope.search = ->
            $scope.filteredLocations = $filter('filter')($scope.locations, $scope.searchKeywords)
            $scope.onFilterChange()

        # orderBy
        $scope.order = (rowName)->
            if $scope.row == rowName
                return
            $scope.row = rowName
            $scope.filteredLocations = $filter('orderBy')($scope.locations, rowName)
            $scope.onOrderChange()

        # pagination
        $scope.numPerPageOpt = [3, 5, 10, 20]
        $scope.numPerPage = $scope.numPerPageOpt[2]
        $scope.currentPage = 1
        $scope.currentPageLocations = []

        # init
        init = ->
            $scope.search()
            $scope.select($scope.currentPage)
        
        #delete
        $scope.deleteAction = [
            id: ""            
            modalName : ""
        ]
        
        $scope.delete = (modalName,id)->
            $scope.deleteAction.modalName = modalName 
            $scope.deleteAction.id = id                   
            modalInstance = $modal.open(
                templateUrl: "ModalDeleteContent.html"
                controller: 'ModalDeleteInstanceCtrl'
                resolve:
                    items: ->
                        $scope.deleteAction
                    data: ->
                        $scope.data               
            )
            modalInstance.result.then ((items) ->
                
                i = 0
                while i < $scope.locations.length
                  if $scope.locations[i]._id is items.id
                    delete $scope.locations[i]
                    break
                  i++
                
                init()               
                return
            ), ->                
                return

            return    



        $scope.items = [
            id: ''
            code: ''
            name: ''
            modalType : ''
            modalName : ''
        ]
        $scope.open = (modalName)->
            $scope.items.modalName = modalName  
            $scope.items.id = ''                 
            modalInstance = $modal.open(
                templateUrl: "myModalContent.html"
                controller: 'ModalInstanceCtrl'
                resolve:
                    items: ->
                        $scope.items 
                    data: -> 
                        $scope.data                 
            )
            modalInstance.result.then ((items) ->                              
                $scope.locations.push items
                #$log.info $scope.regions
                init()                  
                return
            ), ->                
                return

            return

        

        #edit
        $scope.edit = (modalName,id,code,name)->
            $scope.items.modalName = modalName  
            $scope.items.id = id
            $scope.items.code = code
            $scope.items.name = name                 
            modalInstance = $modal.open(
                templateUrl: "myModalContent.html"
                controller: 'ModalInstanceCtrl'
                resolve:
                    items: ->
                        $scope.items  
                    data: ->
                        $scope.data                  
            )
            modalInstance.result.then ((items) ->
               # $log.info items                
                i = 0
                while i < $scope.locations.length
                  if $scope.locations[i]._id is items._id
                    $scope.locations[i] = items
                    break
                  i++
               # $log.info $scope.regions
                init()                
                return
            ), ->
                return

            return

        return

])



#Users

.controller('tableUsersCtrl', [
    '$scope', '$filter', '$http', 'ServerUrl', '$log','$modal'
    ($scope, $filter, $http, ServerUrl, $log, $modal) ->
        # filter

        $scope.users = []
        $http(          
          url: ServerUrl.getUrl() + "user"                           
        ).success((data, status, headers, config) ->               
            $scope.users = data
            init()
        ).error (data, status, headers, config) ->
           

        $scope.searchKeywords = ''
        $scope.filteredUsers = []
        $scope.row = ''

        $scope.select = (page) ->
            start = (page - 1) * $scope.numPerPage
            end = start + $scope.numPerPage
            $scope.currentPageUsers = $scope.filteredUsers.slice(start, end)
            # console.log start
            # console.log end
            # console.log $scope.currentPageStores

        # on page change: change numPerPage, filtering string
        $scope.onFilterChange = ->
            $scope.select(1)
            $scope.currentPage = 1
            $scope.row = ''

        $scope.onNumPerPageChange = ->
            $scope.select(1)
            $scope.currentPage = 1

        $scope.onOrderChange = ->
            $scope.select(1)
            $scope.currentPage = 1            


        $scope.search = ->
            $scope.filteredUsers = $filter('filter')($scope.users, $scope.searchKeywords)
            $scope.onFilterChange()

        # orderBy
        $scope.order = (rowName)->
            if $scope.row == rowName
                return
            $scope.row = rowName
            $scope.filteredUsers = $filter('orderBy')($scope.users, rowName)
            # console.log $scope.filteredRegions
            $scope.onOrderChange()

        # pagination
        $scope.numPerPageOpt = [3, 5, 10, 20]
        $scope.numPerPage = $scope.numPerPageOpt[2]
        $scope.currentPage = 1
        $scope.currentPageUsers = []

        # init
        init = ->
            $scope.search()
            $scope.select($scope.currentPage)
        
        #delete
        $scope.deleteAction = [
            id: ""            
            modalName : ""
        ]
        
        $scope.delete = (modalName,id)->
            $scope.deleteAction.modalName = modalName 
            $scope.deleteAction.id = id                   
            modalInstance = $modal.open(
                templateUrl: "ModalDeleteContent.html"
                controller: 'ModalDeleteInstanceCtrl'
                resolve:
                    items: ->
                        $scope.deleteAction
                    data: ->
                        $scope.data                
            )
            modalInstance.result.then ((items) ->
                
                i = 0
                while i < $scope.users.length
                  if $scope.users[i]._id is items.id
                    delete $scope.users[i]
                    break
                  i++
                
                init()               
                return
            ), ->                
                return

            return

        



        $scope.items = [
            id: ''
            designation: ''
            name: ''
            email: ''
            is_admin: false
            is_authorized: false
            modalType : ''
            modalName : ''
        ]
        $scope.open = (modalName)->
            $scope.items.modalName = modalName  
            $scope.items.id = ''                 
            modalInstance = $modal.open(
                templateUrl: "userModalContent.html"
                controller: 'ModalUserInstanceCtrl'
                resolve:
                    items: ->
                        $scope.items
                    data: ->
                        $scope.data                 
            )
            modalInstance.result.then ((items) ->                
                #$log.info items                
                $scope.users.push items
                #$log.info $scope.regions
                init()                  
                return
            ), ->                
                return

            return

        

        #edit
        $scope.edit = (modalName,id,name,designation,email,is_authorized,is_admin)->
            $scope.items.modalName = modalName  
            $scope.items.id = id
            $scope.items.designation = designation
            $scope.items.name = name 
            $scope.items.email = email        
            $scope.items.is_authorized = is_authorized  
            $scope.items.is_admin = is_admin         
            modalInstance = $modal.open(
                templateUrl: "userModalContent.html"
                controller: 'ModalUserInstanceCtrl'
                resolve:
                    items: ->
                        $scope.items 
                    data: -> 
                        $scope.data                
            )
            modalInstance.result.then ((items) ->
               # $log.info items                
                i = 0
                while i < $scope.users.length
                  if $scope.users[i]._id is items._id
                    $scope.users[i] = items
                    break
                  i++
               # $log.info $scope.regions
                init()                
                return
            ), ->
                return

            return


        #check edit
        $scope.checkEdit = (modalName,id,name,designation,email,is_authorized,is_admin)->
            modalname = modalName            
            data = {}
            data[modalname] =
              _id: id
              name: name
              designation: designation
              email: email
              is_authorized: is_authorized
              is_admin: is_admin
            
            $http(
              method: 'put'          
              url: ServerUrl.getUrl() + modalname
              headers:
                "Content-Type": "application/json"
              data: data                
            ).success((data, status, headers, config) ->                
                i = 0
                while i < $scope.users.length
                  if $scope.users[i]._id is data._id
                    $scope.users[i] = data
                    break
                  i++
               # $log.info $scope.regions
                init() 
                return 
            ).error (data, status, headers, config) ->

        

        #check toggle authorize
        $scope.toggleAuthorize = (is_checked, userId, email) ->         
            data = {"id": userId, "email": email}
                    
            
            if is_checked
                urlString = "user/authorize"
            else 
                urlString = "user/restrict"

            $http(
              method: 'post'          
              url: ServerUrl.getUrl() + urlString
              headers:
                "Content-Type": "application/json"
              data: data
            ).success((data, status, headers, config) ->                
                i = 0
                while i < $scope.users.length
                  if $scope.users[i]._id is data._id
                    $scope.users[i] = data
                    break
                  i++
                init() 
                return 
            ).error (data, status, headers, config) ->



        #check toggle Admin
        $scope.toggleAdmin = (is_checked, userId)->
            urlString = ""           
            data = {"id": userId}
            
            if is_checked
                urlString = "user/makeadmin"
            else 
                urlString = "user/restrictadmin"

            $http(
              method: 'post'          
              url: ServerUrl.getUrl() + urlString
              headers:
                "Content-Type": "application/json"
              data: data
            ).success((data, status, headers, config) ->                
                i = 0
                while i < $scope.users.length
                  if $scope.users[i]._id is data._id
                    $scope.users[i] = data
                    break
                  i++
                init() 
                return 
            ).error (data, status, headers, config) ->
                


        return

])
