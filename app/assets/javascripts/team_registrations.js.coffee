# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $(".typeahead").each (i) ->
    input = $(this)

    input.typeahead
      name: "players_with_ids",
      prefetch: "/players.json",
      limit: 10

    input.on "typeahead:selected typeahead:autocompleted", (e, datum) ->
      $('.player-id_' + input.data('index')).val(datum.id)
  
  $(".players-popover").popover({html: true})

