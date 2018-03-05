$(document).on 'turbolinks:load', ->
  app = angular.module("Starcar", ["ngResource", 'ui.bootstrap'])
  host = 'http://localhost:3000'

  app.service 'carSrv', ($http) ->
    @getCars = (id) ->
      $http.get('/cars.json', params: { branch_id: id})

    @getClient = (rut) ->
      $http.get('/clients.json', params: { rut: rut})

    return

  app.controller 'SalesCtrl', ($scope, $uibModal,$document, $log, carSrv) ->
    sc = this
    @currentBranch = null
    @enableCar = true
    @cars = []
    @rut = ""
    @clients = []
    $scope.currentClient = null
    $scope.casa = 'asda'


    @getCars = () ->
      sc.enableCar = true
      carSrv.getCars(@currentBranch).then(
        (response) ->
          sc.cars = response.data
          sc.enableCar = false
      )
      return

    @getClient = () ->
      carSrv.getClient(@rut).then(
        (response) ->
          sc.clients = response.data
          if sc.clients.length == 1
            $scope.currentClient = response.data[0]
          else
            $scope.currentClient = null
      )
      return



    @alert = () ->
      alert('Hola')
      return

    $ctrl = this
    @animationsEnabled = false

    @open = (size, parentSelector) ->
      parentElem = if parentSelector then angular.element($document[0].querySelector('.modal-demo ' + parentSelector)) else undefined
      modalInstance = $uibModal.open(
        animation: sc.animationsEnabled
        ariaLabelledBy: 'modal-title'
        ariaDescribedBy: 'modal-body'
        templateUrl: '/clients/new?partial'
        controller: 'ModalInstanceCtrl'
        controllerAs: '$ctrl'
        size: size
        appendTo: parentElem
        resolve: {
          newClient: () ->
            $scope.newClient
        }
      )

      modalInstance.result.then ((data) ->
        $scope.currentClient = data
        return
      ), ->
        $log.info 'Modal dismissed at: ' + new Date
        return
      return


    @toggleAnimation = ->
      @animationsEnabled = !@animationsEnabled
      return
    return



  app.controller 'ModalInstanceCtrl', ($uibModalInstance, $scope,$http, newClient) ->
    $ctrl = this
    $scope.newClient = newClient


    $ctrl.ok = ->
      $http.post('/clients.json',
        'client':{
          'email' : $scope.newClient.email,
          'name' : $scope.newClient.name,
          'surname' : $scope.newClient.surname,
          'rut' : $scope.newClient.rut,
          'address' : $scope.newClient.address,
          'phone' : $scope.newClient.phone
        }
        ,
        headers: 'Content-Type': 'application/x-www-form-urlencoded').then ((data) ->
          $scope.data = data.data
          $uibModalInstance.close $scope.data
          return
        ), () ->
          window.location.replace("/clients/new");



      return

    $ctrl.cancel = ->
      $uibModalInstance.dismiss 'cancel'
      return
    return



