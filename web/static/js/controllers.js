import {Socket} from "deps/phoenix/web/static/js/phoenix";

angular.module('controllers', [])

.controller('DashCtrl', ['$scope', 'Restangular', 'poller', '$ionicModal', '$filter', function($scope, Restangular, poller, $ionicModal, $filter) {
  $scope.switches = Restangular.all('switches').getList().$object;

  $scope.socket = new Socket("/socket");
  $scope.socket.connect();
  $scope.channel = $scope.socket.channel("switches:lobby", {});
  $scope.channel.join().receive("ok", function(dt) {
    // wait for magic
  }).receive("error", function(dt) {
    // fallback to polling
    // poller.get(Restangular.all('switches'), {
    //     action: 'getList',
    //     delay: 3000
    // }).promise.then(null, null, function(switches){
    //   $scope.switches = switches;
    // });
  });

  $scope.channel.on("update", function(dt) {
    var switchItem = $filter('filter')($scope.switches, {id: dt.id})[0];
    $scope.$apply(function(){
      _.extend(switchItem,dt);
    });
  });


  $ionicModal.fromTemplateUrl('templates/edit-switch-modal.html', {
    scope: $scope
  }).then(function(modal) {
    $scope.switch_modal = modal;
  });

  $scope.editSwitch = function(switchItem) {
    $scope.edit_switch = switchItem;
    $scope.switch_modal.show();
    // $scope.data = { response: switchItem.name };
    // $ionicPopup.prompt({
    //   title: 'Edit',
    //   template: 'Rename Switch',
    //   inputType: 'text',
    //   scope: $scope
    // }).then(function() {
    //   switchItem.name = $scope.data.response;
    //   $scope.updateSwitch(switchItem);
    // });
  };
  $scope.updateSwitch = function(switchItem) {
    switchItem.save();
    $scope.switch_modal.hide();
  };
}]);
