module ClientActionsHelper
  def client_wrap_status_generator
    wrap_situation_prettified(client.wrap_status)
  end

  def client_wrap_action_prettified
    wrap_situation_prettified(client_action.wrap_action)
  end

  def wrap_situation_prettified(wrap_text)
    if wrap_text.downcase == "opened"
      new_wrap_text = "open"
    else
      new_wrap_text = wrap_text
    end

    "<span class='#{new_wrap_text.to_s}_wrap bold_text'>
      #{new_wrap_text.upcase.gsub(/_/,' ')}
    </span>".html_safe
  end

  def wrap_session_prettified(wrap_session)
    "<span class='#{wrap_session.to_s} bold_text'>
      #{wrap_session.upcase.gsub(/_/,' ')}
    </span>".html_safe
  end
end
