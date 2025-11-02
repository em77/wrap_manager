# Configure will_paginate to use Bootstrap renderer by default
# This avoids having to override the helper method which causes argument issues in Rails 6.1
begin
  if defined?(WillPaginate)
    WillPaginate::ActionView::BootstrapLinkRenderer
    # Set default renderer for will_paginate
    WillPaginate::ViewHelpers.pagination_options[:renderer] = WillPaginate::ActionView::BootstrapLinkRenderer
  end
rescue => e
  Rails.logger.warn "Could not set will_paginate Bootstrap renderer: #{e.message}" if defined?(Rails)
end

