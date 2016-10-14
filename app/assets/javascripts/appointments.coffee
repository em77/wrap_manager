$(document).on "turbolinks:load", ->
  $(".datetimepicker").datetimepicker(
    stepping: 15, format: "YYYY-MM-DD hh:mm A")
  return
