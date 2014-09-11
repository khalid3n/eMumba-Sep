(function() {
  'use strict';
  angular.module('app.tables', []).controller('tableRegionCtrl', [
    '$scope', '$filter', '$http', 'ServerUrl', '$log', '$modal', function($scope, $filter, $http, ServerUrl, $log, $modal) {
      var init;
      $scope.regions = [];
      $http({
        url: ServerUrl.getUrl() + "region"
      }).success(function(data, status, headers, config) {
        $scope.regions = data;
        return init();
      }).error(function(data, status, headers, config) {});
      $scope.searchKeywords = '';
      $scope.filteredRegions = [];
      $scope.row = '';
      $scope.select = function(page) {
        var end, start;
        start = (page - 1) * $scope.numPerPage;
        end = start + $scope.numPerPage;
        return $scope.currentPageRegions = $scope.filteredRegions.slice(start, end);
      };
      $scope.onFilterChange = function() {
        $scope.select(1);
        $scope.currentPage = 1;
        return $scope.row = '';
      };
      $scope.onNumPerPageChange = function() {
        $scope.select(1);
        return $scope.currentPage = 1;
      };
      $scope.onOrderChange = function() {
        $scope.select(1);
        return $scope.currentPage = 1;
      };
      $scope.search = function() {
        $scope.filteredRegions = $filter('filter')($scope.regions, $scope.searchKeywords);
        return $scope.onFilterChange();
      };
      $scope.order = function(rowName) {
        if ($scope.row === rowName) {
          return;
        }
        $scope.row = rowName;
        $scope.filteredRegions = $filter('orderBy')($scope.regions, rowName);
        return $scope.onOrderChange();
      };
      $scope.numPerPageOpt = [3, 5, 10, 20];
      $scope.numPerPage = $scope.numPerPageOpt[2];
      $scope.currentPage = 1;
      $scope.currentPageRegions = [];
      init = function() {
        $scope.search();
        return $scope.select($scope.currentPage);
      };
      $scope.deleteAction = [
        {
          id: "",
          modalName: ""
        }
      ];
      $scope["delete"] = function(modalName, id) {
        var modalInstance;
        $scope.deleteAction.modalName = modalName;
        $scope.deleteAction.id = id;
        modalInstance = $modal.open({
          templateUrl: "ModalDeleteContent.html",
          controller: 'ModalDeleteInstanceCtrl',
          resolve: {
            items: function() {
              return $scope.deleteAction;
            }
          }
        });
        modalInstance.result.then((function(items) {
          var i;
          i = 0;
          while (i < $scope.regions.length) {
            if ($scope.regions[i]._id === items.id) {
              delete $scope.regions[i];
              break;
            }
            i++;
          }
          init();
        }), function() {});
      };
      $scope.items = [
        {
          id: '',
          code: '',
          name: '',
          modalType: '',
          modalName: ''
        }
      ];
      $scope.open = function(modalName) {
        var modalInstance;
        $scope.items.modalName = modalName;
        $scope.items.id = '';
        modalInstance = $modal.open({
          templateUrl: "myModalContent.html",
          controller: 'ModalInstanceCtrl',
          resolve: {
            items: function() {
              return $scope.items;
            }
          }
        });
        modalInstance.result.then((function(items) {
          $scope.regions.push(items);
          init();
        }), function() {});
      };
      $scope.edit = function(modalName, id, code, name) {
        var modalInstance;
        $scope.items.modalName = modalName;
        $scope.items.id = id;
        $scope.items.code = code;
        $scope.items.name = name;
        modalInstance = $modal.open({
          templateUrl: "myModalContent.html",
          controller: 'ModalInstanceCtrl',
          resolve: {
            items: function() {
              return $scope.items;
            }
          }
        });
        modalInstance.result.then((function(items) {
          var i;
          i = 0;
          while (i < $scope.regions.length) {
            if ($scope.regions[i]._id === items._id) {
              $scope.regions[i] = items;
              break;
            }
            i++;
          }
          init();
        }), function() {});
      };
    }
  ]).controller('tableAreaCtrl', [
    '$scope', '$filter', '$http', 'ServerUrl', '$log', '$modal', function($scope, $filter, $http, ServerUrl, $log, $modal) {
      var init;
      $scope.areas = [];
      $http({
        url: ServerUrl.getUrl() + "area"
      }).success(function(data, status, headers, config) {
        $scope.areas = data;
        return init();
      }).error(function(data, status, headers, config) {});
      $scope.searchKeywords = '';
      $scope.filteredAreas = [];
      $scope.row = '';
      $scope.select = function(page) {
        var end, start;
        start = (page - 1) * $scope.numPerPage;
        end = start + $scope.numPerPage;
        return $scope.currentPageAreas = $scope.filteredAreas.slice(start, end);
      };
      $scope.onFilterChange = function() {
        $scope.select(1);
        $scope.currentPage = 1;
        return $scope.row = '';
      };
      $scope.onNumPerPageChange = function() {
        $scope.select(1);
        return $scope.currentPage = 1;
      };
      $scope.onOrderChange = function() {
        $scope.select(1);
        return $scope.currentPage = 1;
      };
      $scope.search = function() {
        $scope.filteredAreas = $filter('filter')($scope.areas, $scope.searchKeywords);
        return $scope.onFilterChange();
      };
      $scope.order = function(rowName) {
        if ($scope.row === rowName) {
          return;
        }
        $scope.row = rowName;
        $scope.filteredAreas = $filter('orderBy')($scope.areas, rowName);
        return $scope.onOrderChange();
      };
      $scope.numPerPageOpt = [3, 5, 10, 20];
      $scope.numPerPage = $scope.numPerPageOpt[2];
      $scope.currentPage = 1;
      $scope.currentPageAreas = [];
      init = function() {
        $scope.search();
        return $scope.select($scope.currentPage);
      };
      $scope.deleteAction = [
        {
          id: "",
          modalName: ""
        }
      ];
      $scope["delete"] = function(modalName, id) {
        var modalInstance;
        $scope.deleteAction.modalName = modalName;
        $scope.deleteAction.id = id;
        modalInstance = $modal.open({
          templateUrl: "ModalDeleteContent.html",
          controller: 'ModalDeleteInstanceCtrl',
          resolve: {
            items: function() {
              return $scope.deleteAction;
            }
          }
        });
        modalInstance.result.then((function(items) {
          var i;
          i = 0;
          while (i < $scope.areas.length) {
            if ($scope.areas[i]._id === items.id) {
              delete $scope.areas[i];
              break;
            }
            i++;
          }
          init();
        }), function() {});
      };
      $scope.items = [
        {
          id: '',
          code: '',
          name: '',
          modalType: '',
          modalName: ''
        }
      ];
      $scope.open = function(modalName) {
        var modalInstance;
        $scope.items.modalName = modalName;
        $scope.items.id = '';
        modalInstance = $modal.open({
          templateUrl: "myModalContent.html",
          controller: 'ModalInstanceCtrl',
          resolve: {
            items: function() {
              return $scope.items;
            }
          }
        });
        modalInstance.result.then((function(items) {
          $scope.areas.push(items);
          init();
        }), function() {});
      };
      $scope.edit = function(modalName, id, code, name) {
        var modalInstance;
        $scope.items.modalName = modalName;
        $scope.items.id = id;
        $scope.items.code = code;
        $scope.items.name = name;
        modalInstance = $modal.open({
          templateUrl: "myModalContent.html",
          controller: 'ModalInstanceCtrl',
          resolve: {
            items: function() {
              return $scope.items;
            }
          }
        });
        modalInstance.result.then((function(items) {
          var i;
          i = 0;
          while (i < $scope.areas.length) {
            if ($scope.areas[i]._id === items._id) {
              $scope.areas[i] = items;
              break;
            }
            i++;
          }
          init();
        }), function() {});
      };
    }
  ]).controller('tableTerritoryCtrl', [
    '$scope', '$filter', '$http', 'ServerUrl', '$log', '$modal', function($scope, $filter, $http, ServerUrl, $log, $modal) {
      var init;
      $scope.territorys = [];
      $http({
        url: ServerUrl.getUrl() + "territory"
      }).success(function(data, status, headers, config) {
        $scope.territorys = data;
        return init();
      }).error(function(data, status, headers, config) {});
      $scope.searchKeywords = '';
      $scope.filteredTerritorys = [];
      $scope.row = '';
      $scope.select = function(page) {
        var end, start;
        start = (page - 1) * $scope.numPerPage;
        end = start + $scope.numPerPage;
        return $scope.currentPageTerritorys = $scope.filteredTerritorys.slice(start, end);
      };
      $scope.onFilterChange = function() {
        $scope.select(1);
        $scope.currentPage = 1;
        return $scope.row = '';
      };
      $scope.onNumPerPageChange = function() {
        $scope.select(1);
        return $scope.currentPage = 1;
      };
      $scope.onOrderChange = function() {
        $scope.select(1);
        return $scope.currentPage = 1;
      };
      $scope.search = function() {
        $scope.filteredTerritorys = $filter('filter')($scope.territorys, $scope.searchKeywords);
        return $scope.onFilterChange();
      };
      $scope.order = function(rowName) {
        if ($scope.row === rowName) {
          return;
        }
        $scope.row = rowName;
        $scope.filteredTerritorys = $filter('orderBy')($scope.territorys, rowName);
        return $scope.onOrderChange();
      };
      $scope.numPerPageOpt = [3, 5, 10, 20];
      $scope.numPerPage = $scope.numPerPageOpt[2];
      $scope.currentPage = 1;
      $scope.currentPageTerritorys = [];
      init = function() {
        $scope.search();
        return $scope.select($scope.currentPage);
      };
      $scope.deleteAction = [
        {
          id: "",
          modalName: ""
        }
      ];
      $scope["delete"] = function(modalName, id) {
        var modalInstance;
        $scope.deleteAction.modalName = modalName;
        $scope.deleteAction.id = id;
        modalInstance = $modal.open({
          templateUrl: "ModalDeleteContent.html",
          controller: 'ModalDeleteInstanceCtrl',
          resolve: {
            items: function() {
              return $scope.deleteAction;
            }
          }
        });
        modalInstance.result.then((function(items) {
          var i;
          i = 0;
          while (i < $scope.territorys.length) {
            if ($scope.territorys[i]._id === items.id) {
              delete $scope.territorys[i];
              break;
            }
            i++;
          }
          init();
        }), function() {});
      };
      $scope.items = [
        {
          id: '',
          code: '',
          name: '',
          modalType: '',
          modalName: ''
        }
      ];
      $scope.open = function(modalName) {
        var modalInstance;
        $scope.items.modalName = modalName;
        $scope.items.id = '';
        modalInstance = $modal.open({
          templateUrl: "myModalContent.html",
          controller: 'ModalInstanceCtrl',
          resolve: {
            items: function() {
              return $scope.items;
            }
          }
        });
        modalInstance.result.then((function(items) {
          $scope.territorys.push(items);
          init();
        }), function() {});
      };
      $scope.edit = function(modalName, id, code, name) {
        var modalInstance;
        $scope.items.modalName = modalName;
        $scope.items.id = id;
        $scope.items.code = code;
        $scope.items.name = name;
        modalInstance = $modal.open({
          templateUrl: "myModalContent.html",
          controller: 'ModalInstanceCtrl',
          resolve: {
            items: function() {
              return $scope.items;
            }
          }
        });
        modalInstance.result.then((function(items) {
          var i;
          i = 0;
          while (i < $scope.territorys.length) {
            if ($scope.territorys[i]._id === items._id) {
              $scope.territorys[i] = items;
              break;
            }
            i++;
          }
          init();
        }), function() {});
      };
    }
  ]).controller('tableCategoriesCtrl', [
    '$scope', '$filter', '$http', 'ServerUrl', '$log', '$modal', function($scope, $filter, $http, ServerUrl, $log, $modal) {
      var init;
      $scope.categories = [];
      $http({
        url: ServerUrl.getUrl() + "category"
      }).success(function(data, status, headers, config) {
        $scope.categories = data;
        return init();
      }).error(function(data, status, headers, config) {});
      $scope.searchKeywords = '';
      $scope.filteredCategories = [];
      $scope.row = '';
      $scope.select = function(page) {
        var end, start;
        start = (page - 1) * $scope.numPerPage;
        end = start + $scope.numPerPage;
        return $scope.currentPageCategories = $scope.filteredCategories.slice(start, end);
      };
      $scope.onFilterChange = function() {
        $scope.select(1);
        $scope.currentPage = 1;
        return $scope.row = '';
      };
      $scope.onNumPerPageChange = function() {
        $scope.select(1);
        return $scope.currentPage = 1;
      };
      $scope.onOrderChange = function() {
        $scope.select(1);
        return $scope.currentPage = 1;
      };
      $scope.search = function() {
        $scope.filteredCategories = $filter('filter')($scope.categories, $scope.searchKeywords);
        return $scope.onFilterChange();
      };
      $scope.order = function(rowName) {
        if ($scope.row === rowName) {
          return;
        }
        $scope.row = rowName;
        $scope.filteredCategories = $filter('orderBy')($scope.categories, rowName);
        return $scope.onOrderChange();
      };
      $scope.numPerPageOpt = [3, 5, 10, 20];
      $scope.numPerPage = $scope.numPerPageOpt[2];
      $scope.currentPage = 1;
      $scope.currentPageCategories = [];
      init = function() {
        $scope.search();
        return $scope.select($scope.currentPage);
      };
      $scope.deleteAction = [
        {
          id: "",
          modalName: ""
        }
      ];
      $scope["delete"] = function(modalName, id) {
        var modalInstance;
        $scope.deleteAction.modalName = modalName;
        $scope.deleteAction.id = id;
        modalInstance = $modal.open({
          templateUrl: "ModalDeleteContent.html",
          controller: 'ModalDeleteInstanceCtrl',
          resolve: {
            items: function() {
              return $scope.deleteAction;
            }
          }
        });
        modalInstance.result.then((function(items) {
          var i;
          i = 0;
          while (i < $scope.categories.length) {
            if ($scope.categories[i]._id === items.id) {
              delete $scope.categories[i];
              break;
            }
            i++;
          }
          init();
        }), function() {});
      };
      $scope.items = [
        {
          id: '',
          desc: '',
          name: '',
          icon: '',
          modalType: '',
          modalName: ''
        }
      ];
      $scope.open = function(modalName) {
        var modalInstance;
        $scope.items.modalName = modalName;
        $scope.items.id = '';
        modalInstance = $modal.open({
          templateUrl: "categoryModalContent.html",
          controller: 'ModalCategoryInstanceCtrl',
          resolve: {
            items: function() {
              return $scope.items;
            }
          }
        });
        modalInstance.result.then((function(items) {
          $scope.categories.push(items);
          init();
        }), function() {});
      };
      $scope.edit = function(modalName, id, name, desc, icon) {
        var modalInstance;
        $scope.items.modalName = modalName;
        $scope.items.id = id;
        $scope.items.desc = desc;
        $scope.items.name = name;
        $scope.items.icon = icon;
        modalInstance = $modal.open({
          templateUrl: "categoryModalContent.html",
          controller: 'ModalCategoryInstanceCtrl',
          resolve: {
            items: function() {
              return $scope.items;
            }
          }
        });
        modalInstance.result.then((function(items) {
          var i;
          i = 0;
          while (i < $scope.categories.length) {
            if ($scope.categories[i]._id === items._id) {
              $scope.categories[i] = items;
              break;
            }
            i++;
          }
          init();
        }), function() {});
      };
    }
  ]).controller('tableUsersCtrl', [
    '$scope', '$filter', '$http', 'ServerUrl', '$log', '$modal', function($scope, $filter, $http, ServerUrl, $log, $modal) {
      var init;
      $scope.users = [];
      $http({
        url: ServerUrl.getUrl() + "user"
      }).success(function(data, status, headers, config) {
        $scope.users = data;
        return init();
      }).error(function(data, status, headers, config) {});
      $scope.searchKeywords = '';
      $scope.filteredUsers = [];
      $scope.row = '';
      $scope.select = function(page) {
        var end, start;
        start = (page - 1) * $scope.numPerPage;
        end = start + $scope.numPerPage;
        return $scope.currentPageUsers = $scope.filteredUsers.slice(start, end);
      };
      $scope.onFilterChange = function() {
        $scope.select(1);
        $scope.currentPage = 1;
        return $scope.row = '';
      };
      $scope.onNumPerPageChange = function() {
        $scope.select(1);
        return $scope.currentPage = 1;
      };
      $scope.onOrderChange = function() {
        $scope.select(1);
        return $scope.currentPage = 1;
      };
      $scope.search = function() {
        $scope.filteredUsers = $filter('filter')($scope.users, $scope.searchKeywords);
        return $scope.onFilterChange();
      };
      $scope.order = function(rowName) {
        if ($scope.row === rowName) {
          return;
        }
        $scope.row = rowName;
        $scope.filteredUsers = $filter('orderBy')($scope.users, rowName);
        return $scope.onOrderChange();
      };
      $scope.numPerPageOpt = [3, 5, 10, 20];
      $scope.numPerPage = $scope.numPerPageOpt[2];
      $scope.currentPage = 1;
      $scope.currentPageUsers = [];
      init = function() {
        $scope.search();
        return $scope.select($scope.currentPage);
      };
      $scope.deleteAction = [
        {
          id: "",
          modalName: ""
        }
      ];
      $scope["delete"] = function(modalName, id) {
        var modalInstance;
        $scope.deleteAction.modalName = modalName;
        $scope.deleteAction.id = id;
        modalInstance = $modal.open({
          templateUrl: "ModalDeleteContent.html",
          controller: 'ModalDeleteInstanceCtrl',
          resolve: {
            items: function() {
              return $scope.deleteAction;
            }
          }
        });
        modalInstance.result.then((function(items) {
          var i;
          i = 0;
          while (i < $scope.users.length) {
            if ($scope.users[i]._id === items.id) {
              delete $scope.users[i];
              break;
            }
            i++;
          }
          init();
        }), function() {});
      };
      $scope.items = [
        {
          id: '',
          designation: '',
          name: '',
          email: '',
          is_admin: false,
          is_authorized: false,
          modalType: '',
          modalName: ''
        }
      ];
      $scope.open = function(modalName) {
        var modalInstance;
        $scope.items.modalName = modalName;
        $scope.items.id = '';
        modalInstance = $modal.open({
          templateUrl: "userModalContent.html",
          controller: 'ModalUserInstanceCtrl',
          resolve: {
            items: function() {
              return $scope.items;
            }
          }
        });
        modalInstance.result.then((function(items) {
          $scope.users.push(items);
          init();
        }), function() {});
      };
      $scope.edit = function(modalName, id, name, designation, email, is_authorized, is_admin) {
        var modalInstance;
        $scope.items.modalName = modalName;
        $scope.items.id = id;
        $scope.items.designation = designation;
        $scope.items.name = name;
        $scope.items.email = email;
        $scope.items.is_authorized = is_authorized;
        $scope.items.is_admin = is_admin;
        modalInstance = $modal.open({
          templateUrl: "userModalContent.html",
          controller: 'ModalUserInstanceCtrl',
          resolve: {
            items: function() {
              return $scope.items;
            }
          }
        });
        modalInstance.result.then((function(items) {
          var i;
          i = 0;
          while (i < $scope.users.length) {
            if ($scope.users[i]._id === items._id) {
              $scope.users[i] = items;
              break;
            }
            i++;
          }
          init();
        }), function() {});
      };
      $scope.checkEdit = function(modalName, id, name, designation, email, is_authorized, is_admin) {
        var data, modalname;
        modalname = modalName;
        data = {};
        data[modalname] = {
          _id: id,
          name: name,
          designation: designation,
          email: email,
          is_authorized: is_authorized,
          is_admin: is_admin
        };
        return $http({
          method: 'put',
          url: ServerUrl.getUrl() + modalname,
          headers: {
            "Content-Type": "application/json"
          },
          data: data
        }).success(function(data, status, headers, config) {
          var i;
          i = 0;
          while (i < $scope.users.length) {
            if ($scope.users[i]._id === data._id) {
              $scope.users[i] = data;
              break;
            }
            i++;
          }
          init();
        }).error(function(data, status, headers, config) {});
      };
    }
  ]);

}).call(this);
