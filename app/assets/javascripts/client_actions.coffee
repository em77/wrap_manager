$(document).on "turbolinks:load", ->
  $("#choices_toggler").click ->
    clear_radios()
    if $("#wrap_status_choices").is ":hidden"
      # Toggle wrap_status_choices slide down
      $("#wrap_status_choices").slideToggle()
      # Change icon on toggler
      $("#choices_toggler span").removeClass("glyphicon-menu-down")
      $("#choices_toggler span").addClass("glyphicon-menu-up")
    else
      clear_radios()
      # Toggle wrap_status_choices slide up
      $("#wrap_status_choices").slideToggle()
      # Change icon on toggler
      $("#choices_toggler span").removeClass("glyphicon-menu-up")
      $("#choices_toggler span").addClass("glyphicon-menu-down")
      return
    return

  # Unselect all radio buttons
  clear_radios = () ->
    $("input[id='client_action_client_wrap_status_open']")\
      .prop("checked", false);
    $("input[id='client_action_client_wrap_status_closed']")\
      .prop("checked", false);
    $("input[id='client_action_client_wrap_status_completed']")\
      .prop("checked", false);
    $("input[id='client_action_client_wrap_status_non_wrap']")\
      .prop("checked", false);
    return
  return
