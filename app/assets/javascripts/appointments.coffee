# Initialize datetimepicker on both Turbolinks and regular page loads
initializeDatetimePicker = ->
  if typeof $.fn.datetimepicker != 'undefined'
    # Destroy any existing instances to prevent duplicates
    $(".datetimepicker").each ->
      if $(this).data('DateTimePicker')
        $(this).data('DateTimePicker').destroy()
    
    # Initialize datetimepicker
    $(".datetimepicker").datetimepicker(
      stepping: 15, format: "YYYY-MM-DD hh:mm A")
  else
    # Retry after a short delay if datetimepicker isn't loaded yet
    setTimeout initializeDatetimePicker, 100

$(document).on "turbolinks:load", initializeDatetimePicker
$(document).ready initializeDatetimePicker
