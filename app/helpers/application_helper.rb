module ApplicationHelper
  def flash_class(flash_type)
    case flash_type
      when :notice then "alert alert-info"
      when :success then "alert alert-success"
      when :error then "alert alert-danger"
      when :alert then "alert alert-warning"
    end
  end

  # Removed will_paginate override - using global renderer configuration instead
  # Bootstrap renderer is set in config/initializers/will_paginate.rb

end
