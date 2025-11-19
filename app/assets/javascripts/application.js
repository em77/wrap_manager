// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require rails-ujs
//= require turbolinks
//= require bootstrap-sprockets
//= require moment
//= require flatpickr
//= require_tree .

// Initialize flatpickr for date and time picking
window.initializeFlatpickr = function() {
  var fp = window.flatpickr || flatpickr;
  
  if (!fp || typeof fp !== 'function') {
    return;
  }
  
  var elements = document.querySelectorAll(".datetimepicker");
  
  for (var i = 0; i < elements.length; i++) {
    var element = elements[i];
    
    if (element._flatpickr) {
      element._flatpickr.destroy();
    }
    
    fp(element, {
      enableTime: true,
      dateFormat: "Y-m-d h:i K",
      time_24hr: false,
      minuteIncrement: 15,
      allowInput: true,
      defaultHour: 12,
      defaultMinute: 0
    });
  }
};

// Initialize on multiple events
if (document.readyState === 'loading') {
  document.addEventListener('DOMContentLoaded', window.initializeFlatpickr);
} else {
  window.initializeFlatpickr();
}

document.addEventListener('turbolinks:load', window.initializeFlatpickr);
window.addEventListener('load', window.initializeFlatpickr);
