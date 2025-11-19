# Initialize datetimepicker - retry until library is available
initializeDatetimePicker = (attempts = 0) ->
  maxAttempts = 100
  
  if typeof $ != 'undefined' && $ && typeof $.fn != 'undefined' && typeof $.fn.datetimepicker != 'undefined'
    # Library is available, initialize
    $(".datetimepicker").each ->
      existing = $(this).data('DateTimePicker')
      existing.destroy() if existing
    
    $(".datetimepicker").datetimepicker(
      stepping: 15
      format: "YYYY-MM-DD hh:mm A"
    )
  else if attempts < maxAttempts
    # Retry after delay
    setTimeout (-> initializeDatetimePicker(attempts + 1)), 100

# Initialize on document ready
$ ->
  initializeDatetimePicker()

# Initialize on Turbolinks navigation
$(document).on "turbolinks:load", ->
  initializeDatetimePicker()

# Fallback: initialize on window load
$(window).on "load", ->
  initializeDatetimePicker()
