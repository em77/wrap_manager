// Initialize flatpickr for date and time picking
(function() {
  'use strict';
  
  console.log("Appointments.js loaded");
  
  function initializeFlatpickr() {
    console.log("initializeFlatpickr called");
    
    // Use flatpickr directly since we know it's available
    var fp = window.flatpickr || (typeof flatpickr !== 'undefined' ? flatpickr : null);
    
    if (!fp || typeof fp !== 'function') {
      console.error("Flatpickr function not available", typeof fp);
      return;
    }
    
    // Find all datetimepicker elements and initialize
    var elements = document.querySelectorAll(".datetimepicker");
    
    console.log("Found", elements.length, "datetimepicker elements");
    
    if (elements.length === 0) {
      console.log("No .datetimepicker elements found");
      return;
    }
    
    for (var i = 0; i < elements.length; i++) {
      var element = elements[i];
      
      // Destroy existing instance if present
      if (element._flatpickr) {
        element._flatpickr.destroy();
      }
      
      // Initialize flatpickr with date and time support
      // Format matches original: "YYYY-MM-DD hh:mm A" -> "Y-m-d h:i K"
      fp(element, {
        enableTime: true,
        dateFormat: "Y-m-d h:i K",
        time_24hr: false,
        minuteIncrement: 15,
        allowInput: true,
        defaultHour: 12,
        defaultMinute: 0
      });
      
      console.log("Flatpickr initialized on element", element);
    }
  }
  
  // Initialize on DOMContentLoaded
  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', initializeFlatpickr);
  } else {
    // DOM already loaded
    initializeFlatpickr();
  }
  
  // Initialize on Turbolinks navigation
  document.addEventListener('turbolinks:load', initializeFlatpickr);
  
  // Fallback: initialize on window load
  window.addEventListener('load', initializeFlatpickr);
})();

