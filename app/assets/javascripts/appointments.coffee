# Initialize flatpickr for date and time picking
initializeFlatpickr = (attempts = 0) ->
  maxAttempts = 200  # Increased retries
  
  # Check multiple ways flatpickr might be available
  fp = null
  if typeof window != 'undefined' && window.flatpickr
    fp = window.flatpickr
  else if typeof flatpickr != 'undefined'
    fp = flatpickr
  else if typeof global != 'undefined' && global.flatpickr
    fp = global.flatpickr
  # Also check if it's available via the compiled bundle
  else if window && window.flatpickr
    fp = window.flatpickr
  
  if fp && typeof fp == 'function'
    # Library is available, initialize
    $(".datetimepicker").each ->
      element = this
      # Destroy existing instance if present
      if element._flatpickr
        element._flatpickr.destroy()
      
      # Initialize flatpickr with date and time support
      # Format matches original: "YYYY-MM-DD hh:mm A" -> "Y-m-d h:i K"
      fp element,
        enableTime: true
        dateFormat: "Y-m-d h:i K"
        time_24hr: false
        minuteIncrement: 15
        allowInput: true
        defaultHour: 12
        defaultMinute: 0
  else if attempts < maxAttempts
    # Retry after delay - flatpickr might load later
    setTimeout (-> initializeFlatpickr(attempts + 1)), 100
  else
    # Last resort: log error for debugging
    console.error "Flatpickr library not found after #{maxAttempts} attempts"

# Initialize on document ready
$ ->
  initializeFlatpickr()

# Initialize on Turbolinks navigation
$(document).on "turbolinks:load", ->
  initializeFlatpickr()

# Fallback: initialize on window load
$(window).on "load", ->
  initializeFlatpickr()
