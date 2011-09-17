$('body a.popup').live 'click', (event) ->
  event.preventDefault()
  window.open( $(this).attr('href') )