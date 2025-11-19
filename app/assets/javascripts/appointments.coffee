# Initialize flatpickr for date and time picking
initializeFlatpickr = ->
  # Use flatpickr directly since we know it's available
  fp = window.flatpickr || flatpickr
  
  if fp && typeof fp == 'function'
    # Find all datetimepicker elements and initialize
    elements = document.querySelectorAll(".datetimepicker")
    
    if elements.length == 0
      console.log "No .datetimepicker elements found"
      return
    
    elements.forEach (element) ->
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
      
      console.log "Flatpickr initialized on element", element
  else
    console.error "Flatpickr function not available"

# Initialize on document ready
$ ->
  initializeFlatpickr()

# Initialize on Turbolinks navigation
$(document).on "turbolinks:load", ->
  initializeFlatpickr()

# Fallback: initialize on window load
$(window).on "load", ->
  initializeFlatpickr()
