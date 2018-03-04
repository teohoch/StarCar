###
$(document).on 'turbolinks:load', ->
  $('input[type=tel]').intlTelInput
    formatOnInit: true
    separateDialCode: true
    initialCountry: 'CL'
    allowDropdown: false
###
