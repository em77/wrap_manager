# Initialize flatpickr for date and time picking
initializeFlatpickr = (attempts = 0) ->
  maxAttempts = 100
  
  if typeof flatpickr != 'undefined'
    # Library is available, initialize
    $(".datetimepicker").each ->
      element = this
      # Destroy existing instance if present
      if element._flatpickr
        element._flatpickr.destroy()
      
      # Initialize flatpickr with date and time support
      # Format matches original: "YYYY-MM-DD hh:mm A" -> "Y-m-d h:i K"
      flatpickr element,
        enableTime: true
        dateFormat: "Y-m-d h:i K"
        time_24hr: false
        minuteIncrement: 15
        allowInput: true
        defaultHour: 12
        defaultMinute: 0
  else if attempts < maxAttempts
    # Retry after delay
    setTimeout (-> initializeFlatpickr(attempts + 1)), 100

# Initialize on document ready
$ ->
  initializeFlatpickr()

# Initialize on Turbolinks navigation
$(document).on "turbolinks:load", ->
  initializeFlatpickr()

# Fallback: initialize on window load
$(window).on "load", ->
  initializeFlatpickr()
