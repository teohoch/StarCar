$(document).on 'turbolinks:load', ->
  language = $('.index_table').data('language')
  if($('[id$=_table_wrapper]').length == 0)
    $('.index_table').dataTable(
      {
        "language": language,"jQueryUI": true,
        responsive: true
      })