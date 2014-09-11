(function() {
  'use strict';
  angular.module('app.ui.ctrls', []).controller('AlertDemoCtrl', [
    '$scope', function($scope) {
      $scope.alerts = [
        {
          type: 'success',
          msg: 'Well done! You successfully read this important alert message.'
        }, {
          type: 'info',
          msg: 'Heads up! This alert needs your attention, but it is not super important.'
        }, {
          type: 'warning',
          msg: "Warning! Best check yo self, you're not looking too good."
        }, {
          type: 'danger',
          msg: 'Oh snap! Change a few things up and try submitting again.'
        }
      ];
      $scope.addAlert = function() {
        var num, type;
        num = Math.ceil(Math.random() * 4);
        type = void 0;
        switch (num) {
          case 0:
            type = 'info';
            break;
          case 1:
            type = 'success';
            break;
          case 2:
            type = 'info';
            break;
          case 3:
            type = 'warning';
            break;
          case 4:
            type = 'danger';
        }
        return $scope.alerts.push({
          type: type,
          msg: "Another alert!"
        });
      };
      return $scope.closeAlert = function(index) {
        return $scope.alerts.splice(index, 1);
      };
    }
  ]).controller('ModalInstanceCtrl', [
    '$scope', '$modalInstance', 'items', '$http', 'ServerUrl', '$log', function($scope, $modalInstance, items, $http, ServerUrl, $log) {
      $scope.items = items;
      $scope.isRegion = false;
      $scope.isArea = false;
      $scope.isTeritory = false;
      $scope.isBrick = false;
      $scope.isLocation = false;
      if ($scope.items.modalName === 'region') {
        $scope.isRegion = true;
        $scope.isArea = false;
        $scope.isTeritory = false;
        $scope.isBrick = false;
        $scope.isLocation = false;
      } else if ($scope.items.modalName === 'area') {
        $scope.isRegion = false;
        $scope.isArea = true;
        $scope.isTeritory = false;
        $scope.isBrick = false;
        $scope.isLocation = false;
      } else if ($scope.items.modalName === 'territory') {
        $scope.isRegion = false;
        $scope.isArea = false;
        $scope.isTeritory = true;
        $scope.isBrick = false;
        $scope.isLocation = false;
      } else if ($scope.items.modalName === 'brick') {
        $scope.isRegion = false;
        $scope.isArea = false;
        $scope.isTeritory = false;
        $scope.isBrick = true;
        $scope.isLocation = false;
      } else if ($scope.items.modalName === 'location') {
        $scope.isRegion = false;
        $scope.isArea = false;
        $scope.isTeritory = false;
        $scope.isBrick = false;
        $scope.isLocation = true;
      }
      $scope.ok = function() {
        var data, methodtype, modalname;
        modalname = $scope.items.modalName;
        methodtype = ($scope.items.id === "" ? "post" : "put");
        data = {};
        data[modalname] = {
          _id: $scope.items.id,
          name: $scope.items.name,
          code: $scope.items.code
        };
        return $http({
          method: methodtype,
          url: ServerUrl.getUrl() + modalname,
          headers: {
            "Content-Type": "application/json"
          },
          data: data
        }).success(function(data, status, headers, config) {
          $modalInstance.close(data);
        }).error(function(data, status, headers, config) {
          return $modalInstance.dismiss("cancel");
        });
      };
      $scope.cancel = function() {
        $scope.isRegion = false;
        $scope.isArea = false;
        $scope.isTeritory = false;
        $scope.isBrick = false;
        $scope.isLocation = false;
        $modalInstance.dismiss("cancel");
      };
    }
  ]).controller('ModalCategoryInstanceCtrl', [
    '$scope', '$modalInstance', 'items', '$http', 'ServerUrl', '$log', function($scope, $modalInstance, items, $http, ServerUrl, $log) {
      $scope.items = items;
      $scope.ok = function() {
        var data, methodtype, modalname;
        modalname = $scope.items.modalName;
        methodtype = ($scope.items.id === "" ? "post" : "put");
        data = {};
        data[modalname] = {
          _id: $scope.items.id,
          name: $scope.items.name,
          description: $scope.items.desc,
          icon: $scope.items.icon
        };
        return $http({
          method: methodtype,
          url: ServerUrl.getUrl() + modalname,
          headers: {
            "Content-Type": "application/json"
          },
          data: data
        }).success(function(data, status, headers, config) {
          $modalInstance.close(data);
        }).error(function(data, status, headers, config) {
          return $modalInstance.dismiss("cancel");
        });
      };
      $scope.cancel = function() {
        $modalInstance.dismiss("cancel");
      };
    }
  ]).controller('ModalUserInstanceCtrl', [
    '$scope', '$modalInstance', 'items', '$http', 'ServerUrl', '$log', function($scope, $modalInstance, items, $http, ServerUrl, $log) {
      $scope.items = items;
      $scope.ok = function() {
        var data, methodtype, modalname;
        modalname = $scope.items.modalName;
        methodtype = ($scope.items.id === "" ? "post" : "put");
        data = {};
        data[modalname] = {
          _id: $scope.items.id,
          name: $scope.items.name,
          designation: $scope.items.designation,
          email: $scope.items.email,
          is_authorized: $scope.items.is_authorized,
          is_admin: $scope.items.is_admin
        };
        return $http({
          method: methodtype,
          url: ServerUrl.getUrl() + modalname,
          headers: {
            "Content-Type": "application/json"
          },
          data: data
        }).success(function(data, status, headers, config) {
          $modalInstance.close(data);
        }).error(function(data, status, headers, config) {
          return $modalInstance.dismiss("cancel");
        });
      };
      $scope.cancel = function() {
        $modalInstance.dismiss("cancel");
      };
    }
  ]).controller('ModalDeleteInstanceCtrl', [
    '$scope', '$modalInstance', 'items', '$http', 'ServerUrl', function($scope, $modalInstance, items, $http, ServerUrl) {
      $scope.items = items;
      $scope.confirm = function() {
        return $http({
          method: "delete",
          url: ServerUrl.getUrl() + $scope.items.modalName + "/" + $scope.items.id
        }).success(function(data, status, headers, config) {
          return $modalInstance.close($scope.items);
        }).error(function(data, status, headers, config) {
          return $modalInstance.dismiss("cancel");
        });
      };
      $scope.cancel = function() {
        $modalInstance.dismiss("cancel");
      };
    }
  ]).controller('PaginationDemoCtrl', [
    '$scope', function($scope) {
      $scope.totalItems = 64;
      $scope.currentPage = 4;
      $scope.maxSize = 5;
      $scope.setPage = function(pageNo) {
        return $scope.currentPage = pageNo;
      };
      $scope.bigTotalItems = 175;
      return $scope.bigCurrentPage = 1;
    }
  ]).controller('TabsDemoCtrl', [
    '$scope', '$location', '$log', 'Session', function($scope, $location, $log, Session) {
      $scope.tabs = [
        {
          title: "Dynamic Title 1",
          content: "Dynamic content 1.  Consectetur adipisicing elit. Nihil, quidem, officiis, et ex laudantium sed cupiditate voluptatum libero nobis sit illum voluptates beatae ab. Ad, repellendus non sequi et at."
        }, {
          title: "Disabled",
          content: "Dynamic content 2.  Lorem ipsum dolor sit amet, consectetur adipisicing elit. Nihil, quidem, officiis, et ex laudantium sed cupiditate voluptatum libero nobis sit illum voluptates beatae ab. Ad, repellendus non sequi et at.",
          disabled: true
        }
      ];
      return $scope.navType = "pills";
    }
  ]).controller('MapDemoCtrl', [
    '$scope', '$http', '$interval', function($scope, $http, $interval) {
      var i, markers;
      markers = [];
      i = 0;
      while (i < 8) {
        markers[i] = new google.maps.Marker({
          title: "Marker: " + i
        });
        i++;
      }
      $scope.GenerateMapMarkers = function() {
        var d, lat, lng, loc, numMarkers;
        d = new Date();
        $scope.date = d.toLocaleString();
        numMarkers = Math.floor(Math.random() * 4) + 4;
        i = 0;
        while (i < numMarkers) {
          lat = 43.6600000 + (Math.random() / 100);
          lng = -79.4103000 + (Math.random() / 100);
          loc = new google.maps.LatLng(lat, lng);
          markers[i].setPosition(loc);
          markers[i].setMap($scope.map);
          i++;
        }
      };
      $interval($scope.GenerateMapMarkers, 2000);
    }
  ]);

}).call(this);
