# Configure will_paginate to use Bootstrap renderer by default
# This is cleaner than overriding the helper method
begin
  WillPaginate::ViewHelpers.pagination_options[:renderer] = WillPaginate::ActionView::BootstrapLinkRenderer
rescue NameError => e
  # If bootstrap-will_paginate gem isn't loaded, this will fail
  # In that case, the default renderer will be used
  Rails.logger.warn "Could not configure will_paginate Bootstrap renderer: #{e.message}"
end

