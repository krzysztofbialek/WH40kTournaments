$ ->
  $('.final_results').on 'click', (e) ->
    e.preventDefault()
    form = $('form')
    form.attr('action', '/tournaments')
    console.log(form)
    form.submit()

