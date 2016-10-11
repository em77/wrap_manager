module ClientActionsHelper
  def client_wrap_status_generator
    "<span class='#{client.wrap_status.to_s}_wrap'>
      #{client.wrap_status.upcase.gsub(/_/,'-')}
    </span>".html_safe
  end
end
