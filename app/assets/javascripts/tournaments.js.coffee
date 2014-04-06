# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  $('.datepicker, .input.datepicker').datepicker(
    dateFormat: "yy-mm-dd"
    onSelect: (e) ->
      $('.hasDatepicker').val(e)
      $('.start_date-alt').val(e)

  )

  $('.ui-datepicker-inline').css('display', 'none')
