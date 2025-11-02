# Configure will_paginate to use Bootstrap renderer by default
# This avoids having to override the helper method which causes argument issues in Rails 6.1
if defined?(WillPaginate)
  WillPaginate::ActionView::BootstrapLinkRenderer
  # Set default renderer for will_paginate
  WillPaginate::ViewHelpers.pagination_options[:renderer] = WillPaginate::ActionView::BootstrapLinkRenderer
rescue => e
  Rails.logger.warn "Could not set will_paginate Bootstrap renderer: #{e.message}"
end

