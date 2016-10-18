module ClientActionsHelper
  def client_wrap_status_generator
    wrap_situation_prettified(client.wrap_status)
  end

  def client_wrap_action_prettified
    wrap_situation_prettified(client_action.wrap_action)
  end

  def wrap_situation_prettified(wrap_status_or_action)
    "<span class='#{wrap_status_or_action.to_s}_wrap'>
      #{wrap_status_or_action.upcase.gsub(/_/,' ')}
    </span>".html_safe
  end
end
