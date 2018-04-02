$(document).on 'turbolinks:load ready page:load', ->
  app = angular.module("Starcar", ["ngResource", 'ui.bootstrap'])

  $('form').on 'click', '.remove_fields', (event) ->
    $(this).prev('input[type=hidden]').val('1')
    $(this).closest('.container').hide()
    event.preventDefault()




  app.service 'carSrv', ($http) ->
    @getCars = (id) ->
      $http.get('/cars.json', params: { branch_id: id})

    @getClient = (rut) ->
      $http.get('/clients.json', params: { rut: rut})

    @getCar = (id) ->
      $http.get('/cars/'+id+'.json')

    return

  app.controller 'SalesCtrl', ($scope, $uibModal,$document, $log, carSrv) ->
    sc = this
    @currentBranch = null
    @currentCar = null
    @currentCarID = null
    @enableCar = true
    @cars = []
    @rut = ""
    @clients = []
    @sale = {
      transfer_cost:  101330,
      appraisal:      0,
      pva:            0,
      total_transfer: 0,
      discount:       0,
      sell_price:     0
        }
    $scope.currentClient = null
    $scope.currentClientID = 0
    $scope.payments = ''



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
          if sc.clients.length > 0
            $scope.currentClient = response.data[0]
            $scope.currentClientID = $scope.currentClient.id
          else
            $scope.currentClient = null
            sc.open('lg')
      )
      return

    @updateFields = () ->
      sc.sale.sale_price = sc.currentCar.list_price - sc.sale.discount
      sc.sale.tax = Math.ceil(Math.max(sc.sale.pva, sc.sale.appraisal, sc.sale.sale_price) * 0.015)
      sc.sale.total_transfer = sc.sale.tax + sc.sale.transfer_cost - sc.sale.discount
      sc.sale.final_price = sc.sale.sale_price + sc.sale.total_transfer
      return

    @add_payment_method = (event) ->
      event.preventDefault()
      if $scope.payment_selector
        id = JSON.parse(event.currentTarget.dataset.ids)[parseInt($scope.payment_selector)]
        html = JSON.parse(event.currentTarget.dataset.fields)[parseInt($scope.payment_selector)]

        time = new Date().getTime()
        regexp = new RegExp(id, 'g')
        data_field = html.replace(regexp, time)

        template = document.createElement('template')
        template.innerHTML = data_field.trim()
        event.currentTarget.parentNode.parentNode.before(template.content.firstChild)
      return

    @remove_payment_method = (event) ->
      event.preventDefault()
      event.currentTarget.prev('input[type=hidden]').val('1')

      event.currentTarget.closest('.container').hide()

      return

    @show_alert = (event) ->
      event.preventDefault()
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
        $scope.currentClientID = $scope.currentClient.id
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



