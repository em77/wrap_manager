$(document).on "turbolinks:load", ->

  # Required field checker for Safari
  $("form").submit (e) ->
    if !e.target.checkValidity()
      ref = $(this).find("[required]")
      $(ref).each ->
        if $(this).val() == ""
          alert "This field cannot be blank:\n" + \
            $(this).prevAll("label:first").text()
          $(this).focus()
          e.preventDefault()
          return false
        return true
      return

  return
