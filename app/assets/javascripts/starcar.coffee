$(document).on 'turbolinks:load ready page:load', ->
  app = angular.module("Starcar", ["ngResource", 'ui.bootstrap','platanus.rut', 'purplefox.numeric'])

  app.directive 'format', [
    '$filter'
    ($filter) ->
      {
        require: '?ngModel'
        link: (scope, elem, attrs, ctrl) ->
          if !ctrl
            return
          ctrl.$formatters.unshift (a) ->
            $filter(attrs.format) ctrl.$modelValue
          elem.bind 'blur', (event) ->
            plainNumber = elem.val().replace(/[^\d|\-+|\.+]/g, '')
            elem.val $filter(attrs.format)(plainNumber)
            return
          return

      }
  ]


  $('form').on 'click', '.remove_fields', (event) ->
    $(this).prev('input[type=hidden]').val('1')
    $(this).closest('.container').hide()
    event.preventDefault()


  app.service 'carSrv', ($http) ->
    @getCars = (id) ->
      $http.get('/cars.json', params: { branch_id: id},{
          withCredentials: true,
          headers: {
            'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
          }
        }
      )

    @getClient = (rut) ->
      $http.get('/clients.json', params: { rut: rut},{
        withCredentials: true,
        headers: {
          'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
        }
      })

    @getCar = (id) ->
      $http.get('/cars/'+id+'.json',{
        withCredentials: true,
        headers: {
          'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
        }
      })

    return

  app.controller 'SalesCtrl', ($scope, $uibModal,$document, $log, carSrv) ->
    sc = this
    @currentBranch = null
    @currentCar = null
    @currentCarID = null
    @enableCar = true
    @cars = []
    @rut = null
    @clients = []
    @sale = {
      transfer_cost:      101330,
      appraisal:          0,
      pva:                0,
      total_transfer:     0,
      transfer_discount:  0,
      list_discount:      0,
      sell_price:         0
    }
    @test = 9898
    $scope.currentClient = null
    $scope.currentClientID = 0
    $scope.payments = ''

    @getBranchCars = () ->
      sc.enableCar = true
      carSrv.getCars(@currentBranch).then(
        (response) ->
          sc.cars = response.data
          sc.enableCar = false
      )
      return

    @getBranchCarsAndSet = () ->
      sc.enableCar = true
      carSrv.getCars(@currentBranch).then(
        (response) ->
          sc.cars = response.data
          sc.enableCar = false
          for car in sc.cars
            if car.id == sc.currentCarID
              sc.currentCar = car
              break

      )
      return

    @getClient = () ->
      if @rut!=null
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
      sc.sale.sale_price = sc.currentCar.list_price - sc.sale.list_discount
      sc.sale.tax = Math.ceil(Math.max(sc.sale.pva, sc.sale.appraisal, sc.sale.sale_price) * 0.015)
      sc.sale.total_transfer = sc.sale.tax + sc.sale.transfer_cost - sc.sale.transfer_discount
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


    @rut = $(".modal-demo").data("rut")

    if @rut.length != 0
      @getClient()

    @currentBranch = $(".modal-demo").data("branch").toString()

    if @currentBranch != ""
      sc.currentCarID = $(".modal-demo").data("car")
      @getBranchCarsAndSet()




    $ctrl = this
    @animationsEnabled = false
    $scope.newClient = {}

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
          ,
          rut: () ->
            sc.rut
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


  app.controller 'ModalInstanceCtrl', ($uibModalInstance, $scope,$http, newClient, rut) ->
    $ctrl = this
    $scope.newClient = newClient
    $scope.newClient.rut = rut


    $ctrl.ok = ->
      if $scope.newClient.rut != null
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


  app.controller 'ReservationCtrl', ($scope, $uibModal,$document, $log, carSrv) ->
    rc = this
    @currentBranch = null
    @currentCar = null
    @currentCarID = null
    @enableCar = true
    @cars = []
    @rut = ""
    @clients = []
    @enableCar = false
    $scope.currentClient = null
    $scope.currentClientID = 0
    $scope.paid_amount = 0



    @getCars = () ->
      rc.enableCar = true
      carSrv.getCars(@currentBranch).then(
        (response) ->
          rc.cars = response.data
          rc.enableCar = false
      )
      return

    @getClient = () ->
      if @rut!=null
        carSrv.getClient(@rut).then(
          (response) ->
            rc.clients = response.data
            if rc.clients.length > 0
              $scope.currentClient = response.data[0]
              $scope.currentClientID = $scope.currentClient.id
            else
              $scope.currentClient = null
              rc.open('lg')
        )
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

    $scope.newClient = {}

    @open = (size, parentSelector) ->
      parentElem = if parentSelector then angular.element($document[0].querySelector('.modal-demo ' + parentSelector)) else undefined
      modalInstance = $uibModal.open(
        animation: rc.animationsEnabled
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
          ,
          rut: () ->
            rc.rut
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




  app.controller 'QuoteCtrl', ($scope, $uibModal,$document, $log, carSrv) ->
    qc = this
    @currentBranch = null
    @currentCar = null
    @currentCarID = null
    @enableCar = true
    @cars = []
    @rut = ""
    @clients = []
    @enableCar = false
    $scope.currentClient = null
    $scope.currentClientID = 0
    $scope.paid_amount = 0
    $scope.newClient = {}


    @getCars = () ->
      qc.enableCar = true
      carSrv.getCars(@currentBranch).then(
        (response) ->
          qc.cars = response.data
          qc.enableCar = false
      )
      return

    @getClient = () ->
      if @rut!=null
        carSrv.getClient(@rut).then(
          (response) ->
            qc.clients = response.data
            if qc.clients.length > 0
              $scope.currentClient = response.data[0]
              $scope.currentClientID = $scope.currentClient.id
            else
              $scope.currentClient = null
              qc.open('lg')
        )
      return



    @open = (size, parentSelector) ->
      parentElem = if parentSelector then angular.element($document[0].querySelector('.modal-demo ' + parentSelector)) else undefined
      modalInstance = $uibModal.open(
        animation: qc.animationsEnabled
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
          ,
          rut: () ->
            qc.rut
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


  app.controller 'AcquisitionCtrl', ($scope, $uibModal,$document, $log, carSrv) ->
    ac = this
    $scope.paid_amount = 0

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

    return





