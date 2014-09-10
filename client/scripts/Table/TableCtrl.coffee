'use strict'

angular.module('app.tables', [])

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
            )
            modalInstance.result.then ((items) ->
                $log.info items 
                i = 0
                while i < $scope.regions.length
                  if $scope.regions[i]._id is items
                    delete $scope.regions[i]
                    break
                  i++
                $log.info $scope.regions
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
            )
            modalInstance.result.then ((items) ->                
                $log.info items                
                $scope.regions.push items
                $log.info $scope.regions
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
            )
            modalInstance.result.then ((items) ->
                $log.info items                
                i = 0
                while i < $scope.regions.length
                  if $scope.regions[i]._id is items._id
                    $scope.regions[i] = items
                    break
                  i++
                $log.info $scope.regions
                init()                
                return
            ), ->
                return

            return

        return

])
.controller('tableCtrl', [
    '$scope', '$filter'
    ($scope, $filter) ->
        # filter
        $scope.stores = [
            {name: 'Nijiya Market', price: '$$', sales: 292, rating: 4.0}
            {name: 'Eat On Monday Truck', price: '$', sales: 119, rating: 4.3}
            {name: 'Tea Era', price: '$', sales: 874, rating: 4.0}
            {name: 'Rogers Deli', price: '$', sales: 347, rating: 4.2}
            {name: 'MoBowl', price: '$$$', sales: 24, rating: 4.6}
            {name: 'The Milk Pail Market', price: '$', sales: 543, rating: 4.5}
            {name: 'Nob Hill Foods', price: '$$', sales: 874, rating: 4.0}
            {name: 'Scratch', price: '$$$', sales: 643, rating: 3.6}
            {name: 'Gochi Japanese Fusion Tapas', price: '$$$', sales: 56, rating: 4.1}
            {name: 'Cost Plus World Market', price: '$$', sales: 79, rating: 4.0}
            {name: 'Bumble Bee Health Foods', price: '$$', sales: 43, rating: 4.3}
            {name: 'Costco', price: '$$', sales: 219, rating: 3.6}
            {name: 'Red Rock Coffee Co', price: '$', sales: 765, rating: 4.1}
            {name: '99 Ranch Market', price: '$', sales: 181, rating: 3.4}
            {name: 'Mi Pueblo Food Center', price: '$', sales: 78, rating: 4.0}
            {name: 'Cucina Venti', price: '$$', sales: 163, rating: 3.3}
            {name: 'Sufi Coffee Shop', price: '$', sales: 113, rating: 3.3}
            {name: 'Dana Street Roasting', price: '$', sales: 316, rating: 4.1}
            {name: 'Pearl Cafe', price: '$', sales: 173, rating: 3.4}
            {name: 'Posh Bagel', price: '$', sales: 140, rating: 4.0}
            {name: 'Artisan Wine Depot', price: '$$', sales: 26, rating: 4.1}
            {name: 'Hong Kong Chinese Bakery', price: '$', sales: 182, rating: 3.4}
            {name: 'Starbucks', price: '$$', sales: 97, rating: 3.7}
            {name: 'Tapioca Express', price: '$', sales: 301, rating: 3.0}
            {name: 'House of Bagels', price: '$', sales: 82, rating: 4.4}
        ]
        $scope.searchKeywords = ''
        $scope.filteredStores = []
        $scope.row = ''

        $scope.select = (page) ->
            start = (page - 1) * $scope.numPerPage
            end = start + $scope.numPerPage
            $scope.currentPageStores = $scope.filteredStores.slice(start, end)
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
            $scope.filteredStores = $filter('filter')($scope.stores, $scope.searchKeywords)
            $scope.onFilterChange()

        # orderBy
        $scope.order = (rowName)->
            if $scope.row == rowName
                return
            $scope.row = rowName
            $scope.filteredStores = $filter('orderBy')($scope.stores, rowName)
            # console.log $scope.filteredStores
            $scope.onOrderChange()

        # pagination
        $scope.numPerPageOpt = [3, 5, 10, 20]
        $scope.numPerPage = $scope.numPerPageOpt[2]
        $scope.currentPage = 1
        $scope.currentPageStores = []

        # init
        init = ->
            $scope.search()
            $scope.select($scope.currentPage)
        init()

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
            )
            modalInstance.result.then ((items) ->
                $scope.deleteAction = items 
                init()               
                return
            ), ->
                $log.info "Modal dismissed at: " + new Date()
                return

            return

        return


        #add
        $scope.items = [
            id: ""
            name: ""
            modalType : ""
            modalName : ""
        ]
        $scope.open = (modalName)->
            $scope.items.modalName = modalName                   
            modalInstance = $modal.open(
                templateUrl: "myModalContent.html"
                controller: 'ModalInstanceCtrl'
                resolve:
                    items: ->
                        $scope.items                  
            )
            modalInstance.result.then ((items) ->
                $scope.items = items
                alert $scope.items
                return
            ), ->
                $log.info "Modal dismissed at: " + new Date()
                return

            return

        return
])